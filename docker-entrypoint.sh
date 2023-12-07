#!/usr/bin/env bash

# TRSS适配器 和 TRSS-Plugin
ICQQ_PLUGIN_PATH="/app/Yunzai-Bot/plugins/Yunzai-ICQQ-Plugin"
QQBOT_PLUGIN_PATH="/app/Yunzai-Bot/plugins/Yunzai-QQBot-Plugin"
QQGUILD_PLUGIN_PATH="/app/Yunzai-Bot/plugins/Yunzai-QQGuild-Plugin"
WECHAT_PLUGIN_PATH="/app/Yunzai-Bot/plugins/Yunzai-WeChat-Plugin"
MYSVILLA_PLUGIN_PATH="/app/Yunzai-Bot/plugins/Yunzai-mysVilla-Plugin"
KOOK_PLUGIN_PATH="/app/Yunzai-Bot/plugins/Yunzai-KOOK-Plugin"
TELEGRAM_PLUGIN_PATH="/app/Yunzai-Bot/plugins/Yunzai-Telegram-Plugin"
DISCORD_PLUGIN_PATH="/app/Yunzai-Bot/plugins/Yunzai-Discord-Plugin"
ROUTE_PLUGIN_PATH="/app/Yunzai-Bot/plugins/Yunzai-Route-Plugin"
TRSS_PLUGIN_PATH="/app/Yunzai-Bot/plugins/TRSS-Plugin"

#默认插件
MIAO_PLUGIN_PATH="/app/Yunzai-Bot/plugins/miao-plugin"
GENSHIN_PATH="/app/Yunzai-Bot/plugins/genshin"


if [[ ! -d "$HOME/.ovo" ]]; then
    mkdir ~/.ovo
fi

cd /app/Yunzai-Bot
# git checkout package.json
git pull

# 批量更新git
cd /app/Yunzai-Bot/plugins
for file in ./*; do
    if test -d $file; then
        {
            cd $file
            for BRANCH in $(git branch --list | sed 's/\*//g'); do
                if [[ -n $(git status -s) ]]; then
                    # echo -e "\n当前工作区有修改，尝试暂存后更新。"
                    echo -e "\n拉取 $file 更新"
                    echo -e "\n当前工作区有修改，尝试暂存后更新。"
                    git add .
                    git stash
                    git pull origin $BRANCH --allow-unrelated-histories --rebase
                    git stash pop
                else
                    echo -e "\n拉取 $file 更新"
                    git pull --allow-unrelated-histories
                fi
            done
            echo -e "\n更新 $file 执行完成\n"
            cd ..
        }
    fi
done

# 检测 genshin 和 miao-plugin
cd /app/Yunzai-Bot
if [[ ! -d $GENSHIN_PATH"/.git" ]]; then
    echo -e "\n ${Warn} ${YellowBG} 检测到Yunzai-genshin目前没有安装，开始自动下载 ${Font} \n"
    git clone --depth=1 https://gitee.com/TimeRainStarSky/Yunzai-genshin.git ./plugins/genshin/
fi

if [[ ! -d $MIAO_PLUGIN_PATH"/.git" ]]; then
    echo -e "\n ${Warn} ${YellowBG} 由于喵版云崽依赖miao-plugin，检测到目前没有安装，开始自动下载 ${Font} \n"
    git clone --depth=1 https://gitee.com/yoimiya-kokomi/miao-plugin.git ./plugins/miao-plugin/
fi

if [[ -d $PY_PLUGIN_PATH"/.git" ]]; then
    if [[ ! -f "$HOME/.ovo/py.ok" ]]; then
        cd $PY_PLUGIN_PATH
        echo -e "\n ================ \n ${Info} ${GreenBG} 更新 py-plugin 运行依赖 ${Font} \n ================ \n"
        poetry config virtualenvs.in-project true
        poetry install
        touch ~/.ovo/py.ok
    fi
fi

#自用
if [[ -d $ICQQ_PLUGIN_PATH"/.git" ]] || [[ -d $QQBOT_PLUGIN_PATH"/.git" ]] || [[ -d $QQGUILD_PLUGIN_PATH"/.git" ]] || [[ -d $WECHAT_PLUGIN_PATH"/.git" ]] || [[ -d $MYSVILLA_PLUGIN_PATH"/.git" ]] || [[ -d $KOOK_PLUGIN_PATH"/.git" ]] || [[ -d $TELEGRAM_PLUGIN_PATH"/.git" ]] || [[ -d $DISCORD_PLUGIN_PATH"/.git" ]] || [[ -d $ROUTE_PLUGIN_PATH"/.git" ]] || [[ -d $TRSS_PLUGIN_PATH"/.git" ]]; then
    if [[ -d "/app/Yunzai-Bot/config/config/adapter" ]]; then
        if [[ ! -f "$HOME/.ovo/trssconfig.ok" ]]; then
            cp /app/Yunzai-Bot/config/config/adapter/* /app/Yunzai-Bot/config/
            touch ~/.ovo/trssconfig.ok
        fi
    fi
fi

if [[ -f "./config/config/redis.yaml" ]]; then
    sed -i 's/127.0.0.1/redis/g' ./config/config/redis.yaml
    echo -e "\n  修改Redis地址完成  \n"
fi

cd /app/Yunzai-Bot
# pnpm i -P --registry=https://registry.npmmirror.com
pnpm i

cd /app/Yunzai-Bot
node app
EXIT_CODE=$?

if [[ $EXIT_CODE != 0 ]]; then
    echo -e "\n ================ \n ${Warn} ${YellowBG} 启动 Yunzai 失败 ${Font} \n ================ \n"
    tail -f /dev/null
fi
