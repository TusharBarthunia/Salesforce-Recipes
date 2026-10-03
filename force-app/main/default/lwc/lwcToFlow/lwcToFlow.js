import { LightningElement,api, track } from 'lwc';
import { FlowAttributeChangeEvent } from "lightning/flowSupport";

export default class LwcToFlow extends LightningElement {
    @track _input;

  @api
  set customTextValue(input) {
    if (input) {
      this._input = input;
    }
  }
  get customTextValue() {
    return this._input;
  }

  handleInputChange(event) {
    const attributeChangeEvent = new FlowAttributeChangeEvent(
      "customTextValue",
      event.target.value,
    );
    this.dispatchEvent(attributeChangeEvent);
  }
}