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
    finish
endif

"************************************
" Plugin settings
"************************************
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+' " Hide .* files
let g:netrw_browsex_viewer='open'     " Open files with viewer
let g:netrw_fast_browse=2            " Use fast browsing
let g:netrw_liststyle=1              " Display file details in browser
let g:netrw_hide=1                   " show not-hidden files
let g:python_failquietly=1           " Dont complain if there is no python
let g:buftabs_marker_start=""        " marker around active buftab
let g:buftabs_marker_end=""          " marker around active buftab
let g:buftabs_separator=":"          " marker around active buftab
let g:buftabs_marker_modified="+"    " Marker for modified buftabs
let g:buftabs_only_basename=1        " Show short name in buftabs
let g:buftabs_in_statusline=1        " Show buftabs in status line
let g:buftabs_inactive_highlight_group="StatusLine" " Color for inactive tabs
let g:buftabs_active_highlight_group="Title"   " Color for active tabs
let g:yankring_history_file = ".vim_yankring"
let g:yankring_min_element_length = 2
let g:yankring_manage_numbered_reg = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_always_populate_location_list = 1
let g:UltiSnipsListSnippets="<c-k>"
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:xmledit_enable_html = 1
let g:sparkupExecuteMapping="<c-i>"
let g:airline_powerline_fonts = 0
" let g:airline#extensions#tabline#enabled = 1   " Enable bufline
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:syntastic_html_tidy_ignore_errors=['trimming empty', 'lacks "alt" attribute', 'lacks "src" attribute']
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = {"mode": "passive" }
let g:syntastic_cpp_config_file = '.vim_syntax'
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'javascript', 'cpp']
let g:signify_vcs_list = [ 'git' ]
let g:rsi_no_meta = 1
let g:EasyClipShareYanks = 1
let g:EasyClipEnableBlackHoleRedirect = 0
let g:tcommentMapLeader2 = ''  " Disable leader key maps
let g:notes_unicode_enabled = 0
let g:GPGPreferArmor = 1
let g:GPGPreferSign = 1
let g:scratch_no_mappings = 1
let g:scratch_persistence_file = expand("$HOME/.vim_scratch")
let g:scratch_horizontal = 0
let g:scratch_height = 80
let g:scratch_top = 0
let g:AutoPairsMapBS = 0
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
" for matching curlys for target arguments
let g:targets_argOpening = '[({[]'
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
" syntax checker
Plug 'scrooloose/syntastic'
" nice status line
Plug 'itchyny/lightline.vim'
" Mark display/jump improvements (whitespace problems on GV)
Plug 'acornejo/vim-signature'

" =========================================================
" Filetype support
" =========================================================
" Language support
Plug 'sheerun/vim-polyglot'
" Golang
Plug 'fatih/vim-go'
" CSV
Plug 'chrisbra/csv.vim', {'for': 'csv'}
" XML
Plug 'sukima/xmledit'
" Latex
Plug 'acornejo/vim-texhelpers', {'for': 'tex'}
" quick html generation
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
" gpg decryption
if version >= 702
Plug 'jamessan/vim-gnupg'
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
" align blocks of things
Plug 'junegunn/vim-easy-align'

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
" snippets
if version >= 704 && s:python_ver >= 260
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
endif
" scratch buffer
Plug 'mtth/scratch.vim'
" close all but this buffer
Plug 'duff/vim-bufonly'
" netrw replacement
Plug 'justinmk/vim-dirvish'
if version >= 703 && s:python_ver >= 260
" highlight closing tag
Plug 'Valloric/MatchTagAlways'
endif
" search and replace
Plug 'gabesoft/vim-ags'
" word highlight
Plug 'neitanod/vim-ondemandhighlight'

" =========================================================
" Disabled
" =========================================================
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
" C/C++/Javascript completion
" if version > 703 || (version >= 703 && has('patch584'))
" Plug 'Valloric/YouCompleteMe'
" command! YcmEnable call plug#load('YouCompleteMe') | call youcompleteme#Enable()
" endif

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
