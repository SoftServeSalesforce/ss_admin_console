import { LightningElement, api, track } from 'lwc';
import runDataLoading from '@salesforce/apex/DiagnosticController.runDataLoading';

export default class LoadTestData extends LightningElement {
    @api isrun;

    handleLoadData = () => {
        runDataLoading()
            .then(result => {
                const runDataLoading = new CustomEvent('rundataloading', {
                    detail: result
                });
                this.dispatchEvent(runDataLoading);
        })
            .catch(error => {
                console.log(error);
        });
    }
}