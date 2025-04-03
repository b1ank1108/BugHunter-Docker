FROM projectdiscovery/nuclei:latest AS nuclei
FROM projectdiscovery/subfinder:latest AS subfinder
FROM projectdiscovery/httpx:latest AS httpx
FROM projectdiscovery/dnsx:latest AS dnsx
FROM projectdiscovery/notify:latest AS notify

FROM golang:1.22-alpine AS gotools
RUN apk add --no-cache git build-base && \
    go install -v github.com/tomnomnom/anew@latest && \
    go install -v github.com/xm1k3/cent@latest && \
    go install github.com/devanshbatham/rayder@v0.0.4

FROM python:3.11.6-alpine

# 安装必要的包并创建目录
RUN apk add --no-cache bash ca-certificates git curl wget \
    gcc musl-dev libffi-dev openssl-dev

# 安装 dirsearch
RUN git clone https://github.com/maurosoria/dirsearch.git /opt/dirsearch && \
    cd /opt/dirsearch && \
    pip install -r requirements.txt && \
    chmod +x dirsearch.py && \
    # 安装完成后，可以删除编译依赖以减小镜像大小
    apk del gcc musl-dev libffi-dev openssl-dev

# 从官方镜像中复制工具
COPY --from=nuclei /usr/local/bin/nuclei /usr/local/bin/
COPY --from=subfinder /usr/local/bin/subfinder /usr/local/bin/
COPY --from=httpx /usr/local/bin/httpx /usr/local/bin/
COPY --from=dnsx /usr/local/bin/dnsx /usr/local/bin/
COPY --from=notify /usr/local/bin/notify /usr/local/bin/
COPY --from=gotools /go/bin/anew /usr/local/bin/
COPY --from=gotools /go/bin/cent /usr/local/bin/
COPY --from=gotools /go/bin/rayder /usr/local/bin/

# 添加工作目录
WORKDIR /root

# 调整 PATH 环境变量顺序，确保 /usr/local/bin 优先于 Python 路径
ENV PATH="/usr/local/bin:/opt/dirsearch:${PATH}"

# 设置默认命令
CMD ["bash"] 