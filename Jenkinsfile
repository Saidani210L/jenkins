pipeline {
    agent {
        node {
            label 'docker-agent-alpine'
        }
    }

    environment {
        DOCKER_IMAGE = "jenkinsapp"
    }

    stages {
        stage('Clone') {
            steps {
                git 'https://github.com/Saidani210L/jenkins.git'
            }
        }

        stage('Build') {
            steps {
                sh 'dotnet build jenkins/JenkinsApp.csproj -c Release'
            }
        }

        stage('Test') {
            steps {
                echo "Running tests..."
            }
        }

        stage('Package') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE:$BUILD_NUMBER .'
            }
        }
    }
}