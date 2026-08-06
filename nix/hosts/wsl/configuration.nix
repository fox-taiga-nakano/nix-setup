{ config, pkgs, ... }:

{
  wsl.enable = true;
  wsl.defaultUser = "taiga";

  system.stateVersion = "24.05";
}
