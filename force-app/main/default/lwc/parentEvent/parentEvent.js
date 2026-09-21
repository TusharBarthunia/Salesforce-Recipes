import { LightningElement } from 'lwc';

export default class ParentEvent extends LightningElement {
    handleButtonClickChild(event) {
        console.log('## Button click handled in parent!'+JSON.stringify(event.target));
        console.log('## Button click handled in parent!'+JSON.stringify(event.currentTarget));
    }

    handleButtonClickDiv(event) {
        console.log('## Button click handled in parent Div!'+JSON.stringify(event.target));
        console.log('## Button click handled in parent Div!'+JSON.stringify(event.currentTarget));
    }
}