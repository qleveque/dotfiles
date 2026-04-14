{ config, lib, pkgs, ... }:

let
  user = builtins.getEnv "USER";
  home = builtins.getEnv "HOME";
  dotfiles = builtins.path {
    path = "${home}/dotfiles";
  };
  my-scripts = map (name:
    pkgs.writeScriptBin name (builtins.readFile "${dotfiles}/bin/${name}")
  ) (builtins.attrNames (builtins.readDir "${dotfiles}/bin"))
  ++ [(pkgs.writeScriptBin "extract" ''
    #!/usr/bin/env zsh
    source ${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/extract/extract.plugin.zsh
    extract "$@"
  '')];
  unstable = import <nixos-unstable> { config.allowUnfree = true; };
  packages = with pkgs; [
    unstable.opencode
    unstable.zellij
    alacritty
    alacritty-theme
    unzip
    zip
    home-manager
    oh-my-zsh
    xsel
    sd
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
    gnumake
    wget
  ];
in
{

  home = {
    username = user;
    homeDirectory = home;
    stateVersion = "25.05";
    packages = packages ++ my-scripts;
  };

  programs = {
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      initContent = ''
        source ${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/jump/jump.plugin.zsh
        source ${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/git/git.plugin.zsh
        source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
        ${builtins.readFile "${dotfiles}/config/zsh/.vim.zsh"}
        ${builtins.readFile "${dotfiles}/config/zsh/.zshrc"}
        ${builtins.readFile "${dotfiles}/config/zsh/.aliases"}
      '';
      envExtra = builtins.readFile "${dotfiles}/config/zsh/.zshenv";
    };
    git = {
      enable = true;
      includes = [
        { path = "${dotfiles}/config/git/config"; }
      ];
      ignores = lib.splitString "\n"
        (builtins.readFile "${dotfiles}/config/git/ignore");
    };
    neovim = {
      enable = true;
      package = unstable.neovim-unwrapped;
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
      package = unstable.less;
      enable = true;
      keys = builtins.readFile (pkgs.runCommand "lesskey" {} ''
        ${pkgs.python3}/bin/python3 "${dotfiles}/config/less/lesskey.py" > $out
      '');
    };
  };

  home.file = {
    ".config/zellij/config.kdl" = {
      text = lib.fileContents "${dotfiles}/config/zellij/config.kdl";
    };
    ".config/zellij/layouts/layout.kdl" = {
      text = lib.fileContents "${dotfiles}/config/zellij/layout.kdl";
    };
    ".config/alacritty/alacritty.toml" = {
      text = ''
        ${lib.fileContents "${dotfiles}/config/alacritty/alacritty.toml"}
        ${lib.fileContents "${pkgs.alacritty-theme}/share/alacritty-theme/catppuccin_macchiato.toml"}
      '';
    };
  };

}
