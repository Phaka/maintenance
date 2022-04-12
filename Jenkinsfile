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
        stage('Linux') {
            matrix {
                axes {
                    axis {
                        name 'HOST'
                        values '192.168.128.249', '192.168.128.245'
                    }
                }
                stages {
                    stage('Maintenance') {
                        agent any
                        steps {
                            sshagent(credentials : ['phaka']) {
                                sh "scp -o StrictHostKeyChecking=no maintenance.sh phaka@${HOST}:~/"
                                sh "ssh -o StrictHostKeyChecking=no phaka@${HOST} chmod u+x maintenance.sh"
                                sh "ssh -o StrictHostKeyChecking=no phaka@${HOST} sudo ./maintenance.sh"
                                sh "ssh -o StrictHostKeyChecking=no phaka@${HOST} echo \"jenkins:J3nkins!\" | sudo chpasswd"
                                sh "ssh -o StrictHostKeyChecking=no phaka@${HOST} rm ./maintenance.sh"
                            }
                        }
                    }
                }
            }
        }
    }
}
