public with sharing virtual class Rest {
	public String accountId;

	public Rest(String accountId) {
		this.accountId = accountId;
	}
	public class RestException extends Exception {
		public integer errorcode;
		public string documentation;

		public RestException(Rest.GenericErrorResponse errorBody) {
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
	// adding helper method for sending. Response handling is done outside as type casting may be needed for error
	public HttpResponse send(
		String url,
		String method,
		String payload
	) {
		Auth.TokenResponse auth = Auth.authenticate(this.accountId);
		Http h = new Http();
		HttpRequest req = new HttpRequest();
		req.setEndpoint(auth.rest_instance_url + url);
		req.setMethod(method);
		req.setHeader('Content-Type', 'application/json');
		req.setHeader('Authorization', 'Bearer ' + auth.access_token);
		if (String.isNotEmpty(payload)) {
			req.setBody(payload);
		}
		HttpResponse res = h.send(req);
		if (res.getStatusCode() > 299) {
			throw new Rest.RestException(
				(Rest.GenericErrorResponse) JSON.deserialize(
					res.getBody(),
					Rest.GenericErrorResponse.class
				)
			);
		} else {
			return res;
		}
	}

	public HttpResponse send(String url, String method) {
		return send(url, method, null);
	}
}