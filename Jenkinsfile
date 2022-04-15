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
                        values '192.168.128.249',   // CentOS 7
                                '192.168.128.245',  // Debian 10 amd64
                                '192.168.128.248',  // Debian 11 i386
                                '192.168.128.252',  // FreeBSD 12 amd64
                                '192.168.128.253',  // FreeBSD 12 i386
                                '192.168.128.254',  // NetBSD 9.0 amd64
                                '192.168.128.255',  // NetBSD 9.1 amd64
                                '192.168.129.2',    // NetBSD 9.1 i386
                                '192.168.129.3',    // OpenBSD 6.5 amd64
                                '192.168.129.0',    // OpenBSD 6.7 amd64
                                '192.168.129.5',    // OpenBSD 6.7 i386
                                '192.168.129.1',    // OpenBSD 6.8 amd64
                                '192.168.129.6',    // OpenBSD 6.8 amd64
                    }
                }
                stages {
                    stage('Maintenance') {
                        options {
                            retry(3)
                        }
                        agent { 
                            label 'maintenance'
                        }
                        steps {
                            sshagent(credentials : ['phaka']) {
                                sh "ssh -o StrictHostKeyChecking=no phaka@${HOST} uname -a"
                                sh "ssh -o StrictHostKeyChecking=no phaka@${HOST} rm -Rf scripts"
                                sh "scp -rp -o StrictHostKeyChecking=no scripts phaka@${HOST}:~/"
                                sh "ssh -o StrictHostKeyChecking=no phaka@${HOST} chmod u+x scripts/*.sh"
                                sh "ssh -o StrictHostKeyChecking=no phaka@${HOST} sudo scripts/adduser.sh \$AGENT_USR \$AGENT_PSW"
                                sh "ssh -o StrictHostKeyChecking=no phaka@${HOST} sudo scripts/maintenance.sh"
                                //sh "ssh -o StrictHostKeyChecking=no phaka@${HOST} sudo scripts/reboot.sh"
                            }
                        }
                    }
                }
            }
        }
    }
}
