pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = 'docker_hub_id' // Identifiant Docker Hub
        GITHUB_CREDENTIALS = 'github_id' // Identifiant GitHub
        DOCKER_IMAGE = "khaola15/greenshop-web"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', 
                    url: 'https://github.com/khaolakkkkk/greenshop-hackathon.git', 
                    credentialsId: "${GITHUB_CREDENTIALS}"
            }
        }

        stage('Prepare Workspace') {
            steps {
                script {
                    // Si un dossier "greenshop" existe déjà, on le supprime pour éviter les erreurs
                    sh 'rm -rf greenshop'
                    // Copier directement le dossier "greenshop" dans le workspace
                    sh 'cp -R ./greenshop-hackathon/greenshop/ ./greenshop'
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


