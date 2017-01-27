if !exists('g:plugs') || !has_key(g:plugs, 'vim-fugitive')
  finish
endif

function! GStatusTabDiff()
  if has('multi_byte_encoding')
    let colon = '\%(:\|\%uff1a\)'
  else
    let colon = ':'
  endif
  let filename = matchstr(matchstr(getline(line('.')),'^#\t\zs.\{-\}\ze\%( ([^()[:digit:]]\+)\)\=$'), colon.' *\zs.*')
  tabedit %
  execute 'Gedit ' . filename
  Gvdiff
endfunction
command! GStatusTabDiff call GStatusTabDiff()
autocmd FileType gitcommit noremap <buffer> dt :GStatusTabDiff<CR>

" define diftab command
command! -nargs=* GdiffTab tabedit %|Gdiff <q-args>

" delete fugitive buffers when inactive
autocmd BufReadPost fugitive://* set bufhidden=delete

autocmd FileType gitrebase nnoremap <buffer> <silent> P :Pick<CR>
autocmd FileType gitrebase nnoremap <buffer> <silent> S :Squash<CR>
autocmd FileType gitrebase nnoremap <buffer> <silent> E :Edit<CR>
autocmd FileType gitrebase nnoremap <buffer> <silent> R :Reword<CR>
autocmd FileType gitrebase nnoremap <buffer> <silent> F :Fixup<CR>

nnoremap <leader>g :echo fugitive#head()<CR>
