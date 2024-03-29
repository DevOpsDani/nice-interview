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
                    // Clone the repository
                    deleteDir()
                    def repoURL = 'https://github.com/DevOpsDani/nice-interview.git'
                    git branch: 'main', credentialsId: 'daniel', url: repoURL
                }
            }
        }
        stage('Terraform Plan - Config') {
            steps {
                script {
                    dir('tf_config') {
                        sh 'terraform init'
                        TERRAFORM_PLAN_OUT = sh(script: 'terraform plan -detailed-exitcode', returnStatus: true, returnStdout: true)
                        if ("$TERRAFORM_PLAN_OUT" == '2') {
                            echo 'Changes detected. Proceeding with Terraform apply'
                            currentBuild.result = 'SUCCESS'
                        } else {
                            echo 'No changes detected. Skipping Terraform apply.'
                        }
                    }
                }
            }
        }
        stage('Terraform apply') {
            when {
                expression { currentBuild.result == 'SUCCESS' }
            }
            steps {
                script {
                    dir('tf_config') {
                        sh 'terraform apply -auto-approve'
                }
            }
         }
      }
        stage('Copy file to S3') {
            steps {
                script {
                    sh 'aws s3 cp parse_me.txt s3://daniel-interview-nice-devops-interview-bucket'
                }
            }
         }
      }
    }
}