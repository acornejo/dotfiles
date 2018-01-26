if !empty($LIGHTTERM)
    set background=light
else
    set background=dark
endif

if HasPlug('vim-solarized8')
    colorscheme solarized8_flat
    if has('termguicolors') && empty($BADTERM)
        set termguicolors
    endif
elseif HasPlug('vim-colors-solarized')
    if !empty($BADTERM)
        let g:solarized_termcolors=256
    endif

    if !empty($ITERM_PROFILE)
        let g:solarized_termtrans=1
    endif
    colorscheme solarized
elseif HasPlug('molokai')
  colorscheme molokai
endif

set fillchars+=vert:\ 
