pipeline {
    agent {
        label 'agent-host'
    }    
    parameters {
    string(name: 'SCRIPT_NAME', defaultValue: 'start1.sh', description: 'contain dos13')
    string(name: 'test', defaultValue: 'test.sh', description: 'test for cheak scripts')
    string(name: 'dest_to_copy', defaultValue: '/home/ubuntu', description: 'path to file')
    }
    options { 
        disableConcurrentBuilds() 
        buildDiscarder(logRotator( numToKeepStr: '5', daysToKeepStr: '5'))
    }
    triggers {
        pollSCM('H/2 * * * *')
    }
    stages {
        stage('Test letters') {
            steps {
                sh "bash -n ${SCRIPT_NAME}"
            }       
        }
        stage('Test') {
            steps {
                sh "bash ${test} ${SCRIPT_NAME}"
            }
        }
        stage('Build') {
            steps {
                sh "gzip -c ${SCRIPT_NAME} > ${env.BUILD_NUMBER}.gz"
                archiveArtifacts artifacts: "${env.BUILD_NUMBER}.gz"  
            }
        }
        stage('Deploy') {
            steps {
                sshagent(credentials:['host-user']) {
                sh "scp -o StrictHostKeyChecking=no ${env.BUILD_NUMBER}.gz ubuntu@192.168.182.15:${dest_to_copy}"
                }        
            }
        }
    }
    post {
        always {
            deleteDir()
             }        
      }  
}

