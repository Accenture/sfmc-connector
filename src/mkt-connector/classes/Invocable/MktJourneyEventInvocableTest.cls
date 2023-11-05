@isTest(isParallel=true)
private class MktJourneyEventInvocableTest {
	@isTest
	static void validateSendEventsObject() {
		Contact c = new Contact(lastName = 'TESTContact');
		insert c;
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

		Invocable.Action action = Invocable.Action.createCustomAction(
			'apex',
			'MktJourneyEventInvocable'
		);
		action.setInvocationParameter('dataObj', c);
		action.setInvocationParameter('accountId', '123');
		action.setInvocationParameter('contactKey', c.id);
		action.setInvocationParameter('externalKey', 'testEvent');
		List<Invocable.Action.Result> results = action.invoke();
		Test.stopTest();
		Assert.areEqual(1, results.size(), 'Success expects one result');
	}
}