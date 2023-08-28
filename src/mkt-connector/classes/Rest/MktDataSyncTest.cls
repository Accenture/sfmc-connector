@isTest(isParallel=true)
private class MktDataSyncTest {
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
		MktDataSync a = new MktDataSync('123');
		List<MktDataSync.RowResponse> res = a.dataUpsert(
			'testDataExtension',
			new List<MktDataSync.Row>{ r }
		);
		Test.stopTest();
		Assert.areEqual(
			c.Id,
			res[0].keys.get('Id'),
			'Success expects contact id in values field to match'
		);
	}

	@isTest
	static void validateSendDataSetsMap() {
		MktDataSync.Row r = new MktDataSync.Row(
			new Map<String, String>{ 'Id' => '123' },
			new Map<String, String>{
				'Id' => '123',
				'Email' => 'Something@example.com'
			}
		);
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
		MktDataSync a = new MktDataSync('123');
		List<MktDataSync.RowResponse> res = a.dataUpsert(
			'testDataExtension',
			new List<MktDataSync.Row>{ r }
		);
		Test.stopTest();
		Assert.areEqual(
			'123',
			res[0].keys.get('Id'),
			'Success expects id in values field to match'
		);
	}

	@isTest
	static void failedRequest() {
		MktDataSync.Row r = new MktDataSync.Row(
			new Map<String, String>{ 'Email' => 'Something@example.com' },
			new Map<String, String>{
				'Id' => '123',
				'Email' => 'Something@example.com'
			}
		);

		// Set mock callout class
		MktRestTestUtils.GenericRestMock m = new MktRestTestUtils.GenericRestMock();
		m.addResponse(
			'test.rest.marketingcloudapis.com/hub/v1/dataevents/key:testDataExtension/rowset',
			'POST',
			400,
			'{"message":"Field \'EmailAddress\' exists but is not a primary key.","errorcode":10000,"documentation":""}'
		);
		Test.setMock(HttpCalloutMock.class, m);
		Test.startTest();
		MktDataSync a = new MktDataSync('123');
		try {
			List<MktDataSync.RowResponse> res = a.dataUpsert(
				'testDataExtension',
				new List<MktDataSync.Row>{ r }
			);
			Assert.fail('Request should fail');
		} catch (Exception ex) {
			Assert.areEqual(
				'Field \'EmailAddress\' exists but is not a primary key.',
				ex.getMessage(),
				'Expected message about Email address not being key'
			);
		}
		Test.stopTest();
	}
}