pipeline {
    agent any

    parameters {
        choice(name: 'ENVIRONMENT', choices: ['staging', 'production'], description: 'Deploy target')
    }

    stages {
        stage('Confirm') {
            when {
                expression { return params.ENVIRONMENT == 'production' }
            }
            steps {
                input message: 'Deploy to production?', ok: 'Deploy'
            }
        }

        stage('Deploy') {
            steps {
                echo "Deploying to ${params.ENVIRONMENT}..."
                sh "./scripts/deploy.sh ${params.ENVIRONMENT}"
            }
        }
    }

    post {
        success {
            echo "Deployed to ${params.ENVIRONMENT} successfully."
        }
        failure {
            echo "Deployment to ${params.ENVIRONMENT} failed!"
        }
    }
}
