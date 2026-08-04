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
                    credentialsId: 'github-pat'   // use your PAT ID here
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

        stage('Deploy') {
            steps {
                bat "docker pull %DOCKER_IMAGE%:latest"
                bat "docker stop bike-service-app || exit 0"
                bat "docker rm bike-service-app || exit 0"
                bat "docker run -d -p 3000:3000 --name bike-service-app %DOCKER_IMAGE%:latest"
            }
        }
    }
}
