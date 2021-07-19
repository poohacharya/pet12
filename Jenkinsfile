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
    stage('test') {
      steps {
        sh '''
        mvn test
        ls
        pwd
        ''' 
       //test code
      }
    }
    stage('package') {
      steps {
        sh '''
        mvn package 
        ls
        pwd
        '''
        //if the code is compiled, we test and package it in its distributable format; run IT and store in target folder
      }
    }
   stage('Publish To Artifactory'){
   steps{
         sh '''
            curl -upooh.acharya@gmail.com:AP4sA8Tq1X3SB184o2FqaAFy7Rd -T target/*.jar  "https://poohacharya.jfrog.io/artifactory/default-generic-local/spring-petclinic"
        ''' 
       // Push the artifact which was built in package to artifactory repo.
       }
  }  
    stage('Building Image') {
      steps{
         sh '''
          docker build -f ./Dockerfile -t petclinic .
         '''
      //Build docker image
      }
    }
    stage('Deploy Image') {
      steps{
          sh '''
             docker tag petclinic poohacharya.jfrog.io/default-docker-virtual:petclinic
             docker push poohacharya.jfrog.io/default-docker-virtual:petclinic
          '''
       // Push the docker image to artifactory repo.
        }
      }
  }
}
