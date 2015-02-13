set guifont=Droid\ Sans\ Mono\ 8
" set guioptions=aeR
set encoding=utf-8

" install pathogen
call pathogen#infect()
syntax enable

filetype plugin indent on
set ignorecase
set smartcase
set backspace=indent,eol,start
set nostartofline
set laststatus=2
set confirm
set visualbell
set mouse=a
set cmdheight=1
set number

" use two-space tabs by default
set smartindent
set shiftwidth=2
set tabstop=2
"set softtabstop=2
set noexpandtab
set autoindent

" make it pretty to use
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
set t_Co=256
set fillchars+=stl:\ ,stlnc:\

" vim-markdown stuff
let g:vim_markdown_folding_disabled=1

" set color scheme to twilight
colorscheme twilight

" keymapping
set whichwrap+=<,>,h,l,[,]
inoremap <S-BS> <Del>

" Mapping to NERDTree
nnoremap <C-n> :NERDTreeToggle<cr>

if ! has('gui_running')
	set ttimeoutlen=10
	augroup FastEscape
		autocmd!
		au InsertEnter * set timeoutlen=0
		au InsertLeave * set timeoutlen=1000
	augroup END
endif

" disable menubar, toolbar
set guioptions-=m
set guioptions-=T
set shortmess+=I
