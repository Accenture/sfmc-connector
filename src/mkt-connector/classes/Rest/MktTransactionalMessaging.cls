/**
 * @description Handles Transactional Messaging on SFMC API
 */
public with sharing class MktTransactionalMessaging extends MktRest {
	public MktTransactionalMessaging(String accountId) {
		super(accountId);
	}

	public virtual class EmailRequest {
		public String definitionKey;
		public Recipient recipient;
	}

	public class SmsRequest extends EmailRequest {
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
		public Map<String, Object> attributes;
	}

	public class MessagingStatusResponse {
		public String requestId;
		public String eventCategoryType;
		public String timestamp;
		public String compositeId;
		public StatusInfo info;
	}
	public class StatusInfo {
		public String messageKey;
		public String contactKey;
		public String to;
	}

	public class MessagingResponse {
		public String requestId;
		public Integer errorCode;
		public List<Map<String, String>> responses;
	}
	/**
	 * Send Transactional Email
	 * @param messageKey unique id to refer to in future
	 * @param payload message request payload
	 * @return  `MktTransactionalMessaging.MessagingResponse`
	 */
	public MktTransactionalMessaging.MessagingResponse sendEmail(
		String messageKey,
		MktTransactionalMessaging.EmailRequest payload
	) {
		HttpResponse res = send(
			'/messaging/v1/email/messages/' + messageKey,
			'POST',
			JSON.serialize(payload)
		);
		return (MktTransactionalMessaging.MessagingResponse) JSON.deserialize(
			res.getBody(),
			MktTransactionalMessaging.MessagingResponse.class
		);
	}
	/**
	 * Send Transactional SMS
	 * @param messageKey unique id to refer to in future
	 * @param payload message request payload
	 * @return  `MktTransactionalMessaging.MessagingResponse`
	 */
	public MktTransactionalMessaging.MessagingResponse sendSms(
		String messageKey,
		MktTransactionalMessaging.SmsRequest payload
	) {
		HttpResponse res = send(
			'/messaging/v1/sms/messages/' + messageKey,
			'POST',
			JSON.serialize(payload)
		);
		return (MktTransactionalMessaging.MessagingResponse) JSON.deserialize(
			res.getBody(),
			MktTransactionalMessaging.MessagingResponse.class
		);
	}
	/**
	 * Get status of transactional email send
	 * @param messageKey unique id used in sending
	 * @return  `MessagingStatusResponse`
	 */
	public MessagingStatusResponse getEmailStatus(String messageKey) {
		HttpResponse res = send(
			'/messaging/v1/email/messages/' + messageKey,
			'GET'
		);
		return (MktTransactionalMessaging.MessagingStatusResponse) JSON.deserialize(
			res.getBody(),
			MktTransactionalMessaging.MessagingStatusResponse.class
		);
	}
	/**
	 * Get status of transactional sms send
	 * @param messageKey unique id used in sending
	 * @return  `MessagingStatusResponse`
	 */
	public MessagingStatusResponse getSmsStatus(String messageKey) {
		HttpResponse res = send('/messaging/v1/sms/messages/' + messageKey, 'GET');
		return (MktTransactionalMessaging.MessagingStatusResponse) JSON.deserialize(
			res.getBody(),
			MktTransactionalMessaging.MessagingStatusResponse.class
		);
	}
}