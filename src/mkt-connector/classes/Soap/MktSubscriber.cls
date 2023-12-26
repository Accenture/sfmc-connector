/**
 * @description Class to handle subscriber relates operations
 */
public with sharing class MktSubscriber {
	/**
	 * @description Class describing Unsubscribe Event
	 */
	@SuppressWarnings('PMD.FieldNamingConventions,PMD.VariableNamingConventions')
	public class LogUnsubEvent {
		public String Name = 'LogUnsubEvent';
		public List<LogUnsubEventParam> Parameters;
	}
	/**
	 * @description Class describing parameters inside unsubscribe Event
	 */
	@SuppressWarnings(
		'PMD.FieldNamingConventions,PMD.VariableNamingConventions,PMD.FormalParameterNamingConventions'
	)
	public class LogUnsubEventParam {
		public String Name;
		public String Value;
		LogUnsubEventParam(String Name, String Value) {
			this.Name = Name;
			this.Value = Value;
		}
	}
	/**
	 * @description Class describing result of Unsubscribe Event payload
	 */
	@SuppressWarnings('PMD.FieldNamingConventions,PMD.VariableNamingConventions')
	public class LogUnsubEventResponse {
		public string OverallStatus;
		public List<LogUnsubEventResult> Results;
	}
	/**
	 * @description Class describing result of Unsubscribe Event payload
	 */
	@SuppressWarnings('PMD.FieldNamingConventions,PMD.VariableNamingConventions')
	public class LogUnsubEventResult {
		public string StatusMessage;
		public integer ErrorCode;
		public string StatusCode;
	}

	/**
	 * @description Unsubscribe from emails
	 * @param accountId MID in SFMC
	 * @param contactKey email address to unsubscribe
	 * @param reason reason for unsubscribe
	 * @param jobId (optional) jobid from email send
	 * @param batchId (optional)  batchId from email send
	 * @return generic JSON object
	 */
	@SuppressWarnings(
		'PMD.ExcessiveParameterList'
	) // cannot pass more complex values
	public static LogUnsubEventResponse unsubscribeFromEmail(
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
			return (LogUnsubEventResponse) result.getValue();
			// return JSON.deserializeUntyped(result.getValueAsString());
		} catch (Exception e) {
			throw new AuraHandledException(e.getMessage());
		}
	}
}