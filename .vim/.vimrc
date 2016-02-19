set nocompatible						    " We want the latest vim options

so ~/.vim/plugins.vim						" Include all plugins

syntax enable                               " Turn on syntax highlighting

set backspace=indent,eol,start				" Make backspace behave like every other editor
let mapleader = ','						    " The default leader is \, but a comma is much better
set number							        " Activate line numbers
set ch=2                                    " Make the command line two lines
set vb                                      " Turn on the visual bell
set backspace=2                             " Allow backspacing over indent, eol, and the start of an indent
set nowrap                                  " Do not autowrap long lines
set hidden                                  " Allow reuse of the same window
set wildmenu                                " Turn on improved command-line completion
set confirm                                 " Istead of failing a command, ask to save
set mouse=a                                 " Allow the use of the mouse in all modes
set spelllang=en_us                         " Use the English spellings

" -- Status Line ---------------------------------------------------"
set laststatus=2
set showcmd

" -- Printing ------------------------------------------------------"
set printoptions=header:0,duplex:long,paper:letter


" -- Visuals ------------------------------------------------------"
set background=dark                         " Use a dark background
set t_Co=256                                " Support 256 colors in the terminal
let g:solarized_termcolors=256              " Use 256 colors
colorscheme solarized   				    " Color theme
set guifont=Fira_Code:h14          		    " Use my coding font
set linespace=12						    " Macvim specific line-height

set guioptions-=l						    " Disable left scroll bar
set guioptions-=L						    " Disable left scroll in a split
set guioptions-=r						    " Disable right scroll bar
set guioptions-=R						    " Disable right scroll bar in a split

set guioptions-=e						    " Use non-gui tabs
set cursorline
set nocursorcolumn

" Color column 80 and everything past 120
let &colorcolumn="80,".join(range(120,999),",")


" -- Backups ------------------------------------------------------"
set noswapfile
set nobackup


" -- Tabs ---------------------------------------------------------"
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent


" -- Search -------------------------------------------------------"
set hlsearch							" Highlight search results
set incsearch							" Do incremental searching
set wrapscan                            " Set the search scan to wrap long lines
set ignorecase                          " Ignore case when searching



" -- Split Management ---------------------------------------------"
set splitbelow
set splitright

nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-H> <C-W><C-H>
nmap <C-L> <C-W><C-L>



" -- Mappings -----------------------------------------------------"

" Make it easy to edit Vimrc file
nmap <Leader>ev :tabedit $MYVIMRC<cr>

" Make it easy to edit Plugins file
nmap <Leader>ep :tabedit ~/.vim/plugins.vim<cr>

" Add simple highlight removal
nmap <Leader><space> :nohlsearch<cr>

" Quickly search for a tag
nmap <leader>f :tag<space>

" Toggle spell checking
nmap <leader>ss :set spell!<cr>



" -- Laravel Specific ---------------------------------------------"
nmap <Leader>lr :e app/Http/routes.php<cr>
nmap <Leader>lc :e app/Http/Controllers/<cr>
nmap <Leader>lm :e app/<cr>
nmap <Leader>lv :e resources/views/<cr>
nmap <Leader>la :!php artisan 
nmap <Leader>lam :!php artisan make:
" nmap <Leader>lar :new | r !php artisan route:list
nmap <Leader><leader>lc :CtrlP<cr>app/Http/Controllers/
nmap <Leader><leader>lm :CtrlP<cr>app/
nmap <Leader><leader>lv :CtrlP<cr>resources/views/


" -- Auto-Commands ------------------------------------------------"

" Automatically source tese files on save.
augroup autosourcing
	autocmd!
	autocmd BufWritePost .vimrc source %
    autocmd BufWritePost plugins.vim source %
augroup END



" -- Functions ---------------------------------------------------"

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction
