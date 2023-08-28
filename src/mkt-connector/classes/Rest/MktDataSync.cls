public with sharing class MktDataSync extends MktRest {
	public MktDataSync(String accountId) {
		super(accountId);
	}

	public class Row {
		public Map<String, Object> keys;
		public Map<String, Object> values;
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
		public Row(Map<String, Object> keys, Map<String, Object> values) {
			this.keys = keys;
			this.values = values;
		}
	}

	public class RowResponse {
		public Map<String, String> keys;
		public Map<String, String> values;
	}
	/**
	 * Send synchronous request to SFMC for upserting a data extension
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
		system.debug(res.getBody());
		return (List<MktDataSync.RowResponse>) JSON.deserialize(
			res.getBody(),
			List<MktDataSync.RowResponse>.class
		);
	}
}