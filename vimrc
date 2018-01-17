set nocompatible

"Vundle Setup/Plugins
set rtp+=~/.vim/bundle/Vundle.vim
filetype off
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'Yggdroot/indentline'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'xolox/vim-easytags'
Plugin 'xolox/vim-misc'
Plugin 'pangloss/vim-javascript'
Plugin 'lumiliet/vim-twig'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'suan/vim-instant-markdown'
Plugin 'tpope/tpope-vim-abolish'
Plugin 'w0rp/ale'
Plugin 'junegunn/vader.vim'
Plugin 'fatih/vim-go'
Plugin 'Valloric/YouCompleteMe'
Plugin 'Raimondi/delimitMate'
Plugin 'tyrannicaltoucan/vim-quantum'
Plugin 'vim-airline/vim-airline'

call vundle#end()

"termguicolor fix for tmux
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

"Set color scheme to quantum
let g:quantum_black = 1
let g:quantum_italics = 1
set termguicolors
set background=dark
color quantum

filetype plugin indent on
let mapleader=","
syntax on
set autoindent
set number
"Prefer tabs when possible, and make appropriate settings for them
set noexpandtab
set tabstop=4
set shiftwidth=4
"Use system clipboard
set clipboard=unnamedplus
"Better splitting
set splitright
"Find while searching
set incsearch
"Set tagfile
set tags=/home/nick/.vimtags
set laststatus=2

"Set indent marker
let g:indentLine_char = '·'
let g:indentLine_first_char = '·'
let g:indentLine_showFirstIndentLevel = 1
set list listchars=tab:·\ 

"Fix crontab writing issues
autocmd FileType crontab setlocal nobackup nowritebackup
"Fix concealing issues with json and indentLine
autocmd FileType json let g:indentLine_conceallevel  = &conceallevel
autocmd FileType json let g:indentLine_concealcursor = &concealcursor
"PEP8 Line length guide
autocmd FileType python setlocal colorcolumn=79

autocmd VimEnter * xnoremap <leader>cc :call NERDComment("x","toggle")<CR>
autocmd VimEnter * nnoremap <leader>cc :call NERDComment("n","toggle")<CR>
autocmd BufRead * :IndentLinesEnable

"Tell Ale to always show sign column
let g:ale_sign_column_always=1
"Make sign column so we always have one for Ale - even on file open. (which Ale doesn't do)
autocmd BufEnter * sign define dummy
"Add blank to sign column
autocmd BufEnter * execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')
"Set space indentation for C(++)
autocmd FileType c,cpp set expandtab
autocmd FileType c,cpp set shiftwidth=4
autocmd FileType c,cpp set softtabstop=4

nnoremap <leader>o o<ESC>
nnoremap <leader>O O<ESC>

let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|venv'

let g:easytags_languages = {
\	'javascript': {
\		'cmd': 'jsctags',
\		'args': ['-f']
\	},
\	'go': {
\		'cmd': 'gotags',
\		'args': [],
\		'stout_opt': '-f -'
\	}
\}

let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

let g:airline_powerline_fonts = 1

if ! has('gui_running')
	augroup FastEscape
		autocmd!
		au InsertEnter * set timeoutlen=0
		au InsertLeave * set timeoutlen=1000
	augroup END
endif
