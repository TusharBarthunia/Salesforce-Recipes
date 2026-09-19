import { LightningElement } from 'lwc';

export default class HealthView extends LightningElement {
    tempString;
    handleTestError() {

        console.log('@@@ Test Error button clicked'+ tempString); // this will throw error at runtime and it will be catch in the errorcallback lifecycle hook of the wrapper 

    }
}