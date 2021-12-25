{ config, pkgs, lib, ... }:

let
  firefox = pkgs.stdenv.mkDerivation rec {
    pname = "Firefox";
    version = "95.0.2";

    buildInputs = [ pkgs.undmg ];
    sourceRoot = ".";
    phases = [ "unpackPhase" "installPhase" ];
    installPhase = ''
      mkdir -p "$out/Applications"
      cp -r Firefox.app "$out/Applications/Firefox.app"
    '';

    src = pkgs.fetchurl {
      name = "Firefox-${version}.dmg";
      url = "https://download-installer.cdn.mozilla.net/pub/firefox/releases/${version}/mac/en-GB/Firefox%20${version}.dmg";
      sha256 = "sha256-BA/n1zeo6ueE9wzLNy+W3zwdV37gw73odXMw2pYSVdc=";
    };

    meta = with pkgs.lib; {
      description = "The Firefox web browser";
      homepage = "https://www.mozilla.org/en-GB/firefox";
      platforms = platforms.darwin;
    };
  }; in

{
  home.username = "jacke";
  home.homeDirectory = "/Users/jacke";

  home.stateVersion = "21.11";
  home.activation = {
    copyApplications =
      let
        apps = pkgs.buildEnv {
          name = "home-manager-applications";
          paths = config.home.packages;
          pathsToLink = "/Applications";
        };
      in
      lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        baseDir="$HOME/Applications/Home Manager Apps"
        if [ -d "$baseDir" ]; then
          rm -rf "$baseDir"
        fi
        mkdir -p "$baseDir"
        for appFile in ${apps}/Applications/*; do
          target="$baseDir/$(basename "$appFile")"
          $DRY_RUN_CMD cp ''${VERBOSE_ARG:+-v} -fHRL "$appFile" "$baseDir"
          $DRY_RUN_CMD chmod ''${VERBOSE_ARG:+-v} -R +w "$target"
        done
      '';
  };

  programs.home-manager.enable = true;

  programs.firefox = {
    enable = true;
    package = firefox;
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    autocd = true;
    shellAliases = {
      ec = "$EDITOR $HOME/.zshrc";
      sc = "source $HOME/.zshrc";
      con = "$EDITOR ~/.config/nvim/init.vim";
      code = "cd ~/code";
      gpeek = "git-peek";
      gl = "git log --graph --abbrev-commit --decorate --all --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(dim white) - \ %an%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n %C(white)%s%C(reset)'";
      n = "nvim";
      c = "clear";
    };
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
    localVariables = {
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=cyan";
      HYPHEN_INSENSITIVE = "true";
      COMPLETION_WAITING_DOTS = "true";
    };
    defaultKeymap = "viins";
    initExtra = builtins.readFile ./configs/zsh/extra.zsh;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "docker-compose"
        "web-search"
        "rails"
        "git"
        "bundler"
        "history-substring-search"
        "colored-man-pages"
        "autojump"
        "colorize"
      ];
    };
  };

  home.packages = [
    pkgs.tree
    pkgs.htop
    pkgs.jq
  ];
}
