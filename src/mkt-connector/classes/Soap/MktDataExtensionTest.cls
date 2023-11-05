@isTest
public with sharing class MktDataExtensionTest {
	@isTest
	static void retrieveDataExtensionRows() {
		// Set mock callout class
		MktTestUtils.GenericMock m = new MktTestUtils.GenericMock();
		m.addSoapResponse(
			'Retrieve',
			200,
			'<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:wsa="http://schemas.xmlsoap.org/ws/2004/08/addressing" xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd" xmlns:wsu="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd"><env:Header xmlns:env="http://www.w3.org/2003/05/soap-envelope"><wsa:Action>RetrieveResponse</wsa:Action><wsa:MessageID>urn:uuid:53779ef9-766e-4714-809f-8b8c16094186</wsa:MessageID><wsa:RelatesTo>urn:uuid:7e0cca04-57bd-4481-864c-6ea8039d2ea0</wsa:RelatesTo><wsa:To>http://schemas.xmlsoap.org/ws/2004/08/addressing/role/anonymous</wsa:To><wsse:Security><wsu:Timestamp wsu:Id="Timestamp-43a6188c-3eef-46b2-b40c-96b27c7c45e1"><wsu:Created>2023-11-05T11:44:40Z</wsu:Created><wsu:Expires>2023-11-05T11:49:40Z</wsu:Expires></wsu:Timestamp></wsse:Security></env:Header><soap:Body><RetrieveResponseMsg xmlns="http://exacttarget.com/wsdl/partnerAPI"><OverallStatus>OK</OverallStatus><RequestID>8b86412e-9335-4dca-9da6-45ced5a0b544</RequestID><Results xsi:type="DataExtensionObject"><PartnerKey xsi:nil="true" /><ObjectID xsi:nil="true" /><Type>DataExtensionObject</Type><Properties><Property><Name>First Name</Name><Value>Oliver</Value></Property></Properties></Results><Results xsi:type="DataExtensionObject"><PartnerKey xsi:nil="true" /><ObjectID xsi:nil="true" /><Type>DataExtensionObject</Type><Properties><Property><Name>First Name</Name><Value>Oliver</Value></Property></Properties></Results></RetrieveResponseMsg></soap:Body></soap:Envelope>'
		);
		Test.setMock(HttpCalloutMock.class, m);
		Test.startTest();
		Object o = MKTDataExtension.getDataExtensionData(
			'123',
			'TestData',
			new List<String>{ 'First Name' },
			'First Name',
			'equals',
			'Oliver'
		);
		Test.stopTest();
		Assert.areEqual(
			'[{"First Name":"Oliver"},{"First Name":"Oliver"}]',
			JSON.serialize(o),
			'Expected specific message to be returned'
		);
	}
}