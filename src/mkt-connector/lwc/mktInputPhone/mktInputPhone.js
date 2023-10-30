import { LightningElement, api, track } from "lwc";
import intlTelInput from "@salesforce/resourceUrl/MKTIntlTelInput";
import { loadScript, loadStyle } from "lightning/platformResourceLoader";
import LANG from "@salesforce/i18n/lang";
import mktInvalidNumber from "@salesforce/label/c.mktInvalidNumber";
import mktInvalidCountryCode from "@salesforce/label/c.mktInvalidCountryCode";
import mktTooShort from "@salesforce/label/c.mktTooShort";
import mktTooLong from "@salesforce/label/c.mktTooLong";
import mktInvalidNumberForType from "@salesforce/label/c.mktInvalidNumberForType";

const errorMap = [
  mktInvalidNumber,
  mktInvalidCountryCode,
  mktTooShort,
  mktTooLong,
  mktInvalidNumber
];

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

const validTypes = {
  mobile: ["MOBILE", "FIXED_LINE_OR_MOBILE"],
  landline: ["FIXED_LINE", "FIXED_LINE_OR_MOBILE"]
};

export default class InputPhone extends LightningElement {
  @api defaultCountryCode;
  @api selectableCountryCodes;
  @api label = "Phone Number";
  @api initialValue = "";
  @api numberType;
  @track inputElem;
  @track iti;
  _isLoading = false;
  errorMessage = "";
  isValid = false;
  /**
   * Connected Callback Handler
   */
  connectedCallback() {
    this._isLoading = true;
    Promise.all([
      loadStyle(this, intlTelInput + "/css/intlTelInput.min.css"),
      loadScript(this, intlTelInput + "/js/intlTelInput.min.js")
    ]).then(() => {
      const settings = {
        utilsScript: intlTelInput + "/js/utils.js",
        localizedCountries: generateLocalCountryMap(
          window.intlTelInputGlobals.getCountryData().map((val) => val.iso2),
          LANG
        )
      };
      if (this.onlyCountryCodes) {
        settings.onlyCountries = this.selectableCountryCodes;
      }
      if (this.defaultCountryCode) {
        settings.initialCountry = this.defaultCountryCode;
        settings.preferredCountries = [settings.initialCountry];
      } else {
        settings.initialCountry = "auto";
        settings.geoIpLookup = (callback) => {
          fetch("https://ipapi.co/json")
            .then((res) => res.json())
            .then((data) => callback(data.country_code))
            .catch(() => callback(""));
        };
      }
      this.iti = window.intlTelInput(
        this.template.querySelector("[data-id=country]"),
        settings
      );
      if (this.initialValue) {
        this.iti.setNumber(this.initialValue);
      }
      this._isLoading = false;
    });
  }
  /**
   * Handle change in value in the input field
   */
  handleChange() {
    const baseEvent = {
      phoneNumber: this.iti.getNumber(),
      isValidNumber: this.iti.isValidNumber()
    };
    this.isValid = baseEvent.isValidNumber;
    if (baseEvent.isValidNumber) {
      baseEvent.location = this.iti.getSelectedCountryData();
      baseEvent.numberType = numberTypeMap[this.iti.getNumberType()];
      // if a specific numbertype was provided then filter for this
      this.errorMessage =
        this.numberType &&
        validTypes[this.numberType].includes(baseEvent.numberType)
          ? ""
          : mktInvalidNumberForType;
    } else {
      baseEvent.errorCode = this.iti.getValidationError();
      baseEvent.errorMessage = errorMap[baseEvent.errorCode];
      this.errorMessage = baseEvent.errorMessage;
    }
    this.dispatchEvent(new CustomEvent("validate", { detail: baseEvent }));
  }

  /**
   * get style when invalid
   * @returns {string} class string
   */
  get styleForState() {
    return this.isValid
      ? "slds-form-element"
      : "slds-form-element slds-has-error";
  }
}
/**
 * Get local country names based on user language
 * @param {string[]} iso2List list of countries to be translated
 * @param {string} language target language
 * @returns {object} map of iso codes to names of countries
 */
function generateLocalCountryMap(iso2List, language) {
  const m = {};
  const regionNames = new Intl.DisplayNames([language], { type: "region" });
  for (const iso2 of iso2List) {
    m[iso2] = regionNames.of(iso2.toUpperCase());
  }
  return m;
}
