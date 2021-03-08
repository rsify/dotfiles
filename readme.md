![Screenshot](/.config/media/mac.png?raw=true "🎉")

```
git hub fish>=3 the_silver_searcher fzf bat exa node
yabai skhd # mac only
```

```
WhichSpace.app Dato.app Karabiner-Elements.app BetterTouchTool.app BitBar.app
```

```sh
$ cd ~
$ git init
$ git remote add origin https://github.com/nikersify/dotfiles.git
$ git fetch
$ git reset --hard origin/master
$ git submodule init
$ git submodule update
$ git branch -u origin/master
$ git config status.showuntrackedfiles no
$ mkdir -p .npm/bin .cargo/bin .gem/ruby
$ echo `which fish` | sudo tee /etc/shells
$ chsh -s `which fish`

# - download node binary (https://nodejs.org/en/download)
# - add its bin/ to path (PATH=$PATH:`pwd`/bin)
# - npx n lts (or whatever version)

$ cd .config/coc/extensions
$ npm install
```

```sh
# add a plugin
$ git submodule add <url> .vim/pack/nikersify/start/<name>

# remove a plugin
$ git rm -f .vim/pack/nikersify/start/<name>

# bump all plugins
$ git submodule update --recursive --remote
```
