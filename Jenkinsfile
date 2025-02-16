node {
    checkout scm
    
    stage('Build') {
        docker.image('node:16-buster-slim').inside {
            sh 'npm install'
            sh 'npm run build'
        }
    }

    stage('Test') {
        docker.image('node:16-buster-slim').inside {
            sh './jenkins/scripts/test.sh'
        }
    }

    stage('Manual Approval') {
        input message: 'Lanjutkan ke tahap Deploy?'
    }

    stage('Deploy') {
            sh "docker build -t react-app ."
            sh "docker run -d -p 3000:3000 --name react-app-container react-app"
    }

    stage('Wait for 1 minute') {
        sh 'sleep 60'
        sh 'docker stop react-app-container && docker rm react-app-container'
    }
}
