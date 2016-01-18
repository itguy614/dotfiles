set nocompatible              " be iMproved, required
filetype off                  " required

" Dracula Theme
syntax on
color navajo-night

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'

call vundle#end()
filetype plugin indent on    " required

" NERDTree
nmap <leader>n :NERDTreeToggle<CR>
let NERDTreeHighlightCursorLine=1
let NERDTreeIgnore = ['']
