import { LightningElement, wire } from 'lwc';
import checkApexTypes from '@salesforce/apex/ApexTypesController.checkApexTypes';

export default class ApexWireMethodWithComplexParams extends LightningElement {
    listItemValue = 0;
    numberValue = 50;
    stringValue = 'Some string';

    parameterObject = {
        someString: this.stringValue,
        someInteger: this.numberValue,
        someList: []
    };

    @wire(checkApexTypes, { wrapper: '$parameterObject', sample: 'Test' })
    apexResponse;

    get errorMessage() {
        return (
            this.apexResponse?.error?.body?.message ||
            this.apexResponse?.error?.message
        );
    }

    handleStringChange(event) {
        this.parameterObject = {
            ...this.parameterObject,
            someString: (this.stringValue = event.target.value)
        };
    }

    handleNumberChange(event) {
        this.parameterObject = {
            ...this.parameterObject,
            someInteger: (this.numberValue = parseInt(event.target.value, 10))
        };
    }

    handleListItemChange(event) {
        const someList = [];
        for (let index = 0; index < event.target.value; index++) {
            someList.push(this.stringValue);
        }
        this.parameterObject = {
            ...this.parameterObject,
            someList
        };
    }
}