import { LightningElement, track, api } from 'lwc';
import runBatch from '@salesforce/apex/DiagnosticController.runBatch';
import obtainBatchClasses from '@salesforce/apex/DiagnosticController.obtainBatchClasses';

export default class RunBatchJob extends LightningElement {
    @track batchClasses = [];
    @track batchSize;
    @track batchClassName;
    @api isrun;

    connectedCallback() {
        this.runBatchAction();
    }

    getBatchClasses(actions) {
        let result = [];
        for (let key in actions) {
            result.push ({
                'label' : actions[key],
                'value' : actions[key]
            });
        }
        return result;
    };

    handleSelectClassName(event) {
        this.batchClassName = event.detail.value;
    };

    handleBatchSize(event) {
        this.batchSize = event.target.value;
    };

    handleRunBatch = () => {
        this.isLoading = true;
        runBatch({className: this.batchClassName, batchSize: this.batchSize})
            .then(result => {
                 this.isLoading = false;
             })
             .catch(error => {
                 this.isLoading = false;
             })
    };

    runBatchAction = () => {
        obtainBatchClasses()
            .then(result => {
                this.batchClasses = this.getBatchClasses(result);
        })
            .catch(error => {
                console.log(error);
        });
    };
}