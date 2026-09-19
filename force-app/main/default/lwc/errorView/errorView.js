import { LightningElement, api } from 'lwc';

export default class ErrorView extends LightningElement {
    @api error;
    @api info;
}