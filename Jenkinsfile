node {
    def imageName = "react-app"
    def containerName = "react-app-container"

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
        docker.image('docker:20.10.12').inside('--privileged -v /var/run/docker.sock:/var/run/docker.sock') {
            sh "docker build -t ${imageName} ."
            sh "docker run -d -p 3000:3000 --name ${containerName} ${imageName}"
        }
    }

    stage('Wait for 1 Minute') {
        sh 'sleep 60'
    }

    stage('Cleanup') {
        docker.image('docker:20.10.12').inside('--privileged -v /var/run/docker.sock:/var/run/docker.sock') {
            sh "docker stop ${containerName} || true"
            sh "docker rm ${containerName} || true"
        }
    }
}
