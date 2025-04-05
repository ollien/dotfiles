set guicursor=n-v-c-sm:block,i-ci-ve-r-cr-o:ver25
set clipboard=unnamedplus
set nrformats+=alpha
set nrformats+=hex
let mapleader=","

if exists('g:vscode')
	syntax off
	call plug#begin(stdpath('data'))
	Plug 'tpope/vim-surround'
	Plug 'easymotion/vim-easymotion'
	Plug 'machakann/vim-sandwich'
	call plug#end()

	nnoremap <space> <Cmd>call VSCodeNotify('editor.action.showHover')<CR>;
	nnoremap <leader>cc <Cmd>call VSCodeNotify('editor.action.commentLine')<CR>;
	let g:clipboard = g:vscode_clipboard
else
	set backup
endif
