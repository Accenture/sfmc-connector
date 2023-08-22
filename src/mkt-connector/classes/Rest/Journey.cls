@SuppressWarnings('PMD.VariableNamingConventions')
public with sharing class Journey extends Rest {
	public Journey(String accountId) {
		super(accountId);
	}
	public class JourneyEventResponse {
		public string eventInstanceId;
	}
	public class JourneyEvent {
		public string ContactKey;
		public string EventDefinitionKey;
		public Map<String, Object> Data;

		public JourneyEvent(
			String ContactKey,
			string EventDefinitionKey,
			Map<String, Object> Data
		) {
			this.ContactKey = Contactkey;
			this.EventDefinitionKey = EventDefinitionKey;
			this.Data = Data;
		}
		public JourneyEvent(
			String contactKey,
			string eventDefinitionKey,
			sObject data
		) {
			this.ContactKey = contactkey;
			this.EventDefinitionKey = eventDefinitionKey;
			this.Data = RestUtils.flattenSObject(data);
		}
	}

	public JourneyEventResponse sendEvent(JourneyEvent payload) {
		HttpResponse res = send(
			'/interaction/v1/events',
			'POST',
			JSON.serialize(payload)
		);
		return (JourneyEventResponse) JSON.deserialize(
			res.getBody(),
			JourneyEventResponse.class
		);
	}
}