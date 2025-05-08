pipeline {
    agent any

    environment {
        DOCKER_USERNAME = 'khaola15'
        DOCKER_PASSWORD = 'FA^WK;h^kkY2zPA'
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
                    // Utiliser le lien symbolique créé
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
                    sh 'echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_USERNAME} --password-stdin'
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


