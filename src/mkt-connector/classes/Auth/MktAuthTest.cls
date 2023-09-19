@isTest(isParallel=true)
private with sharing class MktAuthTest {
	@isTest
	static void authFail() {
		// Set mock callout class
		MktRestTestUtils.GenericRestMock m = new MktRestTestUtils.GenericRestMock();
		m.addResponse(
			'callout:SFMC_Custom/v2/token',
			'POST',
			401,
			'{"error":"invalid_client","error_description":"Invalid client ID. Use the client ID in Marketing Cloud Installed Packages.","error_uri":"https://developer.salesforce.com/docs"}'
		);
		Test.setMock(HttpCalloutMock.class, m);
		Test.startTest();
		try {
			MktAuth.authenticate('123');
			Assert.fail('Request should fail');
		} catch (MktAuth.AuthException ex) {
			Assert.areEqual(
				'invalid_client',
				ex.getMessage(),
				'Expected auth to fail with invalid client'
			);
		}
		Test.stopTest();
	}
}