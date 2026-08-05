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
                    credentialsId: 'github-pat'   // replace with your GitHub PAT ID
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t $DOCKER_IMAGE ."
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh "docker login -u $USER -p $PASS"
                    sh "docker tag $DOCKER_IMAGE $DOCKER_IMAGE:latest"
                    sh "docker push $DOCKER_IMAGE:latest"
                }
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                docker pull $DOCKER_IMAGE:latest
                docker stop bike-service-app || true
                docker rm bike-service-app || true
                docker run -d -p 80:3000 --name bike-service-app $DOCKER_IMAGE:latest
                '''
            }
        }
    }
}

