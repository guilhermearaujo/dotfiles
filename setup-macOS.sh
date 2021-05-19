#!/bin/zsh

clear

echo
echo "+-----------------------------+"
echo "| Workspace setup script      |"
echo "+-----------------------------+"
echo
echo "Installing command line tools..."

if xcode-select -p &> /dev/null; then
  echo "Command line tools already installed"
else
  echo -n "Click 'Install' to download and install. Press RETURN after finished or any other key to abort. "

  xcode-select --install &> /dev/null
  read -s -n 1 key

  if [[ $key != "" ]]; then
    exit
  fi
fi

echo
echo "+---------------------------+"
echo "| Git config                |"
echo "+---------------------------+"
echo

echo -n "Enter your name: "
read name
echo -n "Enter your e-mail: "
read email

git config --global user.name "$name" &> /dev/null
git config --global user.email "$email" &> /dev/null

echo
echo "+-----------------------------+"
echo "| Generating SSH key...       |"
echo "+-----------------------------+"
echo

ssh-keygen -a 100 -t ed25519 -C "$email" -f ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub | pbcopy

echo -n "Your SSH public key has been copied to your clipboard. Press any key to continue. "
read key

echo
echo "+-----------------------------+"
echo "| Installing Homebrew...      |"
echo "+-----------------------------+"
echo

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

brew tap heroku/brew &> /dev/null
brew tap homebrew/cask-fonts &> /dev/null
brew tap homebrew/cask-versions &> /dev/null
brew update &> /dev/null

echo
echo "+-----------------------------+"
echo "| Installing apps...          |"
echo "+-----------------------------+"
echo

cli_tools=(
  direnv
  gnupg
  heroku
  jq
  nodenv
  openssl@1.1
  postgresql
  pyenv
  rbenv
  readline
  redis
  ruby-build
  speedtest-cli
  zlib
)

apps=(
  1password
  adoptopenjdk11
  appcleaner
  ccleaner
  charles
  cyberduck
  docker
  dropbox
  firefox
  google-chrome
  google-cloud-sdk
  google-drive
  handbrake
  itau
  iterm2
  keybase
  mkvtoolnix
  ngrok
  postico
  postman
  sequel-pro-nightly
  sketch
  slack
  spectacle
  steam
  teamviewer
  the-unarchiver
  transmission
  virtualbox
  viscosity
  visual-studio-code
  vlc-nightly
  whatsapp
)
ql_plugins=(
 qlcolorcode
 qlimagesize
 qlmarkdown
 qlprettypatch
 qlstephen
 quicklook-json
 suspicious-package
 webpquicklook
)
fonts=(
  font-hack-nerd-font
)

brew install $cli_tools $apps $ql_plugins $fonts

echo
echo "+-----------------------------+"
echo "| Installing Oh My Zsh...     |"
echo "+-----------------------------+"
echo

exit | sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo
echo "+-----------------------------+"
echo "| Installing Powerlevel10k... |"
echo "+-----------------------------+"
echo

git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

echo
echo "+-----------------------------+"
echo "| Cloning dotfiles...         |"
echo "+-----------------------------+"
echo

mkdir -p $HOME/Repos &> /dev/null
git clone https://github.com/guilhermearaujo/dotfiles.git $HOME/Repos/dotfiles &> /dev/null
chmod +x $HOME/Repos/dotfiles/install &> /dev/null
$HOME/Repos/dotfiles/install &> /dev/null

source $HOME/.zshrc

echo
echo "+-----------------------------+"
echo "| Installing Ruby...          |"
echo "+-----------------------------+"
echo

mkdir -p "$(rbenv root)/plugins"
git clone https://github.com/rbenv/rbenv-each.git "$(rbenv root)/plugins/rbenv-each"
git clone https://github.com/rkh/rbenv-update.git "$(rbenv root)/plugins/rbenv-update"

RUBY_VERSION='3.0.0'
rbenv install $RUBY_VERSION
rbenv global $RUBY_VERSION

rbenv each gem install bundler

echo
echo "+-----------------------------+"
echo "| Installing Python...        |"
echo "+-----------------------------+"
echo

PYTHON_VERSION='3.9.1'
pyenv install $PYTHON_VERSION
pyenv global $PYTHON_VERSION

echo
echo "+-----------------------------+"
echo "| Installing Node...          |"
echo "+-----------------------------+"
echo

mkdir -p "$(nodenv root)/plugins"
git clone https://github.com/nodenv/nodenv-each.git "$(nodenv root)/plugins/nodenv-each"
git clone https://github.com/nodenv/nodenv-update.git "$(nodenv root)/plugins/nodenv-update"
git clone https://github.com/pine/nodenv-yarn-install.git "$(nodenv root)/plugins/nodenv-yarn-install"

NODE_VERSION='15.8.0'
nodenv install $NODE_VERSION
nodenv global $NODE_VERSION

echo
echo "+-----------------------------+"
echo "| Installing Cocoapods...     |"
echo "+-----------------------------+"
echo

gem install cocoapods &> /dev/null
pod repo update &> /dev/null

echo
echo "+-----------------------------+"
echo "| Cleaning & Tuning up...     |"
echo "+-----------------------------+"
echo

brew cleanup &> /dev/null

# Reload QuickLook plugins
qlmanage -r
qlmanage -r cache
