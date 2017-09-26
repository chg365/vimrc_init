#!/bin/bash

#################################################################################
#                                    系统检测
#################################################################################

# {{{ function exists_soft()
function exists_soft()
{
    local is_error="0"

    for i in `echo "$@"`; do
        which $i >/dev/null 2>&1
        if [ "$?" != "0" ];then
            is_error="1"
            echo "not find soft $i" >&2
        fi
    done

    if [ "$is_error" = "1" ];then
        exit 1;
    fi
}
# }}}
exists_soft git vim sort pwd ctags

#sudo yum -y install ctags vim-minimal vim-common vim-enhanced

# 检测sort 是否支持版本号排序
sort_V="V"
echo '' |sort -V >/dev/null 2>&1
if [ "$?" != "0" ];then
    #不支持
    sort_V=""
    echo "Warning: sort not has -V" >&2
fi

#################################################################################
#                                    目录和变量定义
#################################################################################

curr_dir=`pwd`;

VIM_TMP_DIR="/tmp/${LOGNAME}/vim"

if [ -d "$VIM_TMP_DIR" ];then
    echo "the tmp dir is already exists. dir: $VIM_TMP_DIR " >&2
    exit 1;
fi

bundle_dir=$HOME/.vim/bundle
colors_dir=$HOME/.vim/colors
autoload_dir=$HOME/.vim/autoload

mkdir -p $VIM_TMP_DIR
mkdir -p $HOME/.vim/{bundle,colors,autoload}

# {{{ function git_clone()
function git_clone()
{
    local url="$1"
    local pos="$2"

    if [ "$url" = "" ];then
        echo "git clone not find url" >&2
        return 1;
    fi

#if [ "$pos" != "" ];then
#        git clone $url $pos  >/dev/null 2>&1
#    else
#        git clone $url  >/dev/null 2>&1
#    fi
    git clone $url $pos  >/dev/null 2>&1

    if [ "$?" != "0" ];then
        echo "git clone faild. url: $url  dir: $pos"
            return 1;
    fi
}
# }}}
# {{{ function git_pull()
function git_pull()
{
    git pull >/dev/null 2>&1

    if [ "$?" != "0" ];then
        echo "git pull faild. dir: `pwd`" >&2
        return 1;
    fi
}
# }}}

###################################################################
#                            pathogen
###################################################################

cd $VIM_TMP_DIR && \
   git_clone "https://github.com/tpope/vim-pathogen.git" && \
   cp vim-pathogen/autoload/pathogen.vim $autoload_dir/ &

###################################################################
#                            颜色方案
###################################################################

cd $VIM_TMP_DIR && \
   git_clone "https://github.com/tomasr/molokai.git" && \
   cp molokai/colors/molokai.vim $colors_dir/ &

cd $VIM_TMP_DIR && \
   git_clone "https://github.com/altercation/vim-colors-solarized.git" && \
   cp vim-colors-solarized/colors/solarized.vim $colors_dir/ &

###################################################################
#                            bundle
###################################################################

#更新
#snipmate.vim
#有修改
for i in ` find $HOME/.vim/bundle -mindepth 1 -maxdepth 1 -type d`;
do
{
    #echo ${i##*/};
    cd $i 
    #git remote -v |head -1 | awk '{print $2;}'
    if [ -d ".git" ];then
        git_pull
    fi
} &
done

#nginx
{
cd $VIM_TMP_DIR && \
   git_clone "https://github.com/nginx/nginx.git"

if [ "$?" = "0" ];then
   rm -rf $bundle_dir/nginx
   cp -rf nginx/contrib/vim $bundle_dir/nginx
fi
} &

# 下载
bundle_arr=(
        "https://github.com/ctrlpvim/ctrlp.vim.git"
        "https://github.com/rizzatti/dash.vim.git"
        "https://github.com/airblade/vim-gitgutter.git"
        "https://github.com/mattn/emmet-vim.git"
        "https://github.com/Yggdroot/indentLine.git"
        "https://github.com/scrooloose/nerdcommenter.git"
        "https://github.com/msanders/snipmate.vim.git"
        "https://github.com/godlygeek/tabular.git"
        "https://github.com/vim-scripts/taglist.vim.git"
        "https://github.com/plasticboy/vim-markdown.git"
        "https://github.com/fatih/vim-go.git"
        "https://github.com/yianwillis/vimcdoc.git"
        "https://github.com/jelera/vim-javascript-syntax.git"
        "https://github.com/shawncplus/phpcomplete.vim.git"
        "https://github.com/ervandew/supertab.git"
        "https://github.com/Lokaltog/vim-powerline.git"
        #"https://github.com/vim-scripts/OmniCppComplete.git"
        # "https://github.com/gmarik/Vundle.vim.git"
        ##"https://github.com/powerline/powerline.git"
);

version=`vim --version|head -1|awk '{print $5;}'`;
use_neo=0;
if vim --version|grep -q '+lua' ;then
    ver=`echo "$version 7.4"|tr ' ' '\n'|sort -r${sort_V}|head -1`
    if [ "$ver" = "$version" ];then
        use_neo=1;
    fi
fi
if [ "$use_neo" = "0" ];then
    bundle_arr[${#bundle_arr[@]}]="https://github.com/Shougo/neocomplcache.vim.git"
fi

ver=`echo "$version 7.1"|tr ' ' '\n'|sort -r${sort_V}|head -1`
if [ "$ver" = "$version" ];then
    # 使用neocomplete.vim
    bundle_arr[${#bundle_arr[@]}]="https://github.com/Shougo/neocomplete.vim.git"
    bundle_arr[${#bundle_arr[@]}]="https://github.com/vim-syntastic/syntastic.git"
    bundle_arr[${#bundle_arr[@]}]="https://github.com/majutsushi/tagbar.git"
    bundle_arr[${#bundle_arr[@]}]="https://github.com/scrooloose/nerdtree.git"
    bundle_arr[${#bundle_arr[@]}]="https://github.com/ap/vim-css-color.git"
    bundle_arr[${#bundle_arr[@]}]="https://github.com/StanAngeloff/php.vim.git"
    bundle_arr[${#bundle_arr[@]}]="https://github.com/Xuyuanp/nerdtree-git-plugin.git"
fi

for url in "${bundle_arr[@]}";do
    #echo $url;
    dir_name=${url##*/}
    dir_name=${dir_name%%.git}
    if [ ! -d "$bundle_dir/$dir_name" ];then
        git_clone "$url" "$bundle_dir/$dir_name" &
    fi
done


###################################################################
#                          清理临时文件
###################################################################

cd $curr_dir

wait
# clean tmp dir
rm -rf $VIM_TMP_DIR
