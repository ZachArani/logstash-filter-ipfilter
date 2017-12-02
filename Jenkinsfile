pipeline {
  agent any
  stages {
    stage('print line') {
      parallel {
        stage('print line') {
          steps {
            echo 'Test'
          }
        }
        stage('Alt line') {
          steps {
            echo 'other test'
          }
        }
      }
    }
    stage('echo') {
      steps {
        sh 'echo "other test"'
      }
    }
  }
}