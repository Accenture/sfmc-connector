@isTest(isParallel=true)
private class MktDataInvocableTest {
	@isTest
	static void validateSendDataSetsSObject() {
		Contact c = new Contact(lastName = 'TESTContact');
		insert c;
		MktDataSync.Row r = new MktDataSync.Row(new Set<String>{ 'Id' }, c);
		// Set mock callout class
		MktRestTestUtils.GenericRestMock m = new MktRestTestUtils.GenericRestMock();
		m.addResponse(
			'test.rest.marketingcloudapis.com/hub/v1/dataevents/key:testDataExtension/rowset',
			'POST',
			200,
			JSON.serialize(new List<MktDataSync.Row>{ r })
		);
		Test.setMock(HttpCalloutMock.class, m);
		Test.startTest();

		Invocable.Action action = Invocable.Action.createCustomAction(
			'apex',
			'MktDataInvocable'
		);
		action.setInvocationParameter('dataObj', c);
		action.setInvocationParameter('accountId', '123');
		action.setInvocationParameter('externalKey', 'testDataExtension');
		List<Invocable.Action.Result> results = action.invoke();
		Test.stopTest();
		Assert.areEqual(1, results.size(), 'Success expects one result');
	}
}