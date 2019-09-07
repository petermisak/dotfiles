# My macOS dotfiles
My macOS setup with fish, VS Code, Java, Node

# Prerequisites
* [Xcode](https://apps.apple.com/sk/app/xcode/id497799835?mt=12)
* [Visual Studio Code](https://code.visualstudio.com/download)
* [iTerm2](https://www.iterm2.com)
* [Menlo for Powerline](https://github.com/abertsch/Menlo-for-Powerline)
* [MacPorts](https://www.macports.org/install.php)

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

