/**
 * @description Handles Data Events on SFMC API
 */
@SuppressWarnings('PMD.ExcessivePublicCount')
public with sharing class MktDataSync extends MktRest {
	/**
	 * @description Constructor for handling calls to Data Event endpoints
	 * @param accountId MID of business unit
	 */
	public MktDataSync(String accountId) {
		super(accountId);
	}
	/**
	 * @description Request structure for Data Event Row
	 */
	public class Row {
		public Map<String, Object> keys;
		public Map<String, Object> values;
		/**
		 * @description Data Event Row constructor
		 * @param keys key fields of the data extension
		 * @param data data for the data extension in sObject format
		 */
		public Row(Set<String> keys, sObject data) {
			Map<String, Object> m = MktRestUtils.flattenSObject(data);
			this.keys = new Map<String, Object>();
			this.values = new Map<String, Object>();
			for (String k : m.keySet()) {
				if (keys.contains(k)) {
					this.keys.put(k, m.get(k));
				} else {
					this.values.put(k, m.get(k));
				}
			}
		}
		/**
		 * @description Data Event Row constructor
		 * @param keys key fields of the data extension
		 * @param values data for the data extension using Map
		 */
		public Row(Map<String, Object> keys, Map<String, Object> values) {
			this.keys = keys;
			this.values = values;
		}
	}
	/**
	 * @description Response structure for Data Event Row
	 */
	public class RowResponse {
		public Map<String, String> keys;
		public Map<String, String> values;
	}
	/**
	 * @description Send synchronous request to SFMC for upserting a data extension
	 * @param dataExtensionKey target for data
	 * @param payload data to be sent
	 * @return  `List<MktDataSync.RowResponse>`
	 */
	public List<MktDataSync.RowResponse> dataUpsert(
		String dataExtensionKey,
		List<MktDataSync.Row> payload
	) {
		HttpResponse res = send(
			'/hub/v1/dataevents/key:' + dataExtensionKey + '/rowset',
			'POST',
			JSON.serialize(payload)
		);
		return (List<MktDataSync.RowResponse>) JSON.deserialize(
			res.getBody(),
			List<MktDataSync.RowResponse>.class
		);
	}
}