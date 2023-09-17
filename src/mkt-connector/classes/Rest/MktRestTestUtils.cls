@isTest
@SuppressWarnings('PMD.AvoidGlobalModifier') // Must use global as is mock
global with sharing class MktRestTestUtils {
	/**
	 * Helper method for test class to mock api
	 */
	global class GenericRestMock implements HttpCalloutMock {
		global GenericRestMock() {
			//add generic success for auth
			addResponse(
				'callout:SFMC_Custom/v2/token',
				'POST',
				200,
				'{"access_token":"exampleaccesstoken","expires_in":1080,"token_type":"Bearer","rest_instance_url":"test.rest.marketingcloudapis.com","soap_instance_url":"test.soap.marketingcloudapis.com","scope":"email_read email_write email_send"}'
			);
		}
		global Map<string, HttpResponse> responseMap = new Map<string, HttpResponse>();
		@SuppressWarnings(
			'PMD.ExcessiveParameterList'
		) // not ideal but most elegant way of doing this.
		global void addResponse(
			String url,
			String method,
			Integer code,
			String payload
		) {
			HttpResponse res = new HttpResponse();
			res.setHeader('Content-Type', 'application/json');
			res.setBody(payload);
			res.setStatusCode(code);
			this.responseMap.put(method + url, res);
		}
		// Implement this interface method
		global HTTPResponse respond(HTTPRequest req) {
			HttpResponse res = this.responseMap.get(
				req.getMethod() + req.getEndpoint()
			);
			if (res == null) {
				// not found
				res = new HttpResponse();
				res.setBody(
					'{"documentation":"https://developer.salesforce.com/docs/atlas.en-us.mc-apis.meta/mc-apis/error-handling.htm","errorcode":404,"message":"Not Found"}'
				);
				res.setStatusCode(404);
			}
			// otherwise return
			return res;
		}
	}
}