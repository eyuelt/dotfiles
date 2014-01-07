" vundle.vim
" ----------
" Config file for Vundle bundles. This file also sources all
" Vundle-installed plugins. So this file should be sourced
" in the vimrc before attempting to use any of those plugins.
" note: comments after Bundle commands are not allowed.

filetype off                  " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Start bundle list -----------------------------


" let Vundle manage Vundle (required)
Bundle 'gmarik/vundle'

" My bundles
Bundle 'altercation/vim-colors-solarized'


" End bundle list -------------------------------

filetype plugin indent on     " required!



" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install (update) bundles
" :BundleSearch(!) foo - search (or refresh cache first) for foo
" :BundleClean(!)      - confirm (or auto-approve) removal of unused bundles
"
" see :h vundle for more details or the Vundle wiki for FAQ
