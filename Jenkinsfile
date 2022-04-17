pipeline {
    options {
        disableConcurrentBuilds()
    }
    triggers {
        pollSCM 'H/2 * * * *'
        cron '0 7 * * *'
    }
    agent {
        label 'maintenance'
    }
    environment {
        AGENT = credentials('agent')
    }
    stages {
        stage('Bootstrap') {
            parallel {
                stage('CentOS-7-amd64') {
                    options {
                        retry(3)
                    }
                    steps {
                        sshagent(credentials : ['phaka']) {
                            sh './bootstrap.sh 192.168.128.249'
                        }
                    }
                }
                stage('Debian-10.8.0-amd64') {
                    options {
                        retry(3)
                    }
                    steps {
                        sshagent(credentials : ['phaka']) {
                            sh './bootstrap.sh 192.168.128.245'
                        }
                    }
                }
                stage('Debian-11.1.0-i386') {
                    options {
                        retry(3)
                    }
                    steps {
                        sshagent(credentials : ['phaka']) {
                            sh './bootstrap.sh 192.168.128.248'
                        }
                    }
                }
                stage('FreeBSD-12-amd64') {
                    options {
                        retry(3)
                    }
                    steps {
                        sshagent(credentials : ['phaka']) {
                            sh './bootstrap.sh 192.168.128.252'
                        }
                    }
                }
                stage('FreeBSD-12-i386') {
                    options {
                        retry(3)
                    }
                    steps {
                        sshagent(credentials : ['phaka']) {
                            sh './bootstrap.sh 192.168.128.253'
                        }
                    }
                }
                stage('NetBSD-9.0-amd64') {
                    options {
                        retry(3)
                    }
                    steps {
                        sshagent(credentials : ['phaka']) {
                            sh './bootstrap.sh 192.168.128.254'
                        }
                    }
                }
                stage('NetBSD-9.1-amd64') {
                    options {
                        retry(3)
                    }
                    steps {
                        sshagent(credentials : ['phaka']) {
                            sh './bootstrap.sh 192.168.128.255'
                        }
                    }
                }
                stage('NetBSD-9.1-i386') {
                    options {
                        retry(3)
                    }
                    steps {
                        sshagent(credentials : ['phaka']) {
                            sh './bootstrap.sh 192.168.129.2'
                        }
                    }
                }
                stage('OpenBSD-6.8-amd64') {
                    options {
                        retry(3)
                    }
                    steps {
                        sshagent(credentials : ['phaka']) {
                            sh './bootstrap.sh 192.168.129.1'
                        }
                    }
                }
                stage('OpenBSD-6.8-i386') {
                    options {
                        retry(3)
                    }
                    steps {
                        sshagent(credentials : ['phaka']) {
                            sh './bootstrap.sh 192.168.129.6'
                        }
                    }
                }
                stage('MacOS-12.3-M1') {
                    options {
                        retry(3)
                    }
                    steps {
                        sshagent(credentials : ['phaka']) {
                            sh './bootstrap.sh 192.168.1.80'
                        }
                    }
                }
                stage('OpenIndiana-20201031-amd64') {
                    options {
                        retry(3)
                    }
                    steps {
                        sshagent(credentials : ['phaka']) {
                            sh './bootstrap.sh 192.168.129.4'
                        }
                    }
                }
                stage('RHEL-6.10-amd64') {
                    options {
                        retry(3)
                    }
                    steps {
                        sshagent(credentials : ['phaka']) {
                            sh './bootstrap.sh 192.168.129.20'
                        }
                    }
                }
                stage('RHEL-7.9-amd64') {
                    options {
                        retry(3)
                    }
                    steps {
                        sshagent(credentials : ['phaka']) {
                            sh './bootstrap.sh 192.168.129.17'
                        }
                    }
                }
                stage('RHEL-8.5-amd64') {
                    options {
                        retry(3)
                    }
                    steps {
                        sshagent(credentials : ['phaka']) {
                            sh './bootstrap.sh 192.168.129.18'
                        }
                    }
                }
                stage('Solaris-11.4-amd64') {
                    options {
                        retry(3)
                    }
                    steps {
                        sshagent(credentials : ['phaka']) {
                            sh './bootstrap.sh 192.168.128.244'
                        }
                    }
                }
                stage('Ubuntu-16.04-i386') {
                    options {
                        retry(3)
                    }
                    steps {
                        sshagent(credentials : ['phaka']) {
                            sh './bootstrap.sh 192.168.128.247'
                        }
                    }
                }
                stage('freebsd13-ppc64-01') {
                    options {
                        retry(3)
                    }
                    steps {
                        sshagent(credentials : ['phaka']) {
                            sh './bootstrap.sh 192.168.129.48'
                        }
                    }
                }
                stage('opensuse15_3-ppc64le-01') {
                    options {
                        retry(3)
                    }
                    steps {
                        sshagent(credentials : ['phaka']) {
                            sh './bootstrap.sh 192.168.129.47'
                        }
                    }
                }
                stage('debian11-ppc64le-01') {
                    options {
                        retry(3)
                    }
                    steps {
                        sshagent(credentials : ['phaka']) {
                            sh './bootstrap.sh 192.168.129.45'
                        }
                    }
                }
                stage('ubuntu-20.04-ppc64el') {
                    options {
                        retry(3)
                    }
                    steps {
                        sshagent(credentials : ['phaka']) {
                            sh './bootstrap.sh 192.168.129.43'
                        }
                    }
                }
                stage('centos7-ppc64-01') {
                    options {
                        retry(3)
                    }
                    steps {
                        sshagent(credentials : ['phaka']) {
                            sh './bootstrap.sh 192.168.129.54'
                        }
                    }
                }
                stage('centos7-ppc64le-01') {
                    options {
                        retry(3)
                    }
                    steps {
                        sshagent(credentials : ['phaka']) {
                            sh './bootstrap.sh 192.168.129.55'
                        }
                    }
                }
                stage('freebsd13-ppc64le-01') {
                    options {
                        retry(3)
                    }
                    steps {
                        sshagent(credentials : ['phaka']) {
                            sh './bootstrap.sh 192.168.129.52'
                        }
                    }
                }
                stage('kvm01-ppc64el') {
                    options {
                        retry(3)
                    }
                    steps {
                        sshagent(credentials : ['phaka']) {
                            sh './bootstrap.sh 192.168.129.35'
                        }
                    }
                }
                // stage('WindowsServer-2003R2-amd64') {
                //     options {
                //         retry(3)
                //     }
                //     steps {
                //         sshagent(credentials : ['phaka']) {
                //             // sh "./bootstrap.sh 192.168.129.13"
                //             echo 'Hello World'
                //         }
                //     }
                // }
                // stage('WindowsServer-2003R2-i386') {
                //     options {
                //         retry(3)
                //     }
                //     steps {
                //         sshagent(credentials : ['phaka']) {
                //             // sh "./bootstrap.sh 192.168.129.14"
                //             echo 'Hello World'
                //         }
                //     }
                // }
                // stage('WindowsServer-2008R2-amd64') {
                //     options {
                //         retry(3)
                //     }
                //     steps {
                //         sshagent(credentials : ['phaka']) {
                //             // sh "./bootstrap.sh 192.168.129.15"
                //             echo 'Hello World'
                //         }
                //     }
                // }
                // stage('WindowsServer-2012R2-amd64') {
                //     options {
                //         retry(3)
                //     }
                //     steps {
                //         sshagent(credentials : ['phaka']) {
                //             // sh "./bootstrap.sh 192.168.129.11"
                //             echo 'Hello World'
                //         }
                //     }
                // }
                // stage('WindowsServer-2016-amd64') {
                //     options {
                //         retry(3)
                //     }
                //     steps {
                //         sshagent(credentials : ['phaka']) {
                //             // sh "./bootstrap.sh 192.168.129.10"
                //             echo 'Hello World'
                //         }
                //     }
                // }
                // stage('WindowsServer-2019-amd64') {
                //     options {
                //         retry(3)
                //     }
                //     steps {
                //         sshagent(credentials : ['phaka']) {
                //             // sh "./bootstrap.sh 192.168.129.9"
                //             echo 'Hello World'
                //         }
                //     }
                // }
                // stage('WindowsServer-2022-amd64') {
                //     options {
                //         retry(3)
                //     }
                //     steps {
                //         sshagent(credentials : ['phaka']) {
                //             // sh "./bootstrap.sh 192.168.129.16"
                //             echo 'Hello World'
                //         }
                //     }
                // }
            }
        }
    }
}

