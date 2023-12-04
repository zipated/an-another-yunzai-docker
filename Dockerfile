FROM busybox:latest AS resource

COPY docker-entrypoint.sh /res/entrypoint.sh

RUN dos2unix /res/entrypoint.sh \
    && chmod +x /res/entrypoint.sh


FROM node:lts-bullseye-slim AS runtime

RUN sed -i "s/deb.debian.org/mirrors.ustc.edu.cn/g" /etc/apt/sources.list \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y wget xz-utils dos2unix \
    && wget https://zipchannel.top:4001/https://raw.githubusercontent.com/zipated/temp/main/miao-yunzai-docker-ffmpeg/ffmpeg-git-$(dpkg --print-architecture)-static.tar.xz \
    && mkdir -p /res/ffmpeg \
    && tar -xvf ./ffmpeg-git-$(dpkg --print-architecture)-static.tar.xz -C /res/ffmpeg --strip-components 1 \
    && cp /res/ffmpeg/ffmpeg /usr/bin/ffmpeg \
    && cp /res/ffmpeg/ffprobe /usr/bin/ffprobe \
    \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y curl wget gnupg git fonts-wqy-microhei xfonts-utils chromium fontconfig libxss1 libgl1 \
    && apt-get autoremove \
    && apt-get clean \
    \
    && fc-cache -f -v \
    \
    && git config --global --add safe.directory '*' \
    && git config --global pull.rebase false \
    && git config --global user.email "Yunzai@yunzai.bot" \
    && git config --global user.name "Yunzai" \
    \
    && npm config set registry https://registry.npmmirror.com \
    && npm install pnpm -g \
    && pnpm config set registry https://registry.npmmirror.com \
    \
    && rm -rf /var/cache/* \
    && rm -rf /tmp/*

FROM runtime AS prod

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

RUN git clone --depth=1 --branch main https://gitee.com/TimeRainStarSky/Yunzai.git /app/Yunzai-Bot \
    && cd /app/Yunzai-Bot \
    && sed -i 's/127.0.0.1/redis/g' ./config/default_config/redis.yaml \
    && pnpm install -P \
    && git remote set-url origin https://gitee.com/TimeRainStarSky/Yunzai.git

COPY --from=resource /res/entrypoint.sh /app/Yunzai-Bot/entrypoint.sh

WORKDIR /app/Yunzai-Bot

ENTRYPOINT ["/app/Yunzai-Bot/entrypoint.sh"]