{ config, pkgs, lib, ... }:

{
  home.username = "jacke";
  home.homeDirectory = "/Users/jacke";
  home.stateVersion = "21.11";

  programs.home-manager.enable = true;
  manual.manpages.enable = false;

  home.packages = [
    pkgs.tree
    pkgs.htop
    pkgs.jq
    pkgs.autojump
    pkgs.ripgrep
    pkgs.gnupg
    pkgs.silver-searcher
  ];
}
