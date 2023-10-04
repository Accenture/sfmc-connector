import { LightningElement, api, track } from "lwc";
import intlTelInput from "@salesforce/resourceUrl/MKTIntlTelInput";
import { loadScript, loadStyle } from "lightning/platformResourceLoader";
const errorMap = [
  "Invalid number",
  "Invalid country code",
  "Too short",
  "Too long",
  "Invalid number"
]; // TODO update with labels to allow translation of errors
const numberTypeMap = [
  "FIXED_LINE",
  "MOBILE",
  "FIXED_LINE_OR_MOBILE",
  "TOLL_FREE",
  "PREMIUM_RATE",
  "SHARED_COST",
  "VOIP",
  "PERSONAL_NUMBER",
  "PAGER",
  "UAN",
  "VOICEMAIL",
  "UNKNOWN"
];
export default class InputPhone extends LightningElement {
  @api defaultCountryCode;
  @api selectableCountryCodes;
  @api label = "Phone Number";
  @api required = false;
  @api initialValue = "";
  @track inputElem;
  @track iti;
  _isLoading = false;
  errorMessage = "";
  isValid = false;
  connectedCallback() {
    this._isLoading = true;
    Promise.all([
      loadStyle(this, intlTelInput + "/css/intlTelInput.min.css"),
      loadScript(this, intlTelInput + "/js/intlTelInput.min.js")
    ]).then(() => {
      console.log("LOADED");
      this.inputElem = this.template.querySelector("[data-id=country]");
      const settings = {
        utilsScript: intlTelInput + "/js/utils.js",
        localizedCountries: {} // TODO provide local values for countries
      };
      if (this.onlyCountryCodes) {
        settings.onlyCountries = this.selectableCountryCodes;
      }
      if (this.defaultCountryCode) {
        settings.initialCountry = [this.defaultCountryCode];
        settings.preferredCountries = settings.initialCountry;
      } else {
        settings.initialCountry = "auto";
        settings.geoIpLookup = (callback) => {
          fetch("https://ipapi.co/json")
            .then((res) => res.json())
            .then((data) => callback(data.country_code))
            .catch(() => callback(""));
        };
      }
      this.iti = window.intlTelInput(this.inputElem, settings);
      if (this.initialValue) {
        this.iti.setNumber(this.initialValue);
      }
      this._isLoading = false;
    });
  }
  handleChange() {
    const baseEvent = {
      phoneNumber: this.iti.getNumber(),
      isValidNumber: this.iti.isValidNumber()
    };
    this.isValid = baseEvent.isValidNumber;
    if (baseEvent.isValidNumber) {
      baseEvent.location = this.iti.getSelectedCountryData();
      baseEvent.numberType = numberTypeMap[this.iti.getNumberType()];
      this.errorMessage = "";
    } else {
      baseEvent.errorCode = this.iti.getValidationError();
      baseEvent.errorMessage = errorMap[baseEvent.errorCode];
      this.errorMessage = baseEvent.errorMessage;
    }
    console.log(JSON.stringify(baseEvent));
    // Fire the custom event
    this.dispatchEvent(new CustomEvent("validate", { detail: baseEvent }));
  }

  get styleForState() {
    if (this.isValid) {
      return "slds-form-element";
    } else {
      return "slds-form-element slds-has-error";
    }
  }
}
