# hello!

![Screenshot](/.config/media/vim.png?raw=true "🎉")

### prerequisites

`git curl fish@>=2.3 the_silver_searcher fzf`

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
$ ./config/bin/bootstrap.sh
$ chsh -s `which fish`

# enable vim javascript completion via tern
$ cd .vim/pack/nikersify/start/completor.vim
$ make js
```

### vim config

```sh
# adding plugins
$ git submodule add <url> .vim/pack/nikersify/start/<name>

# bumping all
$ git submodule update --recursive --remote

# removing plugins, [-f] for uncommited changes
$ git submodule deinit [-f] .vim/pack/nikersify/start/<name>
$ git rm [-f] .vim/pack/nikersify/start/<name>
```

### fisher plugins

```sh
# installing/removing
$ fisher <name>
$ fisher rm <name>
```
