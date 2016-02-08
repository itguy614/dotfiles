#!/bin/sh

rm ~/.bashrc
ln -s ~/dotfiles/.bash_profile ~/.bashrc

ln -s ~/dotfiles/.bash_profile ~/.bash_profile
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.gitignore_global ~/.gitignore_global
ln -s ~/dotfiles/.editorconfig ~/.editorconfig
ln -s ~/dotfiles/.hushlogin ~/.hushlogin
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.ansible ~/.ansible.cfg
ln -s ~/dotfiles/.vim/.vimrc ~/.vimrc
ln -s ~/dotfiles/.vim/.gvimrc ~/.gvimrc
ln -s ~/dotfiles/.vim ~/.vim
