pipeline {
    agent any
    stages {
        stage('Install') { 
            steps {
                nodejs(nodeJSInstallationName: 'nodejs') {
                    sh 'npm install'
                }
            }
        }
        stage('Build Node') { 
            steps {
                nodejs(nodeJSInstallationName: 'nodejs') {
                    sh 'npm run build'
                }
            }
        }
        stage('Test') { 
            steps {
                nodejs(nodeJSInstallationName: 'nodejs') {
                    sh 'npm test'
                }
            }
        }
        stage('Stop Docker'){
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
        stage('Run Docker') { 
            steps {
                sh 'docker run -d -p 3000:3000 --name seminariojfal seminariojfal'
            }
        }
        
    }
    post {
        always {
            junit skipPublishingChecks: true, testResults: 'junit.xml'
        }
    }
}