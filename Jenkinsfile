pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = 'docker_id'
        DOCKER_IMAGE = "khaolakkkkk/greenshop-web"
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/khaolakkkkk/greenshop-hackathon.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t $DOCKER_IMAGE:latest .'    
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker_id') {
                        sh 'docker push $DOCKER_IMAGE:latest'
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    sh 'docker-compose down'
                    sh 'docker-compose up -d'
                }
            }
        }
    }
}

