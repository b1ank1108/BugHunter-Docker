# 🔍 BugHunter-Docker

[![Build Status](https://github.com/b1ank1108/BugHunter-Docker/actions/workflows/docker-build.yml/badge.svg)](https://github.com/b1ank1108/BugHunter-Docker/actions/workflows/docker-build.yml)
[![Docker Pulls](https://img.shields.io/docker/pulls/b1ank1108/bughunter)](https://hub.docker.com/r/b1ank1108/bughunter)
[![Docker Stars](https://img.shields.io/docker/stars/b1ank1108/bughunter)](https://hub.docker.com/r/b1ank1108/bughunter)

All-in-one cybersecurity vulnerability scanning toolkit, based on Docker containerized deployment.

English Version | [中文版本](README.md)

## 📋 Project Introduction

BugHunter-Docker is a Docker container that integrates multiple powerful security tools, designed for cybersecurity professionals, penetration testers, and bug bounty hunters. This project consolidates commonly used security testing tools into a single container, enabling you to quickly deploy and execute a variety of security testing tasks.

Latest version: 20250404

## 🚀 Features

- 🛠️ Integration of multiple top-tier security tools
- 🔄 Standardized workflows
- 📊 Unified management of results
- 🧩 Modular design for easy expansion
- 🐳 Docker-based, one-click deployment

## 🔧 Included Tools

- **Nuclei**: Powerful vulnerability scanning tool
- **Subfinder**: Subdomain discovery tool
- **HTTPX**: HTTP request tool
- **DNSX**: DNS tool
- **Notify**: Notification tool
- **Anew**: Data processing tool
- **Cent**: Nuclei template management tool
- **Rayder**: Workflow automation tool
- **Dirsearch**: Directory scanning tool

## 💻 Quick Start

### Build the Image

```bash
docker build -t bughunter:latest .
```

### Start the Container

```bash
docker-compose up -d
```

### Enter the Container

```bash
docker exec -it bughunter bash
```

## 📂 Directory Structure

- **config/**: Tool configuration files
- **wordlists/**: Dictionary files
- **scripts/**: Automation scripts
- **output/**: Scan result outputs
- **tools/**: Additional tools
- **targets/**: Scan targets
- **workflow/**: Workflow definition files
- **cent-nuclei-templates/**: Custom Nuclei templates

## 📝 Usage Example

### Subdomain Discovery Example

```bash
./scripts/subfinder-alive.sh
```

This script executes the following operation:
```bash
# Actual command executed
docker exec -it bughunter rayder -w /root/workflow/subfinder-alive.yaml
```

The script uses the Rayder workflow engine to execute the workflow defined in `workflow/subfinder-alive.yaml`, automating the process of subdomain discovery, resolution, and liveness checking.

## 🔄 Custom Workflows

You can create custom Rayder workflow configuration files in the `workflow/` directory to automate the execution of multiple tool combinations. Rayder is a powerful workflow automation tool that allows you to chain multiple security tools together to create complex scanning workflows.

### Example Workflow Structure

```yaml
# Example workflow structure
name: Subdomain Discovery and Validation
steps:
  - name: Find Subdomains
    tool: subfinder
    args:
      - -d {{.TARGET}}
      - -o {{.OUTPUT_DIR}}/subdomains.txt
  
  - name: Check for Live Hosts
    tool: httpx
    args:
      - -l {{.OUTPUT_DIR}}/subdomains.txt
      - -o {{.OUTPUT_DIR}}/alive-subdomains.txt
```

## 📊 Output Management

All scan results are saved in the `output/` directory. The directory is mounted from the host machine, so you can easily access the results without entering the container.

## 🔒 Security Considerations

- Make sure to keep your Docker installation and the tools within the container up to date
- Review the configuration files in the `config/` directory to ensure they meet your security requirements
- Be mindful of the permissions when running the container

## 🔍 Troubleshooting

If you encounter any issues:

1. Check the container logs: `docker logs bughunter`
2. Verify the tool configuration in the `config/` directory
3. Ensure all volumes are properly mounted
4. Check if the required files exist in the appropriate directories

## 🙏 Acknowledgements

Thanks to the following excellent open-source projects, without which this toolkit would not exist:

- [ProjectDiscovery](https://github.com/projectdiscovery) - Providing Nuclei, Subfinder, HTTPX, DNSX, Notify tools
- [tomnomnom/anew](https://github.com/tomnomnom/anew) - Data deduplication tool
- [xm1k3/cent](https://github.com/xm1k3/cent) - Nuclei template management tool
- [devanshbatham/rayder](https://github.com/devanshbatham/rayder) - Security workflow automation tool
- [maurosoria/dirsearch](https://github.com/maurosoria/dirsearch) - Web path scanning tool

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details. 