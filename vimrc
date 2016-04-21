"***********************************
"General Settings
"***********************************
syntax on
filetype plugin indent on
set nocompatible            " no compatibility mode
set laststatus=2            " always display status line
set winaltkeys=no           " disable alt/meta for gui menus
set title titlestring=%t    " set your xterm title
set history=1024            " remember command line history
set showmatch               " show matching bracket when first inserted
set wildmode=longest,list,full " tab completion
set wildmenu                " enable wildmenu for completion with tab
set wildignore+=*.so,*.swp  " ignore in completion
set autoread                " reload if unchanged file was change outside vim
set novb t_vb=              " no visual error
set noerrorbells            " no sound for error (bell)
set textwidth=72            " text width to do hard line wrap
set wrap                    " wrap long lines
set linebreak               " wrap long lines at break chars
set nojoinspaces            " prevents double spaces when joining lines
set fileformat=unix         " default file format
set cindent ai si           " cindent, auto indent, smart indent
set tabstop=4               " set number of spaces used for tab
set shiftwidth=0            " use tabstop as number of spaces when autoindenting
set expandtab               " expand tab to spaces
set smarttab                " replace tab with spaces
set shiftround              " round indents to multiples of shiftwidth
set backspace=2             " backspace over ident, eol and start
set foldmethod=manual       " manual folding, speed boost in large files
set nofoldenable            " remove to enable folding
set hlsearch                " highlight search result
set ignorecase              " search ignores case
set smartcase               " search is case sensitive if using upper case
set incsearch               " enable incremental search
set hidden                  " when abandoning a buffer, hide it
set noswapfile              " disable swap file
set number                  " enable line numbers
set virtualedit=onemore     " allow for cursor beyond last character
set shortmess=filmnxtToOI   " customize messages
set splitbelow              " splits occur below current window
set splitright              " splits occur to the right of current window
set nostartofline           " don’t reset cursor to start of line when moving
set exrc                    " enable per-directory .vimrc files
set secure                  " disable unsafe commands in per-directory .vimrc
set nomodeline              " disable modelines (exploits exist)

" use system clipboard
if has('unnamedplus')
    set clipboard=unnamedplus
else
    set clipboard=unnamed
endif

" configure viminfo
if has('nvim')
    set viminfo='1000,\"100,:20,n~/.nviminfo
else
    set viminfo='1000,\"100,:20,n~/.viminfo
endif

" configure spellchecking
set spellfile=~/.vimspell.add           " save new words
set spellsuggest=best,10

" configure views
set viewdir=~/.vim_view                 " save views

" configure undos
try
    set undofile                        " save undo to file
    set undodir=~/.vim_undo             " set undo directory
catch
endtry

" change settings depending on mode
if has("gui_running")
    set guioptions-=m " remove menubar
    set guioptions-=T " remove toolbar
    set guioptions-=r " remove scrollbar
    set guioptions-=L " remove right scrollbar
    set mousemodel=popup
else
    hi SpellBad ctermfg=Red ctermbg=NONE guibg=NONE guifg=Red cterm=underline gui=underline term=reverse
    hi SpellCap ctermfg=Blue ctermbg=NONE guibg=NONE guifg=Blue cterm=underline gui=underline term=reverse
    if &term == "xterm" || &term == "screen-bce"
        set term=xterm
        set t_Co=256
    endif
    if &term =~ "256color"
        set t_ut=                   " disable background color erase
    endif
endif

" use silversearcher instead of grep
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor\ --column
    if &grepformat !~# '%c'
        set grepformat^=%f:%l:%c:%m
    endif
    let g:ackprg = 'ag --nogroup --nocolor --column'
endif

"************************************
" Autocommands
"************************************
augroup custom-cmds
    " Reload vimrc when modified
    autocmd! BufWritePost .vimrc source ~/.vimrc
    " Unset paste on InsertLeave
    au InsertLeave * silent! set nopaste
    " change directory
    autocmd VimEnter * if isdirectory(expand('%:p:h')) | cd %:p:h | endif
    " Go to last position when reopening file
    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    " Change tab stop for html + javascript
    autocmd FileType html,javascript setlocal ts=2 sw=2
    " Disable line wrap for html
    autocmd FileType html setlocal tw=10000
    " Set type of salt sls files to yaml
    autocmd BufNewFile,BufRead *.sls setlocal ft=yaml ts=2 sw=2
    " Indent and wrap settings for latex
    autocmd BufNewFile,BufRead *.tex setlocal ft=tex fo=tcqaw ts=2 sw=2 nocin colorcolumn=75
    " Set gnuplot filetype
    autocmd BufNewFile,BufRead *.plt,*.gnuplot setf gnuplot
    " Set tioa filetype
    autocmd BufNewFile,BufRead *.tioa setf tioa
    " Enable spell for text files
    autocmd BufNewFile,BufRead *.txt,*.html,*.tex,*.md,README,COMMIT_EDIT_MSG if line2byte(line("$") + 1) < 10000 | setlocal spell spelllang=en | endif
    " close unused netrw buffers
    autocmd FileType netrw setl bufhidden=wipe
    " show trailing spaces http://vim.wikia.com/wiki/Highlight_unwanted_spaces
    au ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
    au BufNewFile,BufRead,InsertLeave * silent! match ExtraWhitespace /\s\+$/
    au InsertEnter * silent! match ExtraWhitespace /\s\+\%#\@<!$/
    " disable syntax highlight on big ruby files
    " autocmd FileType ruby if line2byte(line("$") + 1) > 10000 | syntax clear | endif
augroup END

"************************************
" Custom mappings
"************************************
" remap leader
let mapleader = " "
" Split line
nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>$
" close buffer not window
nnoremap <leader>Z :bp<bar>bd #<CR>
" Smart identation with braces
inoremap {<CR> {<CR>}<c-o>O
" Switch off highlighting
nnoremap <silent> <backspace> :noh<CR>
" Save a few keystrokes
nnoremap <expr> <cr> (&buftype is# "" ? ":" : "<cr>")
" disable Ex mode key
nnoremap Q <nop>

"************************************
" Load other vim settings
"************************************
for f in split(glob("~/.vimrc.pre.*"), "\n") | execute 'source ' . fnameescape(f) | endfor
au VimEnter * for f in split(glob("~/.vimrc.post.*"), "\n") | execute 'source ' . fnameescape(f) | endfor
