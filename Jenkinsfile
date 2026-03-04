pipeline {
    agent any

    triggers {
        githubPush()
    }

    environment {
        DOCKER_IMAGE_NAME = 'calculator'
        DOCKER_HUB_IMAGE  = 'vishnudholu/calculator'
        GITHUB_REPO_URL   = 'https://github.com/Vishnu-dholu/SPE-mini-project.git'
        EMAIL_RECIPIENT   = 'dholuvishnu10@gmail.com'
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

        stage('Tag & Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('', 'DockerHubCred') {
                        sh "docker tag ${DOCKER_IMAGE_NAME} ${DOCKER_HUB_IMAGE}:latest"
                        sh "docker push ${DOCKER_HUB_IMAGE}:latest"
                    }
                }
            }
        }

        stage('Run Ansible Playbook') {
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
            mail to: "${EMAIL_RECIPIENT}",
                 subject: "SUCCESS: Calculator Pipeline Update",
                 body: "The latest push to GitHub was successfully built and deployed. Check console output: ${env.BUILD_URL}"
        }
        failure {
            mail to: "${EMAIL_RECIPIENT}",
                 subject: "FAILURE: Calculator Pipeline Update",
                 body: "The pipeline failed. Please check the console output to debug: ${env.BUILD_URL}"
        }
    }
}
