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
                    def repoURL = 'https://github.com/DevOpsDani/nice-interview.git'
                    git branch: 'main', credentialsId: 'daniel', url: repoURL
                }
            }
        }
        stage('Terraform Plan - Pre Config') {
            steps {
                script {
                    dir('tf_preconfig') {
                        // Run terraform init on the stage that creates our s3 bucket that will include our text file and the terraform backend

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
        stage('Terraform apply - pre config') {
            when {
                expression { currentBuild.result == 'SUCCESS' }
            }
            steps {
                script {
                    dir('tf_preconfig') {
                        sh 'terraform init'
                        sh 'terraform apply -auto-approve'
                    }
                }
            }
        }
        stage('Terraform Plan - Config') {
            steps {
                script {
                    dir('tf_config') {
                        sh 'terraform init -backend-config="key=terraform_backend/terraform.tfstate"'
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
        stage('Terraform apply config') {
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
    }
}