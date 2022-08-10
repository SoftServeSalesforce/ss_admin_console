#!groovy
import groovy.json.JsonSlurperClassic
node {

    def PROJECT_ALIAS='admin_console'
    def BUILD_NUMBER=env.BUILD_NUMBER
    def RUN_ARTIFACT_DIR="tests/${BUILD_NUMBER}"

    def USER_CRED_NAME_PREFIX = PROJECT_ALIAS + '_user_'
    def CLIENT_ID_CRED_NAME_PREFIX = PROJECT_ALIAS + '_client_id_'

    def JWT_KEY_FILE_CRED_NAME = PROJECT_ALIAS + '_jwt_key_file'

    def USER_CRED_NAME
    def CLIENT_ID_CRED_NAME

    def SFDC_HOST = 'https://login.salesforce.com'

    def toolbelt = tool 'toolbelt'

    stage('checkout source') {
        // when running in multi-branch job, one must issue this command
        checkout scm
    }

    echo 'CHANGE_ID ' + env.CHANGE_ID
    echo 'CHANGE_TARGET ' + env.CHANGE_TARGET
    echo 'BRANCH_NAME ' + env.BRANCH_NAME

    boolean isPrToMain = false;
    if (env.CHANGE_TARGET == null) {
        // commit to branch
        USER_CRED_NAME = USER_CRED_NAME_PREFIX + env.BRANCH_NAME
        CLIENT_ID_CRED_NAME = CLIENT_ID_CRED_NAME_PREFIX + env.BRANCH_NAME
    } else {
        // Pull request
        if (env.CHANGE_TARGET == 'master') {
            // Pull request to main
            USER_CRED_NAME = USER_CRED_NAME_PREFIX + 'master'
            CLIENT_ID_CRED_NAME = CLIENT_ID_CRED_NAME_PREFIX + 'master'
            isPrToMain = true
        } else {
            // Pull request not to main
            return;
        }
    }

    boolean isOrgRelatedBranch = stringCredentialsExist(USER_CRED_NAME) && stringCredentialsExist(CLIENT_ID_CRED_NAME)
    echo 'isOrgRelatedBranch ' + String.valueOf(isOrgRelatedBranch)

    if (!isOrgRelatedBranch) {
        return
    }

    def ORG_USERNAME
    def CONNECTED_APP_CONSUMER_KEY
    withCredentials([
                string(credentialsId: USER_CRED_NAME, variable: 'USER'),
                string(credentialsId: CLIENT_ID_CRED_NAME, variable: 'KEY'),
    ]) {
        ORG_USERNAME = USER
        CONNECTED_APP_CONSUMER_KEY = KEY
    }
    echo 'USERNAME ' + ORG_USERNAME

    withCredentials([file(credentialsId: JWT_KEY_FILE_CRED_NAME, variable: 'jwt_key_file')]) {

        stage('Deploy To Org') {
            rc = sh returnStatus: true, script: "${toolbelt}/sfdx force:auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${ORG_USERNAME} --jwtkeyfile ${jwt_key_file} --setdefaultdevhubusername --instanceurl ${SFDC_HOST}"
            if (rc != 0) { error 'hub org authorization failed' }

            if (isPrToMain) {
                rc = sh returnStatus: true, script: "${toolbelt}/sfdx force:source:deploy --checkonly --testlevel RunLocalTests --targetusername ${ORG_USERNAME} -p ss_admin_console"
                if (rc != 0) {
                    error 'Validation failed'
                }
            } else {
                rc = sh returnStatus: true, script: "${toolbelt}/sfdx force:source:deploy --targetusername ${ORG_USERNAME} -p ss_admin_console"
                if (rc != 0) {
                    error 'Deploy failed'
                }
            }
        }

        if (env.BRANCH_NAME == 'master') {
            stage('Run Apex Test') {
                sh "mkdir -p ${RUN_ARTIFACT_DIR}"
                timeout(time: 320, unit: 'SECONDS') {
                    rc = sh returnStatus: true, script: "${toolbelt}/sfdx force:apex:test:run --testlevel RunLocalTests --outputdir ${RUN_ARTIFACT_DIR} --resultformat tap --targetusername ${ORG_USERNAME}"
                    if (rc != 0) {
                        error 'apex test run failed'
                    }
                }
            }

            stage('collect results') {
                junit keepLongStdio: true, testResults: 'tests/**/*-junit.xml'
            }
        }
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