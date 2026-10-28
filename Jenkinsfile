pipeline {
    agent any

    parameters {
        choice(name: 'ENVIRONMENT', choices: ['dev', 'prod'], description: 'Which environment')
        choice(name: 'ACTION', choices: ['apply', 'destroy'], description: 'apply = create, destroy = remove')
    }

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
        AWS_DEFAULT_REGION    = 'ap-south-1'
    }

    stages {
        stage('Terraform Init') {
            steps {
                bat 'if exist .terraform rmdir /s /q .terraform'
                bat 'terraform init -input=false'
                bat "terraform workspace select -or-create ${params.ENVIRONMENT}"
            }
        }

        stage('Terraform Format') {
            steps {
                bat 'terraform fmt -check -recursive'
            }
        }

        stage('Terraform Validate') {
            steps {
                bat 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    if (params.ACTION == 'destroy') {
                        bat "terraform plan -destroy -input=false -var-file=${params.ENVIRONMENT}.tfvars -out=tfplan"
                    } else {
                        bat "terraform plan -input=false -var-file=${params.ENVIRONMENT}.tfvars -out=tfplan"
                    }
                }
            }
        }

        stage('Approval') {
            steps {
                input message: "Environment: ${params.ENVIRONMENT}. Did you read the plan? Proceed with ${params.ACTION}?"
            }
        }

        stage('Terraform Apply') {
            steps {
                bat 'terraform apply -input=false tfplan'
            }
        }
    }
}