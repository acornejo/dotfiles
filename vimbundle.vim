set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

" #### plugin handler
Plugin 'gmarik/vundle'

" #### colorschemes
" solarized color scheme
Plugin 'altercation/vim-colors-solarized'
" base16 color scheme
Plugin 'chriskempson/base16-vim'

" #### filetype support
" LESS
Plugin 'groenewege/vim-less'
" Javascript
Plugin 'pangloss/vim-javascript'
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
Plugin 'jamessan/vim-gnupg'

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
Plugin 'mhinz/vim-signify'
" align blocks
Plugin 'godlygeek/tabular'
" syntax checker
Plugin 'scrooloose/syntastic'
" (un)comment blocks
Plugin 'tomtom/tcomment_vim'
" snippets
Plugin 'SirVer/ultisnips'
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
Plugin 'Shougo/vimproc.vim'
" navigating everything (files,buffers,ack/ag)
Plugin 'Shougo/unite.vim'
" add MRU source to unite
Plugin 'Shougo/neomru.vim'
" add project source to unite
Plugin 'acornejo/vim-unite-projects'
" multiple cursors
Plugin 'terryma/vim-multiple-cursors'

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

call vundle#end()
filetype plugin indent on
