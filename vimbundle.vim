set nocompatible
filetype off

let s:python_ver = 0
silent! python import sys, vim;
            \ vim.command("let s:python_ver="+"".join(map(str,sys.version_info[0:3])))

set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

" #### plugin handler
Plugin 'gmarik/vundle'

" #### colorschemes
" solarized color scheme
Plugin 'altercation/vim-colors-solarized'
" molokai
Plugin 'tomasr/molokai'

" #### filetype support
" LESS
Plugin 'groenewege/vim-less'
" Javascript
Plugin 'pangloss/vim-javascript'
" jsx
Plugin 'mxw/vim-jsx'
" CSV
Plugin 'chrisbra/csv.vim'
" XML
Plugin 'sukima/xmledit'
" Latex
Plugin 'acornejo/vim-texhelpers'
" Markdown
Plugin 'tpope/vim-markdown'
" quick html generation
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" gpg decryption
if version >= 702
Plugin 'jamessan/vim-gnupg'
endif

" #### general
" ack/ag integration
Plugin 'mileszs/ack.vim'
" find and switch to project root
Plugin 'airblade/vim-rooter'
" tmux integration
Plugin 'benmills/vimux'
" insert closing bracket, paren, etc
Plugin 'jiangmiao/auto-pairs'
" kark changed lines
if version >= 703
Plugin 'mhinz/vim-signify'
endif
" align blocks
Plugin 'godlygeek/tabular'
" syntax checker
Plugin 'scrooloose/syntastic'
" (un)comment blocks
if version >= 702
Plugin 'tomtom/tcomment_vim'
endif
" snippets
if version >= 701 && s:python_ver >= 260
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
endif
" close all but this buffer
Plugin 'duff/vim-bufonly'
" git integration
Plugin 'tpope/vim-fugitive'
" netrw improvements
Plugin 'tpope/vim-vinegar'
" useful mappings
Plugin 'tpope/vim-unimpaired'
" surround text with anything
Plugin 'tpope/vim-surround'
" readline bindings for vim
Plugin 'tpope/vim-rsi'
" nice status bar
Plugin 'bling/vim-airline'
" guick jumping around file
Plugin 'Lokaltog/vim-easymotion'
" highlight closing tag
Plugin 'Valloric/MatchTagAlways'
" asynchronous execution in vim
if version >= 703
Plugin 'Shougo/vimproc.vim'
endif
" navigating everything (files,buffers,ack/ag)
if version >= 703
Plugin 'Shougo/unite.vim'
endif
" add MRU source to unite
if version >= 703
Plugin 'Shougo/neomru.vim'
endif
" add project source to unite
if version >= 703
Plugin 'acornejo/vim-unite-projects'
endif
" multiple cursors
Plugin 'terryma/vim-multiple-cursors'
" session management
Plugin 'tpope/vim-obsession'

" #### disabled
" Hex editor
" Plugin 'vim-scripts/hexman.vim'
" Yank register management
" Plugin 'vim-scripts/YankRing.vim'
" C/C++/Javascript completion
" Plugin 'Valloric/YouCompleteMe'
" Javascript completion (with youcompleteme)
" Plugin 'marijnh/tern_for_vim'
" Buffer list in statusbar
" Plugin 'bling/vim-bufferline'
" For local vimrc project files
" Plugin 'MarcWeber/vim-addon-local-vimrc'
" quick open
" Plugin 'kien/ctrlp.vim'
" base16 color scheme
"Plugin 'chriskempson/base16-vim'

call vundle#end()
filetype plugin indent on
