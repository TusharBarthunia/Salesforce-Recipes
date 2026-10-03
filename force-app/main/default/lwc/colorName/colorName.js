// colorName.js
import { LightningElement, api } from "lwc";

export default class colorName extends LightningElement {
  @api color;

  get colorStyle() {
    return "color:" + this.color;
  }
}