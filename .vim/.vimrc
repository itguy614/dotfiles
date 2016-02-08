set nocompatible						    " We want the latest vim options

so ~/.vim/plugins.vim						" Include all plugins

syntax enable                               " Turn on syntax highlighting

set backspace=indent,eol,start				" Make backspace behave like every other editor
let mapleader = ','						    " The default leader is \, but a comma is much better
set number							        " Activate line numbers
set ch=2                                    " Make the command line two lines
set vb                                      " Turn on the visual bell
set backspace=2                             " Allow backspacing over indent, eol, and the start of an indent
set nowrap



" -- Status Line ---------------------------------------------------"
set laststatus=2
" set stl=%f\ %m\ %r\ Line:%l/%L[%p%%]\ Col:%v
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \Line:\ %l/%L[%p%%]\ Col:\ %v
set showcmd                                 " Don't show the current command in the lower right
set showmode                                " Show the current mode


" -- Printing ------------------------------------------------------"
set printoptions=header:0,duplex:long,paper:letter


" -- Visuals ------------------------------------------------------"
colorscheme navajo-night				    " Color theme
set guifont=Fira_Code:h14          		    " Use Hack as the font
set linespace=12						    " Macvim specific line-height

set guioptions-=l						    " Disable left scroll bar
set guioptions-=L						    " Disable left scroll in a split
set guioptions-=r						    " Disable right scroll bar
set guioptions-=R						    " Disable right scroll bar in a split

set guioptions-=e						    " Use non-gui tabs
set cursorline
set nocursorcolumn





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



" -- Auto-Commands ------------------------------------------------"

"Automatically source the CimRC file on save.
augroup autosourcing
	autocmd!
	autocmd BufWritePost .vimrc source %
augroup END



" -- Functions ---------------------------------------------------"

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction
