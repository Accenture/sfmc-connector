/**
 * @description Helper related to REST endpoints
 */
public with sharing class MktRestUtils {
	/**
	 * @description Flatten nested sObject data for adding to SFMC Data Extension
	 * @param data sObject to flatten
	 * @return  `Map<String, Object>`
	 */
	public static Map<String, Object> flattenSObject(sObject data) {
		Map<String, Object> dataMap = Data.getPopulatedFieldsAsMap();
		Map<String, Object> finalDataMap = new Map<String, Object>();
		for (String key : dataMap.keySet()) {
			Object val = dataMap.get(key);
			// this is a nested object so needs serializing
			if (val instanceof SObject) {
				finalDataMap.put(key, JSON.serialize(val));
			}
			// this is a simple type
			else {
				finalDataMap.put(key, val);
			}
		}
		return finalDataMap;
	}
}