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
echo "| Generating SSH keys...      |"
echo "+-----------------------------+"
echo

ssh-keygen -a 100 -t ed25519 -C "$email" -f $HOME/.ssh/id_ed25519
cat $HOME/.ssh/id_ed25519.pub | pbcopy

echo "Your SSH public key has been copied to your clipboard."
echo "Now is a good time to add it to your account on:"
echo " - GitHub: https://github.com/settings/ssh/new"
echo " - GitLab: https://gitlab.com/-/profile/keys"
echo
echo -n "Press any key to continue. "

ssh-keygen -a 100 -t ed25519 -C "$email" -f $HOME/.ssh/signing_ed25519
git config --global user.signingkey "$HOME/.ssh/signing_ed25519" &> /dev/null
cat $HOME/.ssh/signing_ed25519.pub | pbcopy

echo
echo "Now this is the public key for signing commits. It has been copied to the clipboard as well."
echo "You can add them using the same links:"
echo " - GitHub: https://github.com/settings/ssh/new"
echo " - GitLab: https://gitlab.com/-/profile/keys"
echo
echo -n "Press any key to continue. "
read key

echo
echo "+-----------------------------+"
echo "| Installing Homebrew...      |"
echo "+-----------------------------+"
echo

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

brew update &> /dev/null

echo
echo "+-----------------------------+"
echo "| Installing apps...          |"
echo "+-----------------------------+"
echo

cli_tools=(
  asdf
  awscli
  direnv
  gnupg
  jq
  libyaml
  nano
  nanorc
  openssl@3
  speedtest-cli
  zlib
)

apps=(
  1password
  appcleaner
  docker-desktop
  google-chrome
  iterm2
  ngrok
  postman
  rectangle
  slack
  the-unarchiver
  transmission
  visual-studio-code
  vlc-nightly
  whatsapp
)

fonts=(
  font-caskaydia-cove-nerd-font
)

brew install $cli_tools $apps $fonts

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
cd $WORKSPACE/dotfiles
$WORKSPACE/dotfiles/install
cd -

sed -i '' "s|export WORKSPACE.*|export WORKSPACE=\"${workdir}\"|g" $WORKSPACE/dotfiles/zshrc

source $HOME/.zshrc

echo
echo "+-----------------------------+"
echo "| Installing Node...          |"
echo "+-----------------------------+"
echo

asdf plugin-add nodejs
asdf install nodejs latest
asdf set -u nodejs latest

echo
echo "+-----------------------------+"
echo "| Installing Python...        |"
echo "+-----------------------------+"
echo

asdf plugin-add python
asdf install python latest
asdf set -u python latest

echo
echo "+-----------------------------+"
echo "| Installing Go...            |"
echo "+-----------------------------+"
echo

asdf plugin-add golang
asdf install golang latest
asdf set -u golang latest

echo
echo "+-----------------------------+"
echo "| Installing Ruby...          |"
echo "+-----------------------------+"
echo

asdf plugin-add ruby
asdf install ruby 3.2.2
asdf set -u ruby 3.2.2

echo
echo "+-----------------------------+"
echo "| Installing Java...          |"
echo "+-----------------------------+"
echo

asdf plugin-add java
asdf install java temurin-17.0.19+10
asdf set -u java temurin-17.0.19+10

echo
echo "+-----------------------------+"
echo "| Installing uv...            |"
echo "+-----------------------------+"
echo

asdf plugin-add uv
asdf install uv latest
asdf set -u uv latest

echo
echo "+-----------------------------+"
echo "| Cleaning & Tuning up...     |"
echo "+-----------------------------+"
echo

brew cleanup &> /dev/null

# Reload QuickLook plugins
qlmanage -r
qlmanage -r cache
