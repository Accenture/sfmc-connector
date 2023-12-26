@isTest(isParallel=true)
private class MktTransactionalMessagingTest {
	@isTest
	static void sendEmailGetStatusSuccess() {
		String messageKey = 'uniqueid';
		MktTransactionalMessaging.EmailRequest e = new MktTransactionalMessaging.EmailRequest();
		e.definitionKey = 'TESTDEFINITION';
		e.recipient = new MktTransactionalMessaging.Recipient();
		e.recipient.contactKey = 'ABC';
		e.recipient.to = 'someone@example.com';
		e.recipient.attributes = new Map<String, String>{ 'Name' => 'TestName' };
		// Set mock callout class
		MktTestUtils.GenericMock m = new MktTestUtils.GenericMock();
		m.addRestResponse(
			'test.rest.marketingcloudapis.com/messaging/v1/email/messages/' +
			messageKey,
			'POST',
			202,
			'{"requestId":"uniquegeneratedid","errorcode":0,"responses":[{"messageKey":"uniqueid"}]}'
		);
		m.addRestResponse(
			'test.rest.marketingcloudapis.com/messaging/v1/email/messages/' +
			messageKey,
			'GET',
			200,
			'{"requestId":"uniquegeneratedid","eventCategoryType":"TransactionalSendEvents.EmailSent","timestamp":"2018-08-03T13:41:18.55","compositeId":"1F3631D4-5497-E811-80E4-1402EC6B9540.214435.228431.1.231481617","info":{"messageKey":"uniqueid","contactKey":"ABC","to":"someone@example.com"}}'
		);
		Test.setMock(HttpCalloutMock.class, m);
		Test.startTest();
		MktTransactionalMessaging a = new MktTransactionalMessaging('123');
		MktTransactionalMessaging.MessagingResponse res = a.sendEmail(
			messageKey,
			e
		);
		MktTransactionalMessaging.MessagingStatusResponse statusRes = a.getEmailStatus(
			messageKey
		);
		Test.stopTest();
		Assert.areEqual(
			'uniquegeneratedid',
			res.requestId,
			'Expected specific message to be returned'
		);
		Assert.areEqual(
			'TransactionalSendEvents.EmailSent',
			statusRes.eventCategoryType,
			'Expected EmailSent event'
		);
	}

	@isTest
	static void sendEmailFail() {
		String messageKey = 'uniqueid';
		MktTransactionalMessaging.EmailRequest e = new MktTransactionalMessaging.EmailRequest();
		e.definitionKey = 'TESTDEFINITION';
		e.recipient = new MktTransactionalMessaging.Recipient();
		e.recipient.contactKey = 'ABC';
		e.recipient.to = 'someone@example.com';
		e.recipient.attributes = new Map<String, String>{ 'Name' => 'TestName' };
		// Set mock callout class
		MktTestUtils.GenericMock m = new MktTestUtils.GenericMock();
		m.addRestResponse(
			'test.rest.marketingcloudapis.com/messaging/v1/email/messages/' +
			messageKey,
			'POST',
			400,
			'{"message":"MCMS_UTM_Runtime_ObjectNotFound: TriggeredSend definition, definitionKey=TESTDEFINITION","errorcode":30003,"documentation":""}'
		);
		Test.setMock(HttpCalloutMock.class, m);
		Test.startTest();
		MktTransactionalMessaging a = new MktTransactionalMessaging('123');
		try {
			a.sendEmail(messageKey, e);
			Assert.fail('Request should fail');
		} catch (MKTRest.RestException ex) {
			Assert.areEqual(
				30003,
				ex.errorcode,
				'Expected errorcode 30003 (missing definition)'
			);
		}
		Test.stopTest();
	}
	@isTest
	static void sendSmsGetStatusSuccess() {
		String messageKey = 'uniqueid';
		MktTransactionalMessaging.SmsRequest e = new MktTransactionalMessaging.SmsRequest();
		e.definitionKey = 'TESTDEFINITION';
		e.recipient = new MktTransactionalMessaging.Recipient();
		e.recipient.contactKey = 'ABC';
		e.recipient.to = '+316000000000';
		e.recipient.attributes = new Map<String, String>{ 'Name' => 'TestName' };
		e.subscriptions = new MktTransactionalMessaging.SmsSubscriptions();
		e.subscriptions.resubscribe = true;
		e.content = new MktTransactionalMessaging.SmsContent();
		e.content.message = 'TestClassMessage';
		// Set mock callout class
		MktTestUtils.GenericMock m = new MktTestUtils.GenericMock();
		m.addRestResponse(
			'test.rest.marketingcloudapis.com/messaging/v1/sms/messages/' +
			messageKey,
			'POST',
			202,
			'{"requestId":"uniquegeneratedid","errorcode":0,"responses":[{"messageKey":"uniqueid"}]}'
		);
		m.addRestResponse(
			'test.rest.marketingcloudapis.com/messaging/v1/sms/messages/' +
			messageKey,
			'GET',
			200,
			'{"requestId":"uniquegeneratedid","eventCategoryType":"TransactionalSendEvents.SMSSent","timestamp":"2018-08-03T13:41:18.55","compositeId":"1F3631D4-5497-E811-80E4-1402EC6B9540.214435.228431.1.231481617","info":{"messageKey":"uniqueid","contactKey":"ABC","to":"+316000000000"}}'
		);
		Test.setMock(HttpCalloutMock.class, m);
		Test.startTest();
		MktTransactionalMessaging a = new MktTransactionalMessaging('123');
		MktTransactionalMessaging.MessagingResponse res = a.sendSms(messageKey, e);
		MktTransactionalMessaging.MessagingStatusResponse statusRes = a.getSmsStatus(
			messageKey
		);
		Test.stopTest();
		Assert.areEqual(
			'uniquegeneratedid',
			res.requestId,
			'Expected specific message to be returned'
		);
		Assert.areEqual(
			'TransactionalSendEvents.SMSSent',
			statusRes.eventCategoryType,
			'Expected SMSSent event'
		);
	}
}