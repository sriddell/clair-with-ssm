node('linux_standard') {
    stage('bootstrap') {
        cleanWs()
        echo "Loading ${env.PIPELINE_DOCKER_URL}"
        sh 'wget $PIPELINE_DOCKER_URL'
        def pipeline = load 'pipeline.groovy'
        pipeline.execute([publishBranches:['master'], runUnitTests: false])
    }
}