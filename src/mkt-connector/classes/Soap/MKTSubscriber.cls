public with sharing class MKTSubscriber {
	public class LogUnsubEvent {
		public String Name = 'LogUnsubEvent';
		public List<LogUnsubEventParam> Parameters;
	}

	public class LogUnsubEventParam {
		public String Name;
		public String Value;
		LogUnsubEventParam(String Name, String Value) {
			this.Name = Name;
			this.Value = Value;
		}
	}

	/**
	 * @description Retreive data from data extension
	 * using a single field filter
	 * @param accountId MID in SFMC
	 * @param name name of data extension
	 * @param fieldNames list of fields to be returned
	 * @param filterProperty (optional) field which should be used as filter
	 * @param filterOperator (optional) type of comparison
	 * @param filterValue (optional) value to filter upon
	 * @return generic JSON object
	 */
	@AuraEnabled(cacheable=true)
	@SuppressWarnings(
		'PMD.ExcessiveParameterList'
	) // cannot pass more complex values
	public static List<MktSoap.GenericResponse> unsubscribeFromEmail(
		String accountId,
		String contactKey,
		String reason,
		String jobId,
		String batchId
	) {
		try {
			LogUnsubEvent e = new LogUnsubEvent();
			e.Parameters = new List<LogUnsubEventParam>();
			e.Parameters.add(new LogUnsubEventParam('SubscriberKey', contactKey));
			e.Parameters.add(new LogUnsubEventParam('Reason', reason));
			if (String.isNotBlank(jobId) && String.isNotBlank(batchId)) {
				e.Parameters.add(new LogUnsubEventParam('JobID', jobId));
				e.Parameters.add(new LogUnsubEventParam('BatchID', batchId));
			}

			DataWeave.Script requesScript = new DataWeaveScriptResource.ExecuteRequestMsgToXML();
			DataWeave.Result requestResult = requesScript.execute(
				new Map<String, List<LogUnsubEvent>>{
					'payload' => new List<LogUnsubEvent>{ e }
				}
			);
			MktSoap sdk = new MktSoap(accountId);
			HttpResponse res = sdk.send(requestResult.getValueAsString(), 'Execute');
			DataWeave.Script responseScript = new DataWeaveScriptResource.ExecuteUnsubEventResult();
			DataWeave.Result result = responseScript.execute(
				new Map<String, String>{ 'payload' => res.getBody() }
			);
			return (List<MktSoap.GenericResponse>)result.getValue();
			// return JSON.deserializeUntyped(result.getValueAsString());
		} catch (Exception e) {
			throw new AuraHandledException(e.getMessage());
		}
	}
}