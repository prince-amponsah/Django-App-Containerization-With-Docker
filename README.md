# Django-App-Containerization-With-Docker
A Simple Django App Containerization With Docker and Run on AWS EC2

This project is about how to containerize a Django app.

We start by creating a docker file:

What is a docker file: its a file with the commands that interacts withe the docker daemon to create an image out of your application files and needed dependecies. 
This file interacts with the docker daemon and creates the image out of the application files and dependencies needed to run the apimage of the t
A little explanation for each of the command in the docker file:

# Use an official Python image that already has Python and pip installed
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements file and the devops directory to the container
COPY requirements.txt /app
COPY devops /app

# Install any system dependencies (optional)
RUN apt-get update -y && \
    apt-get install -y -v build-essential

# Install Python dependencies from requirements.txt
RUN python3 -m pip install -r requirements.txt -v

# Set Python3 as the entry point for the container
ENTRYPOINT ["python3"]

# Default command to run the Django development server
CMD ["manage.py", "runserver", "0.0.0.0:8000"]


After the Dockerfile is created with other files and uploaded to github account, we move the next step and create an EC2 Instance to install Docker, buid the image based on the application files and Docker file configuration and run the container based on the port settings and others.

Create an Ec2 Instance in any region of your choice, create a key-pair to help you ssh into the Instance via terminal.

Security Group Configuration:
Set SSH port 22 to My Ip or Anywhere IPV4 for learning purposes
Set Custom TCp port 8000 to anywhere - this is the port we will be running our Django app on.

Once the instance is created, ssh into the it via your terminal with the command below:
Make sure to give the right permission to the pem file:
 chmod 400 <~/path-to-pem-file.pem>
 ssh -i <path to your pem file> username@your-ip-address

lets update all the packages on the system:
sudo yum / apt-get udpate -y

Once thats done, let's install Docker

sudo yum install docker -y - Linux

once installations is done, remember to add this user your logged in to the Sudo User group with the following commands:
usermod -aG ec2-user docker

log out of the instance and login again to help the permissions reset and effect.

Lets cloe the respository to this instance:

git clone <your-github-url-for-cloning>

Now start the docker daemon with the commands below

systemct start docker

Run a simple command to test if Docker is working:

docker ps or docker images 

If you get a response, then the docker daemon is running

Now lets buiild our image with the following command:

docker build -t <your-dockerhub-username>/name-of-app:latest .

