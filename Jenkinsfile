pipeline {
    options {
        disableConcurrentBuilds()
    }
    triggers {
        pollSCM 'H/2 * * * *'
        cron '0 7 * * *'
    }
    agent none
    stages {
        stage('CentOS 7') {
            agent any
            steps {
                sshagent(credentials : ['phaka']) {
                    sh 'scp -o StrictHostKeyChecking=no patch.sh phaka@192.168.128.249:~/'
                    sh 'ssh -o StrictHostKeyChecking=no phaka@192.168.128.249 chmod u+x patch.sh'
                    sh 'ssh -o StrictHostKeyChecking=no phaka@192.168.128.249 sudo ./patch.sh'
                }
            }
        }
    }
}
