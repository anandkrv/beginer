pipelineJob("PipeLine Application") {

  logRotator(60, 20, 1, -1)

  description('Pipe Line for application')

  definition {
    cpsScm {
      scm {
        git {
          branch('*/master')
          remote {
            name('')
            refspec('')
            url('git@github.com:OpsTree/CloudAutomation.git')
          }
        }
        scriptPath('PipelineScript/pipeline.groovy')     
      }
    }
  } 
}
