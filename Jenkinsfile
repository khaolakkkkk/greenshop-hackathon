pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = 'docker_id' // Remplace par ton ID Docker dans Jenkins
        DOCKER_IMAGE = "khaolakkkkk/greenshop-web"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/khaolakkkkk/greenshop-hackathon.git', credentialsId: 'github_creds'
            }
        }

        stage('Download Greenshop') {
            steps {
                script {
                    // Télécharge le dossier greenshop directement depuis GitHub
                    sh 'git clone https://github.com/khaolakkkkk/greenshop-hackathon.git'
                    sh 'cp -R greenshop-hackathon/greenshop/ .'
                }
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
                    sh 'docker-compose down || true'
                    sh 'docker-compose up -d --build'
                }
            }
        }
    }
}

