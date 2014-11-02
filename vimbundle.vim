set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'mileszs/ack.vim'
Bundle 'airblade/vim-rooter'
Bundle 'benmills/vimux'
Bundle 'altercation/vim-colors-solarized'
Bundle 'jiangmiao/auto-pairs'
Bundle 'mhinz/vim-signify'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'chriskempson/base16-vim'
Bundle 'godlygeek/tabular'
" Bundle 'vim-scripts/hexman.vim'
Bundle 'vim-scripts/YankRing.vim'
Bundle 'chrisbra/csv.vim'
Bundle 'sukima/xmledit'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/syntastic'
Bundle 'tomtom/tcomment_vim'
Bundle 'SirVer/ultisnips'
Bundle 'duff/vim-bufonly'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-vinegar'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-markdown'
Bundle 'jamessan/vim-gnupg'
Bundle 'pangloss/vim-javascript'
Bundle 'acornejo/vim-texhelpers'
Bundle 'bling/vim-airline'
" Bundle 'bling/vim-bufferline'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'marijnh/tern_for_vim'
Bundle 'Valloric/MatchTagAlways'
" Bundle 'Valloric/YouCompleteMe'

" Filetype support
Bundle 'groenewege/vim-less'

filetype plugin indent on
