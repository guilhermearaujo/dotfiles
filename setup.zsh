#!/usr/bin/env zsh

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

brew tap homebrew/cask-fonts &> /dev/null
brew tap homebrew/cask-versions &> /dev/null
brew update &> /dev/null

echo
echo "+-----------------------------+"
echo "| Installing apps...          |"
echo "+-----------------------------+"
echo

cli_tools=(
  asdf
  direnv
  gnupg
  jq
  nano
  nanorc
  openssl@3
  postgresql@14
  redis
  speedtest-cli
  zlib
)

apps=(
  1password
  appcleaner
  docker
  firefox
  google-chrome
  google-cloud-sdk
  google-drive
  iterm2
  ngrok
  postico
  postman
  rectangle
  slack
  the-unarchiver
  transmission
  viscosity
  visual-studio-code
  vlc-nightly
  whatsapp
)

quicklook_plugins=(
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
  font-caskaydia-cove-nerd-font
  font-hack-nerd-font
)

brew install $cli_tools $quicklook_plugins $fonts
brew install --cask $apps

if [[ $(uname -m) == 'arm64' ]]; then
  curl -o cloud_sql_proxy https://dl.google.com/cloudsql/cloud_sql_proxy.darwin.arm64
else
  curl -o cloud_sql_proxy https://dl.google.com/cloudsql/cloud_sql_proxy.darwin.amd64
fi

sudo mkdir -p /usr/local/bin
sudo mv cloud_sql_proxy /usr/local/bin
chmod +x /usr/local/bin/cloud_sql_proxy

echo
echo "+-----------------------------+"
echo "| Installing Oh My Zsh...     |"
echo "+-----------------------------+"
echo

exit | sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo
echo "+-----------------------------+"
echo "| Installing Powerlevel10k... |"
echo "+-----------------------------+"
echo

git clone https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k

echo
echo "+-----------------------------+"
echo "| Cloning dotfiles...         |"
echo "+-----------------------------+"
echo

echo -n "Enter your default workspace path [\$HOME/Workspace]: "
read workdir
workdir=${workdir:-\$HOME/Workspace}
eval "WORKSPACE=$workdir"

mkdir -p $WORKSPACE
git clone git@github.com:guilhermearaujo/dotfiles.git $WORKSPACE/dotfiles --branch macOS &> /dev/null
if [ $? -ne 0 ]; then
  echo "Failed to clone dotfiles via SSH. Cloning via HTTPS instead."
  git clone https://github.com/guilhermearaujo/dotfiles.git $WORKSPACE/dotfiles --branch macOS &> /dev/null
fi
chmod +x $WORKSPACE/dotfiles/install &> /dev/null
$WORKSPACE/dotfiles/install

sed -i '' "s|export WORKSPACE.*|export WORKSPACE=\"${workdir}\"|g" $WORKSPACE/dotfiles/zshrc

source $HOME/.zshrc

echo
echo "+-----------------------------+"
echo "| Installing Node...          |"
echo "+-----------------------------+"
echo

asdf plugin-add nodejs
asdf install nodejs latest
asdf global nodejs latest

echo
echo "+-----------------------------+"
echo "| Installing Python...        |"
echo "+-----------------------------+"
echo

asdf plugin-add python
asdf install python latest
asdf global python latest

echo
echo "+-----------------------------+"
echo "| Cleaning & Tuning up...     |"
echo "+-----------------------------+"
echo

brew cleanup &> /dev/null

# Reload QuickLook plugins
qlmanage -r
qlmanage -r cache

# Restarting services
brew services restart postgresql@14
brew services restart redis

createuser -s postgres
