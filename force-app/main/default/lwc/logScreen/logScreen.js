import { LightningElement, api, track } from 'lwc';
import { subscribe, unsubscribe, onError, setDebugFlag, isEmpEnabled } from 'lightning/empApi';

export default class LogScreen extends LightningElement {
    @track logs = [];
    payload = {};
    channelName = '/event/JobLogEvent__e';

    connectedCallback() {
        const messageCallback = (response) => {
            this.payload = JSON.parse(JSON.stringify(response));
            this.logs.push(this.payload.data.payload.CreatedDate + ': ' + this.payload.data.payload.Message__c);
        };

        subscribe(this.channelName, -1, messageCallback).then(response => {
            this.subscription = response;
        });
    }

    get logsExist() {
        return !(this.logs === undefined || this.logs === null || this.logs.length === 0);
    }
}