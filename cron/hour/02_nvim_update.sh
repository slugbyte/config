#!/usr/bin/env bash
echo "UPDATING NVIM PLUGINS"
2>/dev/null 1>/dev/null $HOME/workspace/exec/nvim +PlugInstall +PlugUpdate +qall
