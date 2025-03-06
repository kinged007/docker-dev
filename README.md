# Docker Development Environment for Laravel Projects

This repository provides a Docker-based development environment pre-configured with PHP 8.2, Composer, Node, npm, and the necessary PHP extensions. It is designed to allow you to clone and work on any Laravel project remotely while keeping your application code separate from the environment setup.

## Features

- **Pre-configured Environment:**  
  Comes with PHP 8.2, Composer, Node.js, npm, and common PHP extensions (e.g., pdo, mbstring, gd).

- **Separation of Concerns:**  
  The environment is separate from your Laravel application code. Once the container is running, you can clone your Laravel project into the `/var/www/app` directory.

- **Remote Development:**  
  Access the container via VSCode's Remote SSH or Remote Containers extension for a seamless development experience.

- **Persistent Workspace:**  
  The `/var/www/app` directory is mounted as a volume so that your project files, including the Git history, persist across container rebuilds.

## Prerequisites

- Docker and Docker Compose installed on your VPS.
- Access to your VPS (via SSH or a deployment tool like Coolify).
- VSCode with the Remote - SSH or Remote - Containers extension.

## Getting Started

### 1. Clone This Repository

Clone this repository to your VPS:
```bash
git clone <your-docker-dev-repo-url>
cd <your-docker-dev-repo-directory>
