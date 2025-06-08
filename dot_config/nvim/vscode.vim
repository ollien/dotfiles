syntax off
call plug#begin(stdpath('data'))
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'
Plug 'machakann/vim-sandwich'
call plug#end()

nnoremap <space> <Cmd>call VSCodeNotify('editor.action.showHover')<CR>;
nnoremap <leader>cc <Cmd>call VSCodeNotify('editor.action.commentLine')<CR>;
let g:clipboard = g:vscode_clipboard
