自用trss yunzai的docker镜像

主要是不想用那个脚本（

参考喵和SirlyDreamer/Yunzai-Bot-Docker

#

docker-compose.yaml部分参考
```
  trss-yunzai:
    container_name: TRSS-Yunzai
    image: zipated/trss-yunzai:latest
    restart: always
    #ports:
      #- "50831:50831"                                   # 映射锅巴插件端口，格式"主机端口:容器内部端口"
    volumes:
      - ./Yunzai/data:/app/Yunzai-Bot/data
      - ./Yunzai/config:/app/Yunzai-Bot/config/config
      - ./Yunzai/plugins/genshin:/app/Yunzai-Bot/plugins/genshin
      - ./Yunzai/plugins/TRSS-Plugin:/app/Yunzai-Bot/plugins/TRSS-Plugin
      - ./Yunzai/plugins/miao-plugin:/app/Yunzai-Bot/plugins/miao-plugin
      #- ./Yunzai/plugins/xiaoyao-cvs-plugin:/app/Yunzai-Bot/plugins/xiaoyao-cvs-plugin    # 图鉴插件
      #- ./Yunzai/plugins/Guoba-Plugin:/app/Yunzai-Bot/plugins/Guoba-Plugin                # 锅巴插件
      #- ./Yunzai/plugins/achievements-plugin:/app/Yunzai-Bot/plugins/achievements-plugin  # 成就插件
      #- ./Yunzai/plugins/expand-plugin:/app/Yunzai-Bot/plugins/expand-plugin              # 拓展插件
      #- ./Yunzai/plugins/flower-plugin:/app/Yunzai-Bot/plugins/flower-plugin              # 抽卡插件
      #- ./Yunzai/plugins/StarRail-plugin:/app/Yunzai-Bot/plugins/StarRail-plugin          # 星铁插件
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