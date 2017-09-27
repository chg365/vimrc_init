"if isdirectory($HOME . "/.vim/colors")
    " 让终端支持256色，否则很多配色不会正常显示，molokai就是其中之一
    set t_Co=256

    " set cc=100  " colorcolumn 会使刷新变慢

"    if filereadable($HOME . "/.vim/colors/molokai.vim")
        colorscheme molokai
        "let g:molokai_original = 1
        "let g:rehash256 = 1
"    endif
    "if filereadable($HOME . "/.vim/colors/solarized.vim")
        "" set background=light
        "set background=dark
        "colorscheme solarized
        "let g:solarized_termcolors=256
    "endif
" color desert     " 设置背景主题
" color ron     " 设置背景主题
" color torte     " 设置背景主题
"endif
