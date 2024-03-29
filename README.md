# My macOS dotfiles
My macOS setup with fish, VS Code, Java, Node

# Prerequisites
* [Xcode](https://apps.apple.com/sk/app/xcode/id497799835?mt=12)
* [Visual Studio Code](https://code.visualstudio.com/download)
* [iTerm2](https://www.iterm2.com) - Probably going to be deprecated in favor of WezTerm
* [Menlo for Powerline](https://github.com/abertsch/Menlo-for-Powerline)
* [SF Mono for Powerline](https://github.com/Twixes/SF-Mono-Powerline)

# Other software
* [Docker Desktop for Mac](https://hub.docker.com)
* [1Password](https://1password.com/downloads/mac/)
* [Alfred](https://www.alfredapp.com)
* [iStat Menus](https://bjango.com/mac/istatmenus/)
* [Spark](https://apps.apple.com/sk/app/spark-email-app-by-readdle/id1176895641?mt=12)
* [Microsoft Office 365 Apps](http://office.com/)
* [Carbon Copy Cloner](https://bombich.com/download)
* [JetBrains Toolbox](https://www.jetbrains.com/toolbox/app/) - To install IntelliJ IDEA
* [SQL Developer](https://www.oracle.com/technetwork/developer-tools/sql-developer/downloads/)
* [Magnet](https://apps.apple.com/sk/app/magnet/id441258766?mt=12)
* [Transmit](https://panic.com/transmit/#download)
* [Transmission](https://transmissionbt.com)
* [Bear](https://apps.apple.com/sk/app/bear/id1091189122?mt=12)
* [Sourcetree](https://www.sourcetreeapp.com)
* [App Cleaner & Uninstaller](https://nektony.com/mac-app-cleaner)
* [DaisyDisk](https://daisydiskapp.com)
* [Pocket](https://app.getpocket.com)
* [Raindrop.io](hhttps://app.raindrop.io)

# Alfred Workflows
* [Philips Hue Alfred Workflow](https://github.com/benknight/hue-alfred-workflow)
* [Cheatsheet](https://github.com/mutdmour/alfred-workflow-cheatsheet)

# Additional config
## Git
```bash
git config --global user.name "Peter Misak"
git config --global user.email "Your_Mail@...com"
```

## Hostname
From <https://apple.stackexchange.com/questions/287760/set-the-hostname-computer-name-for-macos>:
```bash
sudo scutil --set HostName <new host name>
sudo scutil --set LocalHostName <new host name>
sudo scutil --set ComputerName <new name>
dscacheutil -flushcache
```
Restart your Mac afterwards.

