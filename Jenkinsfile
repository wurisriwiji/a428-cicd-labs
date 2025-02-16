node {
    stage('Build') {
        docker.image('node:16-buster-slim').inside {
            sh 'npm install'
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
        docker.image('docker:20.10.12-dind').inside('--privileged') {
            sh "docker build -t react-app ."
            sh "docker run -d -p 3000:3000 --name react-app-container react-app"
        }
    }

    stage('Wait for 1 minute') {
        sh 'sleep 60'
        sh 'docker stop react-app-container && docker rm react-app-container'
    }
}
