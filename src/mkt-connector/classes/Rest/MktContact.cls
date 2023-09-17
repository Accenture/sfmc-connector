/**
 * @description Handles Contact route operations on SFMC API
 */
public with sharing class MktContact extends MktRest {
	public MktContact(String accountId) {
		super(accountId);
	}
	@SuppressWarnings('PMD.FieldNamingConventions')
	public class DeleteByKeyRequest {
		public String[] Values;
		public String DeleteOperationType = 'ContactAndAttributes';
	}
	public class DeleteByKeyResponse {
		public Boolean operationInitiated;
		public Integer operationID;
		public String requestServiceMessageID;
		public String[] resultMessages;
		public String serviceMessageID;
		public String suppressionType;
		public String priority;
		public String responseDateTime;
		public Boolean hasErrors;
	}
	/**
	 * Delete contacts from SFMC
	 * @param payload DeleteByKeyRequest object for which contact key(s) to delete
	 * @return  `DeleteByKeyResponse`
	 */
	public DeleteByKeyResponse deleteBeyKey(DeleteByKeyRequest payload) {
		HttpResponse res = send(
			'/contacts/v1/contacts/actions/delete?type=keys',
			'POST',
			JSON.serialize(payload)
		);
		return (DeleteByKeyResponse) JSON.deserialize(
			res.getBody(),
			DeleteByKeyResponse.class
		);
	}
}