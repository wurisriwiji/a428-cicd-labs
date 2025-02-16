node {
    stage('Setup Docker Environment') {
        steps {
            sh 'docker run -d --name node-container -v $(pwd):/app -w /app -p 3000:3000 node:16-buster-slim tail -f /dev/null'
        }
    }

    stage('Build') {
        steps {
            sh 'docker exec node-container npm install'
        }
    }

    stage('Test') {
        steps {
            sh 'docker exec node-container ./jenkins/scripts/test.sh'
        }
    }

    stage('Manual Approval') {
        steps {
            script {
                input message: 'Lanjutkan ke tahap Deploy?'
            }
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
            sh 'sleep 60'
            sh 'docker stop react-app-container && docker rm react-app-container'
        }
    }
}

// Cleanup setelah pipeline selesai
node {
    stage('Cleanup Environment') {
        steps {
            sh 'docker stop node-container || true'
            sh 'docker rm node-container || true'
        }
    }
}
