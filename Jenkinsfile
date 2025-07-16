pipeline {
    agent none

    environment {
        DOCKERHUB_CREDENTIALS = credentials("credentials_ID")
    }

    stages {
        stage('git') {
            agent {
                label 'KMaster'
            }
            steps {
                git url: 'https://github.com/umakrishna-2002/website.git'
            }
        }

        stage('docker') {
            agent {
                label 'KMaster'
            }
            steps {
                sh 'sudo docker build . -t umakrishna/project'
                sh "sudo docker login -u ${DOCKERHUB_CREDENTIALS_USR} -p ${DOCKERHUB_CREDENTIALS_PSW}"
                sh 'sudo docker push umakrishna/project'
            }
        }

        stage('k8') {
            agent {
                label 'KMaster'
            }
            steps {
                sh 'kubectl delete deployment my-app '
                sh 'kubectl apply -f deploy.yaml'
                sh 'kubectl delete service my-service'
                sh 'kubectl apply -f service.yaml'
            }
        }
    }
}
