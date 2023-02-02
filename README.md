# dotfiles for macOS

These are the dotfiles I use in my Mac computers. Their contents are intended for usage on macOS only, and compatibility
with other systems are not guaranteed.

## Setting up a fresh macOS install
After performing a fresh install, you can run this setup script.
It will install lots of tools and applications that I use on a regular basis, such as:

**Terminal:** iTerm2, Oh My Zsh, Powerlevel10k, Homebrew.  
**Development:** Xcode Command Line Tools, plus several tools, including but not limited to:

| Category       | Software                              |
|----------------|---------------------------------------|
| Web browsers   | Firefox, Google Chrome                |
| Development    | git, jq, direnv, common libs, VS Code |
| Languages      | asdf (Node.js, Python)                |
| Databases      | PostgreSQL, Redis, Postico            |
| Google Cloud   | google-cloud-sdk, cloud_sql_proxy     |
| Other tools    | Docker, ngrok, speedtest-cli          |

**Quicklook plugins:** several plugins that help you preview source code and media files using QuickLook.  
**Other apps:** 1Password, AppCleaner, Dropbox, Google Drive, Slack, VLC, WhatsApp, and many more.

This script will also automatically configure the dotfiles for you.

To execute the script, run:

```zsh
zsh -c "$(curl -fsSL https://raw.githubusercontent.com/guilhermearaujo/dotfiles/macOS/setup.zsh)"
```

## Using dotfiles only
In order to use them, clone this repo and then run:

```zsh
cd dotfiles
./install
```

There are a couple of additional files that may hold sensitive data (`.secrets`) or extra settings that you may want
personalize on a device basis, and therefore not be commited (`.extra`). At any time, run `dotfiles` in the terminal to
open VS Code and edit all the dotfiles, including those.
