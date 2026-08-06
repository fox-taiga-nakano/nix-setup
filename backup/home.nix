{ config, pkgs, ...}:

{
  
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  home.packages = with pkgs; [
    #nnn 
    #lazygit
    #cowsay
  ];
  
  home.stateVersion = "26.05";
  programs.home-manager.enable = true;
}
