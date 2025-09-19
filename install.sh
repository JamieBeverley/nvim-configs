#!/bin/sh

# For copy/paste
sudo apt install xclip
pip install pyright black isort

npm install -g typescript typescript-language-server

# Install lua language server
mkdir lua-language-server && cd lua-language-server
curl -L -o lua-language-server.tar.gz https://github.com/LuaLS/lua-language-server/releases/download/3.15.0/lua-language-server-3.15.0-linux-x64.tar.gz
tar -xzf lua-language-server.tar.gz
cd ..
sudo mv lua-language-server /usr/local/bin/lua-language-server
echo "make sure /usr/local/bin/lua-language-server/bin/lua-language-server is on PATH"

# Install jsonls language server
npm i -g vscode-langservers-extracted

# TODO: install haskell and haskell-language-server

