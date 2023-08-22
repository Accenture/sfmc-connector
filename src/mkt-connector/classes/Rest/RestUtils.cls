public with sharing class RestUtils {
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