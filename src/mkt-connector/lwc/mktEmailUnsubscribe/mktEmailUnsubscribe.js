import { LightningElement, api, wire } from "lwc";
import unsubscribeFromEmailController from "@salesforce/apex/MKTUnsubscribeController.unsubscribeFromEmailController";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { CurrentPageReference } from "lightning/navigation";

export default class MktEmailUnsubscribe extends LightningElement {
  @api accountId;

  @wire(CurrentPageReference)
  pageRef;

  options = [
    {
      label: "Never Subscribed",
      value: "NeverSubscribed"
    },
    {
      label: "No longer relevant",
      value: "NoLongerRelevant"
    }
  ];

  hasError = true;
  /**
   * Helper to determine if email is potentially valid
   */
  checkIsValid() {
    this.hasError = this.refs.email.validity.valid ? false : true;
  }
  /**
   * Submit the unsubscribe request
   */
  handleSubmit() {
    if (this.refs.email.validity.valid) {
      unsubscribeFromEmailController({
        emailAddress: this.refs.email.value,
        accountId: this.accountId,
        reason: this.refs.reason.value,
        jobId: this.jobId,
        batchId: this.batchId
      })
        .then((res) => {
          console.log("res", res);
        })
        .catch((error) => {
          console.error("error", error);
          ShowToastEvent({
            title: "Error",
            message: error.message,
            variant: "error"
          });
        });
    } else {
      console.log("valid", this.refs.email.validity.valid);
    }
  }
}
