import {LightningElement, api, track} from 'lwc';
import runValidation from '@salesforce/apex/DiagnosticController.runValidation';

export default class DataValidation extends LightningElement {
    @api isrun;

    handleValidateData = () => {
        runValidation()
            .then(result => {
                const runValidation = new CustomEvent('runvalidation', {
                    detail: result
                });
                this.dispatchEvent(runValidation);
            })
            .catch(error => {
                console.log(error);
            });
    }
}