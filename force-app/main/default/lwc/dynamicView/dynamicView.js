import { LightningElement } from 'lwc';

export default class DynamicView extends LightningElement {

    error;
    stack;


  errorCallback(error, stack) {
    this.error = error;
    console.log('@@@ Error'+JSON.stringify(error));
    console.log('@@@ Error'+JSON.stringify(stack));
  }
}