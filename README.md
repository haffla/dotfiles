# dotfiles

Dependencies:

- nix https://nixos.org/download.html
- nix-darwin https://github.com/LnL7/nix-darwin
- Home Manager https://github.com/nix-community/home-manager

## nix-darwin

```
source /etc/bashrc
darwin-rebuild switch
```

## Home Manager

```
home-manager switch
```

## Brew

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew bundle install
```
