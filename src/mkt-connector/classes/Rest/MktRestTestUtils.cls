@isTest(isParallel=true)
@SuppressWarnings(
	'PMD.AvoidGlobalModifier,PMD.NamingConventionForTest'
) // Must use global as is mock and naming is correct
global with sharing class MktRestTestUtils {
	/**
	 * @description Helper method for test class to mock api
	 */
	global class GenericRestMock implements HttpCalloutMock {
		global Map<string, HttpResponse> responseMap = new Map<string, HttpResponse>();
		/**
		 * @description Constructor to setup default mock
		 */
		global GenericRestMock() {
			//add generic success for auth
			addResponse(
				'callout:SFMC_Custom/v2/token',
				'POST',
				200,
				'{"access_token":"exampleaccesstoken","expires_in":1080,"token_type":"Bearer","rest_instance_url":"test.rest.marketingcloudapis.com","soap_instance_url":"test.soap.marketingcloudapis.com","scope":"email_read email_write email_send"}'
			);
		}
		/**
		 * @description add specific response to mock
		 * @param url which should be responded to
		 * @param method type which is expected
		 * @param code response code
		 * @param payload response payload
		 */
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
		/**
		 * @description respond method
		 * @param req request being made
		 * @return  `HTTPResponse` from mock
		 */
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