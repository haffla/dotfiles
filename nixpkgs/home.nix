{ config, pkgs, lib, ... }:

{
  home.username = "jacke";
  home.homeDirectory = "/Users/jacke";
  home.stateVersion = "21.11";

  programs.home-manager.enable = true;
  manual.manpages.enable = false;

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
    pkgs.neovim
    pkgs.autojump
    pkgs.ripgrep
    pkgs.gnupg
    pkgs.silver-searcher
  ];
}
