pipeline {
    agent any

    parameters {
        choice(name: 'ACTION', choices: ['apply', 'destroy'], description: 'apply = உருவாக்கு, destroy = அழி')
    }

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
        AWS_DEFAULT_REGION    = 'ap-south-1'
    }

    stages {
        stage('Terraform Init') {
            steps {
                bat 'terraform init -input=false'
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
                        bat 'terraform plan -destroy -input=false -out=tfplan'
                    } else {
                        bat 'terraform plan -input=false -out=tfplan'
                    }
                }
            }
        }

        stage('Approval') {
            steps {
                input message: "Plan-ஐப் பார்த்தீர்களா? ${params.ACTION} செய்யலாமா?"
            }
        }

        stage('Terraform Apply') {
            steps {
                bat 'terraform apply -input=false tfplan'
            }
        }
    }
}