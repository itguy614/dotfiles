filetype off

set rtp+=~/.vim/bundle/Vundle.vim 				    " Set the runtime path to include vundle
call vundle#begin()						            " Begin plugin definitions
    Plugin 'VundleVim/Vundle.vim'				    " Let Vundle manage itself
    Plugin 'tpope/vim-vinegar'				        " Vinegar
    Plugin 'scrooloose/nerdtree'				    " Nerdtree
    Plugin 'ctrlpvim/ctrlp.vim'				        " Control-P
    Plugin 'nathanaelkane/vim-indent-guides'        " Indent guides
    Plugin 'itchyny/lightline.vim'                  " Lightline for status bar
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
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
let g:ctrlp_match_window = 'bottom,order:btt,min:5,max:25'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_root_markers = ['.git']
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
nmap <D-p> :CtrlP<cr>
nmap <D-r> :CtrlPBufTag<cr>
nmap <D-e> :CtrlPMRUFiles<cr>

"/
"/ Indent Guides
"/

" Use this option to control the percent at which the highlight colors will be
" lightened or darkened.
let g:indent_guides_color_change_percent = 3

" Use this option to customize the size of the indent guide.
let g:indent_guides_guide_size = 1

" Use this option to control whether the plugin is enabled on Vim startup. 
let g:indent_guides_enable_on_vim_startup = 1

"Use this option to control which indent level to start showing guides from.
let g:indent_guides_start_level=2

"Use this option to control whether the plugin considers spaces as indention.
let g:indent_guides_space_guides=0

"/
"/ Lightline
"/
if has('gui_running')
    let g:lightline = {
        \ 'colorscheme': 'solarized_dark',
        \ }
else
    let g:lightline = {
        \ 'colorscheme': 'solarized',
        \ }
endif
