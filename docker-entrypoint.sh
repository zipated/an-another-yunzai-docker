#!/usr/bin/env bash

QQGUILD_PLUGIN_PATH="/app/Yunzai-Bot/plugins/QQGuild-Plugin"
TELEGRAM_PLUGIN_PATH="/app/Yunzai-Bot/plugins/Telegram-Plugin"
KOOK_PLUGIN_PATH="/app/Yunzai-Bot/plugins/KOOK-Plugin"
DISCORD_PLUGIN_PATH="/app/Yunzai-Bot/plugins/Discord-Plugin"
ICQQ_PLUGIN_PATH="/app/Yunzai-Bot/plugins/ICQQ-Plugin"

MIAO_PLUGIN_PATH="/app/Yunzai-Bot/plugins/miao-plugin"
GENSHIN_PATH="/app/Yunzai-Bot/plugins/genshin"
XIAOYAO_CVS_PATH="/app/Yunzai-Bot/plugins/xiaoyao-cvs-plugin"
GUOBA_PLUGIN_PATH="/app/Yunzai-Bot/plugins/Guoba-Plugin"

ACHIEVEMENTS_PLUGIN_PATH="/app/Yunzai-Bot/plugins/achievements-plugin"
EXPAND_PLUGIN_PATH="/app/Yunzai-Bot/plugins/expand-plugin"
FLOWER_PLUGIN_PATH="/app/Yunzai-Bot/plugins/flower-plugin"
STARRAIL_PLUGIN_PATH="/app/Yunzai-Bot/plugins/StarRail-plugin"
PY_PLUGIN_PATH="/app/Miao-Yunzai/plugins/py-plugin"

if [[ ! -d "$HOME/.ovo" ]]; then
    mkdir ~/.ovo
fi

cd /app/Yunzai-Bot
git pull
pnpm install -P --registry=https://registry.npmmirror.com

if [[ ! -d $GENSHIN_PATH"/.git" ]]; then
    echo -e "\n ${Warn} ${YellowBG} 检测到Yunzai-genshin目前没有安装，开始自动下载 ${Font} \n"
    git clone --depth=1 https://gitee.com/TimeRainStarSky/Yunzai-genshin.git ./plugins/genshin/
fi

cd $GENSHIN_PATH
if [[ -n $(git status -s) ]]; then
    echo -e "\n当前工作区有修改，尝试暂存后更新。"
    git add .
    git stash
    git pull origin main --allow-unrelated-histories --rebase
    git stash pop
else
    git pull
fi

if [[ ! -d $MIAO_PLUGIN_PATH"/.git" ]]; then
    echo -e "\n ${Warn} ${YellowBG} 由于喵版云崽依赖miao-plugin，检测到目前没有安装，开始自动下载 ${Font} \n"
    git clone --depth=1 https://gitee.com/yoimiya-kokomi/miao-plugin.git ./plugins/miao-plugin/
fi

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

if [[ -d $ICQQ_PLUGIN_PATH"/.git" ]]; then
    cd $ICQQ_PLUGIN_PATH
    if [[ -n $(git status -s) ]]; then
        echo -e "\n当前工作区有修改，尝试暂存后更新。"
        git add .
        git stash
        git pull origin main --allow-unrelated-histories --rebase
        git stash pop
    else
        git pull origin main --allow-unrelated-histories
    fi
    if [ -e $ICQQ_PLUGIN_PATH"/config.yaml" ] && [ ! -e "/app/Yunzai-Bot/config/ICQQ.yaml" ]; then
        echo -e "检测到 ICQQ-Plugin 配置文件旧位置，复制到config/ICQQ.yaml\n"
        cp config.yaml /app/Yunzai-Bot/config/ICQQ.yaml
        mv config.yaml ICQQ.yaml.bak
    else
        if [ -e "ICQQ.yaml.bak" ] && [ -e "/app/Yunzai-Bot/config/ICQQ.yaml" ]; then
            if [[ "ICQQ.yaml.bak" -nt "/app/Yunzai-Bot/config/ICQQ.yaml" ]]; then
                cp ICQQ.yaml.bak /app/Yunzai-Bot/config/ICQQ.yaml
            fi
        fi
        if [[ -e "/app/Yunzai-Bot/config/config/ICQQ.yaml" ]]; then
            echo -e "\n时雨：乐"
        fi
        # 自用
        if [[ -e "/app/Yunzai-Bot/config/config/adapter/ICQQ.yaml" ]]; then
            if [ "/app/Yunzai-Bot/config/config/adapter/ICQQ.yaml" -nt "/app/Yunzai-Bot/config/ICQQ.yaml" ] || [ ! -e "/app/Yunzai-Bot/config/ICQQ.yaml" ]; then
                cp app/Yunzai-Bot/config/config/adapter/ICQQ.yaml /app/Yunzai-Bot/config/ICQQ.yaml
            fi
        fi
    fi
fi

if [[ -d $QQGUILD_PLUGIN_PATH"/.git" ]]; then
    cd $QQGUILD_PLUGIN_PATH
    if [[ -n $(git status -s) ]]; then
        echo -e "\n当前工作区有修改，尝试暂存后更新。"
        git add .
        git stash
        git pull origin main --allow-unrelated-histories --rebase
        git stash pop
    else
        git pull origin main --allow-unrelated-histories
    fi
    if [ -e $QQGUILD_PLUGIN_PATH"/config.yaml" ] && [ ! -e "/app/Yunzai-Bot/config/QQGuild.yaml" ]; then
        echo -e "检测到 QQGuild-Plugin 配置文件旧位置，复制到config/QQGuild.yaml\n"
        cp config.yaml /app/Yunzai-Bot/config/QQGuild.yaml
        mv config.yaml QQGuild.yaml.bak
    else
        if [ -e "QQGuild.yaml.bak" ] && [ -e "/app/Yunzai-Bot/config/QQGuild.yaml" ]; then
            if [[ "QQGuild.yaml.bak" -nt "/app/Yunzai-Bot/config/QQGuild.yaml" ]]; then
                cp QQGuild.yaml.bak /app/Yunzai-Bot/config/QQGuild.yaml
            fi
        fi
        if [[ -e "/app/Yunzai-Bot/config/config/QQGuild.yaml" ]]; then
            echo -e "\n时雨：乐"
        fi
        # 自用
        if [[ -e "/app/Yunzai-Bot/config/config/adapter/QQGuild.yaml" ]]; then
            if [ "/app/Yunzai-Bot/config/config/adapter/QQGuild.yaml" -nt "/app/Yunzai-Bot/config/QQGuild.yaml" ] || [ ! -e "/app/Yunzai-Bot/config/QQGuild.yaml" ]; then
                cp app/Yunzai-Bot/config/config/adapter/QQGuild.yaml /app/Yunzai-Bot/config/QQGuild.yaml
            fi
        fi
    fi
fi

if [[ -d $TELEGRAM_PLUGIN_PATH"/.git" ]]; then
    cd $TELEGRAM_PLUGIN_PATH
    if [[ -n $(git status -s) ]]; then
        echo -e "\n当前工作区有修改，尝试暂存后更新。"
        git add .
        git stash
        git pull origin main --allow-unrelated-histories --rebase
        git stash pop
    else
        git pull origin main --allow-unrelated-histories
    fi
    if [ -e $TELEGRAM_PLUGIN_PATH"/config.yaml" ] && [ ! -e "/app/Yunzai-Bot/config/Telegram.yaml" ]; then
        echo -e "检测到 Telegram-Plugin 配置文件旧位置，复制到config/Telegram.yaml\n"
        cp config.yaml /app/Yunzai-Bot/config/Telegram.yaml
        mv config.yaml Telegram.yaml.bak
    else
        if [ -e "Telegram.yaml.bak" ] && [ -e "/app/Yunzai-Bot/config/Telegram.yaml" ]; then
            if [[ "Telegram.yaml.bak" -nt "/app/Yunzai-Bot/config/Telegram.yaml" ]]; then
                cp Telegram.yaml.bak /app/Yunzai-Bot/config/Telegram.yaml
            fi
        fi
        if [[ -e "/app/Yunzai-Bot/config/config/Telegram.yaml" ]]; then
            echo -e "\n时雨：乐"
        fi
        # 自用
        if [[ -e "/app/Yunzai-Bot/config/config/adapter/Telegram.yaml" ]]; then
            if [ "/app/Yunzai-Bot/config/config/adapter/Telegram.yaml" -nt "/app/Yunzai-Bot/config/Telegram.yaml" ] || [ ! -e "/app/Yunzai-Bot/config/Telegram.yaml" ]; then
                cp app/Yunzai-Bot/config/config/adapter/Telegram.yaml /app/Yunzai-Bot/config/Telegram.yaml
            fi
        fi
    fi
fi

if [[ -d $KOOK_PLUGIN_PATH"/.git" ]]; then
    cd $KOOK_PLUGIN_PATH
    if [[ -n $(git status -s) ]]; then
        echo -e "\n当前工作区有修改，尝试暂存后更新。"
        git add .
        git stash
        git pull origin main --allow-unrelated-histories --rebase
        git stash pop
    else
        git pull origin main --allow-unrelated-histories
    fi
    if [ -e $KOOK_PLUGIN_PATH"/config.yaml" ] && [ ! -e "/app/Yunzai-Bot/config/KOOK.yaml" ]; then
        echo -e "检测到 KOOK-Plugin 配置文件旧位置，复制到config/KOOK.yaml\n"
        cp config.yaml /app/Yunzai-Bot/config/KOOK.yaml
        mv config.yaml KOOK.yaml.bak
    else
        if [ -e "KOOK.yaml.bak" ] && [ -e "/app/Yunzai-Bot/config/KOOK.yaml" ]; then
            if [[ "KOOK.yaml.bak" -nt "/app/Yunzai-Bot/config/KOOK.yaml" ]]; then
                cp KOOK.yaml.bak /app/Yunzai-Bot/config/KOOK.yaml
            fi
        fi
        if [[ -e "/app/Yunzai-Bot/config/config/KOOK.yaml" ]]; then
            echo -e "\n时雨：乐"
        fi
        # 自用
        if [[ -e "/app/Yunzai-Bot/config/config/adapter/KOOK.yaml" ]]; then
            if [ "/app/Yunzai-Bot/config/config/adapter/KOOK.yaml" -nt "/app/Yunzai-Bot/config/KOOK.yaml" ] || [ ! -e "/app/Yunzai-Bot/config/KOOK.yaml" ]; then
                cp app/Yunzai-Bot/config/config/adapter/KOOK.yaml /app/Yunzai-Bot/config/KOOK.yaml
            fi
        fi
    fi
fi

if [[ -d $DISCORD_PLUGIN_PATH"/.git" ]]; then
    cd $DISCORD_PLUGIN_PATH
    if [[ -n $(git status -s) ]]; then
        echo -e "\n当前工作区有修改，尝试暂存后更新。"
        git add .
        git stash
        git pull origin main --allow-unrelated-histories --rebase
        git stash pop
    else
        git pull origin main --allow-unrelated-histories
    fi
    if [ -e $DISCORD_PLUGIN_PATH"/config.yaml" ] && [ ! -e "/app/Yunzai-Bot/config/Discord.yaml" ]; then
        echo -e "检测到 Discord-Plugin 配置文件旧位置，复制到config/Discord.yaml\n"
        cp config.yaml /app/Yunzai-Bot/config/Discord.yaml
        mv config.yaml Discord.yaml.bak
    else
        if [ -e "Discord.yaml.bak" ] && [ -e "/app/Yunzai-Bot/config/Discord.yaml" ]; then
            if [[ "Discord.yaml.bak" -nt "/app/Yunzai-Bot/config/Discord.yaml" ]]; then
                cp Discord.yaml.bak /app/Yunzai-Bot/config/Discord.yaml
            fi
        fi
        if [[ -e "/app/Yunzai-Bot/config/config/Discord.yaml" ]]; then
            echo -e "\n时雨：乐"
        fi
        # 自用
        if [[ -e "/app/Yunzai-Bot/config/config/adapter/Discord.yaml" ]]; then
            if [ "/app/Yunzai-Bot/config/config/adapter/Discord.yaml" -nt "/app/Yunzai-Bot/config/Discord.yaml" ] || [ ! -e "/app/Yunzai-Bot/config/Discord.yaml" ]; then
                cp app/Yunzai-Bot/config/config/adapter/Discord.yaml /app/Yunzai-Bot/config/Discord.yaml
            fi
        fi
    fi
fi

if [ -d $ICQQ_PLUGIN_PATH"/.git" ] || [ -d $QQGUILD_PLUGIN_PATH"/.git" ] || [ -d $TELEGRAM_PLUGIN_PATH"/.git" ] || [ -d $KOOK_PLUGIN_PATH"/.git" ] || [ -d $DISCORD_PLUGIN_PATH"/.git" ]; then
    cd /app/Yunzai-Bot
    pnpm install
fi

if [[ -d $GUOBA_PLUGIN_PATH"/.git" ]]; then
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

if [[ -d $PY_PLUGIN_PATH"/.git" ]]; then

    echo -e "\n ================ \n ${Info} ${GreenBG} 拉取 py-plugin 插件更新 ${Font} \n ================ \n"

    cd $PY_PLUGIN_PATH

    if [[ -n $(git status -s) ]]; then
        echo -e " ${Warn} ${YellowBG} 当前工作区有修改，尝试暂存后更新。${Font}"
        git add .
        git stash
        git pull origin v3 --allow-unrelated-histories --rebase
        git stash pop
    else
        git pull origin v3 --allow-unrelated-histories
    fi

    if [[ ! -f "$HOME/.ovo/py.ok" ]]; then
        echo -e "\n ================ \n ${Info} ${GreenBG} 更新 py-plugin 运行依赖 ${Font} \n ================ \n"
    fi
    pnpm install --filter=py-plugin
    if [[ ! -f "$HOME/.ovo/py.ok" ]]; then
        poetry config virtualenvs.in-project true
        poetry install
        touch ~/.ovo/py.ok
    fi
    
    echo -e "\n ================ \n ${Version} ${BlueBG} py-plugin 插件版本信息 ${Font} \n ================ \n"

    git log -1 --pretty=format:"%h - %an, %ar (%cd) : %s"

fi

if [[ -d $XIAOYAO_CVS_PATH"/.git" ]]; then
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

if [[ -f "./config/config/redis.yaml" ]]; then
    sed -i 's/127.0.0.1/redis/g' ./config/config/redis.yaml
    echo -e "\n  修改Redis地址完成  \n"
fi

if [[ -d $ACHIEVEMENTS_PLUGIN_PATH"/.git" ]]; then
    cd $ACHIEVEMENTS_PLUGIN_PATH
    git pull
fi

if [[ -d $EXPAND_PLUGIN_PATH"/.git" ]]; then
    cd $EXPAND_PLUGIN_PATH
    git pull
fi

if [[ -d $FLOWER_PLUGIN_PATH"/.git" ]]; then
    cd $FLOWER_PLUGIN_PATH
    git pull
fi

if [[ -d $STARRAIL_PLUGIN_PATH"/.git" ]]; then
    cd $STARRAIL_PLUGIN_PATH
    git pull
fi

cd /app/Yunzai-Bot
node app
EXIT_CODE=$?

if [[ $EXIT_CODE != 0 ]]; then
    echo -e "\n ================ \n ${Warn} ${YellowBG} 启动 Yunzai 失败 ${Font} \n ================ \n"
    tail -f /dev/null
fi

if [[ $EXIT_CODE == 0 ]]; then
    if [[ -e "/app/Yunzai-Bot/config/ICQQ.yaml" ]]; then
        if [[ -e $ICQQ_PLUGIN_PATH"/ICQQ.yaml.bak" ]]; then
            if [[ "/app/Yunzai-Bot/config/ICQQ.yaml" -nt $ICQQ_PLUGIN_PATH"/ICQQ.yaml.bak" ]]; then
                cp /app/Yunzai-Bot/config/ICQQ.yaml $ICQQ_PLUGIN_PATH/ICQQ.yaml.bak
            fi
        fi
        if [[ -e "/app/Yunzai-Bot/config/config/ICQQ.yaml" ]]; then
            if [[ "/app/Yunzai-Bot/config/ICQQ.yaml" -nt "/app/Yunzai-Bot/config/config/ICQQ.yaml" ]]; then
                cp /app/Yunzai-Bot/config/ICQQ.yaml /app/Yunzai-Bot/config/config/ICQQ.yaml
            fi
        fi
        # 自用
        if [[ -e "/app/Yunzai-Bot/config/config/adapter/ICQQ.yaml" ]]; then
            if [[ "/app/Yunzai-Bot/config/ICQQ.yaml" -nt "/app/Yunzai-Bot/config/config/adapter/ICQQ.yaml" ]]; then
                cp /app/Yunzai-Bot/config/ICQQ.yaml /app/Yunzai-Bot/config/config/adapter/ICQQ.yaml
            fi
        fi
    fi
    if [[ -e "/app/Yunzai-Bot/config/QQGuild.yaml" ]]; then
        if [[ -e $QQGUILD_PLUGIN_PATH"/QQGuild.yaml.bak" ]]; then
            if [[ "/app/Yunzai-Bot/config/QQGuild.yaml" -nt $QQGUILD_PLUGIN_PATH"/QQGuild.yaml.bak" ]]; then
                cp /app/Yunzai-Bot/config/QQGuild.yaml $QQGUILD_PLUGIN_PATH/QQGuild.yaml.bak
            fi
        fi
        if [[ -e "/app/Yunzai-Bot/config/config/QQGuild.yaml" ]]; then
            if [[ "/app/Yunzai-Bot/config/QQGuild.yaml" -nt "/app/Yunzai-Bot/config/config/QQGuild.yaml" ]]; then
                cp /app/Yunzai-Bot/config/QQGuild.yaml /app/Yunzai-Bot/config/config/QQGuild.yaml
            fi
        fi
        # 自用
        if [[ -e "/app/Yunzai-Bot/config/config/adapter/QQGuild.yaml" ]]; then
            if [[ "/app/Yunzai-Bot/config/QQGuild.yaml" -nt "/app/Yunzai-Bot/config/config/adapter/QQGuild.yaml" ]]; then
                cp /app/Yunzai-Bot/config/QQGuild.yaml /app/Yunzai-Bot/config/config/adapter/QQGuild.yaml
            fi
        fi
    fi
    if [[ -e "/app/Yunzai-Bot/config/Telegram.yaml" ]]; then
        if [[ -e $TELEGRAM_PLUGIN_PATH"/Telegram.yaml.bak" ]]; then
            if [[ "/app/Yunzai-Bot/config/Telegram.yaml" -nt $TELEGRAM_PLUGIN_PATH"/Telegram.yaml.bak" ]]; then
                cp /app/Yunzai-Bot/config/Telegram.yaml $TELEGRAM_PLUGIN_PATH/Telegram.yaml.bak
            fi
        fi
        if [[ -e "/app/Yunzai-Bot/config/config/Telegram.yaml" ]]; then
            if [[ "/app/Yunzai-Bot/config/Telegram.yaml" -nt "/app/Yunzai-Bot/config/config/Telegram.yaml" ]]; then
                cp /app/Yunzai-Bot/config/Telegram.yaml /app/Yunzai-Bot/config/config/Telegram.yaml
            fi
        fi
        # 自用
        if [[ -e "/app/Yunzai-Bot/config/config/adapter/Telegram.yaml" ]]; then
            if [[ "/app/Yunzai-Bot/config/Telegram.yaml" -nt "/app/Yunzai-Bot/config/config/adapter/Telegram.yaml" ]]; then
                cp /app/Yunzai-Bot/config/Telegram.yaml /app/Yunzai-Bot/config/config/adapter/Telegram.yaml
            fi
        fi
    fi
    if [[ -e "/app/Yunzai-Bot/config/KOOK.yaml" ]]; then
        if [[ -e $KOOK_PLUGIN_PATH"/KOOK.yaml.bak" ]]; then
            if [[ "/app/Yunzai-Bot/config/KOOK.yaml" -nt $KOOK_PLUGIN_PATH"/KOOK.yaml.bak" ]]; then
                cp /app/Yunzai-Bot/config/KOOK.yaml $KOOK_PLUGIN_PATH/KOOK.yaml.bak
            fi
        fi
        if [[ -e "/app/Yunzai-Bot/config/config/KOOK.yaml" ]]; then
            if [[ "/app/Yunzai-Bot/config/KOOK.yaml" -nt "/app/Yunzai-Bot/config/config/KOOK.yaml" ]]; then
                cp /app/Yunzai-Bot/config/KOOK.yaml /app/Yunzai-Bot/config/config/KOOK.yaml
            fi
        fi
        # 自用
        if [[ -e "/app/Yunzai-Bot/config/config/adapter/KOOK.yaml" ]]; then
            if [[ "/app/Yunzai-Bot/config/KOOK.yaml" -nt "/app/Yunzai-Bot/config/config/adapter/KOOK.yaml" ]]; then
                cp /app/Yunzai-Bot/config/KOOK.yaml /app/Yunzai-Bot/config/config/adapter/KOOK.yaml
            fi
        fi
    fi
    if [[ -e "/app/Yunzai-Bot/config/Discord.yaml" ]]; then
        if [[ -e $DISCORD_PLUGIN_PATH"/Discord.yaml.bak" ]]; then
            if [[ "/app/Yunzai-Bot/config/Discord.yaml" -nt $DISCORD_PLUGIN_PATH"/Discord.yaml.bak" ]]; then
                cp /app/Yunzai-Bot/config/Discord.yaml $DISCORD_PLUGIN_PATH/Discord.yaml.bak
            fi
        fi
        if [[ -e "/app/Yunzai-Bot/config/config/Discord.yaml" ]]; then
            if [[ "/app/Yunzai-Bot/config/Discord.yaml" -nt "/app/Yunzai-Bot/config/config/Discord.yaml" ]]; then
                cp /app/Yunzai-Bot/config/Discord.yaml /app/Yunzai-Bot/config/config/Discord.yaml
            fi
        fi
        # 自用
        if [[ -e "/app/Yunzai-Bot/config/config/adapter/Discord.yaml" ]]; then
            if [[ "/app/Yunzai-Bot/config/Discord.yaml" -nt "/app/Yunzai-Bot/config/config/adapter/Discord.yaml" ]]; then
                cp /app/Yunzai-Bot/config/Discord.yaml /app/Yunzai-Bot/config/config/adapter/Discord.yaml
            fi
        fi
    fi
fi

