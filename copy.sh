sh "scp requirements.txt  ubuntu@18.170.27.109:/home/ubuntu"
sh "scp mongo-db.dockerfile  ubuntu@18.170.27.109:/home/ubuntu"
sh "scp nginx.dockerfile  ubuntu@18.170.27.109:/home/ubuntu"
sh "scp docker-compose-prod.yaml  ubuntu@18.170.27.109:/home/ubuntu"
sh "scp init-db.js ubuntu@18.170.27.109:/home/ubuntu"
sh "scp app.py ubuntu@18.170.27.109:/home/ubuntu"
sh "scp test/unit-test.sh ubuntu@18.170.27.109:/home/ubuntu"
sh "scp nginx/nginx.conf ubuntu@18.170.27.109:/home/ubuntu"
sh "scp templates/home.html ubuntu@18.170.27.109:/home/ubuntu"
sh "scp deploy.sh ubuntu@18.170.27.109:/home/ubuntu"
sh "ssh ubuntu@18.170.27.109:/home/ubuntu"


