@isTest(isParallel=true)
public with sharing class MktSubscriberTest {
	@isTest
	static void unsubscribeFromEmailTest() {
		// Set mock callout class
		MktTestUtils.GenericMock m = new MktTestUtils.GenericMock();
		m.addSoapResponse(
			'Execute',
			200,
			'<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:wsa="http://schemas.xmlsoap.org/ws/2004/08/addressing" xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd" xmlns:wsu="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd"><soap:Header><wsa:Action>ExecuteResponse</wsa:Action><wsa:MessageID>urn:uuid:3c901eec-e683-4f64-8512-f736c58fe456</wsa:MessageID><wsa:RelatesTo>urn:uuid:d1be68d1-7c05-4012-85ea-f16f8168a14c</wsa:RelatesTo><wsa:To>http://schemas.xmlsoap.org/ws/2004/08/addressing/role/anonymous</wsa:To><wsse:Security><wsu:Timestamp wsu:Id="Timestamp-e3d11526-9b93-4053-80f6-fcfff9016fd5"><wsu:Created>2023-11-05T22:04:43Z</wsu:Created><wsu:Expires>2023-11-05T22:09:43Z</wsu:Expires></wsu:Timestamp></wsse:Security></soap:Header><soap:Body><ExecuteResponseMsg xmlns="http://exacttarget.com/wsdl/partnerAPI"><OverallStatus>OK</OverallStatus><RequestID>3dddf56f-6e56-449d-818e-f4d68e2249b3</RequestID><Results><StatusCode>OK</StatusCode><StatusMessage>Event posted</StatusMessage></Results></ExecuteResponseMsg></soap:Body></soap:Envelope>'
		);
		Test.setMock(HttpCalloutMock.class, m);
		Test.startTest();
		MKTSubscriber.LogUnsubEventResponse r = MKTSubscriber.unsubscribeFromEmail(
			'123',
			'TEST',
			'UNKNOWN',
			'1',
			'2'
		);
		Test.stopTest();
		Assert.areEqual(
			'{"Results":[{"StatusMessage":"Event posted","StatusCode":"OK","ErrorCode":null}],"OverallStatus":"OK"}',
			JSON.serialize(r),
			'Expected specific message to be returned'
		);
	}
}

// '<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:wsa="http://schemas.xmlsoap.org/ws/2004/08/addressing" xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd" xmlns:wsu="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd"><soap:Header><wsa:Action>ExecuteResponse</wsa:Action><wsa:MessageID>urn:uuid:3c901eec-e683-4f64-8512-f736c58fe456</wsa:MessageID><wsa:RelatesTo>urn:uuid:d1be68d1-7c05-4012-85ea-f16f8168a14c</wsa:RelatesTo><wsa:To>http://schemas.xmlsoap.org/ws/2004/08/addressing/role/anonymous</wsa:To><wsse:Security><wsu:Timestamp wsu:Id="Timestamp-e3d11526-9b93-4053-80f6-fcfff9016fd5"><wsu:Created>2023-11-05T22:04:43Z</wsu:Created><wsu:Expires>2023-11-05T22:09:43Z</wsu:Expires></wsu:Timestamp></wsse:Security></soap:Header><soap:Body><ExecuteResponseMsg xmlns="http://exacttarget.com/wsdl/partnerAPI"><OverallStatus>OK</OverallStatus><RequestID>3dddf56f-6e56-449d-818e-f4d68e2249b3</RequestID><Results><StatusCode>OK</StatusCode><StatusMessage>Event posted</StatusMessage></Results></ExecuteResponseMsg></soap:Body></soap:Envelope>'
