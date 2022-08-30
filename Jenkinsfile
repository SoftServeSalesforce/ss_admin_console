#!groovy
import groovy.json.JsonSlurperClassic
node {

    def BUILD_NUMBER=env.BUILD_NUMBER
    def RUN_ARTIFACT_DIR="tests/${BUILD_NUMBER}"
    def SFDC_USERNAME
    def CRED_PREFIX = 'retrain_user_'
    def KEY_PREFIX = 'retrain_key_'

    
    def SFDC_HOST = 'https://login.salesforce.com'
    
    def JWT_KEY_CRED_ID = 'sfdx'
    def JWT_KEY_LOCATION = '/var/lib/jenkins/certificates/retrain2021_1/server.key'

    def ORG_USERNAME = ''
    def CONNECTED_APP_CONSUMER_KEY = ''
    def toolbelt = tool 'toolbelt'

    // Default dev hub values
    withCredentials([
            string(credentialsId: 'RETRAIN_2021_HUB', variable: 'USER'),
            string(credentialsId: 'RETRAIN_2021_KEY', variable: 'KEY'),
            ]) {
            ORG_USERNAME = USER
            CONNECTED_APP_CONSUMER_KEY = KEY
    }


    stage('checkout source') {
        // when running in multi-branch job, one must issue this command
        checkout scm
    }

    boolean isOrgRelatedBranch = stringCredentialsExist(CRED_PREFIX + env.BRANCH_NAME)

    boolean isSandbox = env.BRANCH_NAME.equalsIgnoreCase('qa') || env.BRANCH_NAME.equalsIgnoreCase('ui')
    if (isSandbox) {
        SFDC_HOST = 'https://test.salesforce.com'
    }
    boolean is_scratch_org_exists = false
    echo 'isOrgRelatedBranch'
    echo String.valueOf(isOrgRelatedBranch)

    if (isOrgRelatedBranch) {
        withCredentials([
            string(credentialsId: CRED_PREFIX + env.BRANCH_NAME, variable: 'USER'),
            string(credentialsId: KEY_PREFIX + env.BRANCH_NAME, variable: 'KEY'),
            ]) {
            ORG_USERNAME = USER
            CONNECTED_APP_CONSUMER_KEY = KEY
        }
    } else {
        def authorEmail = sh (
            script: "git show -s --format='%ae' HEAD",
            returnStdout: true
        )

        def authorAlias = authorEmail.substring(0, authorEmail.indexOf('@')) 
        echo 'authorEmail ' + authorEmail
        echo 'authorAlias ' + authorAlias
        if (stringCredentialsExist(CRED_PREFIX + authorAlias)) {
            withCredentials([
                string(credentialsId: CRED_PREFIX + authorAlias, variable: 'USER'),
                string(credentialsId: KEY_PREFIX + authorAlias, variable: 'KEY'),
                ]) {
                ORG_USERNAME = USER
                CONNECTED_APP_CONSUMER_KEY = KEY
            }
        }
        
    }

    echo 'USERNAME ' + ORG_USERNAME
        
    withCredentials([file(credentialsId: JWT_KEY_CRED_ID, variable: 'jwt_key_file')]) {
        
        if (!isOrgRelatedBranch) {
            stage('Create Scratch Org') {
                rc = sh returnStatus: true, script: "${toolbelt}/sfdx force:auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${ORG_USERNAME} --jwtkeyfile ${JWT_KEY_LOCATION} --setdefaultdevhubusername --instanceurl ${SFDC_HOST}"
                if (rc != 0) { error 'hub org authorization failed' }
                // need to pull out assigned username
                rmsg = sh returnStdout: true, script: "${toolbelt}/sfdx force:org:create --definitionfile config/project-scratch-def.json -d 1 --json --setdefaultusername"
                printf rmsg
                def jsonSlurper = new JsonSlurperClassic()
                def robj = jsonSlurper.parseText(rmsg)
                if (robj.status != 0) { error 'org creation failed: ' + robj.message }
                SFDC_USERNAME=robj.result.username
                robj = null
                is_scratch_org_exists = true
            }

    withCredentials([file(credentialsId: JWT_KEY_FILE_CRED_NAME, variable: 'jwt_key_file')]) {

        stage('Deploy To Org') {
            rc = sh returnStatus: true, script: "${toolbelt}/sfdx force:auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${ORG_USERNAME} --jwtkeyfile ${jwt_key_file} --setdefaultdevhubusername --instanceurl ${SFDC_HOST}"
            if (rc != 0) { error 'hub org authorization failed' }

            if (isPrToMain) {
                rc = sh returnStatus: true, script: "${toolbelt}/sfdx force:source:deploy --checkonly --testlevel RunLocalTests --targetusername ${ORG_USERNAME} -p \"3rd-party, ss_admin_console\""
                if (rc != 0) {
                    error 'push failed'
                }
            } else {
                rc = sh returnStatus: true, script: "${toolbelt}/sfdx force:source:deploy --targetusername ${ORG_USERNAME} -p \"3rd-party, ss_admin_console\""
                if (rc != 0) {
                    error 'Deploy failed'
                }
            }
        }

        stage('Run Apex Test') {
            sh "mkdir -p ${RUN_ARTIFACT_DIR}"
            timeout(time: 320, unit: 'SECONDS') {
                rc = sh returnStatus: true, script: "${toolbelt}/sfdx force:apex:test:run --testlevel RunLocalTests --outputdir ${RUN_ARTIFACT_DIR} --resultformat tap --targetusername ${isOrgRelatedBranch ? ORG_USERNAME : SFDC_USERNAME}"
                if (rc != 0) {
                    error 'apex test run failed'
                }
            }
        }

        if (!isOrgRelatedBranch) {
            stage('Delete Test Org') {
                timeout(time: 120, unit: 'SECONDS') {
                    rc = sh returnStatus: true, script: "${toolbelt}/sfdx force:org:delete --targetusername ${SFDC_USERNAME} --noprompt"
                    if (rc != 0) {
                        error 'org deletion request failed'
                    }
                }
            }
        }

        stage('PMD Code Analysis') {
            rc = sh returnStatus: true, script: "sudo bash ./pmd/bin/run.sh pmd -d ./force-app/ -f xml -R ./ruleset.xml > pmd_result.xml"
            
            def pmd = scanForIssues tool: pmdParser(pattern: '**pmd_result.xml')
            publishIssues issues: [pmd]
        }

        stage('collect results') {
            junit keepLongStdio: true, testResults: 'tests/**/*-junit.xml'
        }
    }

    stage('Archive Artifacts') {
        //archiveArtifacts artifacts: 'pmd_result.xml', onlyIfSuccessful: false
    }
}

boolean stringCredentialsExist(String id) {
    try {
        withCredentials([string(credentialsId: id, variable: 'irrelevant')]) {
            true
        }
    } catch (_) {
        false
    }
}