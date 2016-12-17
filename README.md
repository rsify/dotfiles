- install `fish`
- `chsh fish`

```sh
$ cd ~
$ git init
$ git remote add origin https://github.com/nikersify/dotfiles.git
$ git fetch --recurse-submodules --jobs=4
$ git checkout -t origin/master
$ ./bootstrap.sh
```
