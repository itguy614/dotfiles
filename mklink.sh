#!/bin/sh

rm ~/.bashrc

ln -s ~/dotfiles/.ansible ~/.ansible.cfg
ln -s ~/dotfiles/.bash_profile ~/.bash_profile
ln -s ~/dotfiles/.bash_profile ~/.bashrc
ln -s ~/dotfiles/bin ~/bin
ln -s ~/dotfiles/.ctags ~/.ctags
ln -s ~/dotfiles/.editorconfig ~/.editorconfig
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.gitignore_global ~/.gitignore_global
ln -s ~/dotfiles/.hushlogin ~/.hushlogin
ln -s ~/dotfiles/.vim ~/.vim
ln -s ~/dotfiles/.vim/.gvimrc ~/.gvimrc
ln -s ~/dotfiles/.vim/.vimrc ~/.vimrc
ln -s ~/dotfiles/.weechat ~/.weechat
ln -s ~/dotfiles/.zshrc ~/.zshrc
