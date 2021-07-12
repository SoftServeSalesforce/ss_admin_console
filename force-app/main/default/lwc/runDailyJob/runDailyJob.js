import { LightningElement, track, api } from 'lwc';
import obtainScheduledClasses from '@salesforce/apex/DiagnosticController.obtainScheduledClasses';
import setUpScheduledJob from '@salesforce/apex/DiagnosticController.setUpScheduledJob';

export default class RunDailyJob extends LightningElement {
    @track scheduledClasses = [];
    @track scheduledTime;
    @track scheduledClassName;
    @api isrun;

    connectedCallback() {
        this.runDailyJobAction();
    }

    runDailyJobAction = () => {
        obtainScheduledClasses()
            .then(result => {
                this.scheduledClasses = this.getScheduledClasses(result);
        })
            .catch(error => {
                console.log(error);
        });
    };

    getScheduledClasses(actions) {
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
        this.scheduledClassName = event.detail.value;
    };

    handleScheduledTime(event) {
        this.scheduledTime = event.target.value;
    };

    handleRunScheduledJob = () => {
        this.isLoading = true;
        setUpScheduledJob({className: this.scheduledClassName, jobTime: this.scheduledTime})
            .then(result => {
                 this.isLoading = false;
             })
             .catch(error => {
                 this.isLoading = false;
             })
    };
}