if !exists('g:plugs') || !has_key(g:plugs, 'vim-colors-solarized')
    finish
endif

if !empty($BADTERM)
    let g:solarized_termcolors=256
endif

if !empty($ITERM_PROFILE)
    let g:solarized_termtrans=1
endif

colorscheme solarized

if !empty($LIGHTTERM)
    set background=light
else
    set background=dark
endif

set fillchars+=vert:\ 
hi VertSplit guibg=Black ctermbg=Black
