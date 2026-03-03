{ config, lib, pkgs, ... }:

let
  user = builtins.getEnv "USER";
  home = builtins.getEnv "HOME";
  dotfiles = builtins.path {
    path = "${home}/dotfiles";
  };
  scriptNames = builtins.attrNames (builtins.readDir "${dotfiles}/bin");
in
{

  home = {
    username = user;
    homeDirectory = home;
    stateVersion = "25.05";
  };

  home.packages = with pkgs; [
    unzip
    zip
    home-manager
    oh-my-zsh
    xsel
    sd
    starship
    ripgrep
    fd
    jq
    bat
    lsd
    fzf
    zsh-fzf-tab
    file
    bc
    nodejs
    python3
    wget
    (pkgs.writeScriptBin "wudo" ''
      ${builtins.readFile (pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/Chronial/wsl-sudo/master/wsl-sudo.py";
        sha256 = "K/sQalNioRlhsFUhcXCXz8qM63rJp9Zamy++oUrd9rc=";
      })}
    '')
    (pkgs.writeScriptBin "extract" ''
      #!${pkgs.zsh}/bin/zsh
      source ${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/extract/extract.plugin.zsh
      extract "$@"
    '')
  ] ++ (
    map (name:
      pkgs.writeScriptBin name ''
        #!${pkgs.zsh}/bin/zsh
        ${builtins.readFile "${dotfiles}/bin/${name}"}
      ''
    ) scriptNames
  );

  programs = {
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      initContent = ''
        source ${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/jump/jump.plugin.zsh
        source ${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/git/git.plugin.zsh
        source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
        ${builtins.readFile "${dotfiles}/config/zsh/.zshrc"}
        ${builtins.readFile "${dotfiles}/config/zsh/.vim.zsh"}
        ${builtins.readFile "${dotfiles}/config/zsh/.aliases"}
      '';
      envExtra = builtins.readFile "${dotfiles}/config/zsh/.zshenv";
    };
    git = {
      enable = true;
      includes = [
        { path = "${dotfiles}/config/git/.gitconfig"; }
      ];
      ignores = lib.splitString "\n"
        (builtins.readFile "${dotfiles}/config/git/.gitignore");
    };
    neovim = {
      enable = true;
      extraLuaConfig = lib.fileContents "${dotfiles}/config/neovim/.nvim.lua";
      extraConfig = lib.fileContents "${dotfiles}/config/neovim/.vimrc";
    };
    vifm = {
      enable = true;
      extraConfig = ''
        ${lib.fileContents "${dotfiles}/config/vifm/.vifmrc"}
        ${lib.fileContents (pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/thimc/vifm_devicons/master/favicons.vifm";
          sha256 = "sha256-2DFwYMZEh/FLNU5LYhCqmtCPlfk66hdnmi9X0YuPB1I=";
        })}
      '';
    };
    less = {
      enable = true;
      keys = builtins.readFile (pkgs.runCommand "lesskey" {} ''
        ${pkgs.python3}/bin/python3 "${dotfiles}/config/less/lesskey.py" > $out
      '');
    };
  };

}
