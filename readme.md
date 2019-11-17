# hello!

![Screenshot](/.config/media/vim.png?raw=true "🎉")

### prerequisites

`git hub fish>=3 the_silver_searcher fzf`

### setup

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

# enable vim javascript completion via tern
$ cd .vim/pack/nikersify/start/completor.vim
$ make js
```

### vim config

```sh
# add plugin
$ git submodule add <url> .vim/pack/nikersify/start/<name>

# bump all
$ git submodule update --recursive --remote

# remove plugins
$ git rm -f .vim/pack/nikersify/start/<name>
```
