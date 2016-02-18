filetype off

set rtp+=~/.vim/bundle/Vundle.vim 				    " Set the runtime path to include vundle
call vundle#begin()						            " Begin plugin definitions

    Plugin 'VundleVim/Vundle.vim'				    " Let Vundle manage itself
    Plugin 'tpope/vim-vinegar'				        " Vinegar
    Plugin 'scrooloose/nerdtree'				    " Nerdtree
    Plugin 'ctrlpvim/ctrlp.vim'				        " Control-P
    Plugin 'nathanaelkane/vim-indent-guides'        " Indent guides
    Plugin 'itchyny/lightline.vim'                  " Lightline for status bar
    Plugin 'majutsushi/tagbar'                      " Nice tag browser for the current file
    Plugin 'SirVer/ultisnips'                       " Use Ultisnips for snippets
    Plugin 'honza/vim-snippets'                     " Collection of starter snippets
    Plugin 'vimwiki/vimwiki'                        " Vim Wiki

call vundle#end()						            " End plugin definitions
filetype plugin indent on


" -- Plugin Configuration ------------------------------------------------------"

"/
"/ Tagbar
"/
nmap <D-2> :TagbarToggle<cr>

"/
"/ Vim Wiki
"/
" Default Bindings
" <Leader>ww Open the default wiki index file
" <Leader>wt Open default wiki index file in a new tab
" <Leader>ws Select and open wiki index file
" <Leader>wd Delete wiki file you are in
" <Leader>wr Rename wiki file you are in
" <Enter> Follow/Create wiki link
" <Shift-Enter> Split and follow/create wiki link
" <Ctrl-Enter> Vertical split and follow/create wiki link
" <Backspace> Go back to parent (previous) wiki link
" <Tab> Find next wiki link
" <Shift-Tab> Find previous wiki link

"/
"/ Ultisnips
"/
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

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
"let g:ctrlp_working_path_mode = 'ra'
"let g:ctrlp_root_markers = ['.git']
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
let g:lightline = {
    \ 'colorscheme': 'solarized_dark',
    \ }
