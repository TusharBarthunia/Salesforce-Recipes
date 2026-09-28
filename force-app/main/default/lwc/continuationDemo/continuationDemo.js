import { LightningElement } from 'lwc';

import startRequest from '@salesforce/apexContinuation/ContinuationDemoController.startRequest';

export default class ContinuationDemo extends LightningElement {

    response;
    error;
    isLoading = false;


    handleCallout() {

        this.isLoading = true;
        this.response = undefined;
        this.error = undefined;


        startRequest()

            .then(result => {

                console.log(
                    '@@@ Continuation Response:',
                    result
                );

                this.response = result;

            })

            .catch(error => {

                console.error(
                    '@@@ Continuation Error:',
                    error
                );

                this.error =
                    error?.body?.message ||
                    'Unknown error occurred';

            })

            .finally(() => {

                this.isLoading = false;

            });
    }
}