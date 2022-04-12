pipeline {
    options {
        disableConcurrentBuilds()
    }
    triggers {
        pollSCM 'H/2 * * * *'
        cron '0 7 * * *'
    }
    agent none
    matrix {
        axes {
            axis {
                name 'HOST'
                values '192.168.128.249', '192.168.128.250'
            }
        }
        stages {
            stage('Bootstrap') {
                agent any
                steps {
                    sshagent(credentials : ['phaka']) {
                        sh "scp -o StrictHostKeyChecking=no bootstrap.sh phaka@${HOST}:~/"
                        sh "ssh -o StrictHostKeyChecking=no phaka@${HOST} chmod u+x bootstrap.sh"
                        sh "ssh -o StrictHostKeyChecking=no phaka@${HOST} sudo ./bootstrap.sh"
                    }
                }
            }
            stage('Patch') {
                agent any
                steps {
                    sshagent(credentials : ['phaka']) {
                        sh "scp -o StrictHostKeyChecking=no patch.sh phaka@${HOST}:~/"
                        sh "ssh -o StrictHostKeyChecking=no phaka@${HOST} chmod u+x patch.sh"
                        sh "ssh -o StrictHostKeyChecking=no phaka@${HOST} sudo ./patch.sh"
                    }
                }
            }
        }
    }
}
