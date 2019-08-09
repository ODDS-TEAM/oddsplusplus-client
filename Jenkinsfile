def to_push
pipeline {
    agent any
    tools {nodejs "node12"}
    stages {
        stage('Build') {
            steps {
                echo 'building'
            }
        }
        stage('Test') {
            steps {
                echo 'testing'
            }
        }
        stage('Deploy') {
            steps {
                echo 'deploying'
            }
        }
    }
}