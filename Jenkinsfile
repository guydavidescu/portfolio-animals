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


        stage("Build Portfolio image chec") {
             steps {
                 sh "docker build -t ${IMAGE_REPO_NAME} ."
             }
         }

        stage('Test App container') {
                steps {
                    
                    sh """
                    docker-compose up -d --build
                    
                    sleep 5
                    curl 18.130.121.101:80
                    """
                    }
                }


         stage('Test E2E') {
               steps {
                    
                    sh """
                    chmod 777 test/test.sh
                    ./test/test.sh
                    cat score.txt
                    docker-compose down
                    """
                    }
                }


        stage("Tagging commit and tags"){
            when {
                branch 'main'
            }
            steps{
                script{
                    env.GIT_COMMIT_MSG = sh(script: "git log -1 --pretty=%B ${env.GIT_COMMIT}", returnStdout: true).trim()
                    if(GIT_COMMIT_MSG.contains("version")){
                       withCredentials([gitUsernamePassword(credentialsId: "guy-token", gitToolName: 'Default')]){
                            sh """
                                git switch main
                                git fetch origin --tags
                                git tag --list
                            """
                            Ver_Calc=sh(script: "bash tag_calc.sh ${GIT_COMMIT_MSG}",returnStdout: true).trim()
                            New_tag=Ver_Calc.split("\n").last()
                            echo "${New_tag}"
                            sh  """
                                git tag ${New_tag}
                                git push origin ${New_tag}
                                git fetch
                                """
                       }
                    }
                }
            }
        }

       
        stage('Push App to ECR') {
            steps {
                sh "docker tag ${IMAGE_REPO_NAME}:latest ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${New_tag}"
                sh "docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${New_tag}"
            }
        }


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
  
