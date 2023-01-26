sh "scp requirements.txt ssh ubuntu@18.170.27.109  /home/ubuntu/requirements.txt"
sh "scp mongo-db.dockerfile ssh ubuntu@18.170.27.109  /home/ubuntu/mongo.dockerfile"
sh "scp nginx.dockerfile ssh ubuntu@18.170.27.109  /home/ubuntu/nginx.dockerfile"
sh "scp docker-compose-prod.yaml ssh ubuntu@18.170.27.109  /home/ubuntu/docker-compose-prod.yaml"
sh "scp init-db.js ssh ubuntu@18.170.27.109  /home/ubuntu/init-db.js"
sh "scp app.py ssh ubuntu@18.170.27.109  /home/ubuntu/app.py"
sh "scp test/unit-test.sh ssh ubuntu@18.170.27.109  /home/ubuntu/tests/"
sh "scp nginx/nginx.conf ssh ubuntu@18.170.27.109  /home/ubuntu/nginx/"
sh "scp templates/home.html ssh ubuntu@18.170.27.109  /home/ubuntu/templates/"
sh "scp deploy.sh ssh ubuntu@18.170.27.109  /home/ubuntu/deploy.sh"
sh "ssh ubuntu@18.170.27.109   /home/ubuntu/deploy.sh"


