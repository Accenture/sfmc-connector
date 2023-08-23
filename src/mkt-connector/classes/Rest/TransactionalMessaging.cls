public with sharing class TransactionalEmail extends Rest {
	public TransactionalEmail(String accountId) {
		super(accountId);
	}

	public virtual class TransactionalEmailRequest {
		public String definitionKey;
		public Recipient recipient;
	}

	public class TransactionSmsRequest extends TransactionalEmailRequest {
		public SmsSubscriptions subscriptions;
		public SmsContent content;
	}

	public class SmsSubscriptions {
		public boolean resubscribe;
	}
	public class SmsContent {
		public string message;
	}
	public class Recipient {
		public String contactKey;
		public String to;
		public Map<String, String> attributes;
	}

	public class TransactionalEmailStatusResponse {
		public String requestId;
		public String eventCategoryType;
		public String timestamp;
		public String compositeId;
		public TransactionalEmailStatusInfo info; 
	}
	public class TransactionalEmailStatusInfo {
		public String messageKey;
		public String contactKey;
		public String to;
	}

	public class TransactionalMessagingResponse {
		public String requestId;
		public Integer errorCode;
		public List<Map<String, String>> responses;
	}

	public TransactionalMessagingResponse sendEmail(
		String messageKey,
		TransactionalEmailRequest payload
	) {
		HttpResponse res = send(
			'/messaging/v1/email/messages/' + messageKey,
			'POST',
			JSON.serialize(payload)
		);
		return (TransactionalMessagingResponse) JSON.deserialize(
			res.getBody(),
			TransactionalMessagingResponse.class
		);
	}
	public TransactionalMessagingResponse sendSms(
		String messageKey,
		TransactionSmsRequest payload
	) {
		HttpResponse res = send(
			'/messaging/v1/sms/messages/' + messageKey,
			'POST',
			JSON.serialize(payload)
		);
		return (TransactionalMessagingResponse) JSON.deserialize(
			res.getBody(),
			TransactionalMessagingResponse.class
		);
	}

	public TransactionalEmailStatusResponse getEmailStatus(
		String messageKey,
	) {
		HttpResponse res = send(
			'/messaging/v1/email/messages/' + messageKey,
			'GET'
		);
		return (TransactionalEmailStatusResponse) JSON.deserialize(
			res.getBody(),
			TransactionalEmailStatusResponse.class
		);
	}
}