#!/bin/bash

curr_dir=`pwd`;

VIM_TMP_DIR="/tmp/${LOGNAME}/vim"

if [ -d "$VIM_TMP_DIR" ];then
    echo "the tmp dir is already exists. dir: $VIM_TMP_DIR " >&2
    exit 1;
fi

which vim >/dev/null 2>&1
if [ "$?" != "0" ];then
    sudo yum -y install ctags vim-minimal.x86_64 vim-common.x86_64 vim-enhanced.x86_64 &
fi

bundle_dir=$HOME/.vim/bundle
colors_dir=$HOME/.vim/colors
autoload_dir=$HOME/.vim/autoload

mkdir -p $VIM_TMP_DIR
mkdir -p $HOME/.vim/{bundle,colors,autoload}



###################################################################
#                            Vundle
###################################################################

# git clone https://github.com/gmarik/Vundle.vim.git $bundle_dir/Vundle.vim &

###################################################################
#                            pathogen
###################################################################

cd $VIM_TMP_DIR && \
   git clone https://github.com/tpope/vim-pathogen.git && \
   cp vim-pathogen/autoload/pathogen.vim $autoload_dir/ &

###################################################################
#                            颜色方案
###################################################################

cd $VIM_TMP_DIR && \
   git clone https://github.com/tomasr/molokai.git && \
   cp molokai/colors/molokai.vim $colors_dir/ &

cd $VIM_TMP_DIR && \
   git clone https://github.com/altercation/vim-colors-solarized.git && \
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
        git pull
    fi
} &
done

#nginx
{
cd $VIM_TMP_DIR && \
   git clone https://github.com/nginx/nginx.git

if [ "$?" = "0" ];then
   rm -rf $bundle_dir/nginx
   cp -rf nginx/contrib/vim $bundle_dir/nginx
fi
} &

# 下载
bundle_arr=(
        "https://github.com/ctrlpvim/ctrlp.vim.git"
        "https://github.com/rizzatti/dash.vim.git"
        "https://github.com/StanAngeloff/php.vim.git"
        "https://github.com/airblade/vim-gitgutter.git"
        "https://github.com/mattn/emmet-vim.git"
        "https://github.com/Yggdroot/indentLine.git"
        # "https://github.com/Shougo/neocomplcache.vim.git"
        # "https://github.com/Shougo/neocomplete.vim.git"
        "https://github.com/scrooloose/nerdcommenter.git"
        "https://github.com/scrooloose/nerdtree.git"
        "https://github.com/msanders/snipmate.vim.git"
        "https://github.com/godlygeek/tabular.git"
        "https://github.com/majutsushi/tagbar.git"
        "https://github.com/vim-scripts/taglist.vim.git"
        "https://github.com/vim-syntastic/syntastic.git"
        "https://github.com/vim-scripts/OmniCppComplete.git"
        "https://github.com/plasticboy/vim-markdown.git"
        "https://github.com/ap/vim-css-color.git"
        "https://github.com/fatih/vim-go.git"
        "https://github.com/yianwillis/vimcdoc.git"
        "https://github.com/jelera/vim-javascript-syntax.git"
        "https://github.com/gmarik/Vundle.vim.git"
        "https://github.com/shawncplus/phpcomplete.vim.git"
        "https://github.com/ervandew/supertab.git"
        "https://github.com/Lokaltog/vim-powerline.git"
        ##"https://github.com/powerline/powerline.git"
);

use_neo=0;
if vim --version|grep -q '+lua' ;then
    version=`vim --version|head -1|awk '{print $5;}'`;
    ver=`echo "$version 7.4"|tr ' ' '\n'|sort -rV|head -1`
    if [ "$ver" = "$version" ];then
        use_neo=1;
    fi
fi
if [ "$use_neo" = "0" ];then
    bundle_arr[${#bundle_arr[@]}]="https://github.com/Shougo/neocomplcache.vim.git"
else
    # 使用neocomplete.vim
    bundle_arr[${#bundle_arr[@]}]="https://github.com/Shougo/neocomplete.vim.git"
fi

for url in "${bundle_arr[@]}";do
    #echo $url;
    dir_name=${url##*/}
    dir_name=${dir_name%%.git}
    if [ ! -d "$bundle_dir/$dir_name" ];then
        git clone $url $bundle_dir/$dir_name &
    fi
done


###################################################################
#                          清理临时文件
###################################################################

cd $curr_dir

wait
# clean tmp dir
rm -rf $VIM_TMP_DIR
