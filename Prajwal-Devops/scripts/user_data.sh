#!/bin/bash

# Update the system
apt update -y

# Install Java 17 (OpenJDK)
apt install -y openjdk-17-jdk

# Install Maven and Git
apt install -y maven git

# Move to ubuntu user's home directory
cd /home/ubuntu

# Clone the GitHub repo
git clone https://github.com/Trainings-TechEazy/test-repo-for-devops.git

# Change ownership so ubuntu can access the files
chown -R ubuntu:ubuntu test-repo-for-devops

# Build the app
cd test-repo-for-devops
mvn clean package

# Run the app on port 80 in background
nohup java -jar target/hellomvc-0.0.1-SNAPSHOT.jar --server.port=80 > app.log 2>&1 &

# Wait for 5 minutes (300 seconds)
sleep 300

# Stop the instance
shutdown -h now
