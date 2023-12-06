<strong>自用</strong>的某机器人的docker镜像（需要py的用Dockerfile_poetry

个人原因不想用那个脚本

参考喵~~和SirlyDreamer/Yunzai-Bot-Docker~~

<details><summary>适配器配置文件问题建议自行解决</summary>

  请直接用原脚本。

</details>


<details><summary>建议不要用我这个，反正没人看</summary>

  ~~除非和我一样试了确实用不了他脚本（~~

</details>

<!-- 阿里云用海外机器构建 -->
#

docker-compose.yaml部分参考（自行下载/修改映射需要的部分，例如[genshin]、[miao-plugin](https://github.com/yoimiya-kokomi/miao-plugin)、[默认的js插件]或其他插件/适配器~~（虽然前面这几个默认会带/下载~~
```
version: "3"
services:
  trss-yunzai:
    container_name: TRSS-Yunzai
    # build: .
    image: registry.cn-hangzhou.aliyuncs.com/zipated/trss-yunzai:latest
    # image: registry.cn-hangzhou.aliyuncs.com/zipated/trss-yunzai:poetry
    # image: registry.cn-hangzhou.aliyuncs.com/zipated/trss-yunzai:poetry_bookworm
    restart: always
    #ports:
      # - "50831:50831"                                   # 映射锅巴插件端口，格式"主机端口:容器内部端口"
    volumes:
      - ./Yunzai/data:/app/Yunzai-Bot/data                                                # 用户数据
      - ./Yunzai/config:/app/Yunzai-Bot/config/config                                     # 配置文件
      - ./Yunzai/plugins/genshin:/app/Yunzai-Bot/plugins/genshin                          # 原神核心文件
      - ./Yunzai/resources:/app/Yunzai-Bot/resources                                      # 额外资源文件
      - ./Yunzai/plugins/example:/app/Yunzai-Bot/plugins/example                          # js插件
      # - ./Yunzai/plugins/TRSS-Plugin:/app/Yunzai-Bot/plugins/TRSS-Plugin                  # TRSS插件
      - ./Yunzai/plugins/miao-plugin:/app/Yunzai-Bot/plugins/miao-plugin                  # 喵喵插件
      # - ./Yunzai/plugins/Yunzai-ICQQ-Plugin:/app/Yunzai-Bot/plugins/ICQQ-Plugin    # TRSS适配器 ↓
      # - ./Yunzai/plugins/Yunzai-QQBot-Plugin:/app/Yunzai-Bot/plugins/QQBot-Plugin
      # - ./Yunzai/plugins/Yunzai-QQGuild-Plugin:/app/Yunzai-Bot/plugins/QQGuild-Plugin
      # - ./Yunzai/plugins/Yunzai-WeChat-Plugin:/app/Yunzai-Bot/plugins/WeChat-Plugin
      # - ./Yunzai/plugins/Yunzai-mysVilla-Plugin:/app/Yunzai-Bot/plugins/mysVilla-Plugin
      # - ./Yunzai/plugins/Yunzai-KOOK-Plugin:/app/Yunzai-Bot/plugins/KOOK-Plugin
      # - ./Yunzai/plugins/Yunzai-Telegram-Plugin:/app/Yunzai-Bot/plugins/Telegram-Plugin
      # - ./Yunzai/plugins/Yunzai-Discord-Plugin:/app/Yunzai-Bot/plugins/Discord-Plugin
      # - ./Yunzai/plugins/Yunzai-Route-Plugin:/app/Yunzai-Bot/plugins/Route-Plugin  # TRSS适配器 ↑
      # - ./Yunzai/plugins/xiaoyao-cvs-plugin:/app/Yunzai-Bot/plugins/xiaoyao-cvs-plugin    # cvs图鉴插件
      # - ./Yunzai/plugins/Guoba-Plugin:/app/Yunzai-Bot/plugins/Guoba-Plugin                # 锅巴插件
      # - ./Yunzai/plugins/expand-plugin:/app/Yunzai-Bot/plugins/expand-plugin              # 拓展插件
      # - ./Yunzai/plugins/flower-plugin:/app/Yunzai-Bot/plugins/flower-plugin              # 抽卡插件
      # - ./Yunzai/plugins/StarRail-plugin:/app/Yunzai-Bot/plugins/StarRail-plugin          # 星铁插件
      # - ./Yunzai/plugins/py-plugin:/app/Yunzai-Bot/plugins/py-plugin                      # py-plugin
    depends_on:
      redis: { condition: service_healthy }
    deploy:
      resources:
        limits:
          memory: 2G

  redis:
    container_name: Yunzai-redis
    image: redis:alpine
    restart: always
    volumes:
      # 前往 https://download.redis.io/redis-stable/redis.conf 下载配置文件，放入 ./redis/config 文件夹中
      # - ./redis/config:/etc/redis/    # Redis配置文件
      - ./redis/data:/data
      - ./redis/logs:/logs
    # command: /etc/redis/redis.conf    # 取消注释以应用Redis配置文件
    healthcheck:
      test: [ "CMD", "redis-cli", "PING" ]
      start_period: 10s
      interval: 5s
      timeout: 1s
```
