pipeline {
  environment {
    registry = "poohacharya"
    registryCredential = 'docker-hub'
    dockerImage = ''
  }
  agent any
  tools {
    maven 'maven'
    jdk 'jdk9'
  } 
  stages {
    stage('Cloning Git') {
      steps {
        git 'https://github.com/poohacharya/pet12.git'
      }
    }
    stage('Compile') {
       steps {
         sh 'mvn compile' //only compilation of the code
       }
    }
    stage('Test') {
      steps {
        sh '''
        mvn clean install
        ls
        pwd
        ''' 
        //if the code is compiled, we test and package it in its distributable format; run IT and store in local repository
      }
    }
    stage('Building Image') {
      steps{
        sh '''
        mvn package
        ls
        pwd
        ''' 
        //script {
         // dockerImage = docker.build registry + ":latest"
        //}
      }
    }
    stage('Deploy Image') {
      steps{
         script {
            docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
  }
}
