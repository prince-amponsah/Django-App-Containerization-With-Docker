
# Django App Containerization with Docker

This project demonstrates how to containerize a Django app using Docker and run it on an AWS EC2 instance.

## Table of Contents
- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Project Setup](#project-setup)
- [Deploying to AWS EC2](#deploying-to-aws-ec2)
- [Docker Commands](#docker-commands)

## Overview
This project outlines the steps to containerize a Django app using Docker and deploy it on an AWS EC2 instance. We will create a Dockerfile, build a Docker image, and run the container on an EC2 instance.

## Prerequisites
- Basic knowledge of Django, Docker, and AWS EC2
- AWS account with permissions to create EC2 instances
- A GitHub account (optional) for storing project files

## Project Setup

### Step 1: Create a Dockerfile

The Dockerfile defines the environment and dependencies required to run your Django app. Here’s a basic Dockerfile:

```Dockerfile
# Use the official Python image with Python and pip pre-installed
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements file and the devops directory into the container
COPY requirements.txt /app
COPY devops /app

# Update package lists and install system dependencies (optional)
RUN apt-get update -y && apt-get install -y build-essential

# Install Python dependencies from requirements.txt
RUN pip install -r requirements.txt

# Set Python3 as the entry point
ENTRYPOINT ["python3"]

# Run the Django development server by default
CMD ["manage.py", "runserver", "0.0.0.0:8000"]
```

### Step 2: Push Code to GitHub
Once the Dockerfile and related files are ready, push them to your GitHub repository.

## Deploying to AWS EC2

### Step 1: Launch an EC2 Instance

1. Create an EC2 instance in the AWS region of your choice.
2. Generate a key-pair to enable SSH access.
3. Configure the security group:
   - Allow inbound SSH on port 22 (restrict to your IP or "Anywhere" for learning purposes).
   - Open custom TCP port 8000 to allow access to the Django app.

### Step 2: SSH into the EC2 Instance

Use the following commands to connect to your EC2 instance. Make sure to set correct permissions on your `.pem` file:

```bash
chmod 400 ~/path-to-pem-file.pem
ssh -i ~/path-to-pem-file.pem ec2-user@your-ec2-ip-address
```

### Step 3: Update System Packages

Update the package manager:

```bash
sudo yum update -y  # For Amazon Linux
sudo apt-get update -y  # For Ubuntu
```

### Step 4: Install Docker

Install Docker with the following commands:

```bash
sudo yum install docker -y  # For Amazon Linux
sudo apt-get install docker.io -y  # For Ubuntu
```

Add your user to the `docker` group:

```bash
sudo usermod -aG docker ec2-user
```

Log out and log back in for the permissions to take effect.

### Step 5: Clone the Repository

Clone the project repository from GitHub:

```bash
git clone <your-github-repository-url>
```

### Step 6: Start Docker

Start the Docker service:

```bash
sudo systemctl start docker
```

Check if Docker is running by using:

```bash
docker ps
```

## Docker Commands

### Build and Run the Docker Image

To build and run your Docker image, navigate to the project directory and run:

```bash
docker build -t <your-dockerhub-username>/django-app:latest .
```

This will build the Docker image based on your Dockerfile. After the image is built, you can run it using the appropriate port settings.

### Verify Docker Installation

You can verify Docker installation by running:

```bash
docker ps
docker images
```

## License
This project is licensed under the MIT License.
