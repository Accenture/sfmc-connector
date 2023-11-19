import { LightningElement, api, wire } from "lwc";
import unsubscribeFromEmailByEmail from "@salesforce/apex/MKTUnsubscribeController.unsubscribeFromEmailByEmail";
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

  checkIsValid() {
    if (this.refs.email.validity.valid) {
      this.hasError = false;
    } else {
      this.hasError = true;
    }
  }

  handleSubmit() {
    if (this.refs.email.validity.valid) {
      console.log(
        "check",
        this.refs.email.value,
        this.refs.reason.value,
        this.pageRef
      );
      unsubscribeFromEmailByEmail({
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
        });
    } else {
      console.log("valid", this.refs.email.validity.valid);
    }
  }
}
