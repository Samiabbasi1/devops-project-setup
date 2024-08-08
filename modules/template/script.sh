#! /bin/bash
cd /home/ubuntu
yes | sudo apt update
yes | sudo apt install python3 python3-pip
git clone https://github.com/Samiabbasi1/python-flask-rest-api.git
sleep 20
cd python-flask-rest-api
pip3 install -r requirements.txt
echo 'Wait for 30 seconds before running the app.py so all the dependencies get installed'
setsid python3 -u app.py &
sleep 30