pipeline {
    options {
        disableConcurrentBuilds()
    }
    triggers {
        pollSCM 'H/2 * * * *'
        cron '0 7 * * *'
    }
    agent none
    environment {
        AGENT = credentials('agent')
    }
    stages {
        stage('Linux') {
            matrix {
                axes {
                    axis {
                        name    'HOST'
                        values  '192.168.128.249', // CentOS 7
                                '192.168.128.245'  // Debian 10
                    }
                }
                stages {
                    stage('Maintenance') {
                        agent any
                        steps {
                            sshagent(credentials : ['phaka']) {
                                sh "ssh -o StrictHostKeyChecking=no phaka@${HOST} rm -Rf scripts"
                                sh "scp -rp -o StrictHostKeyChecking=no scripts phaka@${HOST}:~/"
                                sh "ssh -o StrictHostKeyChecking=no phaka@${HOST} chmod u+x scripts/*.sh"
                                sh "ssh -o StrictHostKeyChecking=no phaka@${HOST} sudo scripts/adduser.sh \"$AGENT_USR\" \"$AGENT_PSW\""
                                sh "ssh -o StrictHostKeyChecking=no phaka@${HOST} sudo scripts/maintenance.sh"
                                sh "ssh -o StrictHostKeyChecking=no phaka@${HOST} sudo scripts/reboot.sh"
                            }
                        }
                    }
                }
            }
        }
    }
}
