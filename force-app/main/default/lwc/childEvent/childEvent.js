import { LightningElement } from 'lwc';

export default class ChildEvent extends LightningElement {
    handleClick(event) {
        //this.dispatchEvent(new CustomEvent('customevent'));
        //this.dispatchEvent(new CustomEvent('customevent',{ bubbles: true}));
        //this.dispatchEvent(new CustomEvent('customevent',{ bubbles: false,composed: true})); // not supported in LWC, works as same as bubbles:false, composed:false
        this.dispatchEvent(new CustomEvent('customevent',{ bubbles: true,composed: true}));
        console.log('## Child event fired!'+JSON.stringify(event.target));
        console.log('## Child event fired!'+JSON.stringify(event.currentTarget));
    }
}