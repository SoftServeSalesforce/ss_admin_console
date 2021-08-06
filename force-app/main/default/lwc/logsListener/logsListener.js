import {LightningElement} from 'lwc';
import {subscribe} from 'lightning/empApi';

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
            logs.push(this.handleMessage(this.payload.data.payload.Message_Type__c,
                this.payload.data.payload.Message_Title__c,
                this.payload.data.payload.Message__c,
                this.payload.data.payload.CreatedDate));
            const logsEvent = new CustomEvent('logslistener', {
                detail: logs
            });
            this.dispatchEvent(logsEvent);
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
}