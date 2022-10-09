# dotfiles

These are the dotfiles I use in my computers. Their contents are intended for usage on Windows Subsystem for Linux 2 with Ubuntu.

In order to use them, clone this repo and then run:

```bash
cd dotfiles
./install
```

There are a couple of additional files that may hold sensitive data (`.secrets`) or extra settings that you may want personalize on a device basis, and therefore not be commited (`.extra`). At any time, run `dotfiles` in the terminal to open VS Code and edit all the dotfiles, including those.

# Setting up a fresh WSL2 install
After performing a fresh install, you can run this setup script.
It will install lots of libs and tools that I use on a regular basis, such as:


|                |                                   |
|----------------|-----------------------------------|
| Development    | git, jq, direnv, common libs      |
| Languages      | asdf (Node.js, Python)            |
| Databases      | PostgreSQL, Redis                 |
| Google Cloud   | google-cloud-sdk, cloud_sql_proxy |
| Other tools    | Docker, ngrok, speedtest-cli      |


This script will also automatically configure the dotfiles for you.

To execute the script, run:

```bash
wget -O - https://raw.github.com/guilhermearaujo/dotfiles/wsl2/setup.sh | bash
```

# Nerd Fonts
The shell theme configurations included in this repo includes icons that require a [Nerd Font](https://www.nerdfonts.com). You can install the font you prefer, or disable the icon usage by running `p10k configure`.
