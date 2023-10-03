/**
 * @description Handles Contact route operations on SFMC API
 */
@SuppressWarnings('PMD.ExcessivePublicCount')
public with sharing class MktContact extends MktRest {
	/**
	 * @description Constructor for handling calls to Contact endpoints
	 * @param accountId MID of business unit
	 */
	public MktContact(String accountId) {
		super(accountId);
	}
	/**
	 * @description Request structure for Deleting Contact
	 */
	@SuppressWarnings('PMD.FieldNamingConventions,PMD.VariableNamingConventions')
	public class DeleteByKeyRequest {
		public String[] Values;
		public String DeleteOperationType = 'ContactAndAttributes';
	}
	/**
	 * @description Response structure for Deleting Contact
	 */
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
	 * @description Delete contacts from SFMC
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