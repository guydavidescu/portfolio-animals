#!/bin/bash

 scp ./requirements.txt  ubuntu@18.170.27.109:/home/ubuntu
 scp ./mongo-db.dockerfile  ubuntu@18.170.27.109:/home/ubuntu
 scp ./nginx.dockerfile  ubuntu@18.170.27.109:/home/ubuntu
 scp ./docker-compose-prod.yaml  ubuntu@18.170.27.109:/home/ubuntu
 scp ./init-db.js ubuntu@18.170.27.109:/home/ubuntu
 scp ./app.py ubuntu@18.170.27.109:/home/ubuntu
 scp ./test/unit-test.sh ubuntu@18.170.27.109:/home/ubuntu
 scp ./nginx/nginx.conf ubuntu@18.170.27.109:/home/ubuntu
 scp ./templates/home.html ubuntu@18.170.27.109:/home/ubuntu
 scp ./deploy.sh ubuntu@18.170.27.109:/home/ubuntu
 ssh ./ubuntu@18.170.27.109:/home/ubuntu


