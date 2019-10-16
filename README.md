# dotfiles

These are the dotfiles I use in my computers. Their contents are intended for usage on macOS only, and compatibility with other systems are not guaranteed.

In order to use them, clone this repo and then run:

```bash
cd dotfiles
./install
```

There are a couple of additional files that may hold sensitive data (`.secrets`) or extra settings that you may want personalize on a device basis, and therefore not be commited (`.extra`). At any time, run `dotfiles` in the terminal to open VS Code and edit all the dotfiles, including those.

## Setting up a fresh macOS install
After performing a fresh install, you can run this setup script.
It will install lots of tools and applications that I use on a regular basis, such as:

**Terminal:** iTerm2, Oh My Zsh, Powerlevel10k, Homebrew.  
**Development:** Xcode Command Line Tools, plus several tools, including but not limited to:

|                |                                                 |
|----------------|-------------------------------------------------|
| Editors & IDEs | Visual Studio Code, Android Studio              |
| Languages      | Ruby, Python, Node.js                           |
| Database       | Postgres, MySQL 5.6, Redis, Sequel Pro, Postico |
| Browsers       | Google Chrome, Firefox                          |
| Debugging      | Charles, Postman, ngrok                         |
| Other tools    | Docker, CocoaPods, Carthage                     |

**Quicklook plugins:** several plugins that help you preview source code and media files using QuickLook.  
**Other apps:** 1Password, Dropbox, AppCleaner, Sketch, Slack, Zeplin, TeamViewer, and many more.

This script will also automatically configure the dotfiles for you.

To execute the script, run:

```bash
sh -c "$(curl -fsSL https://raw.github.com/guilhermearaujo/dotfiles/master/setup-macOS.sh)"
```
