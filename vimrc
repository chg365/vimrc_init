if has("lua")
    " echo "aaaa"
endif

" 如果vim启动太慢，用--startuptime,可以知道为什么
" vim --startuptime /tmp/vimslow.log

set nocompatible " 不使用vi的兼容模式 必须是第一个，因为可能会影响其他选项

if exists("$VIMRUNTIM/vimrc_example.vim")
  source $VIMRUNTIM/vimrc_example.vim
endif

" set noswapfile " 不使用交换文件
set hidden " 使得不可见的缓冲区保持载入
" set bufhidden=hide " 缓冲区不再在窗口里显示时的行为

" set linespace=0 " 字符间的像素行为 不支持？

" set list " 显示不可见的tab ^I 换行 $
" set listchars=tab:>-,trail:- " GUI模式 高亮显示空格和TAB, TAB显示成">---" 行尾多余的空白符显示成 -
" set fillchars+=stl:\ ,stlnc:\   "

" 历史记录数
set history=1000

"set report=0 " 报告行改变的行数下限,默认为2

"set noerrorbells " 有错误消息时不响铃
"set autoread " 有vim之外的改动时，自动重读文件

set fileformat=unix
" 
set fileformats=unix,dos  " ,mac

set nobackup " 不备份文件
set nowritebackup " 不备份文件

" 定义新的文件类型
"autocmd BufNewFile,BufRead *.txt set filetype=txt

set backspace=indent,eol,start

"filetype plugin indent on
filetype plugin on

"set autoindent " 自动缩进
"set smartindent
set cindent

set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab " 使用空格代替制表符

set helplang=cn
" set langmenu=zh_CN.UTF-8 " 默认和:language一致

" set smarttab 非空字符后，使用真的<Tab>,设置expandtab后，无效

" set cmdheight=2 " 显示消息的高度(行数)



set termencoding=utf8
set encoding=utf8
"set fileencodings=utf8,ucs-bom,gbk,cp936,gb2312,gb18030
set fileencodings=utf8,chinese,latin1
set fileencoding=utf8

set textwidth=0 " 不自动换行
autocmd FileType text setlocal textwidth=78
autocmd FileType text set noexpandtab "  text文件时不使用空格代替制表符

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 显示相关
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"syntax enable " 会保持当前的色彩设置
syntax on " 会用缺省值覆盖色彩设置

if exists("$HOME/.vim/colors")
    " 让终端支持256色，否则很多配色不会正常显示，molokai就是其中之一
    set t_Co=256

    " set cc=100  " colorcolumn 会使刷新变量

    if exists("$HOME/.vim/colors/molokai.vim")
        colorscheme molokai
        "let g:molokai_original = 1
        "let g:rehash256 = 1
    endif
    "if exists("$HOME/.vim/colors/solarized.vim")
        "" set background=light
        "set background=dark
        "colorscheme solarized
        "let g:solarized_termcolors=256
    "endif
" color desert     " 设置背景主题
" color ron     " 设置背景主题
" color torte     " 设置背景主题
endif

" set foldmethod=syntax
" set foldmethod=indent
set foldmethod=marker " 折叠方式
" autocmd FileType php set foldmethod=marker
" set foldopen=all  " all 时， 当光标在上面后，自动打开折叠
" set foldclose=all " all 时，当光标不在上面后，自动关闭折叠
" set foldenable      " 默认值  显示所有打开的折叠
set foldcolumn=4 " 窗口左边显示一小栏，用来标识折叠, 宽度
" set foldlevel=50

set mousemodel=popup " 鼠标

set wrap " 对长行自动换行
" set linebreak " 行超长时的处理, 优雅换行，不截断单词 lbr
" set whichwrap+=<,>,h,l   " 允许backspace和光标键跨越行边界(不建议)

set cul "高亮光标所在行 cursorline
" set cuc "高亮光标所在列 cursorcolumet

set shortmess+=atI   " 消息显示格式 信息缩写方式 文件名显示不全的方式 只启动vim不显示那个信息

" autocmd InsertLeave * se nocul  " 离开插入模式时 不用浅色高亮当前行
" autocmd InsertEnter * se cul    " 进入插入模式时 用浅色高亮当前行

set ruler           " 显示标尺
set showcmd         " 输入的命令显示出来，看的清楚些
set scrolloff=3     " 光标移动到buffer的顶部和底部时保持3行距离 zt zz zb


set showmatch   " 显示匹配括号
set matchtime=4 " 匹配括号上停留时间,单位为1/10秒

" 状态行显示的内容
" set statusline= " 不会用
" set laststatus=1    " 最后一个窗口显示状态。 使用分隔窗口时(1),总是(2)

" set novisualbell " 可视铃声


"set ignorecase " 搜索时忽略大小写
set hlsearch   " 搜索的字符串高亮
set incsearch  " 在输入过程中就显示匹配点

if exists("$HOME/.vim")

    " pathogen
    if exists("$HOME/.vim/autoload/pathogen.vim")
        execute pathogen#infect()
    endif


    if exists("$HOME/.vim/bundle/syntastic/plugin/syntastic.vim")
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
        highlight SyntasticErrorSign guifg=white guibg=black
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

        nnoremap <Leader>s :call ToggleErrors()<cr>
        " nnoremap <Leader>sn :lnext<cr>
        " nnoremap <Leader>sp :lprevious<cr>
    endif

    " 状态线 觉得没什么用
    if exists("$HOME/.vim/bundle/vim-powerline")
        let g:Powerline_loaded = 1 " 既然不使用，就别再加载了
        "let g:Powerline_symbols='unicode' " 需要set laststatus=2
        "let g:Powerline_symbols = 'fancy'
    endif
endif

" 根据当前窗口的文件切换目录
set autochdir
map <C-n> :NERDTreeToggle<CR>

" golang
"let g:go_snippet_engine = "neosnippet"

set wildmenu " 自动补全，菜单式的补全列表

let g:neocomplete#enable_at_startup = 1
" php自动补全
"autocmd FileType php set omnifunc=phpcomplete#CompletePHP
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.c =
    \ '[^.[:digit:] *\t]\%(\.\|->\)\%(\h\w*\)\?'

let g:neocomplete#sources#omni#input_patterns.php =
    \ '\h\w*\|[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'

let g:phpcomplete_relax_static_constraint = 1 " 0
let g:phpcomplete_complete_for_unknown_classes = 1
let g:phpcomplete_search_tags_for_variables = 1
let g:phpcomplete_min_num_of_chars_for_namespace_completion = 1 " 2
let g:phpcomplete_parse_docblock_comments = 1
let g:phpcomplete_cache_taglists = 1
" let g:phpcomplete_enhance_jump_to_definition = 1
