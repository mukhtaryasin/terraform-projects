#!/bin/bash -ex

# Install Python3, Git, and pip
sudo yum install -y python3 git python3-pip python3-flask
pip3 install --upgrade pip

# Install NGINX
sudo yum install -y nginx

# Start NGINX service
sudo systemctl start nginx
sudo systemctl enable nginx

# Get public IP
PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
echo "Public IP of this EC2 instance is: $PUBLIC_IP"

# Define repository directory
REPO_DIR=/home/ec2-user/flask-app-todolist

# Check if the directory exists
if [ -d "$REPO_DIR" ]; then
    echo "Directory $REPO_DIR exists. Removing it..."
    rm -rf "$REPO_DIR"
else
    echo "Directory $REPO_DIR does not exist. Proceeding to clone."
fi

# Clone your GitHub Flask app
cd /home/ec2-user
git clone https://github.com/mukhtaryasin/flask-app-todolist.git
cd flask-app-todolist

# Create a virtual environment and activate it
python3 -m venv venv
source venv/bin/activate

# Install Gunicorn and app requirements
pip install gunicorn
pip install -r requirements.txt

# Create a systemd service for Gunicorn to run the Flask app
sudo bash -c 'cat > /etc/systemd/system/flaskapp.service <<EOF
[Unit]
Description=Flask Web App
After=network.target

[Service]
User=ec2-user
WorkingDirectory=/home/ec2-user/flask-app-todolist
ExecStart=/home/ec2-user/flask-app-todolist/venv/bin/gunicorn --workers=3 --bind 0.0.0.0:8000 app:app
Restart=always

[Install]
WantedBy=multi-user.target
EOF'

# Enable and start the Gunicorn service
sudo systemctl enable flaskapp
sudo systemctl start flaskapp

# Configure NGINX as a reverse proxy
sudo bash -c 'cat > /etc/nginx/conf.d/flaskapp.conf <<EOF
server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }

    error_page 500 502 503 504 /50x.html;
    location = /50x.html {
        root /usr/share/nginx/html;
    }
}
EOF'

# Test and restart NGINX
sudo nginx -t
sudo systemctl restart nginx

echo "Flask app should now be running on http://$PUBLIC_IP"
