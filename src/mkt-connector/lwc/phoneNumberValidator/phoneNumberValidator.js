import { LightningElement, wire, api } from "lwc";
import { getRecord, updateRecord } from "lightning/uiRecordApi";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { refreshApex } from "@salesforce/apex";
import ID_FIELD from "@salesforce/schema/Contact.Id";
import MOBILE_FIELD from "@salesforce/schema/Contact.MobilePhone";
export default class PhoneNumberValidator extends LightningElement {
  @api recordId;
  @api objectApiName;
  currentNumber;
  futureNumber;
  _isEditing = false;
  isInvalid = true;

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
    this.futureNumber = event.detail.isValidNumber
      ? event.detail.phoneNumber
      : null;
    this.isInvalid = !this.futureNumber;
  }
  toggleEdit() {
    this._isEditing = !this._isEditing;
  }
  handleSave() {
    const fields = {};
    fields[ID_FIELD.fieldApiName] = this.recordId;
    fields[MOBILE_FIELD.fieldApiName] = this.futureNumber;
    updateRecord({ fields })
      .then(() => {
        this.dispatchEvent(
          new ShowToastEvent({
            title: "Success",
            message: "Contact updated",
            variant: "success"
          })
        );
        // Display fresh data in the form
        return refreshApex({ fields });
      })
      .catch((error) => {
        this.dispatchEvent(
          new ShowToastEvent({
            title: "Error creating record",
            message: error.body.message,
            variant: "error"
          })
        );
      })
      .finally(() => {
        this.toggleEdit();
      });
  }
}
