import {LightningElement, track} from 'lwc';
import checkData from '@salesforce/apex/DiagnosticController.checkData';
import setUpBatch from '@salesforce/apex/DiagnosticController.setUpBatch';
import runCountTimeBatch from '@salesforce/apex/DiagnosticController.runCountTimeBatch';
import populateOperatingHours from '@salesforce/apex/DiagnosticController.populateOperatingHours';
import populateWorkTypes from '@salesforce/apex/DiagnosticController.populateWorkTypes';
import populateTenantWarnings from '@salesforce/apex/DiagnosticController.populateTenantWarnings';
import populateQuestions from '@salesforce/apex/DiagnosticController.populateQuestions';
import populateQuestionsLookup from '@salesforce/apex/DiagnosticController.populateQuestionsLookup';
import populateServiceTerritories from '@salesforce/apex/DiagnosticController.populateServiceTerritories';

export default class Diagnostic extends LightningElement {

    @track isPopulateButtonDisabled = true;
    @track isPopulateOpHoursDisabled = true;
    @track isLoading = false;
    @track isPopulateST1Disabled = true;
    @track isPopulateST2Disabled = true;
    @track isPopulateST3Disabled = true;
    @track isPopulateST4Disabled = true;
    @track isPopulateWorkTypesDisabled = true;
    @track isPopulateTWarningsDisabled = true;
    @track isPopulateQuestionsDisabled = true;
    @track isPopulateQuestionsLookupDisabled = true;
    @track logs = [];

    testFslData = () => {
        this.isLoading = true;
        checkData()
            .then(result => {
                let log = result;
                log = log.replace(new RegExp('(OK)', 'g'), STATUS_OK);
                log = log.replace(new RegExp('(WARNING)', 'g'), STATUS_WARNING);
                log = log.replace(new RegExp('(FAILED)', 'g'), STATUS_FAILED);
                this.logs.push(log);
                this.isClearButtonDisabled = false;
                this.isPopulateOpHoursDisabled = false;
                this.isLoading = false;
            })
            .catch(error => {
                this.logs.push(`<span style="color:red">${error}</span>`)
                this.isLoading = false;
            })
    };

    populateOperatingHours = () => {
        this.isLoading = true;
        populateOperatingHours()
            .then(result => {
                this.logs.push(result);
                this.isPopulateST1Disabled = false;
                this.isLoading = false;
            })
            .catch(error => {
                this.logs.push(`<span style="color:red">${error}</span>`)
                this.isLoading = false;
            })
    };

    populateServiceTerritoriesP1 = () => {
        this.isLoading = true;
        populateServiceTerritories()
            .then(result => {
                this.logs.push(result);
                this.isPopulateST2Disabled = false;
                this.isLoading = false;
            })
            .catch(error => {
                this.logs.push(`<span style="color:red">${error}</span>`)
                this.isLoading = false;
            })
    };

    populateServiceTerritoriesP2 = () => {
        this.isLoading = true;
        populateServiceTerritories({toValidate : 'DiagnosticTerritoriesP2.serviceTerritories'})
            .then(result => {
                this.logs.push(result);
                this.isPopulateST3Disabled = false;
                this.isLoading = false;
            })
            .catch(error => {
                this.logs.push(`<span style="color:red">${error}</span>`)
                this.isLoading = false;
            })
    };

    populateServiceTerritoriesP3 = () => {
        this.isLoading = true;
        populateServiceTerritories({toValidate : 'DiagnosticTerritoriesP3.serviceTerritories'})
            .then(result => {
                this.logs.push(result);
                this.isPopulateST4Disabled = false;
                this.isLoading = false;
            })
            .catch(error => {
                this.logs.push(`<span style="color:red">${error}</span>`)
                this.isLoading = false;
            })
    };

    populateServiceTerritoriesP4 = () => {
        this.isLoading = true;
        populateServiceTerritories({toValidate : 'DiagnosticTerritoriesP4.serviceTerritories'})
            .then(result => {
                this.logs.push(result);
                this.isPopulateWorkTypesDisabled = false;
                this.isLoading = false;
            })
            .catch(error => {
                this.logs.push(`<span style="color:red">${error}</span>`)
                this.isLoading = false;
            })
    };

    populateWorkTypes = () => {
        this.isLoading = true;
        populateWorkTypes()
            .then(result => {
                this.logs.push(result);
                this.isPopulateTWarningsDisabled = false;
                this.isLoading = false;
            })
            .catch(error => {
                this.logs.push(`<span style="color:red">${error}</span>`)
                this.isLoading = false;
            })
    };

    populateTenantWarnings = () => {
        this.isLoading = true;
        populateTenantWarnings()
            .then(result => {
                this.logs.push(result);
                this.isPopulateQuestionsDisabled = false;
                this.isLoading = false;
            })
            .catch(error => {
                this.logs.push(`<span style="color:red">${error}</span>`)
                this.isLoading = false;
            })
    };

    populateQuestions = () => {
        this.isLoading = true;
        populateQuestions()
            .then(result => {
                this.logs.push(result);
                this.isPopulateQuestionsLookupDisabled = false;
                this.isLoading = false;
            })
            .catch(error => {
                this.logs.push(`<span style="color:red">${error}</span>`)
                this.isLoading = false;
            })
    };

    populateQuestionsLookup = () => {
        this.isLoading = true;
        populateQuestionsLookup()
            .then(result => {
                this.logs.push(result);
                this.isLoading = false;
            })
            .catch(error => {
                this.logs.push(`<span style="color:red">${error}</span>`)
                this.isLoading = false;
            })
    };

    setUpBatch = () => {
        this.isLoading = true;
        setUpBatch()
            .then(result => {
                this.logs.push(result);
                this.isLoading = false;
            })
            .catch(error => {
                this.logs.push(`<span style="color:red">${error}</span>`)
                this.isLoading = false;
            })
    };

    runCountTimeBatch = () => {
        this.isLoading = true;
        runCountTimeBatch()
            .then(result => {
                this.logs.push(result);
                this.isLoading = false;
            })
            .catch(error => {
                this.logs.push(`<span style="color:red">${error}</span>`)
                this.isLoading = false;
            })
    };

    handleClear = () => {
        this.logs = [];
        this.isClearButtonDisabled = true;
    };

    get logsExist() {
        return !(this.logs === undefined || this.logs === null || this.logs.length === 0);
    }

}

const STATUS_FAILED = '<span style="color:red">FAILED</span>';
const STATUS_OK = '<span style="color:forestgreen">OK</span>';
const STATUS_WARNING = '<span style="color:darkgoldenrod">WARNING</span>';
const STATUS_DUPLICATE_VALUE = '<span style="color:red">DUPLICATED VALUE</span>';