public with sharing virtual class MktRest {
	public String accountId;
	public Boolean isRetry = false;

	public MktRest(String accountId) {
		this.accountId = accountId;
	}
	public class RestException extends Exception {
		public integer errorcode;
		public string documentation;

		public RestException(MktRest.GenericErrorResponse errorBody) {
			this(errorBody.message);
			this.errorcode = errorBody.errorcode;
			this.documentation = errorBody.documentation;
		}
	}

	public class GenericErrorResponse {
		public string message;
		public integer errorcode;
		public string documentation;
	}
	/**
	 * Send to SFMC using REST API
	 * @param url to send to
	 * @param method http method
	 * @param payload stringified payload
	 * @return  `HttpResponse`
	 */
	public HttpResponse send(String url, String method, String payload) {
		MktAuth.TokenResponse auth = MktAuth.authenticate(this.accountId);
		Http h = new Http();
		HttpRequest req = new HttpRequest();
		req.setEndpoint(auth.rest_instance_url + url);
		req.setMethod(method);
		req.setHeader('Content-Type', 'application/json');
		req.setHeader('Authorization', 'Bearer ' + auth.access_token); //NOPMD - token is retrieved from cache as cannot used named credential for storing token
		if (String.isNotEmpty(payload)) {
			req.setBody(payload);
		}
		HttpResponse res = h.send(req);
		// force reauthentication and try again (assuming not already doing so)
		if (res.getStatusCode() == 401 && this.isRetry == false) {
			MktAuth.authenticate(this.accountId, true);
			return send(url, method, payload);
		} else if (res.getStatusCode() > 299) {
			throw new MktRest.RestException(
				(MktRest.GenericErrorResponse) JSON.deserialize(
					res.getBody(),
					MktRest.GenericErrorResponse.class
				)
			);
		} else {
			return res;
		}
	}
	/**
	 * Send to SFMC using REST API
	 * @param url to send to
	 * @param method http method
	 * @return  `HttpResponse`
	 */
	public HttpResponse send(String url, String method) {
		return send(url, method, null);
	}
}