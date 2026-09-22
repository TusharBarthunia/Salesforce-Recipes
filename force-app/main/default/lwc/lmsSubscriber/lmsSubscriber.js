import { LightningElement, wire } from 'lwc';
import { subscribe, unsubscribe, MessageContext } from 'lightning/messageService';
import LMS_DEMO from '@salesforce/messageChannel/LmsDemo__c';

export default class LmsSubscriber extends LightningElement {
    subscription = null;
    message = 'Waiting for a message...';

    @wire(MessageContext)
    messageContext;

    connectedCallback() {
        if (this.messageContext) {
            this.subscription = subscribe(
                this.messageContext,
                LMS_DEMO,
                (payload) => {
                    this.message = payload.message;
                }
            );
        }
    }

    disconnectedCallback() {
        if (this.subscription) {
            unsubscribe(this.subscription);
            this.subscription = null;
        }
    }
}
