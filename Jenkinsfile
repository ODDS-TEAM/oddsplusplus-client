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
                sh "docker push sivaroot/frontend:sprint1 ."
            }
        }
        stage('Deploy') {
            steps {
             try{
                sh 'docker kill frontend'


             } catch (e){
                echo "frontend is not running"
             }
             try{
                sh 'docker rm frontend'
            } catch (e){
                echo "Not found frontend container"
            }
              sh 'docker run -d -p 8080:8080 --name frontend sivaroot/frontend:sprint1'
            }
        }
    }
}