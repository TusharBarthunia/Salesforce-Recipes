import { LightningElement } from 'lwc';

export default class AppEvent extends LightningElement {
    handleButtonClick(event) {
        console.log('## Button click handled in app!', event.target);
        console.log('## Button click handled in app!', event.currentTarget);
    }
}