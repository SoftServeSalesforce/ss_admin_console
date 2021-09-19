import {LightningElement, track, api} from 'lwc';
import execute from '@salesforce/apex/DiagnosticController.execute';
import test from '@salesforce/apex/DiagnosticController.test';
import getDataTypes from '@salesforce/apex/DiagnosticController.getDataTypes';
import getJobClasses from '@salesforce/apex/DiagnosticController.getJobClasses';
import {subscribe} from 'lightning/empApi';

export default class Diagnostic extends LightningElement {
    @track isLoading = false;
    @track selectedAction;
    @track actionDisabled = true;
    @track logs = [];
    @track logsExist = false;
    @track actionTypes = [];
    @track actionNumber = 0;
    @track types = [];
    @track batchClasses = [];
    @track scheduledClasses = [];
    logPayload = {};
    jobResultPayload = {};
    logChannelName = '/event/JobLogEvent__e';
    jobResultChannelName = '/event/JobResultEvent__e';

    get actions() {
        return [
            {label: 'Run Scheduled Job', value: 'RunScheduledJob'},
            {label: 'Run Batchable Job', value: 'RunBatchableJob'},
            {label: 'Load Data', value: 'LoadData'}
        ];
    };

    dataTypes() {
        getDataTypes()
            .then(result => {
                this.types = this.getOptions(result);
            })
            .catch(error => {
                console.log(error);
            })
    };

    getBatchableClasses() {
        getJobClasses({interfaceName: 'Database.Batchable'})
            .then(result => {
                this.batchClasses = this.getOptions(result);
            })
            .catch(error => {
                console.log(error);
            })
    };

    getScheduledClasses() {
        getJobClasses({interfaceName: 'Schedulable'})
            .then(result => {
                this.scheduledClasses = this.getOptions(result);
            })
            .catch(error => {
                console.log(error);
            })
    };

    getOptions(result) {
        let options = [];
        for (let key in result) {
            options.push({
                label: result[key],
                value: result[key]
            });
        }
        return options;
    };

    connectedCallback() {
        this.getBatchableClasses();
        this.getScheduledClasses();
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
            if (this.logPayload.data.payload.SObject_Type__c) {
                this.logs.push(this.handleHeaderMessage(this.handleFinishMessage(
                    this.logPayload.data.payload.SObject_Type__c,
                    this.logPayload.data.payload.Action_Type__c)));
            } else {
                this.actionNumber = 0;
                this.actionDisabled = false;
            }
        };
        subscribe(this.logChannelName, -1, messageCallback).then(response => {
            this.subscription = response;
        });
    };

    handleJobResultSubscribe() {
        const messageCallback = (response) => {
            this.jobResultPayload = JSON.parse(JSON.stringify(response));
            if (this.actionTypes.length != this.actionNumber) {
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
        let type = this.actionTypes[this.actionNumber];
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
        let type = this.actionTypes[this.actionNumber];
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
        this.actionTypes = event.detail.value;
        this.actionDisabled = !this.actionTypes || this.actionTypes.length <= 0
    };

    handleActions(event) {
        this.actionTypes = [];
        this.actionNumber = 0;
        this.actionDisabled = !this.actionTypes || this.actionTypes.length <= 0;
        this.selectedAction = event.detail.value;
    };

    handleClear() {
        this.logs = [];
    };

    handleSelectClassName(event) {
        this.actionTypes.push(event.detail.value);
        this.actionDisabled = !this.actionTypes || this.actionTypes.length <= 0
    }

    get isDataLoading() {
        return this.selectedAction === 'LoadData';
    }

    get isJobScheduled() {
        return this.selectedAction === 'RunScheduledJob';
    }

    get isJobBatchable() {
        return this.selectedAction === 'RunBatchableJob';
    }
}