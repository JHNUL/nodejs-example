node {
  String commitId

  stage('Preparation') {
    checkout scm
    sh 'git rev-parse --short HEAD > .git/commit-id'
    commitId = readFile('.git/commit-id').trim()
  }

  stage('Test') {
    nodejs(nodeJSInstallationName: 'node18') {
      sh 'npm install'
      sh 'npm run test'
    }
  }

  stage('docker build') {
    docker.withRegistry('https://index.docker.io/v1/', 'dockrhubcred') {
      def app = docker.build("juhanir/nodexample:${commitId}", '.')
      app.push()
    }
  }
}
