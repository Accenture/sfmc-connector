import { LightningElement, api, wire } from "lwc";
import getDataExtensionData from "@salesforce/apex/MKTDataExtension.getDataExtensionData";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import MktIcon from "@salesforce/resourceUrl/MktIcon";

export default class MktDataExtensionRows extends LightningElement {
  @api name;
  @api fieldNames;
  @api recordIdFieldName;
  @api componentTitle;
  @api recordId;
  @api accountId;
  rows;
  iconSVG = MktIcon + "#icon";

  /**
   * Retrieve rows from SFMC for current recordid
   * @param {object} root0  result from getDataExtensionData helper
   * @param {object} root0.data  rows from backend
   * @param {object} root0.error  errors from backend
   */
  @wire(getDataExtensionData, {
    name: "$name",
    fieldNames: "$splitFieldNames",
    filterProperty: "$recordIdFieldName",
    filterOperator: "equals",
    filterValue: "$recordId",
    accountId: "$accountId"
  })
  handleRows({ error, data }) {
    if (data && data !== "null") {
      this.rows = data.map((val, i) => {
        const valCopy = JSON.parse(JSON.stringify(val));
        valCopy.rowNumber = i;
        return valCopy;
      });
    } else if (error) {
      this.dispatchEvent(
        new ShowToastEvent({
          title: "Error",
          message: error.message,
          variant: "error"
        })
      );
    }
  }
  /**
   * check if any records were retrieved
   * @returns {boolean} is empty
   */
  get isEmpty() {
    return this.rows.length > 0 ? false : true;
  }
  /**
   * split string to array
   * @returns {string[]} array of strings
   */
  get splitFieldNames() {
    return this.fieldNames?.split(",");
  }
  /**
   * Convert simple array to array of objects
   * @returns {object[]} array of objects
   */
  get columns() {
    return this.splitFieldNames?.map((val) => {
      return {
        label: val,
        fieldName: val
      };
    });
  }
}
