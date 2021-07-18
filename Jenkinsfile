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
    stage('install') {
      steps {
        sh '''
        mvn clean install
        ls
        pwd
        ''' 
        //if the code is compiled, we test and package it in its distributable format; run IT and store in local repository
      }
    }
    stage('package') {
      steps {
        sh '''
        mvn package 
        ls
        pwd
        '''
        //if the code is compiled, we test and package it in its distributable format; run IT and store in local repository
      }
    }
   stage('Publish To Artifactory'){
   steps{
         sh '''
            curl -upooh.acharya@gmail.com:AP4sA8Tq1X3SB184o2FqaAFy7Rd -T target/*.jar  "https://poohacharya.jfrog.io/artifactory/default-generic-local/spring-petclinic"
            //def server = Artifactory.newServer url: 'ARTIFACTORY_URL', username: 'ARTIFACTORY_USER_NAME', password: 'ARTIFACTORY_PASSWORD'
            //def uploadSpec = """{
              // "files": [
                // { 
                  // "pattern": "target/*.jar",
                   //"target" : "ARTIFACTORY_TARGET_REPO",
                 //}
               //]
             //}"""
            //server.upload(uploadSpec)
    ''' 
       }
  }  
    stage('Building Image') {
      steps{
        script {
         dockerImage = docker.build registry + ":latest"
        }
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
