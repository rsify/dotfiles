- install `fish`
- `chsh fish`

```sh
$ cd ~
$ git init
$ git remote add origin https://github.com/nikersify/dotfiles.git
$ git fetch --all
$ git reset --hard origin/master
$ git submodule init
$ git submodule update
$ git checkout -t origin/master
$ ./bootstrap.sh
```
