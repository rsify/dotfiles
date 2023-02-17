![Arch Linux setup (ryrz)](ryrz.png)

# Install
```bash
$ cd ~
$ git init
$ mv .git .dotfiles
$ alias dots "git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
$ dots remote add origin https://github.com/nikersify/dotfiles.git
$ dots fetch
$ dots reset --hard origin/master
$ dots branch -u origin/master
$ dots config status.showuntrackedfiles no

$ echo "<city-name>" > .config/private/current-city
```

# Shell
```bash
$ echo `which fish` | sudo tee /etc/shells
$ chsh -s `which fish`
# relog to switch login shells
```

# Node
- Download a node binary (https://nodejs.org/en/download)
- Add its `bin/` to path (fish: ``PATH=$PATH:`pwd`/bin``)
- `npx n lts` (or whichever version)
