" vundle.vim
" ----------
" Config file for Vundle plugins. This file also sources all
" Vundle-installed plugins. So this file should be sourced
" in the vimrc before attempting to use any of those plugins.

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=$VUNDLE
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" Start plugin list -----------------------------


Plugin 'gmarik/Vundle.vim'                    " Vundle [required]
Plugin 'altercation/vim-colors-solarized'     " solarized colorsheme
Plugin 'jelera/vim-javascript-syntax'         " javascript syntax highlighting
Plugin 'pangloss/vim-javascript'              " javascript indentation
Plugin 'digitaltoad/vim-jade'                 " jade syntax highlighting
Plugin 'wavded/vim-stylus'                    " stylus syntax highlighting
Plugin 'walm/jshint.vim'                      " run JSHint within vim
Plugin 'eyuelt/vim-better-whitespace'         " clean whitespace
Plugin 'elzr/vim-json'                        " json syntax highlighting
Plugin 'derekwyatt/vim-scala'                 " scala syntax highlighting
Plugin 'leafgarland/typescript-vim'           " typescript syntax highlighting
Plugin 'google/vim-searchindex'               " show number of search matches
Plugin 'google/vim-jsonnet'                   " jsonnet syntax highlighting


" End plugin list -------------------------------

call vundle#end()             " [required]
filetype plugin indent on     " [required]


" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or the Vundle wiki for FAQ
