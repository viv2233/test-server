# Use a Python base image
FROM python:3.12-slim

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt .

# Install the necessary dependencies
RUN pip install --upgrade pip  # Ensure pip is up to date
RUN pip install gunicorn flask  # Install Gunicorn and Flask directly
RUN pip install -r requirements.txt  # Install additional dependencies from requirements.txt

# Copy the application files into the container
COPY . .

# Expose the port the app will run on
EXPOSE 3000

# Command to run the application using Gunicorn
CMD ["gunicorn", "--workers", "3", "--bind", "0.0.0.0:3000", "app:app"]
