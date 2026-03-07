FROM nginx:alpine

# 安装 git
RUN apk add --no-cache git bash curl

WORKDIR /usr/share/nginx/html

# clone 官方 dev 分支
RUN git clone --depth 1 -b dev https://github.com/NoFxAiOS/nofx.git /tmp/nofx \
    && cp -r /tmp/nofx/docs/i18n/zh-CN/* /usr/share/nginx/html/ \
    && rm -rf /tmp/nofx

# 修改 nginx 默认 80 端口监听为 7860（Hugging Face 要求）
RUN sed -i 's/listen       80;/listen       7860;/' /etc/nginx/conf.d/default.conf

# Supabase 配置
COPY .env.example /etc/nofx/.env

EXPOSE 7860

CMD ["nginx", "-g", "daemon off;"]
