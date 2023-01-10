node {
  String commitId
  String imageName

  stage('Preparation') {
    checkout scm
    sh 'git rev-parse --short HEAD > .git/commit-id'
    commitId = readFile('.git/commit-id').trim()
    imageName = "juhanir/nodexample:${commitId}"
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
