import { LightningElement, track, api } from 'lwc';
import runBatch from '@salesforce/apex/DiagnosticController.runBatch';
import obtainJobClasses from '@salesforce/apex/DiagnosticController.obtainJobClasses';

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
        if (!this.batchClassName || !this.batchSize) {
            return;
        }
        runBatch({className: this.batchClassName, batchSize: this.batchSize})
            .then(result => {
                const runJobEvent = new CustomEvent('runbatchjob', {
                    detail: result
                });
                this.dispatchEvent(runJobEvent);
             })
             .catch(error => {
                 console.log(error);
             })
    };

    runBatchAction = () => {
        obtainJobClasses({interfaceName: 'Database.Batchable'})
            .then(result => {
                this.batchClasses = this.getBatchClasses(result);
        })
            .catch(error => {
                console.log(error);
        });
    };
}