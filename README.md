# Symfony FrankenPHP Deployment

This repository provides a robust setup for deploying Symfony API projects using FrankenPHP. It is designed to work seamlessly for both local development and remote production environments.

This is a modified version of Douglas symfony-deploy repo. The original example is [here](https://github.com/dunglas/symfony-docker)

### 🚀 Features
- FrankenPHP Integration: Use modern PHP runtimes for performance and simplicity.
- Dockerized Multistage Environment: Fully containerized setup for consistent deployment.
- Scalable Deployment: Ready for local and remote deployments.

### 🛠 Prerequisites

Ensure you have the following installed on your system:
- Docker
- Docker Compose

### 📂 Project Structure

``` bash
  ├── symfony_frankenphp_deploy/
  │   ├── .githooks/                   # hooks config for git
  │   ├── bin/                         # startup build scripts
  │   ├── frankenphp/                  # FrankenPHP configuration files 
  │       ├── conf.d/                  # PHP configuration files
  │       ├── Caddyfile                # Caddy server configuration file
  │       ├── docker-entrypont.sh      # Docker entrypoint script
  │       ├── supervisord.conf         # Supervisor configuration file for running messenger workers
  │       ├── worker.Caddyfile/        # Caddy server configuration file for worker mode
  │   ├── docker-compose.overide.yml   # Docker Compose override file
  │   ├── compose.prod.yml             # Docker Compose setup for production
  │   ├── compose.yml                  # Docker Compose setup for development
  │   ├── Dockerfile                   # Dockerfile for building the multistage app image
  │   ├── Readme.md                    # Project documentation            
```

### 🔧 Pre-Setup configuration

- The deploy.sh file add git hooks and can be usefully to run local database creation, migrations and other commands. Feel fre to change git hooks to your needs, right now is set up to run phpstan, phpcs (those are not present so you must adapt it).
- Disable https:
``` yaml
SERVER_NAME=http://localhost \
TRUSTED_HOSTS='^localhost|php$' \
APP_SECRET=ChangeMe \
docker compose -f -compose.yaml -f compose.prod.yaml up --wait
```

### 🚀 Quick Start

1. Add files to your symfony project
2. follow the pre-setup configuration
3. Run docker shortcuts command related in the Makefile

``` bash
# Build images
make build
# Start the development environment
make start
```

### 📦 Run Messenger Workers

If APP_ENV is set to 'local' the messenger workers will not run automatically, so you must run them manually. To run messenger workers, you can use the following command after container is up and running:

``` bash
php /app/bin/console messenger:consume async scheduler_default --time-limit=3600 -vv
```

You can set up consumers in the supervisord.conf file for production environments.
