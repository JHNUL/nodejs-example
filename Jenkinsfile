node {
  String imageName

  stage('Preparation') {
    checkout scm
    String commit = sh(
      script: 'git rev-parse --short=10 HEAD',
      returnStdout: true
    ).trim()
    imageName = "juhanir/nodexample:${commit}"
  }

  stage('Test') {
    nodejs(nodeJSInstallationName: 'node18') {
      sh 'npm install'
      sh 'npm run test'
    }
  }

  stage('docker build/push') {
    docker.withRegistry('https://index.docker.io/v1/', 'dockrhubcred') {
      def app = docker.build(imageName, '.')
      app.push()
    }
  }

  stage('remove local image') {
    sh "docker rmi ${imageName}"
  }
}
