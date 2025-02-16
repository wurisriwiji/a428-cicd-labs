pipeline {
    agent {
        docker {
            image 'node:16-buster-slim'
            args '-p 3000:3000'
        }
    }
    stages {
        stage('Build') {
            steps {
                sh 'npm install'
            }
        }
        stage('Test') {
            steps {
                sh './jenkins/scripts/test.sh'
            }
        }
        stage('Manual Approval') {
            input message: 'Lanjutkan ke tahap Deploy?'
        }
        stage('Deploy') { 
            steps {
                sh 'docker build -t react-app .'
                sh 'docker run -d -p 3000:3000 --name react-app-container react-app'
            }
        }
        stage('Wait for 1 minute') {
            sh 'sleep 60' // Jeda eksekusi selama 1 menit
            sh 'docker stop react-app-container && docker rm react-app-container'
        }
    }
}