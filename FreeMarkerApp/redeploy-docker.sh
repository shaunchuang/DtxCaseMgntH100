#!/bin/bash

# 取得 git 版本號（使用日期與短 hash）
VERSION=$(date +%Y%m%d)-$(git rev-parse --short HEAD)
IMAGE_NAME=dtxcasemgnt:$VERSION
CONTAINER_NAME=dtxcasemgnt

# 拉取最新程式碼
git fetch
git pull

# 停止並移除舊 container
if [ $(docker ps -aq -f name=$CONTAINER_NAME) ]; then
    docker stop $CONTAINER_NAME
    docker rm $CONTAINER_NAME
fi

# 建立新 image
docker build -t $IMAGE_NAME .

# 啟動新 container
docker run --name $CONTAINER_NAME -d -p 8262:8262 $IMAGE_NAME

echo "已部署版本: $VERSION"