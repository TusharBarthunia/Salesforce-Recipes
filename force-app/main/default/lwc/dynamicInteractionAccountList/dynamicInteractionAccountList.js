import { LightningElement, wire } from 'lwc';

import getAccounts from '@salesforce/apex/AccountControllerDatatable.getAccounts';

const COLUMNS = [
    {
        label: 'Account Name',
        fieldName: 'Name'
    },
    {
        label: 'Industry',
        fieldName: 'Industry'
    },
    {
        label: 'Phone',
        fieldName: 'Phone'
    }
];

export default class DynamicInteractionAccountList extends LightningElement {

    accounts = [];
    columns = COLUMNS;

    @wire(getAccounts)
    wiredAccounts({ data, error }) {

        if (data) {

            this.accounts = data;

        } else if (error) {

            console.error(
                '@@@ Error loading Accounts',
                error
            );
        }
    }


    handleRowSelection(event) {

        const selectedRows = event.detail.selectedRows;

        if (selectedRows.length === 0) {
            return;
        }

        const selectedAccount = selectedRows[0];

        const itemSelected = new CustomEvent(
            'itemselected',
            {
                detail: {
                    recordId: selectedAccount.Id,
                    accountName: selectedAccount.Name
                }
            }
        );

        this.dispatchEvent(itemSelected);
    }
}