import { LightningElement, wire } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import LMS_DEMO from '@salesforce/messageChannel/LmsDemo__c';

export default class LmsPublisher extends LightningElement {
    messageText = 'Hello from the publisher';

    @wire(MessageContext)
    messageContext;

    handleInputChange(event) {
        this.messageText = event.target.value;
    }

    handlePublish() {
        const payload = {
            message: this.messageText
        };

        publish(this.messageContext, LMS_DEMO, payload);
    }
}
