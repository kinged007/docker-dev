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
```

### 2. Build and Run the Container

Build the Docker image and start the container using Docker Compose:
```bash
docker-compose up -d
```
This will build the image based on the Dockerfile and run the container defined in `docker-compose.yml`.

### 3. Access the Container

You can access the running container via SSH:
```bash
docker exec -it dev_env bash
```
Once inside, navigate to the working directory:
```bash
cd /var/www/app
```

### 4. Clone Your Laravel Project

Inside the container, clone your Laravel application into the working directory:
```bash
git clone <your-laravel-repo-url> .
```
> **Note:** The dot (`.`) at the end clones the repository directly into the current directory.

### 5. Set Up Your Laravel Application

After cloning your project, run the following commands inside the container:

1. **Copy the Environment File:**
   ```bash
   cp .env.example .env
   ```

2. **Install PHP Dependencies:**
   ```bash
   composer install
   ```

3. **Run Database Migrations and Seeders:**
   ```bash
   php artisan migrate --force
   php artisan db:seed --force
   ```

4. **Install Node Dependencies:**
   ```bash
   npm install
   ```

5. **Start the Vite Development Server (if using Vite):**
   ```bash
   npm run dev
   ```
   > **Tip:** Ensure your Vite configuration (`vite.config.js`) is set to listen on `0.0.0.0` so it is accessible externally.

### 6. Access Your Application

- **Backend (PHP-FPM):**  
  The PHP-FPM server is exposed on port `9000`.

- **Frontend (Vite):**  
  The Vite dev server is exposed on port `3000`.

Make sure these ports are open and properly mapped in your `docker-compose.yml`.

## Repository Structure

- **Dockerfile:**  
  Contains instructions to build your development environment image.

- **docker-compose.yml:**  
  Defines the service configuration and volume mounts (project files are mounted to `/var/www/app`).

## Additional Notes

- **Persistent Code Base:**  
  The `/var/www/app` volume mount ensures that any changes (including Git history) persist across container restarts and rebuilds.

- **Modifying the Environment:**  
  You can update the Dockerfile or docker-compose.yml to install additional tools or adjust configurations as needed.

- **Remote Development:**  
  Use VSCode’s Remote SSH or Remote Containers extension to open the project directory for a more integrated development experience.

## Troubleshooting

- **File Not Found Issues:**  
  If you encounter errors like "file does not exist" when copying `.env.example`, verify that you are in the correct directory (`/var/www/app`) and that the volume mount is correctly configured.

- **Port Accessibility:**  
  Ensure that ports `9000` (PHP-FPM) and `3000` (Vite) are not blocked by your VPS firewall and match the mappings in your `docker-compose.yml`.

## Conclusion

This Docker development environment is designed to provide a consistent, pre-configured workspace for developing Laravel applications remotely. Clone your Laravel project into the environment, set it up, and enjoy seamless development and version control—all without polluting your local system with additional dependencies.
