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
                    bat "echo %PASS% | docker login -u %USER% --password-stdin"
                    bat "docker tag %DOCKER_IMAGE% %DOCKER_IMAGE%:latest"
                    bat "docker push %DOCKER_IMAGE%:latest"
                }
            }
        }

        stage('Deploy to EC2') {
            steps {
                sshagent(['ec2-ssh-key']) {
                    bat '''
                    ssh -o StrictHostKeyChecking=no ubuntu@3.109.209.161 ^
                    "docker pull %DOCKER_IMAGE%:latest && ^
                     docker stop bike-service || true && ^
                     docker rm bike-service || true && ^
                     docker run -d --name bike-service -p 3000:3000 %DOCKER_IMAGE%:latest"
                    '''
                }
            }
        }
    }
}
