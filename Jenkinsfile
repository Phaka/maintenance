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
                echo 'Maintenance'
            }
        }
    }
}
