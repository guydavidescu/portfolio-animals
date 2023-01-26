New_tag=$1
export New_tag
docker rmi $(docker images -aq)
docker pull 644435390668.dkr.ecr.eu-west-2.amazonaws.com/guy-repo:${New_tag}
cd protfolio-animals
docker compose -f docker-compose-prod.yaml  build --no-cache
docker compose -f docker-compose-prod.yaml up -d
