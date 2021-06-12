#/bin/bash
# https://www.nerdfonts.com/font-downloads
# IncosolataGo Nerd Font Complete Mono Windows Compatible for Windows
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/InconsolataGo.zip
unzip InconsolataGo.zip -d ~/.fonts
fc-cache -fv
echo "done!"

