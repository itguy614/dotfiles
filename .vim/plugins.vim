filetype off

set rtp+=~/.vim/bundle/Vundle.vim 				    " Set the runtime path to include vundle
call vundle#begin()						            " Begin plugin definitions

    Plugin 'VundleVim/Vundle.vim'				    " Let Vundle manage itself
    Plugin 'tpope/vim-vinegar'				        " Vinegar
    Plugin 'scrooloose/nerdtree'				    " Nerdtree
    Plugin 'ctrlpvim/ctrlp.vim'				        " Control-P
    Plugin 'nathanaelkane/vim-indent-guides'        " Indent guides
    Plugin 'majutsushi/tagbar'                      " Nice tag browser for the current file
    Plugin 'vimwiki/vimwiki'                        " Vim Wiki
    Plugin 'jiangmiao/auto-pairs'                   " Auto insert closing brackets
    Plugin 'sirver/ultisnips'                       " Snippet manager
    Plugin 'tpope/vim-surround'                     "
    Plugin 'StanAngeloff/php.vim'                   " Updated PHP syntax definition
    Plugin 'arnaud-lb/vim-php-namespace'            " Easy way to insert namespace and use statements
    Plugin 'craigemery/vim-autotag'                 " Automatically regenerate tag file
    Plugin 'Shougo/vimproc.vim'
    Plugin 'editorconfig/editorconfig-vim'          " Use the excellent editor config plugin
    Plugin 'ervandew/supertab'                      " SuperTab
    Plugin 'stephpy/vim-php-cs-fixer'               " Auto format PSR-2
    Plugin 'vim-airline/vim-airline'                " Status line
    Plugin 'vim-airline/vim-airline-themes'         " Airline themes

    Plugin 'trevordmiller/nova-vim'
    Plugin 'pangloss/vim-javascript'
    Plugin 'othree/html5.vim'
    Plugin 'hail2u/vim-css3-syntax'

    Plugin 'reedes/vim-pencil'

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
"/ Snip
"/
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
nmap <leader>es :UltiSnipsEdit<cr>

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
"nmap <D-r> :CtrlPBufTag<cr>
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
"/ vim-php-cs-fixer
"/
let g:php_cs_fixer_level = "psr2"               " Use PSR2 formatting
let g:php_cs_fixer_fixers_list = "-psr0"        " Disable PSR0
let g:php_cs_fixer_enable_default_mapping = 0   " Disable default key maps

nmap <leader>pf :call PhpCsFixerFixFile()<cr>


"/
"/ Airline
"/
let g:airline_theme = "hybrid"
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 0


"/
"/ vim-php-namespace
"/

" Import classes (add use statements)
function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction

function! IPhpExpandClass()
    call PhpExpandClass()
    call feedkeys('a', 'n')
endfunction

augroup phpnamespace
    autocmd!
    autocmd FileType php inoremap <Leader>n <Esc>:call IPhpInsertUse()<CR>
    autocmd FileType php noremap <Leader>n :call PhpInsertUse()<CR>
    autocmd FileType php inoremap <Leader>e <Esc>:call IPhpExpandClass()<CR>
    autocmd FileType php noremap <Leader>e :call PhpExpandClass()<CR>
augroup END
