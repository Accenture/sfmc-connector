/**
 * @description Handles Transactional Messaging on SFMC API
 */
@SuppressWarnings('PMD.ExcessivePublicCount')
public with sharing class MktTransactionalMessaging extends MktRest {
	/**
	 * @description Constructor for handling calls to Transactional Messaging endpoints
	 * @param accountId MID of business unit
	 */
	public MktTransactionalMessaging(String accountId) {
		super(accountId);
	}
	/**
	 * @description Request structure for Transactional Email Message
	 */
	public virtual class EmailRequest {
		public String definitionKey;
		public Recipient recipient;
	}
	/**
	 * @description Request structure for Transactional SMS Message
	 */
	public class SmsRequest extends EmailRequest {
		public SmsSubscriptions subscriptions;
		public SmsContent content;
	}
	/**
	 * @description Request structure for Subscription settings in SMS Message
	 */
	public class SmsSubscriptions {
		public boolean resubscribe;
	}
	/**
	 * @description Request structure for SMS Message content
	 */
	public class SmsContent {
		public string message;
	}
	/**
	 * @description Request structure for Recipient in Transactional Messages
	 */
	public class Recipient {
		public String contactKey;
		public String to;
		public Map<String, Object> attributes;
	}
	/**
	 * @description Response structure for Transactional Messages Status Requests
	 */
	public class MessagingStatusResponse {
		public String requestId;
		public String eventCategoryType;
		public String timestamp;
		public String compositeId;
		public StatusInfo info;
	}
	/**
	 * @description Response structure for Status of Transactional Messages
	 */
	public class StatusInfo {
		public String messageKey;
		public String contactKey;
		public String to;
	}
	/**
	 * @description Response structure for Transactional Messages
	 */
	public class MessagingResponse {
		public String requestId;
		public Integer errorCode;
		public List<Map<String, String>> responses;
	}
	/**
	 * @description Send Transactional Email
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
	 * @description Send Transactional SMS
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
	 * @description Get status of transactional email send
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
	 * @description Get status of transactional sms send
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