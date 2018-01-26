function! HasPlug(plug_name)
    return exists('g:plugs') && has_key(g:plugs, a:plug_name) && isdirectory(glob(g:plug_home . '/' . a:plug_name))
endfunction

function! s:UnPlug(plug_name)
  if exists('g:plugs') && has_key(g:plugs, a:plug_name)
    call remove(g:plugs, a:plug_name)
  endif
endfunction
command!  -nargs=1 UnPlug call s:UnPlug(<args>)

if !empty($VIM_NOPLUGINS) || exists('g:loaded_plugins')
    finish
endif
let g:loaded_plugins = 1

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
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
let g:scratch_height = 1.0
let g:scratch_top = 0
let g:AutoPairsMapBS = 0             " Don't delete in pairs
let g:targets_argOpening = '[({[]'   " for matching curlys for target arguments
let g:targets_argClosing = '[]})]'
let g:rooter_manual_only = empty($NOCD) ? 0 : 1

call plug#begin('~/.vim_plugged')

" =========================================================
" Colorschemes
" =========================================================
" solarized
Plug 'lifepillar/vim-solarized8'
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
" language support
Plug 'sheerun/vim-polyglot'

if filereadable(expand("~/.vimrc.plugins.local"))
  source ~/.vimrc.plugins.local
endif

call plug#end()

if HasPlug('vim-easy-align')
    xmap ga <Plug>(EasyAlign)
    nmap ga <Plug>(EasyAlign)
endif

if HasPlug('vim-textobj-user')
    call textobj#user#plugin('camelcase', {
    \  'camel': {
    \     'pattern': '_\{0,1\}[A-Za-z][a-z0-9]\+',
    \     'select': ['ac', 'ic']
    \  }
    \})
endif
