#!/bin/bash

# 更新系统包列表
sudo apt update

# 安装必要的软件包以允许 apt 通过 HTTPS 使用存储库
sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

# 添加 Docker 的官方 GPG 密钥
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# 设置稳定版 Docker 存储库
echo "deb [signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 安装 Docker Engine
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

# 添加当前用户到 docker 用户组以避免使用 sudo 运行 Docker 命令
sudo usermod -aG docker $USER

# 重新启动 Docker 服务
sudo systemctl restart docker
