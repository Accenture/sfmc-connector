@isTest(isParallel=true)
private class MktAddressTest {
	@isTest
	static void validateMktAddressTestSuccess() {
		// Set mock callout class
		MktRestTestUtils.GenericRestMock m = new MktRestTestUtils.GenericRestMock();
		m.addResponse(
			'test.rest.marketingcloudapis.com/MktAddress/v1/validateEmail',
			'POST',
			200,
			'{"email":"help@example.com","valid":true}'
		);
		Test.setMock(HttpCalloutMock.class, m);
		Test.startTest();
		MktAddress a = new MktAddress('123');
		MktAddress.ValidateEmailRequest p = new MktAddress.ValidateEmailRequest();
		p.email = 'help@example.com';
		p.validators = new List<MktAddress.EmailMktAddressValidators>{
			MktAddress.EmailMktAddressValidators.MXValidator
		};
		MktAddress.ValidateEmailResponse res = a.validateEmail(p);
		Test.stopTest();
		Assert.isTrue(res.valid, 'Request should succeed');
	}
}