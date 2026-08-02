pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "ilangoip3008/bike-service-app"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Ilangoip3008/2k_Bike-service.git',
                    credentialsId: 'ec2-ssh-key'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat "docker build -t %DOCKER_IMAGE% ."
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    bat "docker login -u %USER% -p %PASS%"
                    bat "docker tag %DOCKER_IMAGE% %DOCKER_IMAGE%:latest"
                    bat "docker push %DOCKER_IMAGE%:latest"
                }
            }
        }

       stage('Deploy to EC2') {
    steps {
        bat '''
        ssh -i "C:\\Program Files\\Jenkins\\.ssh\\bike-service-new.pem" -o StrictHostKeyChecking=no ubuntu@3.109.1.40 ^
        "docker pull ilangoip3008/bike-service-app:latest && \
         docker stop bike-service || true && \
         docker rm bike-service || true && \
         docker run -d --name bike-service -p 3000:3000 ilangoip3008/bike-service-app:latest"
        '''
    }
}




    }
}
