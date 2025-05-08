pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "khaola15/greenshop-web"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', 
                    url: 'https://github.com/khaolakkkkk/greenshop-hackathon.git'
            }
        }

        stage('Prepare Workspace') {
            steps {
                script {
                    sh 'ls -l /var/lib/jenkins/workspace/web-docker/greenshop'
                    sh 'cp -R /var/lib/jenkins/workspace/web-docker/greenshop .'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'cd /var/lib/jenkins/workspace/web-docker && docker build -t ${DOCKER_IMAGE}:latest .'
                }
            }
        }

        stage('Login to DockerHub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker_hub_credential', 
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
                    // Forcer l’arrêt et la suppression des conteneurs existants
                    sh '''
                    docker-compose down || true
                    docker rm -f greenshop-db || true
                    docker rm -f greenshop-web || true
                    docker-compose up -d --build
                    '''
                }
            }
        }
    }
}

