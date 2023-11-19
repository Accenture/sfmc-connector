public without sharing class MKTUnsubscribeController {
	/**
	 * @description Retreive data from data extension
	 * using a single field filter
	 * @param accountId MID in SFMC
	 * @param emailAddress email address to unsubscribe
	 * @param reason reason for unsubscribe
	 * @param jobId (optional) jobid from email send
	 * @param batchId (optional)  batchId from email send
	 * @return generic JSON object
	 */
	@AuraEnabled(cacheable=false)
	@SuppressWarnings(
		'PMD.ExcessiveParameterList'
	) // cannot pass more complex values
	public static List<MktSoap.GenericResponse> unsubscribeFromEmailByEmail(
		String accountId,
		String emailAddress,
		String reason,
		String jobId,
		String batchId
	) {
		List<Contact> cList = [SELECT Id FROM Contact WHERE email = :emailAddress];
		List<MktSoap.GenericResponse> resList = new List<Object>();
		for (Contact c : cList) {
			resList.add(
				MKTSubscriber.unsubscribeFromEmail(
					accountId,
					c.Id,
					reason,
					jobId,
					batchId
				)
			);
		}
		return resList;
	}
}