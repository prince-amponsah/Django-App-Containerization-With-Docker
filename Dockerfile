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
