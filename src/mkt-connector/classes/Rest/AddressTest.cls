@isTest
private class AddressTest {
	@isTest
	static void validateAddressTestSuccess() {
		// Set mock callout class
		RestTestUtils.GenericRestMock m = new RestTestUtils.GenericRestMock();
		m.addResponse('test.rest.marketingcloudapis.com/address/v1/validateEmail', 'POST', 200, '{"email":"help@example.com","valid":true}');
		m.addResponse(
			'callout:SFMC_Custom/v2/token',
			'POST',
			200,
			'{"access_token":"exampleaccesstoken","expires_in":1080,"token_type":"Bearer","rest_instance_url":"test.rest.marketingcloudapis.com","soap_instance_url":"test.soap.marketingcloudapis.com","scope":"email_read email_write email_send"}'
		);
		Test.setMock(HttpCalloutMock.class, m);
		Test.startTest();
		Address a = new Address('123');
		Address.ValidateEmailRequest p = new Address.ValidateEmailRequest();
		p.email = 'help@example.com';
		p.validators = new List<Address.EmailAddressValidators>{
			Address.EmailAddressValidators.MXValidator
		};
		Address.ValidateEmailResponse res = a.validateEmail(p);
		Test.stopTest();
		Assert.isTrue(res.valid, 'Request should succeed');
	}
}