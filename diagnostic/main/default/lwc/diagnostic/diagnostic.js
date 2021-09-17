import {LightningElement, track, api} from 'lwc';
import execute from '@salesforce/apex/DiagnosticController.execute';
import test from '@salesforce/apex/DiagnosticController.test';
import getDataTypes from '@salesforce/apex/DiagnosticController.getDataTypes';
import {subscribe} from 'lightning/empApi';

export default class Diagnostic extends LightningElement {
    @track isLoading = false;
    @track selectedAction;
    @track actionDisabled = true;
    @track logs = [];
    @track logsExist = false;
    @track selectedDataTypes;
    @track actionNumber = 0;
    @track types = [];
    logPayload = {};
    jobResultPayload = {};
    logChannelName = '/event/JobLogEvent__e';
    jobResultChannelName = '/event/JobResultEvent__e';

    get actions() {
        return [
            {label: 'Run Schedule Job', value: 'RunScheduleJob'},
            {label: 'Run Job', value: 'RunJob'},
            {label: 'Load Data', value: 'LoadData'}
        ];
    };

    dataTypes() {
        getDataTypes()
            .then(result => {
                for (let key in result) {
                    this.types.push({
                        label: result[key],
                        value: result[key]
                    })
                }
            })
            .catch(error => {
                console.log(error);
            })
    };

    connectedCallback() {
        this.dataTypes();
        this.handleLogSubscribe();
        this.handleJobResultSubscribe();
    };

    handleLogSubscribe() {
        const messageCallback = (response) => {
            this.logPayload = JSON.parse(JSON.stringify(response));
            this.logsExist = true;
            this.logs.push(this.handleMessage(this.logPayload.data.payload.Message_Type__c,
                this.logPayload.data.payload.Message_Title__c,
                this.logPayload.data.payload.Message__c,
                this.logPayload.data.payload.CreatedDate));
            this.logs.push(this.handleHeaderMessage(this.handleFinishMessage(
                this.logPayload.data.payload.SObject_Type__c,
                this.logPayload.data.payload.Action_Type__c)))
        };
        subscribe(this.logChannelName, -1, messageCallback).then(response => {
            this.subscription = response;
        });
    };

    handleJobResultSubscribe() {
        const messageCallback = (response) => {
            this.jobResultPayload = JSON.parse(JSON.stringify(response));
            if (this.selectedDataTypes.length != this.actionNumber) {
                if (this.jobResultPayload.data.payload.Job_Action__c === 'Test') {
                    this.handleTest();
                } else if (this.jobResultPayload.data.payload.Job_Action__c === 'Execute') {
                    this.handleExecute();
                }
            } else {
                this.actionDisabled = false;
                this.actionNumber = 0;
            }
        };
        subscribe(this.jobResultChannelName, -1, messageCallback).then(response => {
            this.subscription = response;
        });
    };

    handleMessage(messageType, messageTitle, message, messageDate) {
        let log = messageDate + ': ';
        if (messageType == 'DUPLICATED' || messageType == 'FAILED') {
            log += this.setColor('red', messageTitle);
        } else if (messageType == 'OK') {
            log += this.setColor('green', messageTitle);
        } else if (messageType == 'WARNING') {
            log += this.setColor('darkgoldenrod', messageTitle);
        }
        if (message) {
            log += ' ' + message;
        }

        return log;
    };

    handleFinishMessage(objectType, actionType) {
        return actionType + ' action was finished for SObject - ' + objectType;
    }

    setColor(color, message) {
        return '<p style="font-weight: bold; color:' + color + '">' + message + '</p>';
    }

    handleExecute = () => {
        this.actionDisabled = true;
        let type = this.selectedDataTypes[this.actionNumber];
        this.actionNumber = this.actionNumber + 1;
        execute({actionType: type})
            .then(result => {
                this.logs.push(this.handleHeaderMessage(result));
            })
            .catch(error => {
                console.log(error);
            })
    };

    handleTest = () => {
        this.actionDisabled = true;
        let type = this.selectedDataTypes[this.actionNumber];
        this.actionNumber = this.actionNumber + 1;
        test({actionType: type})
            .then(result => {
                this.logs.push(this.handleHeaderMessage(result));
            })
            .catch(error => {
                console.log(error);
            });
    };

    handleHeaderMessage(message) {
        return '<p style="font-weight:bold; font-size:150%">' + message + '</p>';
    }

    handleDataType(event) {
        this.selectedDataTypes = event.detail.value;
        this.actionDisabled = !this.selectedDataTypes || this.selectedDataTypes.length <= 0
    };

    handleActions(event) {
        this.selectedAction = event.detail.value;
    };

    handleClear() {
        this.logs = [];
    };

    get isDataLoading() {
        return this.selectedAction === 'LoadData';
    }

    get isJobScheduling() {
        return this.selectedAction === 'RunScheduleJob';
    }

    get isJobRunning() {
        return this.selectedAction === 'RunJob';
    }
}