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
                        name   'HOST'
                        values '192.168.128.249',
                                '192.168.128.245',
                                '192.168.128.248'
                    }
                }
                stages {
                    stage('Maintenance') {
                        agent any
                        steps {
                            dir('keys') {
                                withCredentials([file(credentialsId: 'jenkins_rsa.pub', variable: 'jenkins_rsa'),
                                                    file(credentialsId: 'jenkins_ed25519.pub', variable: 'jenkins_ed25519')]) {
                                    writeFile file: 'jenkins_rsa.pub', text: readFile(jenkins_rsa)
                                    writeFile file: 'jenkins_ed25519.pub', text: readFile(jenkins_ed25519)
                                }
                            }
                            sshagent(credentials : ['phaka']) {
                                sh "ssh -o StrictHostKeyChecking=no phaka@${HOST} rm -Rf scripts"
                                sh "scp -rp -o StrictHostKeyChecking=no scripts phaka@${HOST}:~/"
                                sh "ssh -o StrictHostKeyChecking=no phaka@${HOST} chmod u+x scripts/*.sh"
                                sh "ssh -o StrictHostKeyChecking=no phaka@${HOST} sudo scripts/adduser.sh \$AGENT_USR \$AGENT_PSW"
                                sh "ssh -o StrictHostKeyChecking=no phaka@${HOST} sudo scripts/maintenance.sh"
                            }
                            sshagent(credentials : ['agent']) {
                                dir('keys') {
                                    sh "ssh-copy-id -i jenkins_rsa.pub \$AGENT_USR@${HOST}"
                                    sh "ssh-copy-id -i jenkins_ed25519.pub \$AGENT_USR@${HOST}"
                                }
                            }
                            sshagent(credentials : ['phaka']) {
                                sh "ssh -o StrictHostKeyChecking=no phaka@${HOST} sudo scripts/reboot.sh"
                            }
                        }
                    }
                }
            }
        }
    }
}
