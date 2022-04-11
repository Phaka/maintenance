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
            echo 'Running Maintenance Tasks'
        }
    }
}
