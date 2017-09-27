" if filereadable($HOME . "/.vim/bundle/neocomplete.vim/autoload/neocomplete.vim")
"if exists('g:loaded_neocomplete')
    set wildmenu " 自动补全，菜单式的补全列表
    let g:neocomplete#enable_at_startup = 1
    " php自动补全
    "autocmd FileType php set omnifunc=phpcomplete#CompletePHP
    if !exists('g:neocomplete#sources#omni#input_patterns')
        let g:neocomplete#sources#omni#input_patterns = {}
    endif
    let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)\%(\h\w*\)\?'

    let g:neocomplete#sources#omni#input_patterns.php = '\h\w*\|[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'

    let g:phpcomplete_relax_static_constraint = 1 " 0
    let g:phpcomplete_complete_for_unknown_classes = 1
    let g:phpcomplete_search_tags_for_variables = 1
    let g:phpcomplete_min_num_of_chars_for_namespace_completion = 1 " 2
    let g:phpcomplete_parse_docblock_comments = 1
    let g:phpcomplete_cache_taglists = 1
    " let g:phpcomplete_enhance_jump_to_definition = 1
"endif
