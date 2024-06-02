#!/usr/bin/env bash

clear

echo
echo "+-----------------------------+"
echo "| Installing packages...      |"
echo "+-----------------------------+"
echo
packages=(
  build-essential
  ca-certificates
  curl
  direnv
  git
  gnupg
  jq
  libbz2-dev
  libffi-dev
  liblzma-dev
  libreadline-dev
  libsqlite3-dev
  libssl-dev
  lsb-release
  speedtest-cli
  zlib1g-dev
  zsh
)

sudo -s apt update
sudo -s apt install -y ${packages[@]}

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

echo
echo "Here's the public key:"
echo "Now is a good time to add it to your account on:"
echo " - GitHub: https://github.com/settings/ssh/new"
echo " - GitLab: https://gitlab.com/-/profile/keys"
cat $HOME/.ssh/id_ed25519.pub

ssh-keygen -a 100 -t ed25519 -C "$email" -f $HOME/.ssh/signing_ed25519
git config --global user.signingkey "$HOME/.ssh/signing_ed25519" &> /dev/null

echo
echo "Now this is the public key for signing commits:"
echo "You can add them using the same links:"
echo " - GitHub: https://github.com/settings/ssh/new"
echo " - GitLab: https://gitlab.com/-/profile/keys"
cat $HOME/.ssh/signing_ed25519.pub

echo
echo -n "Press any key to continue"
read key

echo
echo "+-----------------------------+"
echo "| Installing Oh My Zsh...     |"
echo "+-----------------------------+"
echo

exit | sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo
echo "+-----------------------------+"
echo "| Installing powerleve10k...  |"
echo "+-----------------------------+"
echo

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k

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
git clone git@github.com:guilhermearaujo/dotfiles.git $WORKSPACE/dotfiles --branch wsl2 &> /dev/null
if [ $? -ne 0 ]; then
  echo "Failed to clone dotfiles via SSH. Cloning via HTTPS instead."
  git clone https://github.com/guilhermearaujo/dotfiles.git $WORKSPACE/dotfiles --branch wsl2 &> /dev/null
fi
chmod +x $WORKSPACE/dotfiles/install &> /dev/null
cd $WORKSPACE/dotfiles
$WORKSPACE/dotfiles/install
cd -

sed -i "s|export WORKSPACE.*|export WORKSPACE=\"$workdir\"|g" ~/Workspace/dotfiles/zshrc

echo
echo "+-----------------------------+"
echo "| Installing asdf...          |"
echo "+-----------------------------+"
echo

git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf
cd $HOME/.asdf
git fetch --tags
latestTag=$(git describe --tags `git rev-list --tags --max-count=1`)
git checkout $latestTag
cd -

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
echo "| Installing other tools...   |"
echo "+-----------------------------+"
echo

sudo -s install -m 0755 -d /etc/apt/keyrings
sudo -s curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo -s chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo -s tee /etc/apt/sources.list.d/docker.list > /dev/null

curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo -s tee /etc/apt/trusted.gpg.d/ngrok.asc > /dev/null
echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo -s tee /etc/apt/sources.list.d/ngrok.list

sudo -s apt update
sudo -s apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin ngrok

echo
echo "+-----------------------------+"
echo "| Starting services...        |"
echo "+-----------------------------+"
echo

sudo -s service docker start

echo "Updating WSL boot command. A backup has been saved at /etc/wsl.conf.bkp"
sudo -s cp /etc/wsl.conf /etc/wsl.conf.bkp
sudo -s sh -c 'echo "[boot]\ncommand=\"service docker start;\"" >> /etc/wsl.conf'

echo
echo "+-----------------------------+"
echo "| Cleaning up...              |"
echo "+-----------------------------+"
echo

sudo -s apt autoremove
