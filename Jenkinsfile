pipeline {
    agent any
    
    parameters {
    string(name: 'SCRIPT_NAME', defaultValue: 'start1.sh', description: 'contain dos13')
    string(name: 'test', defaultValue: 'test.sh', description: 'test for cheak scripts')
    string(name: 'src_from_copy', defaultValue: "/var/jenkins_home/workspace/Multibranch_Pipeline_main/${env.BUILD_NUMBER}.gz", description: 'path to file')
    string(name: 'dest_to_copy', defaultValue: '/home/ubuntu/lesson_36/For_Jenkins/lesson37', description: 'path to file')
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
                sshagent(credentials:['my_key']) {
                sh "scp -o StrictHostKeyChecking=no ${src_from_copy} ubuntu@192.168.182.15:${dest_to_copy}"
                }        
            }
        }
    }
}

