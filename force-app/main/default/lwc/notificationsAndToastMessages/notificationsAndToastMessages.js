import { LightningElement } from 'lwc';

import LightningAlert from 'lightning/alert';
import LightningConfirm from 'lightning/confirm';
import LightningPrompt from 'lightning/prompt';

import Toast from 'lightning/toast';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class NotificationsAndToastMessages extends LightningElement {

    promptValue;
    confirmResult;

    async handleAlert() {

        await LightningAlert.open({
            message: 'This is an Alert message.',
            theme: 'info',
            label: 'Alert'
        });

        console.log('@@@ Alert closed');
    }

    async handleConfirm() {

        const result = await LightningConfirm.open({
            message: 'Do you want to continue?',
            variant: 'headerless',
            label: 'Confirm'
        });

        this.confirmResult = result
            ? 'User clicked OK'
            : 'User clicked Cancel';
    }

    async handlePrompt() {

        this.promptValue = await LightningPrompt.open({
            message: 'Enter your name:',
            label: 'User Input',
            defaultValue: '',
            theme: 'shade'
        });

        if (this.promptValue) {
            console.log(
                '@@@ Prompt Value:',
                this.promptValue
            );
        }
    }

    handleToast() {

        Toast.show({
            label: 'Success',
            message: 'Toast displayed using lightning/toast.',
            mode: 'dismissible',
            variant: 'success'
        });
    }

    handlePlatformToast() {

        const event = new ShowToastEvent({
            title: 'Success',
            message: 'Toast displayed using platformShowToastEvent.',
            variant: 'success',
            mode: 'dismissible'
        });

        this.dispatchEvent(event);
    }
}