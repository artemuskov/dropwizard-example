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
                    withCredentials([usernamePassword(credentialsId: '591c4f2c-e5eb-43ff-aef3-731995297aa7', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                        sh("git tag -a some_tag -m 'Jenkins'")
                        sh('git push https://${GIT_USERNAME}:${GIT_PASSWORD}@<REPO> --tags')
                    }
                }
            }
        }
        stage('S3Copy') {
            steps {
                s3Upload acl: 'Private', bucket: '30daysdevops/dropwizard/release', cacheControl: '', excludePathPattern: '', file: 'target/', metadatas: [''], sseAlgorithm: '', workingDir: ''
                s3Upload acl: 'Private', bucket: '30daysdevops/dropwizard/release', cacheControl: '', excludePathPattern: '', file: 'mysql.yml', metadatas: [''], sseAlgorithm: '', workingDir: ''
            }
        }
    }
}
