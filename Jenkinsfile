pipeline {
    agent {
        docker {
            image 'docker:20.10-dind'
            args '--privileged -v /var/lib/docker'
        }
    }
    stages {
        stage('Setup') {
            steps {
                sh 'dockerd-entrypoint.sh &'
                sh 'sleep 10'
            }
        }
        stage('Deploy') {
            steps {
                sh 'docker build -t react-app .'
                sh 'docker run -d -p 3000:3000 --name react-app-container react-app'
            }
        }
    }
}
