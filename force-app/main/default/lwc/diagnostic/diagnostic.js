import {LightningElement, track, api} from 'lwc';

export default class Diagnostic extends LightningElement {
    @track value;
    @track isLoading = false;
    @track isDailyBatch;
    @track isRunBatch;
    @track isLoadData;
    @track isValidate;
    @track logs = [];
    @track logsExist = false;

    get options() {
        return [
            {label: 'Validation', value: 'Validation'},
            {label: 'Load Test Data', value: 'Load Test Data'},
            {label: 'Set up Daily Batch', value: 'Set up Daily Batch'},
            {label: 'Run Batch', value: 'Run Batch'},
            {label: 'Clear', value: 'Clear'},
        ];
    };

    handleLogs(event) {
        event.detail.forEach(log => {
            this.logs.push(log);
        });
        this.logsExist = true;
    };

    handleDataLoading(event) {
        this.logs.push(event.detail);
        this.logsExist = true;
    };

    handleValidation(event) {
        this.logs.push(event.detail);
        this.logsExist = true;
    }

    handleBatchJob(event) {
        this.logs.push(event.detail);
        this.logsExist = true;
    };

    handleScheduledJob(event) {
        this.logs.push(event.detail);
        this.logsExist = true;
    };

    handleChange(event) {
        this.value = event.detail.value;
        if (this.value == 'Load Test Data') {
            this.isDailyBatch = false;
            this.isRunBatch = false;
            this.isValidate = false;
            this.isLoadData = true;
        }
        if (this.value == 'Validation') {
            this.isDailyBatch = false;
            this.isRunBatch = false;
            this.isValidate = true;
            this.isLoadData = false;
        }
        if (this.value == 'Set up Daily Batch') {
            this.isDailyBatch = true;
            this.isRunBatch = false;
            this.isValidate = false;
            this.isLoadData = false;
        }
        if (this.value == 'Run Batch') {
            this.isDailyBatch = false;
            this.isRunBatch = true;
            this.isLoadData = false;
            this.isValidate = false;
        }
        if (this.value == 'Clear') {
            this.isDailyBatch = false;
            this.isRunBatch = false;
            this.isLoadData = false;
            this.isValidate = false;
            this.logs = [];
            this.logsExist = false;
        }
    };
}