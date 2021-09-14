import {LightningElement, track, api} from 'lwc';
import execute from '@salesforce/apex/DiagnosticController.execute';
import test from '@salesforce/apex/DiagnosticController.test';
import {subscribe} from 'lightning/empApi';

export default class Diagnostic extends LightningElement {
    @track isLoading = false;
    @track selectedAction;
    @track actionDisabled = true;
    @track logs = [];
    @track logsExist = false;
    @track selectedDataType;
    payload = {};
    channelName = '/event/JobLogEvent__e';

    get actions() {
        return [
            {label: 'Run Schedule Job', value: 'RunScheduleJob'},
            {label: 'Run Job', value: 'RunJob'},
            {label: 'Load Data', value: 'LoadData'}
        ];
    };

    get dataTypes() {
        return [
            {label: 'Customer Data', value: 'CUSTOMERS_DATA'},
            {label: 'Product Data', value: 'PRODUCTS_DATA'},
            {label: 'Opportunity Data', value: 'OPPORTUNITY_DATA'}
        ];
    };

    connectedCallback() {
        this.handleSubscribe();
    };

    handleSubscribe() {
        const messageCallback = (response) => {
            this.payload = JSON.parse(JSON.stringify(response));
            this.logsExist = true;
            this.logs.push(this.handleMessage(this.payload.data.payload.Message_Type__c,
                this.payload.data.payload.Message_Title__c,
                this.payload.data.payload.Message__c,
                this.payload.data.payload.CreatedDate));
            this.logs.push(this.handleHeaderMessage(this.handleFinishMessage(
                this.payload.data.payload.SObject_Type__c,
                this.payload.data.payload.Action_Type__c)))
        };
        subscribe(this.channelName, -1, messageCallback).then(response => {
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
        execute({actionTypes: this.selectedDataType})
            .then(result => {
                this.logs.push(this.handleHeaderMessage(result));
            })
            .catch(error => {
                console.log(error);
            })
    };

    handleTest = () => {
        test({actionTypes: this.selectedDataType})
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
        this.selectedDataType = event.detail.value;
    };

    handleActions(event) {
        this.selectedAction = event.detail.value;
        this.actionDisabled = false;
    };

    handleClear() {
        this.logs = [];
    };

    get isDataLoading() {
        return this.selectedAction == 'LoadData';
    }

    get isJobScheduling() {
        return this.selectedAction == 'RunScheduleJob';
    }

    get isJobRunning() {
        return this.selectedAction == 'RunJob';
    }
}