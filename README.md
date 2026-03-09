# 🔍 BugHunter-Docker 

[![构建状态](https://github.com/b1ank1108/BugHunter-Docker/actions/workflows/docker-build.yml/badge.svg)](https://github.com/b1ank1108/BugHunter-Docker/actions/workflows/docker-build.yml)
[![Docker Pulls](https://img.shields.io/docker/pulls/b1ank1108/bughunter)](https://hub.docker.com/r/b1ank1108/bughunter)
[![Docker Stars](https://img.shields.io/docker/stars/b1ank1108/bughunter)](https://hub.docker.com/r/b1ank1108/bughunter)

一站式网络安全漏洞扫描工具集，基于Docker容器化部署。

[English Version](README_EN.md) | 中文版本

## 📋 项目介绍

BugHunter-Docker是一个集成了多种强大安全工具的Docker容器，专为网络安全专业人员、渗透测试者和漏洞赏金猎人设计。该项目将常用的安全测试工具整合到一个容器中，使您能够快速部署并执行一系列安全测试工作。

最新版本: 20260309

## 🚀 功能特点

- 🛠️ 集成多种顶级安全工具
- 🔄 标准化的工作流程
- 📊 结果输出统一管理
- 🧩 模块化设计，便于扩展
- 🐳 基于Docker，一键部署

## 🔧 包含工具

- **Nuclei**: 强大的漏洞扫描工具
- **Subfinder**: 子域名发现工具
- **HTTPX**: HTTP请求工具
- **DNSX**: DNS工具
- **Notify**: 通知工具
- **Anew**: 数据处理工具
- **Cent**: Nuclei模板管理工具
- **Rayder**: 工作流自动化工具
- **Dirsearch**: 目录扫描工具

## 💻 快速开始

### 构建镜像

```bash
docker build -t bughunter:latest .
```

### 启动容器

```bash
docker-compose up -d
```

### 进入容器

```bash
docker exec -it bughunter bash
```

## 📂 目录结构

- **config/**: 各工具配置文件
- **wordlists/**: 字典文件
- **scripts/**: 自动化脚本
- **output/**: 扫描结果输出
- **tools/**: 额外工具
- **targets/**: 扫描目标
- **workflow/**: 工作流定义文件
- **cent-nuclei-templates/**: 自定义Nuclei模板

## 📝 使用示例

### 子域名发现示例

```bash
./scripts/subfinder-alive.sh
```

这个脚本会执行以下操作：
```bash
# 实际执行的命令
docker exec -it bughunter rayder -w /root/workflow/subfinder-alive.yaml
```

脚本通过Rayder工作流引擎执行`workflow/subfinder-alive.yaml`中定义的工作流，自动化处理子域名的发现、解析和活跃性检测。

## 🔄 自定义工作流

您可以在`workflow/`目录下创建自定义Rayder工作流配置文件，以自动化执行多个工具的组合操作。

### 工作流示例结构

```yaml
# 工作流示例结构
name: 子域名发现和验证
steps:
  - name: 发现子域名
    tool: subfinder
    args:
      - -d {{.TARGET}}
      - -o {{.OUTPUT_DIR}}/subdomains.txt
  
  - name: 检查活跃主机
    tool: httpx
    args:
      - -l {{.OUTPUT_DIR}}/subdomains.txt
      - -o {{.OUTPUT_DIR}}/alive-subdomains.txt
```

## 📊 输出管理

所有扫描结果都保存在`output/`目录中。该目录从主机挂载，因此您无需进入容器即可轻松访问结果。

## 🔒 安全注意事项

- 确保及时更新您的Docker安装和容器内的工具
- 查看`config/`目录中的配置文件，确保它们满足您的安全要求
- 运行容器时注意权限设置

## 🔍 故障排除

如果遇到任何问题：

1. 检查容器日志：`docker logs bughunter`
2. 验证`config/`目录中的工具配置
3. 确保所有卷正确挂载
4. 检查所需文件是否存在于适当的目录中

## 🙏 致谢

感谢以下优秀的开源项目，没有它们就没有这个工具集：

- [ProjectDiscovery](https://github.com/projectdiscovery) - 提供了Nuclei, Subfinder, HTTPX, DNSX, Notify等工具
- [tomnomnom/anew](https://github.com/tomnomnom/anew) - 数据去重工具
- [xm1k3/cent](https://github.com/xm1k3/cent) - Nuclei模板管理工具
- [devanshbatham/rayder](https://github.com/devanshbatham/rayder) - 安全工作流自动化工具
- [maurosoria/dirsearch](https://github.com/maurosoria/dirsearch) - Web路径扫描工具

## 📄 许可证

本项目采用MIT许可证 - 详情请查看LICENSE文件。 