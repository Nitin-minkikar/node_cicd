pipeline {
    agent any
//     triggers {
//         GenericTrigger(
//             genericVariables: [
//                 [key: 'ref', value: '$.ref'],
//                 [key: 'repository', value: '$.repository.name'],
//                 [key: 'action', value: 'published'],
//                 [key: 'event', value: '$.requestHeaders["X-GitHub-Event"]'],
//             ],
//             genericHeaderVariables: [
//                 [key: 'X-Hub-Signature', value: '$.requestHeaders["X-Hub-Signature"]'],
//             ],
//             token: 'Nanis',
//         )
//     }
    stages {
        stage('Fetch Tags from GitHub') {
            steps {
                script {
                    def apiUrl = 'https://api.github.com/repos/Nagendra2140/node_cicd/releases'
                    def credentialsId = 'GITHUB'
                    withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: credentialsId, usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]) {
                        sh """
                            curl -s --user $USERNAME:$PASSWORD $apiUrl > releases.json
                        """
                    }
                    def tagsJson = readFile('releases.json')
                    def tags = new groovy.json.JsonSlurper().parseText(tagsJson)
                    // Process fetched tags as needed
                    echo "Fetched tags: ${tags}"
                }
            }
        }
        stage("New deploy"){
            steps {
                sshagent(['Nodejs']) {
                    sh "ssh ubuntu@3.111.186.190 /home/ubuntu/new_tag.sh"
                }
            }
        }
        stage('Check Application on port') {
            steps {
                sshagent(['ssh_test']) {
                    script {
                        def serverStatus = sh(script: "ssh -o StrictHostKeyChecking=no ubuntu@3.111.186.190 'if netstat -tna | grep \":7000\" | grep -q 'LISTEN'; then echo \"Server is running on port 7000\"; else echo \"Server is not running on port 7000\"; fi'", returnStdout: true)
                        if (serverStatus.contains('not running')) {
                            echo "Server is not running on port 7000"
                            env.SERVER_HEALTHY = false
                        } else {
                            echo "Server is running on port 7000"
                            env.SERVER_HEALTHY = true
                        }
                    }
                }
            }
        }
        stage('Rollback') {
            when {
                expression {
                    return env.SERVER_HEALTHY == 'false'
                }
            }
            steps {
                sshagent(['ssh_test']) {
                    sh "ssh ubuntu@3.111.186.190 /home/ubuntu/old_tag.sh"
                }
            }
        }
    }
}


// pipeline {
// environment {
//         EMAIL_TO = 'nagendrababusuramsetty2140@gmail.com'
//     }
//     agent any
//     stages {
//         stage("clone code") {
//             steps {
//                 git url: 'https://github.com/Nagendra2140/node_cicd.git'
//             }
//         }
//         stage("deploy"){
//             steps {
//                 sshagent(['Nodejs']) {
//                     sh "scp -r -o StrictHostKeyChecking=no /var/lib/jenkins/workspace/multi-branch_master/* ubuntu@3.108.65.199:/opt/"
//                     sh "ssh ubuntu@3.108.65.199 /opt/npm.sh"
//                 }
//             }
//         }
//     }
//     post {
//         failure {
//             emailext body: 'Check console output at $BUILD_URL to view the results. \n\n ${CHANGES} \n\n ------- \n${BUILD_LOG, maxLines=100, escapeHtml=false}', 
//                     to: "${EMAIL_TO}", 
//                     subject: 'Build failed in Jenkins: $PROJECT_NAME - #$BUILD_NUMBER'
//                 }
//         unstable {
//             emailext body: 'Check console output at $BUILD_URL to view the results. \n\n ${CHANGES} \n\n ------- \n${BUILD_LOG, maxLines=100, escapeHtml=false}', 
//                     to: "${EMAIL_TO}", 
//                     subject: 'Unstable build in Jenkins: $PROJECT_NAME - #$BUILD_NUMBER'
//                   }
//         changed {
//             emailext body: 'Check console output at $BUILD_URL to view the results. \n\n ${CHANGES} \n\n ------- \n${BUILD_LOG, maxLines=100, escapeHtml=false}', 
//                     to: "${EMAIL_TO}", 
//                     subject: 'Jenkins build is back to changed: $PROJECT_NAME - #$BUILD_NUMBER'
//                 }
//         success {
//             emailext body: 'Check console output at $BUILD_URL to view the results. \n\n ${CHANGES} \n\n ------- \n${BUILD_LOG, maxLines=100, escapeHtml=false}', 
//                     to: "${EMAIL_TO}", 
//                     subject: 'Jenkins build is back to sucess: $PROJECT_NAME - #$BUILD_NUMBER'
//                 }
//     }
// }
