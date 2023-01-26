sh "scp requirements.txt ssh ubuntu@18.170.27.109  /home/ubuntu"
sh "scp mongo-db.dockerfile ssh ubuntu@18.170.27.109  /home/ubuntu"
sh "scp nginx.dockerfile ssh ubuntu@18.170.27.109  /home/ubuntu"
sh "scp docker-compose-prod.yaml ssh ubuntu@18.170.27.109  /home/ubuntu"
sh "scp init-db.js ssh ubuntu@18.170.27.109  /home/ubuntu"
sh "scp app.py ssh ubuntu@18.170.27.109  /home/ubuntu"
sh "scp test/unit-test.sh ssh ubuntu@18.170.27.109  /home/ubuntu"
sh "scp nginx/nginx.conf ssh ubuntu@18.170.27.109  /home/ubuntu"
sh "scp templates/home.html ssh ubuntu@18.170.27.109  /home/ubuntu"
sh "scp deploy.sh ssh ubuntu@18.170.27.109  /home/ubuntu"
sh "ssh ubuntu@18.170.27.109   /home/ubuntu"


