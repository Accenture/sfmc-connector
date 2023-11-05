@isTest(isParallel=true)
private class MktJourneyTest {
	@isTest
	static void validateSendEventSObject() {
		Contact c = new Contact(lastName = 'TESTContact');
		insert c;
		insert new Case(contactid = c.id, Origin = 'Web');
		c = [
			SELECT lastName, (SELECT id, origin FROM Cases)
			FROM Contact
			WHERE id = :c.id
		];

		MktJourney.JourneyEvent e = new MktJourney.JourneyEvent(
			String.valueOf(c.Id),
			'TestEvent',
			c
		);
		// Set mock callout class
		MktTestUtils.GenericMock m = new MktTestUtils.GenericMock();
		m.addRestResponse(
			'test.rest.marketingcloudapis.com/interaction/v1/events',
			'POST',
			200,
			'{"eventInstanceId":"RANDOMGUID"}'
		);
		Test.setMock(HttpCalloutMock.class, m);
		Test.startTest();
		MktJourney a = new MktJourney('123');
		MktJourney.JourneyEventResponse res = a.sendEvent(e);
		Test.stopTest();
		Assert.areEqual(
			'RANDOMGUID',
			res.eventInstanceId,
			'Success expects an event GUID result to be returned'
		);
	}
	@isTest
	static void validateSendEventMap() {
		MktJourney.JourneyEvent e = new MktJourney.JourneyEvent(
			'123',
			'TestEvent',
			new Map<String, String>{
				'Id' => '123',
				'Email' => 'Something@example.com'
			}
		);
		// Set mock callout class
		MktTestUtils.GenericMock m = new MktTestUtils.GenericMock();
		m.addRestResponse(
			'test.rest.marketingcloudapis.com/interaction/v1/events',
			'POST',
			200,
			'{"eventInstanceId":"RANDOMGUID"}'
		);
		Test.setMock(HttpCalloutMock.class, m);
		Test.startTest();
		MktJourney a = new MktJourney('123');
		MktJourney.JourneyEventResponse res = a.sendEvent(e);
		Test.stopTest();
		Assert.areEqual(
			'RANDOMGUID',
			res.eventInstanceId,
			'Success expects an event GUID result to be returned'
		);
	}

	@isTest
	static void failedRequest() {
		MktJourney.JourneyEvent e = new MktJourney.JourneyEvent(
			'123',
			'TestEvent',
			new Map<String, String>{
				'Id' => '123',
				'Email' => 'Something@example.com'
			}
		);
		// Set mock callout class
		MktTestUtils.GenericMock m = new MktTestUtils.GenericMock();
		m.addRestResponse(
			'test.rest.marketingcloudapis.com/interaction/v1/events',
			'POST',
			400,
			'{"message":"EventDefinitionKey TestEvent not found","errorcode":10000,"documentation":""}'
		);
		Test.setMock(HttpCalloutMock.class, m);
		Test.startTest();
		MktJourney a = new MktJourney('123');

		try {
			a.sendEvent(e);
			Assert.fail('Request should fail');
		} catch (Exception ex) {
			Assert.areEqual(
				'EventDefinitionKey TestEvent not found',
				ex.getMessage(),
				'Expected message about Event Definition not existing'
			);
		}
		Test.stopTest();
	}
}