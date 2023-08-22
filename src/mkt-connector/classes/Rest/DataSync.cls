public with sharing class DataSync extends Rest {
	public DataSync(String accountId) {
		super(accountId);
	}

	public class Row {
		public Map<String, Object> keys;
		public Map<String, Object> values;
		public Row(Set<String> keys, sObject data) {
			Map<String, Object> m = RestUtils.flattenSObject(data);
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

	public List<Row> send(String dataExtensionKey, List<Row> payload) {
		HttpResponse res = send(
			'/hub/v1/dataevents/key:' + dataExtensionKey + '/rowset',
			'POST',
			JSON.serialize(payload)
		);

		return (List<Row>) JSON.deserialize(res.getBody(), List<Row>.class);
	}
}