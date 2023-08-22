// Planned for Contact operations like delete
public with sharing class Contact extends Rest{
	public Contact(String accountId) {
		super(accountId);
	}  
	@SuppressWarnings('PMD.VariableNamingConventions')
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
	}
	public DeleteByKeyResponse deleteBeyKey(
		DeleteByKeyRequest payload
	) {
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