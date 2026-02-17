{ config, lib, pkgs, ... }:

{
  imports = [
    <nixos-wsl/modules>
  ];

  users.users.qle = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    # home = "/mnt/c/Users/qleve";
    home = "/home/qle";
  };

  wsl = {
    enable = true;
    defaultUser = "qle";
  };

  environment.systemPackages = with pkgs; [
    git
    zsh
  ];
  programs.zsh.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "25.05";
}
