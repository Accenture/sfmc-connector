public with sharing class MktJourneyEventInvocable {
	@InvocableMethod(
		label='Send Journey Event'
		description='Send Journey Event to Marketing Cloud'
		category='Marketing Cloud'
		callout=true
	)
	public static List<MktJourney.JourneyEventResponse> sendData(
		List<DataRequests> requests
	) {
		List<MktJourney.JourneyEventResponse> resList = new List<MktJourney.JourneyEventResponse>();
		for (DataRequests dataRequest : requests) {
			MktJourney a = new MktJourney(dataRequest.accountId);
			MktJourney.JourneyEvent e = new MktJourney.JourneyEvent(
				dataRequest.contactKey,
				dataRequest.externalKey,
				dataRequest.dataObj
			);
			resList.add(a.sendEvent(e));
		}
		return resList;
	}
	public class DataRequests {
		@InvocableVariable(
			label='Record to Send'
			description='Single sObject'
			required=true
		)
		public sObject dataObj;
		@InvocableVariable(
			label='Contact Key'
			description='Unique Identifier of the Contact'
			required=true
		)
		public String contactKey;
		@InvocableVariable(
			label='MID'
			description='ID if the Business Unit'
			required=true
		)
		public String accountId;
		@InvocableVariable(
			label='Event Key'
			description='Key of the Event'
			required=true
		)
		public String externalKey;
	}
}