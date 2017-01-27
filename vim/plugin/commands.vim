" search in dictionary
function! s:Dict(command)
  if ! executable('dict')
    echo "dict binary not found"
  else
    let command = join(map(split('dict ' . a:command), 'expand(v:val)'))
    let winnr = bufwinnr('^dict$')
    silent! execute  winnr < 0 ? 'botright new ' . fnameescape('dict') : winnr . 'wincmd w'
    setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap
    echo 'Searching for word ' . command . '...'
    silent! execute 'silent %!'. command
    silent! execute 'resize ' . line('$')
    silent! redraw
    silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
    silent! execute 'nnoremap <silent> <buffer> q :bd<CR>'
  endif
endfunction
command! -nargs=+ Dict call s:Dict(<q-args>)

" strip trailing whitespace
function! s:Strip()
  execute "normal mz"
  %s/\s\+$//gn
  %s/\s\+$//e
  execute "normal `z"
endfunction
command! Strip call s:Strip()

" open scratch buffer
function! s:TempScratch()
  silent! execute ':enew'
  setlocal buftype=nofile bufhidden=hide noswapfile buflisted modifiable
endfunction
command! -nargs=? TempScratch call s:TempScratch()


function! s:Pipe(command)
  let switchbuf_saved = &switchbuf
  set switchbuf=useopen

  let cur_buffer = bufnr("%")
  let pipe_name = "[Pipe] " . bufname(cur_buffer)
  let pipe_buffer = bufnr(pipe_name)

  if pipe_buffer == -1
    let pipe_buffer = bufnr(pipe_name, 1)

    if &splitright
      silent execute "vert sbuffer " . pipe_buffer
    else
      silent execute "sbuffer " . pipe_buffer
    endif

    setlocal buftype=nofile bufhidden=wipe noswapfile
  else
    silent execute "sbuffer" pipe_buffer
  endif

  " copy old buffer to new buffer
  execute ":%d _"
  call append(line('0'), getbufline(cur_buffer, 1, "$"))

  echo "running '" . a:command . "'. this may take some time..."
  let l:start = reltime()
  silent execute ":%!" . a:command
  redraw
  echo "ran '" . a:command . "' in" . reltimestr(reltime(start)) . "s"

  " Go back to the last window.
  silent execute "sbuffer" cur_buffer

  let &switchbuf = switchbuf_saved
endfunction
command! -nargs=1 -complete=shellcmd Pipe call s:Pipe(<q-args>)

" http://vimcasts.org/episodes/project-wide-find-and-replace/
function! s:QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

command! -nargs=0 -bar Qargs execute 'args ' . s:QuickfixFilenames()
command! -nargs=1 -complete=command -bang Qdo exec 'bufdo bd' | exe 'args ' . s:QuickfixFilenames() | argdo<bang> <args>

" Switch between source and header
function! s:SwitchSourceHeader()
  let source = ["cpp", "C", "c", "cc"]
  let header = ["h", "hpp"]
  let candidates = []

  for ext in source
    if expand("%:e") == ext
        let candidates = header
        break
    endif
  endfor

  for ext in header
    if expand("%:e") == ext
        let candidates = source
        break
    endif
  endfor

  for ext in candidates
    let file = expand("%:t:r") . "." . ext
    let found = findfile (file)
    if filereadable(found)
        execute ":edit " . found
        break
    endif
  endfor
endfunction
command! SwitchSourceHeader call s:SwitchSourceHeader()

nnoremap <leader>s :SwitchSourceHeader<CR>

function! s:CloseHiddenBuffers()
  " list of *all* buffer numbers
  let l:buffers = range(1, bufnr('$'))

  " what tab page are we in?
  let l:currentTab = tabpagenr()
  try
    " go through all tab pages
    let l:tab = 0
    while l:tab < tabpagenr('$')
      let l:tab += 1

      " go through all windows
      let l:win = 0
      while l:win < winnr('$')
        let l:win += 1
        " whatever buffer is in this window in this tab, remove it from
        " l:buffers list
        let l:thisbuf = winbufnr(l:win)
        call remove(l:buffers, index(l:buffers, l:thisbuf))
      endwhile
    endwhile

    " if there are any buffers left, delete them
    if len(l:buffers)
      execute 'bwipeout' join(l:buffers)
    endif
  finally
    " go back to our original tab page
    execute 'tabnext' l:currentTab
  endtry
endfunction
command! CloseHiddenBuffers call s:CloseHiddenBuffers()

" change directory to current file
command! Cd :cd! %:p:h

" run external command
command! -nargs=1 -complete=shellcmd Run | execute ':silent !'.<q-args> | execute ':redraw!'

command! CountMatches execute ':%s///gn'

" make * and # find word but not move cursor
nnoremap <silent> * :let @/= '\<'.expand('<cword>').'\>'\|set hlsearch<CR>
nnoremap <silent> # :let @/= '\<'.expand('<cword>').'\>'\|set hlsearch<CR>

" make * and # work on visual mode too.
function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

xnoremap <silent> * :<C-u>call <SID>VSetSearch('/')\|set hlsearch<CR>
xnoremap <silent> # :<C-u>call <SID>VSetSearch('?')\|set hlsearch<CR>
