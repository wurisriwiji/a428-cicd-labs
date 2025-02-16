pipeline {
    agent {
        docker {
            image 'node:16-buster-slim'
            args '--network=host -v /var/run/docker.sock:/var/run/docker.sock'
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
            steps {
                input message: 'Lanjutkan ke tahap Deploy?'
            }
        }
        stage('Deploy') { 
            steps {
                sh 'docker build -t react-app .'
                sh 'docker run -d -p 3000:3000 --name react-app-container react-app'
            }
        }
        stage('Wait for 1 minute') {
            steps {
                sh 'sleep 60' // Jeda eksekusi selama 1 menit
                sh 'docker stop react-app-container && docker rm react-app-container'
            }
        }
    }
}
