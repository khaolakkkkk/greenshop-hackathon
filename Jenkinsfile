pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = 'docker_hub_id' // Identifiant Docker Hub
        GITHUB_CREDENTIALS = 'docker_id' // Identifiant GitHub
        DOCKER_IMAGE = "khaolakkkkk/greenshop-web"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', 
                    url: 'https://github.com/khaolakkkkk/greenshop-hackathon.git', 
                    credentialsId: "${GITHUB_CREDENTIALS}"
            }
        }

        stage('Download Greenshop') {
            steps {
                script {
                    // Assure-toi que le dossier greenshop est bien téléchargé
                    sh 'git clone https://github.com/khaolakkkkk/greenshop-hackathon.git'
                    sh 'cp -R greenshop-hackathon/greenshop/ .'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t ${DOCKER_IMAGE}:latest .'
                }
            }
        }

        stage('Login to DockerHub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: "${DOCKER_HUB_CREDENTIALS}", 
                                                      usernameVariable: 'DOCKER_USERNAME', 
                                                      passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
                    }
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    sh 'docker push ${DOCKER_IMAGE}:latest'
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
