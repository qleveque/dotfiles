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
    home-manager
    oh-my-zsh
    git
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
    ghostty
    (pkgs.writeScriptBin "wudo" ''
      ${builtins.readFile (pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/Chronial/wsl-sudo/master/wsl-sudo.py";
        sha256 = "K/sQalNioRlhsFUhcXCXz8qM63rJp9Zamy++oUrd9rc=";
      })}
    '')
  ] ++ (
    map (name:
      pkgs.writeScriptBin name ''
        #!${pkgs.zsh}/bin/zsh
        ${builtins.readFile "${dotfiles}/bin/${name}"}
      ''
    ) scriptNames
  );

  home.file = {
    ".lesskey" = {
      source = (pkgs.runCommand ".lesskey" { } ''
        ${pkgs.python3}/bin/python3 "${dotfiles}/config/less/lesskey.py" > $out
      '');
      force = true;
    };
    ".config/vifm/favicons.vifm".source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/thimc/vifm_devicons/master/favicons.vifm";
      sha256 = "sha256-2DFwYMZEh/FLNU5LYhCqmtCPlfk66hdnmi9X0YuPB1I=";
    };
    ".config/zsh/.vim.zsh".source = "${dotfiles}/config/zsh/.vim.zsh";
    ".aliases".source = "${dotfiles}/config/zsh/.aliases";
    ".vimrc" = {
      source = "${dotfiles}/config/neovim/.vimrc";
      force = true;
    };
    ".gitconfig" = {
      source = "${dotfiles}/config/git/.gitconfig";
      force = true;
    };
    ".gitignore" = {
      source = "${dotfiles}/config/git/.gitignore";
      force = true;
    };
    ".ideavimrc" = {
      source = "${dotfiles}/config/JetBrains/.ideavimrc";
      force = true;
    };
    ".wezterm.lua" = {
      source = "${dotfiles}/config/wezterm/.wezterm.lua";
      force = true;
    };
  };

  programs = {
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      initContent = ''
        source ${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/jump/jump.plugin.zsh
        source ${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/git/git.plugin.zsh
        source ${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/extract/extract.plugin.zsh
        source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
        ${builtins.readFile "${dotfiles}/config/zsh/.zshrc"}
      '';
      envExtra = builtins.readFile "${dotfiles}/config/zsh/.zshenv";
    };
    neovim = {
      enable = true;
      extraLuaConfig = lib.fileContents "${dotfiles}/config/neovim/.nvim.lua";
    };
    vifm = {
      enable = true;
      extraConfig = lib.fileContents "${dotfiles}/config/vifm/.vifmrc";
    };
  };

}
