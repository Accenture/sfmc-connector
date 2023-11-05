/**
 * @description Data Extension specific methods
 */

public with sharing class MKTDataExtension {
	/**
	 * @description SOAP simple filter
	 */
	@SuppressWarnings(
		'PMD.FieldNamingConventions,PMD.VariableNamingConventions'
	) // cannot use different values
	public class SimpleFilter {
		public String Property;
		public String SimpleOperator;
		public String Value;
	}
	/**
	 * @description Request with Simple Filter
	 */
	@SuppressWarnings(
		'PMD.FieldNamingConventions,PMD.VariableNamingConventions'
	) // cannot use different values
	public class SimpleRetrieveRequest {
		public String ObjectType;
		public List<String> Properties;
		public SimpleFilter Filter;
	}

	/**
	 * @description Retreive data from data extension
	 * using a single field filter
	 * @param accountId MID in SFMC
	 * @param name name of data extension
	 * @param fieldNames list of fields to be returned
	 * @param filterProperty (optional) field which should be used as filter
	 * @param filterOperator (optional) type of comparison
	 * @param filterValue (optional) value to filter upon
	 * @return generic JSON object
	 */
	@AuraEnabled(cacheable=true)
	@SuppressWarnings(
		'PMD.ExcessiveParameterList'
	) // cannot pass more complex values
	public static object getDataExtensionData(
		String accountId,
		String name,
		List<String> fieldNames,
		String filterProperty,
		String filterOperator,
		String filterValue
	) {
		try {
			MKTDataExtension.SimpleRetrieveRequest r = new MKTDataExtension.SimpleRetrieveRequest();
			r.Properties = fieldNames;
			r.ObjectType = 'DataExtensionObject[' + name + ']';

			if (String.isNotEmpty(filterProperty)) {
				r.Filter = new MKTDataExtension.SimpleFilter();
				r.Filter.Property = filterProperty;
				r.Filter.SimpleOperator = filterOperator;
				r.Filter.Value = filterValue;
			}

			DataWeave.Script requesScript = new DataWeaveScriptResource.RetrieveRequestMsgToXML();
			DataWeave.Result requestResult = requesScript.execute(
				new Map<String, List<MKTDataExtension.SimpleRetrieveRequest>>{
					'payload' => new List<MKTDataExtension.SimpleRetrieveRequest>{ r }
				}
			);
			MktSoap sdk = new MktSoap(accountId);
			HttpResponse res = sdk.send(requestResult.getValueAsString(), 'Retrieve');
			DataWeave.Script responseScript = new DataWeaveScriptResource.RetrieveDataExtensionRows();
			DataWeave.Result result = responseScript.execute(
				new Map<String, String>{ 'payload' => res.getBody() }
			);
			return JSON.deserializeUntyped(result.getValueAsString());
		} catch (Exception e) {
			throw new AuraHandledException(e.getMessage());
		}
	}
}