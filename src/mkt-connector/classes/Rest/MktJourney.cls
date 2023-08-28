@SuppressWarnings('PMD.VariableNamingConventions')
public with sharing class MktJourney extends MktRest {
	public MktJourney(String accountId) {
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
			this.Data = MktRestUtils.flattenSObject(data);
		}
	}
/**
 * Single event to be added to journey
 * @param payload JourneyEvent object to add to Journey
 * @return  `MktJourney.JourneyEventResponse`
 */
	public MktJourney.JourneyEventResponse sendEvent(MktJourney.JourneyEvent payload) {
		HttpResponse res = send(
			'/interaction/v1/events',
			'POST',
			JSON.serialize(payload)
		);
		return (MktJourney.JourneyEventResponse) JSON.deserialize(
			res.getBody(),
			MktJourney.JourneyEventResponse.class
		);
	}
}