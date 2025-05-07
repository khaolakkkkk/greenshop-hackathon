pipeline {
    agent any
    
    environment {
        registryProjet = 'khaolakkkkk/greenshop-hackathon'  // Met ton projet ici
        registryCredential = 'docker_id' // Utilisation de l'ID de credential que tu as configuré
        IMAGE = "${registryProjet}:latest"
    }

    stages {
        stage('Clone') {
            steps {
                checkout scm
            }
        }
        
        stage('Build') {
            steps {
                script {
                    dockerImage = docker.build("${IMAGE}", '.')
                }
            }
        }
        
        stage('Run') {
            steps {
                script {
                    // Nettoyer les anciens conteneurs
                    sh "docker rm -f srvweb || true"
                    
                    // Lancer le conteneur
                    dockerImage.run("-d --name srvweb -p 8000:80")
                }
            }
        }
        
        stage('Push') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', registryCredential) {
                        dockerImage.push('latest')
                    }
                }
            }
        }
    }

    post {
        always {
            script {
                // Nettoyer après la fin
                sh "docker rm -f srvweb || true"
                sh "docker rmi ${IMAGE} || true"
            }
        }
    }
}
