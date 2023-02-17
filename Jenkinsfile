pipeline {
    agent any
    stages {
        stage("clone code") {
            steps {
                sh "rm -r *"
                git url: 'https://github.com/Nagendra2140/node_cicd.git'
            }
        }
        stage("deploy"){
            steps {
                sshagent(['Nodejs']) {
                    sh "scp -r -o StrictHostKeyChecking=no /var/lib/jenkins/workspace/node-master/* ubuntu@13.233.6.4:/var/www/html/"
                    sh "ssh ubuntu@13.233.6.4 /var/www/html/npm.sh"
                }
            }
        }  
    }
}
