/**
 * @description Handles interaction with Journeys on SFMC API
 */
@SuppressWarnings('PMD.FieldNamingConventions')
public with sharing class MktJourney extends MktRest {
	/**
	 * @description Constructor for handling calls to Journey (Interaction) endpoints
	 * @param accountId MID of business unit
	 */
	public MktJourney(String accountId) {
		super(accountId);
	}
	/**
	 * @description Response structure for Journey Event
	 */
	public class JourneyEventResponse {
		@InvocableVariable(
			label='Event Instance Id'
			description='ID of specific event triggered'
			required=true
		)
		public string eventInstanceId;
	}
	/**
	 * @description Request structure for Journey Event
	 */
	@SuppressWarnings('PMD.VariableNamingConventions')
	public class JourneyEvent {
		public string ContactKey;
		public string EventDefinitionKey;
		public Map<String, Object> Data;
		/**
		 * @description Journey Event Constructor
		 * @param contactKey of the event
		 * @param eventDefinitionKey where to send to the event
		 * @param data to be sent in Map format
		 */
		public JourneyEvent(
			String contactKey,
			string eventDefinitionKey,
			Map<String, Object> data
		) {
			this.ContactKey = contactkey;
			this.EventDefinitionKey = eventDefinitionKey;
			this.Data = data;
		}
		/**
		 * @description Journey Event Constructor
		 * @param contactKey of the event
		 * @param eventDefinitionKey where to send to the event
		 * @param data to be sent in sObject format
		 */
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
	 * @description Single event to be added to journey
	 * @param payload JourneyEvent object to add to Journey
	 * @return  `MktJourney.JourneyEventResponse`
	 */
	public MktJourney.JourneyEventResponse sendEvent(
		MktJourney.JourneyEvent payload
	) {
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