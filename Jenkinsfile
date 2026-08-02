pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "ilangoip3008/bike-service-app"
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/Ilangoip3008/2k_Bike-service.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh 'echo $PASS | docker login -u $USER --password-stdin'
                    sh 'docker tag $DOCKER_IMAGE $DOCKER_IMAGE:latest'
                    sh 'docker push $DOCKER_IMAGE:latest'
                }
            }
        }

        stage('Deploy to EC2') {
            steps {
                sshagent(['ec2-ssh-key']) {
                    sh '''
                    ssh -o StrictHostKeyChecking=no ubuntu@<APP_EC2_IP> \
                    "docker pull $DOCKER_IMAGE:latest && \
                     docker stop bike-service || true && \
                     docker rm bike-service || true && \
                     docker run -d --name bike-service -p 3000:3000 $DOCKER_IMAGE:latest"
                    '''
                }
            }
        }
    }
}
