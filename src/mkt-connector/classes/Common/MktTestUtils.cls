@isTest(isParallel=true)
@SuppressWarnings(
	'PMD.AvoidGlobalModifier,PMD.NamingConventionForTest'
) // Must use global as is mock and naming is correct
global with sharing class MktTestUtils {
	/**
	 * @description Helper method for test class to mock api
	 */
	global class GenericMock implements HttpCalloutMock {
		global Map<string, HttpResponse> responseMap = new Map<string, HttpResponse>();
		/**
		 * @description Constructor to setup default mock
		 */
		global GenericMock() {
			//add generic success for auth
			addRestResponse(
				'callout:MKTCustomConnector/v2/token',
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
		global void addRestResponse(
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
		 * @description add specific response to mock
		 * @param action type which is expected ie. retrieve
		 * @param code response code
		 * @param payload response payload
		 */
		@SuppressWarnings(
			'PMD.ExcessiveParameterList'
		) // not ideal but most elegant way of doing this.
		global void addSoapResponse(String action, Integer code, String payload) {
			HttpResponse res = new HttpResponse();
			res.setHeader('Content-Type', 'text/xml');
			res.setBody(payload);
			res.setStatusCode(code);
			this.responseMap.put(action, res);
		}
		/**
		 * @description respond method
		 * @param req request being made
		 * @return  `HTTPResponse` from mock
		 */
		global HTTPResponse respond(HTTPRequest req) {
			HttpResponse res;
			if (req.getHeader('Content-Type') == 'text/xml') {
				res = this.responseMap.get(req.getHeader('SOAPAction'));
				if (res == null) {
					// not found
					res = new HttpResponse();
					res.setBody(
						'<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"><html xmlns="http://www.w3.org/1999/xhtml"><head><meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/><title>404 - File or directory not found.</title><style type="text/css"><!--body{margin:0;font-size:.7em;font-family:Verdana, Arial, Helvetica, sans-serif;background:#EEEEEE;}fieldset{padding:0 15px 10px 15px;}h1{font-size:2.4em;margin:0;color:#FFF;}h2{font-size:1.7em;margin:0;color:#CC0000;}h3{font-size:1.2em;margin:10px 0 0 0;color:#000000;}#header{width:96%;margin:0 0 0 0;padding:6px 2% 6px 2%;font-family:"trebuchet MS", Verdana, sans-serif;color:#FFF;background-color:#555555;}#content{margin:0 0 0 2%;position:relative;}.content-container{background:#FFF;width:96%;margin-top:8px;padding:10px;position:relative;}--></style></head><body><div id="header"><h1>Server Error</h1></div><div id="content"> <div class="content-container"><fieldset> <h2>404 - File or directory not found.</h2> <h3>The resource you are looking for might have been removed, had its name changed, or is temporarily unavailable.</h3> </fieldset></div></div></body></html>'
					);
					res.setStatusCode(404);
				}
			} else {
				res = this.responseMap.get(req.getMethod() + req.getEndpoint());
				if (res == null) {
					// not found
					res = new HttpResponse();
					res.setBody(
						'{"documentation":"https://developer.salesforce.com/docs/atlas.en-us.mc-apis.meta/mc-apis/error-handling.htm","errorcode":404,"message":"Not Found"}'
					);
					res.setStatusCode(404);
				}
			}

			// otherwise return
			return res;
		}
	}
}