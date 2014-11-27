set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" #### plugin handler
Bundle 'gmarik/vundle'

" #### colorschemes
" solarized color scheme
Bundle 'altercation/vim-colors-solarized'
" base16 color scheme
Bundle 'chriskempson/base16-vim'

" #### filetype support
" LESS
Bundle 'groenewege/vim-less'
" Javascript
Bundle 'pangloss/vim-javascript'
" CSV
Bundle 'chrisbra/csv.vim'
" XML
Bundle 'sukima/xmledit'
" Latex
Bundle 'acornejo/vim-texhelpers'
" Markdown
Bundle 'tpope/vim-markdown'
" quick html generation
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
" gpg decryption
Bundle 'jamessan/vim-gnupg'

" #### general
" ack/ag integration
Bundle 'mileszs/ack.vim'
" find and switch to project root
Bundle 'airblade/vim-rooter'
" tmux integration
Bundle 'benmills/vimux'
" insert closing bracket, paren, etc
Bundle 'jiangmiao/auto-pairs'
" kark changed lines
Bundle 'mhinz/vim-signify'
" align blocks
Bundle 'godlygeek/tabular'
" syntax checker
Bundle 'scrooloose/syntastic'
" (un)comment blocks
Bundle 'tomtom/tcomment_vim'
" snippets
Bundle 'SirVer/ultisnips'
" close all but this buffer
Bundle 'duff/vim-bufonly'
" git integration
Bundle 'tpope/vim-fugitive'
" netrw improvements
Bundle 'tpope/vim-vinegar'
" useful mappings
Bundle 'tpope/vim-unimpaired'
" surround text with anything
Bundle 'tpope/vim-surround'
" readline bindings for vim
Bundle 'tpope/vim-rsi'
" nice status bar
Bundle 'bling/vim-airline'
" guick jumping around file
Bundle 'Lokaltog/vim-easymotion'
" highlight closing tag
Bundle 'Valloric/MatchTagAlways'
" asynchronous execution in vim
Bundle 'Shougo/vimproc.vim'
" navigating everything (files,buffers,ack/ag)
Bundle 'Shougo/unite.vim'
" add MRU source to unite
Bundle 'Shougo/neomru.vim'
" add project source to unite
Bundle 'acornejo/vim-unite-projects'
" multiple cursors
Bundle 'terryma/vim-multiple-cursors'

" #### disabled
" Hex editor
" Bundle 'vim-scripts/hexman.vim'
" Yank register management
" Bundle 'vim-scripts/YankRing.vim'
" C/C++/Javascript completion
" Bundle 'Valloric/YouCompleteMe'
" Javascript completion (with youcompleteme)
" Bundle 'marijnh/tern_for_vim'
" Buffer list in statusbar
" Bundle 'bling/vim-bufferline'
" For local vimrc project files
" Bundle 'MarcWeber/vim-addon-local-vimrc'
" quick open
" Bundle 'kien/ctrlp.vim'

filetype plugin indent on
