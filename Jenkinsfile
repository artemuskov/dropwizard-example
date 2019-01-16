pipeline {
    agent {
        docker {
            image 'maven:3-alpine'
            args '-v /root/.m2:/root/.m2'
        }
    }
    stages {
        stage('Build') {
            steps {
                sh 'mvn -B -DskipTests clean package'
            }
        }
        stage('Test') {
            steps {
                sh 'mvn test'
            }
            post {
                always {
                    archiveArtifacts artifacts: '**/*.jar', fingerprint: true
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        stage('S3Copy') {
            steps {
                s3Upload acl: 'Private', bucket: '30daysdevops/jenkins/qa', cacheControl: '', excludePathPattern: '', file: '*.jar', includePathPattern: '**/', metadatas: [''], sseAlgorithm: '', workingDir: ''
            }
        }
    }
}
