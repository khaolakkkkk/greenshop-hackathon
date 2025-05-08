pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = 'docker_hub_id' // Identifiant Docker Hub
        DOCKER_IMAGE = "khaola15/greenshop-web" // Remplacez par votre nom d'utilisateur Docker Hub
    }

    stages {
        stage('Prepare Workspace') {
            steps {
                script {
                    // Utiliser le lien symbolique
                    sh 'cp -R /var/lib/jenkins/workspace/web-docker/greenshop .'
                    sh 'cp /var/lib/jenkins/workspace/web-docker/greenshop.conf .'
                    sh 'cp /var/lib/jenkins/workspace/web-docker/Dockerfile .'
                    sh 'cp /var/lib/jenkins/workspace/web-docker/docker-compose.yml .'
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
