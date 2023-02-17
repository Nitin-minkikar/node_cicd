pipeline {
    agent any
    stages {
        stage("deploy"){
            steps {
                sshagent(['Nodejs']) {
                    sh "ssh ubuntu@13.126.249.23 /home/ubuntu/nani.sh"
                }
            }
        }  
    }
}
