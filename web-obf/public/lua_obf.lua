-- lua_obf.lua
-- Usage: lua lua_obf.lua input.lua > output.lua
-- Options configurable inside code (or extend to parse args)

local io = io
local string = string
local math = math
local table = table

-- Configuration
local CONFIG = {
  encode_strings = true,       -- encode string literals (base64)
  rename_locals = true,        -- rename local variables
  remove_comments = true,      -- remove -- and --[[ ]] comments
  minify = true,               -- remove extra whitespace/newlines
  wrap_load = true,            -- wrap with load(loadstring)/assert
  seed = os.time()
}

math.randomseed(CONFIG.seed)

-- Base64 helper
local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
local function base64_encode(data)
  return ((data:gsub('.', function(x) 
      local r,bits='', x:byte()
      for i=8,1,-1 do r = r .. (bits%2==1 and '1' or '0'); bits = math.floor(bits/2) end
      return r
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
      if #x < 6 then return '' end
      local c=0
      for i=1,6 do c = c*2 + (x:sub(i,i) == '1' and 1 or 0) end
      return b:sub(c+1,c+1)
    end) .. ({ '', '==', '=' })[#data%3+1])
end

local function escape_for_lua(s)
  -- we'll store base64 and decode at runtime
  return s
end

-- Tokenize in a simple way (not a full Lua parser) but robust enough for common scripts
local function read_all(path)
  local f = io.open(path, "rb")
  if not f then error("Cannot open "..path) end
  local c = f:read("*a")
  f:close()
  return c
end

-- remove comments
local function strip_comments(src)
  -- remove block comments --[[ ... ]]
  src = src:gsub("%-%-%[%[[%s%S]-%]%]", "")
  -- remove line comments -- ...
  src = src:gsub("%-%-[^\n]*", "")
  return src
end

-- find string literals and replace with markers
local function collect_strings(src)
  local strings = {}
  local placeholder_idx = 0
  local out = {}
  local i = 1
  local n = #src
  while i <= n do
    local c = src:sub(i,i)
    if c == "'" or c == '"' then
      local q = c
      local j = i+1
      local str = ""
      while j <= n do
        local ch = src:sub(j,j)
        if ch == "\\" then
          str = str .. src:sub(j,j+1)
          j = j + 2
        elseif ch == q then
          break
        else
          str = str .. ch
          j = j + 1
        end
      end
      if j > n then
        -- unterminated; keep raw
        out[#out+1] = src:sub(i)
        break
      else
        placeholder_idx = placeholder_idx + 1
        local key = "__STR_PLACEHOLDER_"..placeholder_idx.."__"
        strings[key] = src:sub(i, j) -- include quotes and escapes
        out[#out+1] = key
        i = j + 1
      end
    elseif src:sub(i,i+1) == "[[" or src:sub(i,i+3) == "[=[[" then
      -- long bracket string
      local level = 0
      local k = i+1
      while src:sub(k,k) == "=" do level = level + 1; k = k + 1 end
      local open = string.rep("=", level)
      local close = "]"..open.."]"
      local s,e = src:find(close, i+1, true)
      if not s then
        out[#out+1] = src:sub(i)
        break
      else
        placeholder_idx = placeholder_idx + 1
        local key = "__STR_PLACEHOLDER_"..placeholder_idx.."__"
        strings[key] = src:sub(i, e)
        out[#out+1] = key
        i = e + 1
      end
    else
      out[#out+1] = c
      i = i + 1
    end
  end
  return table.concat(out), strings
end

-- simple identifier renamer: rename locals found via "local" occurrences
local function rename_locals_simple(src)
  -- find sequences "local <varlist> =?" and rename each identifier
  local mapping = {}
  local nextname_id = 0
  local function newname()
    nextname_id = nextname_id + 1
    local t = {}
    local n = nextname_id
    while n > 0 do
      local r = (n-1) % 26
      t[#t+1] = string.char(string.byte('a') + r)
      n = math.floor((n-1)/26)
    end
    return "_" .. table.concat(t)
  end

  -- pattern to capture variable list after local (handles "local a,b = ..." and "local a,b")
  local res = src:gsub("(%f[%w_]local%s+)([A-Za-z_][A-Za-z0-9_]*(%s*,%s*[A-Za-z_][A-Za-z0-9_]*)*)(%s*[=,%(%{]?)",
    function(prefix, varlist, _, suffix)
      local vars = {}
      for v in varlist:gmatch("[A-Za-z_][A-Za-z0-9_]*") do
        if not mapping[v] then
          mapping[v] = newname()
        end
        vars[#vars+1] = mapping[v]
      end
      return prefix .. table.concat(vars, ",") .. suffix
    end)

  -- replace uses of mapped names when they appear as identifiers (word boundaries)
  for original, mapped in pairs(mapping) do
    -- avoid replacing parts of longer identifiers
    res = res:gsub("(%f[%w_])" .. original .. "(%f[^%w_])", "%1" .. mapped .. "%2")
  end

  return res, mapping
end

local function restore_strings(src, strings)
  -- replace placeholders with actual encoded forms or runtime decoder calls
  for key, val in pairs(strings) do
    if CONFIG.encode_strings then
      -- remove surrounding quotes from val and decode content
      local quote = val:sub(1,1)
      local inner = val:sub(2, -2)
      -- keep escape sequences as-is; simpler approach: encode raw inner via base64
      local enc = base64_encode(inner)
      -- replace with code that decodes at runtime
      local repl = "(__decode_b64(\""..enc.."\") )"
      -- ensure it becomes a string expression: wrap with tostring if needed
      -- but we want it to be a literal string so use load to return string
      repl = "( (function() return (__decode_b64(\""..enc.."\") ) end)() )"
      src = src:gsub(key, repl)
    else
      src = src:gsub(key, val)
    end
  end
  return src
end

-- add runtime base64 decoder
local function add_runtime_decoder(src)
  local decoder = [[
local _b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/' 
local function __decode_b64(data)
  local bytes = {}
  local pad = 0
  data = data:gsub('[^'.._b..'=]', '')
  local i = 1
  while i <= #data do
    local a = _b:find(data:sub(i,i),1,true)-1; i=i+1
    local b = _b:find(data:sub(i,i),1,true)-1; i=i+1
    local c = _b:find(data:sub(i,i),1,true)-1; i=i+1
    local d = _b:find(data:sub(i,i),1,true)-1; i=i+1
    local n = a*262144 + b*4096 + c*64 + d
    local o1 = math.floor(n/65536)%256
    local o2 = math.floor(n/256)%256
    local o3 = n%256
    bytes[#bytes+1] = string.char(o1)
    if c ~= 64 then bytes[#bytes+1] = string.char(o2) end
    if d ~= 64 then bytes[#bytes+1] = string.char(o3) end
  end
  return table.concat(bytes)
end
]]
  return decoder .. "\n" .. src
end

-- minify whitespace
local function minify(src)
  -- collapse multiple spaces and newlines, but keep necessary ones between tokens
  -- naive approach: remove sequential newlines and trim spaces around operators
  src = src:gsub("[ \t\r\n]+", " ")
  src = src:gsub("%s*([=+%-%*/%%%^%#%.,;:%(%){%}%[%]])%s*", "%1")
  return src
end

-- wrap into loadstring
local function wrap_load(src)
  -- we will produce: assert(load((function() return [[...]] end)(), nil, 't'))()
  -- but simpler: return "assert(load([["..src.."]]))()"
  local wrapper = "assert(load([[" .. src .. "]]))()"
  return wrapper
end

-- main
local function main()
  local input = arg[1]
  if not input then
    io.stderr:write("Usage: lua lua_obf.lua input.lua > out.lua\n")
    os.exit(1)
  end
  local src = read_all(input)

  if CONFIG.remove_comments then
    src = strip_comments(src)
  end

  local raw, strings = collect_strings(src)

  if CONFIG.rename_locals then
    raw = rename_locals_simple(raw)
  end

  if CONFIG.minify then
    raw = minify(raw)
  end

  -- restore strings (with encoding)
  local with_strings = restore_strings(raw, strings)

  if CONFIG.encode_strings then
    with_strings = add_runtime_decoder(with_strings)
  end

  local final = with_strings
  if CONFIG.wrap_load then
    final = wrap_load(final)
  end

  io.write(final)
end

main()
