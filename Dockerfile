pipeline {
    agent any

    environment {
        IMAGE_NAME = "my-node-app"
        CONTAINER_NAME = "node-app-container"
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/your-username/your-repo.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t $IMAGE_NAME ."
                }
            }
        }

        stage('Stop Existing Container (if any)') {
            steps {
                script {
                    sh """
                        docker stop $CONTAINER_NAME || true
                        docker rm $CONTAINER_NAME || true
                    """
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    sh "docker run -d --name $CONTAINER_NAME -p 3000:3000 $IMAGE_NAME"
                }
            }
        }
    }

    post {
        success {
            echo "✅ Deployment successful. App running in Docker."
        }
        failure {
            echo "❌ Something went wrong."
        }
    }
}
