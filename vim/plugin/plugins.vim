if !empty($VIM_NOPLUGINS) || exists('g:loaded_plugins')
    finish
endif
let g:loaded_plugins = 1

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

if !filereadable(expand("$HOME/.vim/autoload/plug.vim"))
    echo "Install plug.vim to handle vim plugins."
    call system(expand("curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"))
    exit
endif

"************************************
" Plugin settings
"************************************
let g:UltiSnipsListSnippets="<c-k>"
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:closetag_filenames = '*.xml,*.html,*.xhtml,*.jsx'
let g:closetag_xhtml_filenames = '*.xml,*.xhtml,*.jsx'
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'javascript', 'cpp']
let g:rsi_no_meta = 1
let g:scratch_no_mappings = 1
let g:scratch_persistence_file = expand("$HOME/.vim_scratch")
let g:scratch_horizontal = 0
let g:scratch_height = 80
let g:scratch_top = 0
let g:AutoPairsMapBS = 0             " Don't delete in pairs
let g:targets_argOpening = '[({[]'   " for matching curlys for target arguments
let g:targets_argClosing = '[]})]'

let s:python_ver = 0
silent! python import sys, vim;
            \ vim.command("let s:python_ver="+"".join(map(str,sys.version_info[0:3])))

" Stolen from thoughtbot's dotfiles
function! s:UnPlug(plug_name)
  if has_key(g:plugs, a:plug_name)
    call remove(g:plugs, a:plug_name)
  endif
endfunction
command!  -nargs=1 UnPlug call s:UnPlug(<args>)

call plug#begin('~/.vim/plugged')

" =========================================================
" Colorschemes
" =========================================================
" solarized
Plug 'altercation/vim-colors-solarized'
" molokai
Plug 'tomasr/molokai'

" =========================================================
" UI improvements
" =========================================================
" mark changed lines in git
Plug 'airblade/vim-gitgutter'
" nice status line
Plug 'itchyny/lightline.vim'
" mark display/jump improvements
Plug 'kshenoy/vim-signature'
" file browsing replacement
Plug 'justinmk/vim-dirvish'
" syntax checker
if version >= 800
Plug 'w0rp/ale'
else
Plug 'scrooloose/syntastic'
endif

" =========================================================
" Editor motions
" =========================================================
" cx mapping for exchange
Plug 'tommcdo/vim-exchange'
" sensible target motions
Plug 'wellle/targets.vim'
" custom textobjects
Plug 'kana/vim-textobj-user'
" insert closing bracket, paren, etc
Plug 'jiangmiao/auto-pairs'
" insert closing html tag on >
Plug 'alvan/vim-closetag'
" match html tags
Plug 'gregsexton/MatchTag'
" align blocks of things
Plug 'junegunn/vim-easy-align'
" close all but this buffer
Plug 'duff/vim-bufonly'

" =========================================================
" TPOPE goodness
" =========================================================
" tmux integration
Plug 'tpope/vim-tbone'
" git integration
Plug 'tpope/vim-fugitive'
" useful mappings
Plug 'tpope/vim-unimpaired'
" surround text with anything
Plug 'tpope/vim-surround'
" readline bindings for vim
Plug 'tpope/vim-rsi'
" unix wrapper utilities
Plug 'tpope/vim-eunuch'
" repeat action for scripts
Plug 'tpope/vim-repeat'
" For autocorrect
Plug 'tpope/vim-abolish'
" (un)comment blocks
Plug 'tpope/vim-commentary'

" =========================================================
" Misc Productivity
" =========================================================
" fzf integration
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'
" git browser
Plug 'junegunn/gv.vim'
" ack/ag integration
Plug 'mileszs/ack.vim'
" find and switch to project root
Plug 'airblade/vim-rooter'
" tmux integration
Plug 'benmills/vimux'
" scratch buffer
Plug 'mtth/scratch.vim'
" search and replace
Plug 'gabesoft/vim-ags'
" word highlight
Plug 'neitanod/vim-ondemandhighlight'

" =========================================================
" Auto complete
" =========================================================
" Snippets
if version >= 704 && s:python_ver >= 260
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
endif

" =========================================================
" Filetype support
" =========================================================
" Language support
Plug 'sheerun/vim-polyglot'

" =========================================================
" Disabled
" =========================================================
" XML edit
" Plug 'sukima/xmledit'
" Go
" Plug 'fatih/vim-go'
" Flow
" Plug 'flowtype/vim-flow'
" Prettier
" Plug 'prettier/vim-prettier'
" gpg decryption
" if version >= 702
" Plug 'jamessan/vim-gnupg'
" endif
" Autocomplete
" if version >= 800
" Plug 'prabirshrestha/async.vim'
" Plug 'prabirshrestha/vim-lsp'
" Plug 'prabirshrestha/asyncomplete.vim'
" Plug 'prabirshrestha/asyncomplete-lsp.vim'
" endif
" quick html generation
" Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
" Hex editor
" Plug 'vim-scripts/hexman.vim'
" Javascript completion (with youcompleteme)
" Plug 'marijnh/tern_for_vim'
" Buffer list in statusbar
" Plug 'bling/vim-bufferline'
" For local vimrc project files
" Plug 'MarcWeber/vim-addon-local-vimrc'
" quick open
" Plug 'kien/ctrlp.vim'
" base16 color scheme
" Plug 'chriskempson/base16-vim'
" navigating everything (files,buffers,ack/ag)
" if version >= 703
"  Plug 'Shougo/unite.vim'
" endif
" add MRU source to unite
" if version >= 703
"  Plug 'Shougo/neomru.vim'
" endif
" add project source to unite
" if version >= 703
" Plug 'acornejo/vim-unite-projects'
" endif
" asynchronous execution in vim
" if version >= 703
"  Plug 'Shougo/vimproc.vim', { 'do': 'make' }
" endif
" mark changed lines in vcs
" if version >= 703
"  Plug 'mhinz/vim-signify'
" endif
" Yank register management
" Plug 'vim-scripts/YankRing.vim'
" nice status bar
" Plug 'bling/vim-airline'
" " Search for visual selection
" Plug 'bronson/vim-visual-star-search'"
" " multiple cursors
" Plug 'terryma/vim-multiple-cursors'
" " quick jumping around file
" Plug 'Lokaltog/vim-easymotion'
" " sane vim clipboard behavior
" Plug 'svermeulen/vim-easyclip'
" " gitk emulation
" Plug 'gregsexton/gitv', {'on': ['Gitv']}
" " camel case ,w ,e ,b motions
" Plug 'bkad/CamelCaseMotion'
" " netrw improvements
" Plug 'tpope/vim-vinegar'
" " (un)comment blocks
" if version >= 702
" Plug 'tomtom/tcomment_vim'
" endif
" Latex
" Plug 'acornejo/vim-texhelpers', {'for': 'tex'}
" C/C++/Javascript completion
" if version > 703 || (version >= 703 && has('patch584'))
" Plug 'Valloric/YouCompleteMe'
" command! YcmEnable call plug#load('YouCompleteMe') | call youcompleteme#Enable()
" endif
" highlight closing tag
" if version >= 703 && s:python_ver >= 260
" Plug 'Valloric/MatchTagAlways'
" endif
" CSV
" Plug 'chrisbra/csv.vim', {'for': 'csv'}

if filereadable(expand("~/.vimrc.plugins.local"))
  source ~/.vimrc.plugins.local
endif

call plug#end()

if has_key(g:plugs, 'vim-easy-align')
    " Start interactive EasyAlign in visual mode (e.g. vipga)
    xmap ga <Plug>(EasyAlign)
    " Start interactive EasyAlign for a motion/text object ()"
    nmap ga <Plug>(EasyAlign)
endif

if has_key(g:plugs, 'vim-textobj-user')
    call textobj#user#plugin('camelcase', {
    \  'camel': {
    \     'pattern': '_\{0,1\}[A-Za-z][a-z0-9]\+',
    \     'select': ['ac', 'ic']
    \  }
    \})
endif

if !empty($NOCD)
  let g:rooter_manual_only = 1
endif
