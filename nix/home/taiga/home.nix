{ config, pkgs, ... }:

{
  home.username = "taiga";
  home.homeDirectory = "/home/taiga";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}
