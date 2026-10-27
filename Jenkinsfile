pipeline {
    agent any
    options { skipDefaultCheckout(true); disableConcurrentBuilds(); timeout(time: 15, unit: 'MINUTES') }

    tools {
        maven 'Maven' // Nombre del Maven configurado en Jenkins
        jdk 'Java21'   // JDK instalado y configurado en Jenkins
    }

    stages {

        stage('Checkout') {
            steps {
                echo 'Clonando el repositorio...'
                checkout scm
            }
        }

        stage('Build & Test') {
            steps {
                echo 'Ejecutando pruebas Karate...'
                bat 'mvn -B -ntp clean test'
            }
        }

    }

    post {
        always {
            script {
                if (fileExists('target/surefire-reports')) {
                    junit testResults: 'target/surefire-reports/TEST-*.xml', skipPublishingChecks: true
                }
                if (fileExists('target/karate-reports/karate-summary.html')) {
                publishHTML([
                    allowMissing: false,
                    alwaysLinkToLastBuild: true,
                    keepAll: true,
                    reportDir: 'target/karate-reports',
                    reportFiles: 'karate-summary.html',
                    reportName: 'Reporte de Pruebas Karate'
                ])
                archiveArtifacts artifacts: 'target/karate-reports/**', allowEmptyArchive: false
                }
            }
        }
        cleanup {
            echo 'Pipeline finalizado — limpiando workspace.'
            cleanWs()
        }
        success {
            echo 'Pruebas Karate ejecutadas con éxito.'
        }
        failure {
            echo 'Falló alguna etapa del pipeline.'
        }
    }
}
