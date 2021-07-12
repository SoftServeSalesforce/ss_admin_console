import { LightningElement, api, track } from 'lwc';
import runDataLoading from '@salesforce/apex/DiagnosticController.runDataLoading';

export default class LoadTestData extends LightningElement {
    @api isrun;

    handleLoadData = () => {
        runDataLoading()
            .then(result => {
                
        })
            .catch(error => {
                console.log(error);
        });
    }
}