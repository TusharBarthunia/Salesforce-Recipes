import { LightningElement, api } from 'lwc';

export default class LdsAccountEditor extends LightningElement {
    @api recordId;

    handleSuccess(event) {

        console.log(
            '@@@ Account updated successfully',
            event.detail.id
        );
    }

    handleError(event) {

        console.error(
            '@@@ Account update failed',
            event.detail
        );
    }
}