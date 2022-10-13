pipeline {
    agent any
    stages {
        stage('Stop Docker') {
            steps {
                catchError{
                    sh 'docker stop seminariojfal'
                }
                catchError{
                    sh 'docker rm seminariojfal'
                }
            }
        }
        stage('Build Docker') {
            steps {
                sh 'docker build -t seminariojfal .'
            }
        }
        stage('Deploy Docker') {
            steps {
                sh 'docker run -d -p 3000:3000 --name seminariojfal seminariojfal'
            }
        }
    }
}