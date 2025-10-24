// server.js
const express = require('express');
const bodyParser = require('body-parser');
const { spawn } = require('child_process');
const fs = require('fs');
const path = require('path');
const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.static(path.join(__dirname, 'public')));
app.use(bodyParser.json({ limit: '1mb' }));

app.post('/obfuscate', async (req, res) => {
  try {
    const code = req.body.code || "";
    const options = req.body.options || {};
    if (!code) return res.status(400).json({ error: "No code provided" });

    // write to a temp file
    const inPath = path.join(__dirname, 'tmp_input.lua');
    fs.writeFileSync(inPath, code, 'utf8');

    // call lua obfuscator (lua must be installed and in PATH)
    const luaScript = path.join(__dirname, 'lua_obf.lua');
    const luaCmd = process.env.LUA_CMD || 'lua';

    const proc = spawn(luaCmd, [luaScript, inPath], { cwd: __dirname });

    let out = "";
    let err = "";
    proc.stdout.on('data', d => out += d.toString());
    proc.stderr.on('data', d => err += d.toString());

    proc.on('close', codeExit => {
      // cleanup
      try { fs.unlinkSync(inPath); } catch(e) {}
      if (codeExit !== 0) {
        return res.status(500).json({ error: "Obfuscator failed", details: err });
      }
      res.json({ obf: out });
    });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

app.listen(PORT, () => {
  console.log("Server listening on http://localhost:" + PORT);
});
