filetype off

set rtp+=~/.vim/bundle/Vundle.vim 				    " Set the runtime path to include vundle
call vundle#begin()						            " Begin plugin definitions
	Plugin 'VundleVim/Vundle.vim'				    " Let Vundle manage itself
	Plugin 'tpope/vim-vinegar'				        " Vinegar
	Plugin 'scrooloose/nerdtree'				    " Nerdtree
	Plugin 'ctrlpvim/ctrlp.vim'				        " Control-P
    Plugin 'nathanaelkane/vim-indent-guides'        " Indent guides
call vundle#end()						            " End plugin definitions
filetype plugin indent on


" -- Plugin Configuration ------------------------------------------------------"

"/
"/ NERDTree
"/
let NERDTreeHijackNetrw=0
nmap <D-1> :NERDTreeToggle<cr>

"/
"/ Ctrl-P
"/
let g:ctrlp_custom_ignore = 'node_modules\DS_Store\|git'
let g:ctrlp_match_window = 'bottom,order:btt,min:5,max:25'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_root_markers = ['.git']
nmap <D-p> :CtrlP<cr>
nmap <D-r> :CtrlPBufTag<cr>
nmap <D-e> :CtrlPMRUFiles<cr>

"/
"/ Indent Guides
"/
let g:indent_guides_color_change_percent = 3
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1
