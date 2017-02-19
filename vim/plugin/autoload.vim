augroup custom-cmds
    " Clear current autocommand group
    autocmd!
    " Reload vimrc when modified
    autocmd BufWritePost .vimrc source ~/.vimrc
    " Unset paste on InsertLeave
    autocmd InsertLeave * silent! set nopaste
    " make quickfix windows span full width
    autocmd FileType qf wincmd J
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
    " Set log filetype
    autocmd BufNewFile,BufRead *.log setlocal ft=log
    " Set no wrap for command line editing
    autocmd BufRead bash-* setlocal tw=0 ft=sh
    autocmd FileType log setlocal nowrap colorcolumn=
    " Enable spell for text files
    autocmd BufNewFile,BufRead *.txt,*.html,*.tex,*.md,README,COMMIT_EDIT_MSG if line2byte(line("$") + 1) < 10000 | setlocal spell spelllang=en | endif
    " Set comment string for c++
    autocmd FileType cpp setlocal commentstring=//\ %s
    " close unused netrw buffers
    autocmd FileType netrw setl bufhidden=wipe
    autocmd FileType netrw nnoremap <buffer> Q :Rexplore<CR>
    " show trailing spaces http://vim.wikia.com/wiki/Highlight_unwanted_spaces
    autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
    autocmd BufNewFile,BufRead,InsertLeave * silent! match ExtraWhitespace /\s\+$/
    autocmd InsertEnter * silent! match ExtraWhitespace /\s\+\%#\@<!$/
    " disable syntax highlight on big ruby files
    " autocmd FileType ruby if line2byte(line("$") + 1) > 10000 | syntax clear | endif
augroup END
