```sh
$ brew leaves
autojump bat coreutils deno exa ffmpeg findutils fish fzf git gnupg hub insect jo jq libvterm lua ncdu neovim nghttp2 ranger ripgrep the_silver_searcher tmux wget youtube-dl
```

```sh
$ cd ~
$ git init
$ git remote add origin https://github.com/nikersify/dotfiles.git
$ git fetch
$ git reset --hard origin/master
$ git branch -u origin/master
$ git config status.showuntrackedfiles no
$ echo `which fish` | sudo tee /etc/shells
$ chsh -s `which fish`

$ echo "<city-name>" > .config/private/current-city

# node:
# - download node binary (https://nodejs.org/en/download)
# - add its bin/ to path (PATH=$PATH:`pwd`/bin)
# - npx n lts (or whatever version)
```
