pipeline {
    agent {
        docker { image 'node:20-alpine' }
    }

    stages {
        stage('Install') {
            steps {
                sh 'npm ci'
            }
        }

        stage('Lint') {
            steps {
                sh 'npm run lint || true'
            }
        }

        stage('Build') {
            steps {
                sh './scripts/build.sh'
            }
            post {
                success {
                    archiveArtifacts artifacts: 'dist/**', allowEmptyArchive: true
                }
            }
        }
    }
}
