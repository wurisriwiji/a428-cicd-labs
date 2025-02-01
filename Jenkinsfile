node {
    def myDockerImage = docker.image('node:16-buster-slim')

    // Pull Docker image jika belum ada
    myDockerImage.pull()

    stage('Build') {
        myDockerImage.inside('-p 3000:3000') {
            sh 'npm install'
        }
    }

    stage('Test') {
        myDockerImage.inside('-p 3000:3000') {
            sh './jenkins/scripts/test.sh'
        }
    }
}