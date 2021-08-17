import {LightningElement, track, api} from 'lwc';
import execute from '@salesforce/apex/DiagnosticController.execute';
import test from '@salesforce/apex/DiagnosticController.test';
import {subscribe} from 'lightning/empApi';

export default class Diagnostic extends LightningElement {
    @track isLoading = false;
    @track selectedAction;
    @track isActionSelected;
    @track logs = [];
    @track logsExist = false;
    payload = {};
    channelName = '/event/JobLogEvent__e';

    get options() {
        return [
            {label: 'Customer Data', value: 'CUSTOMERS_DATA'},
            {label: 'Product Data', value: 'PRODUCTS_DATA'},
            {label: 'Clear', value: 'Clear'},
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
    }

    setColor(color, message) {
        return '<p style="font-weight: bold; color:' + color + '">' + message + '</p>';
    }

    handleExecute = () => {
        execute({actionType: this.selectedAction})
            .then(result => {
                this.logs.push(result);
            })
            .catch(error => {
                console.log(error);
            })
    };

    handleTest = () => {
        test({actionType: this.selectedAction})
            .then(result => {
                this.logs.push(result);
            })
            .catch(error => {
                console.log(error);
            });
    };

    handleChange(event) {
        this.selectedAction = event.detail.value;
        this.isActionSelected = true;
        if (this.selectedAction == 'Clear') {
            this.logs = [];
            this.isActionSelected = false;
        }
    };
}