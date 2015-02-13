"
" vimrc, awful edition
"

if has("win32")
	" work around winderp
	set nocompatible
	source $VIMRUNTIME/vimrc_example.vim
	source $VIMRUNTIME/mswin.vim
	behave mswin

	if ! exists("MyDiff")
		set diffexpr=MyDiff()
		function MyDiff()
			let opt = '-a --binary '
			if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
			if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
			let arg1 = v:fname_in
			if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
			let arg2 = v:fname_new
			if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
			let arg3 = v:fname_out
			if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
			let eq = ''
			if $VIMRUNTIME =~ ' '
				if &sh =~ '\<cmd'
				let cmd = '""' . $VIMRUNTIME . '\diff"'
				let eq = '"'
			else
				let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
			endif
			else
				let cmd = $VIMRUNTIME . '\diff'
			endif
			silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
		endfunction
	endif
	
	map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR> 

	" use Droid Sans Mono if we're using powerline, or Consolas if we're going portable
	set guifont=Droid_Sans_Mono_for_Powerline:h8:cANSI
	" set guifont=Consolas:h9:cANSI
else
	" the *nix side, so much simpler
	set guifont=Droid\ Sans\ Mono\ 8
endif
set encoding=utf-8

" install pathogen
call pathogen#infect()
syntax enable

filetype plugin indent on
set nowrap
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

" indentation settings
set smartindent
set shiftwidth=2
set tabstop=2
"set softtabstop=2
set noexpandtab
set autoindent
set formatoptions-=t

" don't autowrap
set textwidth=0
set wrapmargin=0

" make it pretty to use
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
colorscheme twilight

" gvim things
set guioptions-=m
set guioptions-=T
set shortmess+=I

" vim-markdown stuff
let g:vim_markdown_folding_disabled=1

" nerdtree stuff
nnoremap <C-n> :NERDTreeToggle<cr>

if ! has('gui_running')
	set ttimeoutlen=10
	augroup FastEscape
		autocmd!
		au InsertEnter * set timeoutlen=0
		au InsertLeave * set timeoutlen=1000
	augroup END
endif
