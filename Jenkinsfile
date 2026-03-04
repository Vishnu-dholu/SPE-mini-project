pipeline {
    agent any

    triggers {
        githubPush()
    }

    environment {
        DOCKER_IMAGE_NAME = 'calculator'
        DOCKER_HUB_IMAGE = 'vishnudholu/calculator'
        GITHUB_REPO_URL = 'https://github.com/Vishnu-dholu/SPE-mini-project.git'
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main', url: "${GITHUB_REPO_URL}"
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE_NAME}")
                }
            }
        }

        stage('Login to DockerHub') {
            steps {
                script {
                    docker.withRegistry('', 'DockerHubCred') {
                        sh "docker tag ${DOCKER_IMAGE_NAME} ${DOCKER_HUB_IMAGE}:latest"
                        sh "docker push ${DOCKER_HUB_IMAGE}:latest"
                    }
                }
            }
        }

        stage('Run Ansible Deployment') {
            steps {
                ansiblePlaybook(
                    playbook: 'deploy.yml',
                    inventory: 'inventory'
                )
            }
        }
    }

    post {
        success {
            emailext (
                subject: "Jenkins Build SUCCESS: ${env.JOB_NAME}",
                body: "Build completed successfully.\nDocker image pushed and deployed.",
                to: "your-email@gmail.com"
            )
        }

        failure {
            emailext (
                subject: "Jenkins Build FAILED: ${env.JOB_NAME}",
                body: "Build failed. Please check Jenkins logs.",
                to: "your-email@gmail.com"
            )
        }
    }
}

// test
