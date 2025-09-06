#!/bin/bash

wget https://github.com/microsoft/vscode-cpptools/releases/download/v1.26.3/cpptools-linux-x64.vsix
unzip cpptools-linux-x64.vsix -d ~/.local/share/cpptools
chmod +x ~/.local/share/cpptools/extension/debugAdapters/bin/OpenDebugAD7
echo "~/.local/share/cpptools/extension/debugAdapters/bin/OpenDebugAD7"

