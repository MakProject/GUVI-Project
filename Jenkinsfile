pipeline {
    agent any
    
    stages {
	
        stage('Build and Push to Production') {
	    when {
                expression { env.GIT_BRANCH == 'origin/main' }
            }
            steps {
                script {

		    sh './build.sh'

                    docker.withRegistry('https://registry.hub.docker.com', 'docker') {
                        def customImageName = "makproject/prod:${env.BUILD_ID}"
                        docker.build(customImageName).push()
			
		    sh './deploy.sh'

                    }
                }
            }
        }

	stage('Build and Push to Development') {
            when {
                expression { env.GIT_BRANCH == 'origin/dev' }
            }
            steps {
                script {

                    sh './build.sh'

                    docker.withRegistry('https://registry.hub.docker.com', 'docker') {
                        def customImageName = "makproject/dev:${env.BUILD_ID}"
                        docker.build(customImageName).push()

                    sh './deploy.sh'

                    }
                }
            }
        }
    }
}
