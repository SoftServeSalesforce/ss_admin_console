import { LightningElement, api, track } from 'lwc';
import { subscribe } from 'lightning/empApi';

export default class LogsListener extends LightningElement {
    payload = {};
    channelName = '/event/JobLogEvent__e';
    connectedCallback() {
        this.handleSubscribe();
    };

    handleSubscribe() {
        const messageCallback = (response) => {
            let logs = [];
            this.payload = JSON.parse(JSON.stringify(response));
            logs.push(this.handleMessageType(this.payload.data.payload.Message_Type__c));
            logs.push(this.payload.data.payload.CreatedDate + ': ' + this.payload.data.payload.Message__c);
            const logsEvent = new CustomEvent('logslistener', {
                detail: logs
            });
            this.dispatchEvent(logsEvent);
        };
        subscribe(this.channelName, -1, messageCallback).then(response => {
            this.subscription = response;            
        });
    }
    

    handleMessageType(messageType) {
        if (messageType == "WARNING") {
            return STATUS_WARNING;
        }
        if (messageType == "FAILED") {
            return STATUS_FAILED;
        }
        if (messageType == "OK") {
            return STATUS_OK;
        }
        if (messageType == "DUPLICATED") {
            return STATUS_DUPLICATE_VALUE;
        }
    }
}

const STATUS_FAILED = '<span style="color:red">FAILED</span>';
const STATUS_OK = '<span style="color:forestgreen">OK</span>';
const STATUS_WARNING = '<span style="color:darkgoldenrod">WARNING</span>';
const STATUS_DUPLICATE_VALUE = '<span style="color:red">DUPLICATED VALUE</span>';