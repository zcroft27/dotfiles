```bash
git clone git@github.com:zcroft27/dotfiles.git ~/dotfiles
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install stow
cd ~/dotfiles
mv ~/.zshrc ~/.zshrc.backup
stow zshrc
stow nvim
stow tmux
cd brew
brew bundle install
```
