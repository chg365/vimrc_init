"if filereadable($HOME . "/.vim/bundle/syntastic/plugin/syntastic.vim")
    "set statusline+=%#warningmsg#
    "set statusline+=%{SyntasticStatuslineFlag()}
    "set statusline+=%*

    let g:syntastic_php_checkers = ['php']

    " echo syntastic#util#system('echo "$PATH"')

    let g:syntastic_error_symbol = '>>'
    let g:syntastic_warning_symbol = '>'
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0
    let g:syntastic_enable_highlighting = 1
    let g:syntastic_python_checkers = ['pyflakes'] " 使用pyflakes,速度比pylint快
    let g:syntastic_javascript_checkers = ['jsl', 'jshint']
    let g:syntastic_html_checkers = ['tidy', 'jshint']

    " 修改高亮的背景色, 适应主题
    " highlight SyntasticErrorSign guifg=white guibg=black
    " set guifont=PowerlineSymbols\ for\ Powerline

    " to see error location list
    let g:syntastic_always_populate_loc_list = 0
    let g:syntastic_auto_loc_list = 0
    let g:syntastic_loc_list_height = 5

    function! ToggleErrors()
        let old_last_winnr = winnr('$')
        lclose
        if old_last_winnr == winnr('$')
            " Nothing was closed, open syntastic error location panel
            Errors
        endif
    endfunction

    nnoremap <unique> <Leader>s :call ToggleErrors()<cr>
    " nnoremap <Leader>sn :lnext<cr>
    " nnoremap <Leader>sp :lprevious<cr>
"endif
