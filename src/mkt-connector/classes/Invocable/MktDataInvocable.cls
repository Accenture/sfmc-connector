/**
 * @description Invocable class for sending data to SFMC sync
 */
public with sharing class MktDataInvocable {
	@InvocableMethod(
		label='Send data'
		description='Send data to a SFMC data extension'
		category='Marketing Cloud'
		callout=true
		iconName='resource:MktIcon:icon'
	)
	/**
	 * @description Invocable method to send data to SFMC
	 * @param requests from flow
	 * @return  `List<Boolean>` list of successes
	 */
	public static List<Boolean> sendData(List<DataRequests> requests) {
		List<Boolean> resList = new List<Boolean>();

		Map<String, List<MktDataSync.Row>> consolidatedRequests = new Map<String, List<MktDataSync.Row>>();

		for (DataRequests dataRequest : requests) {
			String k = dataRequest.accountId + '|' + dataRequest.externalKey;
			if (consolidatedRequests.get(k) == null) {
				consolidatedRequests.put(k, new List<MktDataSync.Row>());
			}
			consolidatedRequests.get(k)
				.add(new MktDataSync.Row(new Set<String>{ 'Id' }, dataRequest.dataObj));
			resList.add(true);
		}

		for (String k : consolidatedRequests.keySet()) {
			List<String> keySplit = k.split('\\|');
			MktDataSync a = new MktDataSync(keySplit[0]);
			a.dataUpsert(keySplit[1], consolidatedRequests.get(k));
		}
		return resList;
	}

	/**
	 * @description Invocable structure for requests from flow
	 */
	public class DataRequests {
		@InvocableVariable(
			label='Record to Send'
			description='Single sObject'
			required=true
		)
		public sObject dataObj;
		@InvocableVariable(
			label='MID'
			description='ID if the Business Unit'
			required=true
		)
		public String accountId;
		@InvocableVariable(
			label='Data Extension'
			description='External Id of the Data Extension'
			required=true
		)
		public String externalKey;
	}
}