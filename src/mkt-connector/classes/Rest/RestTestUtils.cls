@isTest
global with sharing class RestTestUtils {
	global class GenericRestMock implements HttpCalloutMock {
		global Map<string, HttpResponse> responseMap = new Map<string, HttpResponse>();
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
				system.debug(req);
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