import { LightningElement, api, wire } from "lwc";
import { getRecord, updateRecord } from "lightning/uiRecordApi";
import { getObjectInfo } from "lightning/uiObjectInfoApi";
import { refreshApex } from "@salesforce/apex";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class MktPhoneNumbers extends LightningElement {
  @api mobilePhoneField;
  @api landlinePhoneField;
  @api recordId;
  @api objectApiName;
  @api defaultCountryCode;

  phoneNumbers;

  _isEditing = false;

  _editingField;

  _futureState;

  _isLoading = false;

  @wire(getObjectInfo, { objectApiName: "$objectApiName" })
  _objectDetails;

  /**
   * get phone fields from getRecord helper
   * @param {object} root0  result from getRecord helper
   * @param {object} root0.data  data object from result
   */
  @wire(getRecord, {
    recordId: "$recordId",
    fields: "$fields"
  })
  handleChannels({ data }) {
    if (data) {
      this.phoneNumbers = this.fields
        .filter((field) => field != null)
        .map((field) => {
          const name = field.split(".")[1];
          return {
            name: name,
            label: this._objectDetails.data.fields[name].label,
            type: this.mobilePhoneField === field ? "mobile" : "landline",
            value: data.fields[name].value
          };
        });
    }
  }

  /**
   * return field which is currently being edited
   * @returns {object} selected field
   */
  get _currentEditingField() {
    return this.phoneNumbers.find((phone) => phone.name === this._editingField);
  }

  /**
   * handle edit
   * @param {event} event from clicking edit
   */
  toggleEdit(event) {
    if (this._editingField) {
      this._editingField = null;
      this._futureState = null;
    } else {
      this._editingField = event.target.dataset.fieldName;
      this._futureState = { errorMessage: "no change" };
    }
  }

  /**
   * get fields which are to be displayed
   * @returns {string[]} fields array
   */
  get fields() {
    return [this.mobilePhoneField, this.landlinePhoneField];
  }

  /**
   * handle updated input
   * @param {event} event from input phone component
   */
  handleValidate(event) {
    this._futureState = event.detail;
  }

  /**
   * handle save event
   */
  handleSave() {
    this._isLoading = true;
    const fields = { Id: this.recordId };
    fields[this._editingField] = this._futureState.phoneNumber;
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
        this._isLoading = false;
        this.toggleEdit();
      });
  }
}
