#!/usr/bin/env bash

MIAO_PLUGIN_PATH="/app/Yunzai-Bot/plugins/miao-plugin"
XIAOYAO_CVS_PATH="/app/Yunzai-Bot/plugins/xiaoyao-cvs-plugin"
GUOBA_PLUGIN_PATH="/app/Yunzai-Bot/plugins/Guoba-Plugin"

ACHIEVEMENTS_PLUGIN_PATH="/app/Yunzai-Bot/plugins/achievements-plugin"
EXPAND_PLUGIN_PATH="/app/Yunzai-Bot/plugins/expand-plugin"
FLOWER_PLUGIN_PATH="/app/Yunzai-Bot/plugins/flower-plugin"
STARRAIL_PLUGIN_PATH="/app/Yunzai-Bot/plugins/StarRail-plugin"

cd /app/Yunzai-Bot
git pull
pnpm install -P --registry=https://registry.npmmirror.com
cd $MIAO_PLUGIN_PATH
if [[ -n $(git status -s) ]]; then
    echo -e "\n当前工作区有修改，尝试暂存后更新。"
    git add .
    git stash
    git pull origin master --allow-unrelated-histories --rebase
    git stash pop
else
    git pull origin master --allow-unrelated-histories
fi
pnpm install -P --registry=https://registry.npmmirror.com

if [ -d $XIAOYAO_CVS_PATH"/.git" ]; then
        cd $XIAOYAO_CVS_PATH
    if [[ -n $(git status -s) ]]; then
        echo -e "\n当前工作区有修改，尝试暂存后更新。"
        git add .
        git stash
        git pull origin master --allow-unrelated-histories --rebase
        git stash pop
    else
        git pull origin master --allow-unrelated-histories
    fi
    cd /app/Yunzai-Bot
    pnpm add promise-retry superagent -w
fi

if [ -d $GUOBA_PLUGIN_PATH"/.git" ]; then
    cd $GUOBA_PLUGIN_PATH
    if [[ -n $(git status -s) ]]; then
        echo -e "\n当前工作区有修改，尝试暂存后更新。"
        git add .
        git stash
        git pull origin master --allow-unrelated-histories --rebase
        git stash pop
    else
        git pull origin master --allow-unrelated-histories
    fi
    cd /app/Yunzai-Bot
    pnpm install --filter=guoba-plugin
fi
if [ -f "./config/config/redis.yaml" ]; then
    sed -i 's/127.0.0.1/redis/g' ./config/config/redis.yaml
    echo -e "\n  修改Redis地址完成  \n"
fi

if [ -d $ACHIEVEMENTS_PLUGIN_PATH"/.git" ]; then
    cd $ACHIEVEMENTS_PLUGIN_PATH
    git pull
fi

if [ -d $EXPAND_PLUGIN_PATH"/.git" ]; then
    cd $EXPAND_PLUGIN_PATH
    git pull
fi

if [ -d $FLOWER_PLUGIN_PATH"/.git" ]; then
    cd $FLOWER_PLUGIN_PATH
    git pull
fi

if [ -d $STARRAIL_PLUGIN_PATH"/.git" ]; then
    cd $STARRAIL_PLUGIN_PATH
    git pull
fi

cd /app/Yunzai-Bot
node app