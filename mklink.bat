@echo off

del ..\.editorconfig
mklink %userprofile%\.editorconfig %userprofile%\dotfiles\.editorconfig

del ..\.aliases
mklink %userprofile%\.aliases %userprofile%\dotfiles\.aliases

del ..\.bash_profile
mklink %userprofile%\.bash_profile %userprofile%\dotfiles\.bash_profile

del ..\.gitconfig
mklink %userprofile%\.gitconfig %userprofile%\dotfiles\.gitconfig

del ..\.gitignore_global
mklink %userprofile%\.gitignore_global %userprofile%\dotfiles\.gitignore_global

del ..\.vimrc
mklink %userprofile%\.vimrc %userprofile%\dotfiles\.vim\.vimrc

del ..\.vim
mklink /d %userprofile%\.vim %userprofile%\dotfiles\.vim
