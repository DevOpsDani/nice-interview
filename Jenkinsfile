pipeline {
    agent any
    environment {
        AWS_CREDENTIALS = credentials('AWS_CREDENTIALS')  // Use the ID you assigned
        AWS_DEFAULT_REGION = 'us-east-1'
        TF_S3_BACKEND = ''
    }
    stages {
        stage('Clone Repository') {
            steps {
                script {
                    def repoURL = 'https://github.com/DevOpsDani/nice-interview.git'
                    git branch: 'main', credentialsId: 'daniel', url: repoURL
                }
            }
        stage('Terraform pre config') {
            steps {
                script {
                    dir('tf_preconfig') {
                        sh 'terraform init'
                        sh 'terraform plan'
                        // def terraformOutput = sh(script: 'terraform output -json', returnStdout: true).trim()
                        // TF_S3_BACKEND = terraformOutput
                }
            }
        }
      }
    }
}