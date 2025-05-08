pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = 'docker_hub_id' // Identifiant Docker Hub
        GITHUB_CREDENTIALS = 'docker_id' // Identifiant GitHub
        DOCKER_IMAGE = "khaola15/greenshop-web" // Remplacez par votre nom d'utilisateur Docker Hub
        WORKSPACE_DIR = '/var/lib/jenkins/workspace/web-docker'
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
                    // Utilise directement le dossier existant de greenshop
                    sh 'ls -l ${WORKSPACE_DIR}/greenshop'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh '''
                    cd ${WORKSPACE_DIR}
                    docker build -t ${DOCKER_IMAGE}:latest .
                    '''
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
                    sh '''
                    docker push ${DOCKER_IMAGE}:latest
                    '''
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Utiliser docker-compose pour déployer
                    sh '''
                    cd ${WORKSPACE_DIR}
                    docker-compose down || true
                    docker-compose up -d --build
                    '''
                }
            }
        }
    }
}

