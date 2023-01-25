pipeline {
    agent any
      environment {
        AWS_ACCOUNT_ID="644435390668"
        AWS_DEFAULT_REGION="eu-west-2"
        IMAGE_REPO_NAME="guy-repo"
        IMAGE_TAG="latest"
        REPOSITORY_URI="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
        }
    stages {

        stage('checkout') {
            steps {
                deleteDir()
                checkout scm
            }
        }
      
        stage ("aws login"){
            steps{
                script{
                    sh """
                    apt update
                    apt install -y awscli
                    aws configure set aws_access_key_id AKIAZMC2XWDGO6KFC6FA
                    aws configure set aws_secret_access_key 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
                    aws configure set default.region eu-west-2
                    aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com
                    """
                }
            }
        }


    //     stage("Build Portfolio image chec") {
    //         steps {
    //             sh "docker build -t ${IMAGE_REPO_NAME} ."
    //         }
    //     }

    //     stage('Test App container') {
    //            steps {
                    
    //                 sh """
    //                 docker-compose build --no-cache
    //                 docker-compose up -d 
    //                 docker cp ./nginx/nginx.conf  portfolio_main_reverseproxy_1:/etc/nginx/conf.d
    //                 docker cp ./templates  portfolio_main_reverseproxy_1:/usr/share/nginx/html
    //                 docker cp ./db/setup.sql  portfolio_main_db_1:/docker-entrypoint-initdb.d/
    //                 sleep 10
    //                 curl 18.130.189.49:80
    //                 """
    //                 }
    //             }


    //      stage('Test E2E') {
    //            steps {
                    
    //                 sh """
    //                 chmod 777 test/test.sh
    //                 ./test/test.sh
    //                 docker-compose down
    //                 """
    //                 }
    //             }

       
    //     stage('Push App Image') {
    //         steps {
    //             sh 'docker tag ${IMAGE_REPO_NAME}:latest ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:latest'
    //             sh 'docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:latest'
    //         }
    //     }


    //         stage('Deploy') {
    //           steps {
    //               sh """ 
    //               scp deploy.sh ubuntu@18.130.170.162:/home/ubuntu
    //               scp app.py ubuntu@18.130.170.162:/home/ubuntu
    //               scp docker-compose.yaml ubuntu@18.130.170.162:/home/ubuntu
    //               scp dockerfile ubuntu@18.130.170.162:/home/ubuntu
    //               scp Dockerfile  ubuntu@18.130.170.162:/home/ubuntu
    //               scp templates/index.html ubuntu@18.130.170.162:/home/ubuntu
    //               scp requirements.txt ubuntu@18.130.170.162:/home/ubuntu
    //               ssh ubuntu@18.130.170.162 /home/ubuntu/deploy.sh
    //               """
    //           }
    //      }

       }
    }
  
