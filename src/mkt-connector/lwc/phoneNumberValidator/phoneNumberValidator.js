import { LightningElement, wire, api } from "lwc";
import { getRecord } from "lightning/uiRecordApi";
import MOBILE_FIELD from "@salesforce/schema/Contact.MobilePhone";
export default class PhoneNumberValidator extends LightningElement {
  @api recordId;
  @api objectApiName;
  currentNumber;
  _isEditing = false;

  @wire(getRecord, {
    recordId: "$recordId",
    fields: [MOBILE_FIELD]
  })
  handleChannels({ error, data }) {
    if (data) {
      this.currentNumber = data.fields.MobilePhone.value;
    }
  }
  handleValidate(event) {
    console.log("ONVALIDATE EVENT", event, JSON.stringify(event.detail));
  }
  toggleEdit() {
    this._isEditing = !this._isEditing;
  }
}
