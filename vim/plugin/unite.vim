if !HasPlug('unite.vim')
  finish
endif

" generalte unite options
let g:unite_source_history_yank_enable = 1
let g:unite_source_history_yank_save_clipboard = 1
let g:unite_source_grep_max_candidates = 500
let g:unite_project_folder = '~/src'
let g:unite_project_list_command = 'find %s -type d -maxdepth 1'

" unimpaired style maps for unite
nmap [z :UnitePrevious<CR>
nmap ]z :UniteNext<CR>
nmap [Z :UniteFirst<CR>
nmap ]Z :UniteLast<CR>

" setup AG with unite
if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor --column -i'
    let g:unite_source_grep_recursive_opt = ''
    let g:unite_source_rec_async_command= 'ag --nocolor --nogroup -g ""'
endif

" custom mappings for the unite buffer
function! s:unite_settings()
    " Play nice with supertab
    let b:SuperTabDisabled=1
    " Enable navigation with control-j and control-k in insert mode
    imap <buffer> <C-j>   <Plug>(unite_select_next_line)
    imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
    imap <buffer> <C-w>   <Plug>(unite_toggle_auto_preview)
    imap <buffer> <C-c>   <Plug>(unite_exit)
    imap <buffer> <Esc>   <Plug>(unite_exit)
    imap <silent><buffer><expr> <C-x> unite#do_action('split')
    imap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
    nmap <buffer> <Esc>   <Plug>(unite_exit)
endfunction

augroup plugin-unite
    call unite#custom#profile('default', 'context', {'start_insert': 1, 'winheight': 15, 'direction': 'botright', })
    call unite#filters#matcher_default#use(['matcher_fuzzy', 'matcher_hide_current_file'])
    call unite#filters#sorter_default#use(['sorter_rank'])
    autocmd FileType unite call s:unite_settings()
augroup END
