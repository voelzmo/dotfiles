## Install instructions

```sh
# clone this repo
$ git clone --recursive

# install all the things
$ ./install

# install umlauts with option key layout
$ wget http://hci.rwth-aachen.de/tiki-download_wiki_attachment.php?attId=793&page=USGermanKeyboard
$ unzip USGerman\ Keyboard\ Layout\ 0.98.zip
$ sudo mv USGerman\ Keyboard\ Layout\ 0.98/Roman.bundle /Library/Keyboard\ Layouts/
$ rm -rf USGerman\ Keyboard\ Layout\ 0.98

# add git aliases
$ git config --global alias.history 'log --graph --pretty=format:"%Cred%h%Creset %C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit --date=relative'
$ git config --global alias.ci 'duet-commit -v'
```


## TODO

* backup and install atom packages
* use rubymine profile
