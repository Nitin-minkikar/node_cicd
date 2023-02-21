pipeline {
environment {
        EMAIL_TO = 'nagendrababusuramsetty2140@gmail.com'
    }
    agent any
    stages {
        stage("deploy"){
            steps {
                sshagent(['Nodejs']) {
                    sh "ssh -o StrictHostKeyChecking=no jenkins@13.233.200.41 /home/jenkins/nan.sh"
                }
            }
        }
    }
    post {
        failure {
            emailext body: 'Check console output at $BUILD_URL to view the results. \n\n ${CHANGES} \n\n ------- \n${BUILD_LOG, maxLines=100, escapeHtml=false}', 
                    to: "${EMAIL_TO}", 
                    subject: 'Build failed in Jenkins: $PROJECT_NAME - #$BUILD_NUMBER'
                }
        unstable {
            emailext body: 'Check console output at $BUILD_URL to view the results. \n\n ${CHANGES} \n\n ------- \n${BUILD_LOG, maxLines=100, escapeHtml=false}', 
                    to: "${EMAIL_TO}", 
                    subject: 'Unstable build in Jenkins: $PROJECT_NAME - #$BUILD_NUMBER'
                  }
        // changed {
        //     emailext body: 'Check console output at $BUILD_URL to view the results. \n\n ${CHANGES} \n\n ------- \n${BUILD_LOG, maxLines=100, escapeHtml=false}', 
        //             to: "${EMAIL_TO}", 
        //             subject: 'Jenkins build is back to changed: $PROJECT_NAME - #$BUILD_NUMBER'
        //         }
        success {
            emailext body: 'Check console output at $BUILD_URL to view the results. \n\n ${CHANGES} \n\n ------- \n${BUILD_LOG, maxLines=100, escapeHtml=false}', 
                    to: "${EMAIL_TO}", 
                    subject: 'Jenkins build is back to sucess: $PROJECT_NAME - #$BUILD_NUMBER'
                }
    }
}
