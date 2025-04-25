#!/bin/bash -ex

# Define the repository directory
REPO_DIR=~/flask-app-todolist

# Check if the directory exists
if [ -d "$REPO_DIR" ]; then
  # If the directory exists, delete it
  echo "Directory exists, removing it..."
  rm -rf "$REPO_DIR"
else
  echo "Directory does not exist, proceeding to clone the repository..."
fi

# Clone the latest version of the repository
cd ~
git clone https://github.com/mukhtaryasin/flask-app-todolist.git
cd flask-app-todolist

# Install Python3, Git, and pip
sudo apt-get update
sudo apt-get install -y python3 python3-pip git python3-venv  # Install python3-venv if not installed

# Create a virtual environment
python3 -m venv venv

# Activate the virtual environment
source venv/bin/activate

# Upgrade pip inside the virtual environment
pip install --upgrade pip

# Install requirements
pip install -r requirements.txt

# Optional: install stress (or remove this line if not needed)
sudo apt-get install -y stress

# Export env variables
# export FLASK_APP=app.py  # or application.py if your file is named so
# export FLASK_ENV=development
# export AWS_DEFAULT_REGION=ap-southeast-2
# export DYNAMO_MODE=on

# Run the Flask app on 0.0.0.0:80
python app.py &