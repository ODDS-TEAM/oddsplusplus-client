def to_push
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh "docker build -t sivaroot/frontend:sprint1 ."
            }
        }
        stage('Push') {
            steps {
                sh "docker push sivaroot/frontend:sprint1"
            }
        }
        stage('Deploy') {
            steps {
                script {
                    try{
                        sh 'docker kill frontend'
                     } catch (Exception e){
                        echo "frontend is not running"
                     }
                     try{
                        sh 'docker rm frontend'
                    } catch (Exception e){
                        echo "Not found frontend container"
                    }
                    sh 'docker run -d -p 80:80 -p 8088:80 --name frontend sivaroot/frontend:sprint1'
                }
            }
        }

    }
}