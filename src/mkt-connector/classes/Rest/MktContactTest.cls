@isTest(isParallel=true)
private class MktContactTest {
	@isTest
	static void deleteBeyKeyTestSuccess() {
		// Set mock callout class
		MktRestTestUtils.GenericRestMock m = new MktRestTestUtils.GenericRestMock();
		m.addResponse(
			'test.rest.marketingcloudapis.com/contacts/v1/contacts/actions/delete?type=keys',
			'POST',
			200,
			'{"suppressionType":"SuppressAllRequested","operationInitiated":true,"operationID":5190016,"priority":"Standard","requestServiceMessageID":"6405c902-21df-48a3-909f-cc75957a8ce7","responseDateTime":"2023-08-24T14:24:28.1620612-06:00","hasErrors":false,"resultMessages":[],"serviceMessageID":"2a4b518b-2644-434a-940e-cd8d7b10c562"}'
		);
		Test.setMock(HttpCalloutMock.class, m);
		Test.startTest();
		MktContact a = new MktContact('123');
		MktContact.DeleteByKeyRequest p = new MktContact.DeleteByKeyRequest();
		p.Values = new List<String>{ 'TEST_317-531-5555' };
		MktContact.DeleteByKeyResponse res = a.deleteBeyKey(p);
		Test.stopTest();
		Assert.areEqual(
			'6405c902-21df-48a3-909f-cc75957a8ce7',
			res.requestServiceMessageID,
			'Expected Request ID did not match'
		);
	}
}