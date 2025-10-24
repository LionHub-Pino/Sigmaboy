document.getElementById('go').addEventListener('click', async () => {
  const code = document.getElementById('input').value;
  const options = {
    encode_strings: document.getElementById('encode').checked,
    rename_locals: document.getElementById('rename').checked,
    minify: document.getElementById('minify').checked
  };
  const res = await fetch('/obfuscate', {
    method: 'POST',
    headers: {'Content-Type':'application/json'},
    body: JSON.stringify({ code, options })
  });
  const data = await res.json();
  if (data.error) {
    document.getElementById('out').value = "Error: " + (data.details || data.error);
  } else {
    document.getElementById('out').value = data.obf;
  }
});

document.getElementById('clear').addEventListener('click', () => {
  document.getElementById('input').value = "";
  document.getElementById('out').value = "";
});
