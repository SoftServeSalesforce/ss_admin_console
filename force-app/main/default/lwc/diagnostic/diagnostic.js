import {LightningElement, track, wire} from 'lwc';

export default class Diagnostic extends LightningElement {
    @track value;
    @track isLoading = false;
    @track isTestFLSData;
    @track isDailyBatch;
    @track isRunBatch;
    @track isLoadData;
    
    get options() {
        return [
            { label: 'Load Test Data', value: 'Load Test Data' },
            { label: 'Set up Daily Batch', value: 'Set up Daily Batch' },
            { label: 'Run Batch', value: 'Run Batch' },
            { label: 'Clear', value: 'Clear' },
        ];
    };

    handleChange(event) {
        this.value = event.detail.value;
        if (this.value == 'Load Test Data') {
            this.isTestFLSData = false;
            this.isDailyBatch = false;
            this.isRunBatch = false;
            this.isLoadData = true;
        }
        if (this.value == 'Set up Daily Batch') {
            this.isTestFLSData = false;
            this.isDailyBatch = true;
            this.isRunBatch = false;
            this.isLoadData = false;
        }
        if (this.value == 'Run Batch') {
            this.isTestFLSData = false;
            this.isDailyBatch = false;
            this.isRunBatch = true;
            this.isLoadData = false;
        }
        if (this.value == 'Clear') {
            this.isTestFLSData = false;
            this.isDailyBatch = false;
            this.isRunBatch = false;
            this.isLoadData = false;
        }
    };
}

const STATUS_FAILED = '<span style="color:red">FAILED</span>';
const STATUS_OK = '<span style="color:forestgreen">OK</span>';
const STATUS_WARNING = '<span style="color:darkgoldenrod">WARNING</span>';
const STATUS_DUPLICATE_VALUE = '<span style="color:red">DUPLICATED VALUE</span>';