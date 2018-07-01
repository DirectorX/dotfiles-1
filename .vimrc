" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Make backspace behave in a sane manner.
set backspace=indent,eol,start

" Traverse line breaks
set whichwrap=b,s,<,>,[,]

" Highlight current line
set cursorline

" Switch syntax highlighting on
syntax on

" Enable file type detection and do language-dependent indenting.
filetype plugin indent on

" Show line column
set nu

" Enable plugins
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
	\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Set tabs to have 4 spaces
set ts=4

" Indent when moving to the next line while writing code
set autoindent

" Expand tabs into spaces
set expandtab

" When using the >> or << commands, shift lines by 4 spaces
set shiftwidth=4

" Ehow the matching part of the pair for [] {} and ()
set showmatch

" Enable all Python syntax highlighting features
let python_highlight_all = 1

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'chriskempson/base16-vim'
Plug 'airblade/vim-gitgutter'

" Initialize plugin system
call plug#end()


" Plugins settings

" Nerdtree
" Toggle nerdtree with F10
map <F10> :NERDTreeToggle<CR>

" Current file in nerdtree
map <F9> :NERDTreeFind<CR>

" Base16
let base16colorspace=256  " Access colors present in 256 colorspace
colorscheme base16-onedark

" Git-Gutter
let g:gitgutter_sign_added = '➡'
let g:gitgutter_sign_modified = '➡'
let g:gitgutter_sign_removed = '➡'
let g:gitgutter_sign_removed_first_line = '⬆'
let g:gitgutter_sign_modified_removed = '⬇'
let g:gitgutter_override_sign_column_highlight = 0
hi! GitGutterAdd ctermbg=NONE
hi! GitGutterChange ctermbg=NONE
hi! GitGutterDelete ctermbg=NONE
hi! GitGutterChangeDelete ctermbg=NONE
set updatetime=100

" Misc

" Remove background from
hi LineNr ctermbg=NONE
hi SignColumn ctermbg=NONE
