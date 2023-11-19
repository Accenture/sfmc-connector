/**
 * @description Generic helper for Soap endpoints
 */
public with sharing virtual class MktSoap {
	public String accountId;
	public Boolean isRetry = false;
	/**
	 * @description Constructor for handling calls to Soap endpoints
	 * @param accountId MID of business unit
	 */
	public MktSoap(String accountId) {
		this.accountId = accountId;
	}
	/**
	 * WIP - copied from REST
	 * @description Custom Exception related to Soap API calls
	 */
	public class SoapException extends Exception {
		public integer errorCode;
		public string details;
		/**
		 * @description Constructor for Custom Exception
		 * @param errorBody body returned from API where there was an error
		 */
		public SoapException(String status, Integer statusCode, String details) {
			this(status);
			this.errorcode = statusCode;
			this.details = details;
		}
	}
	/**
	 * WIP - copied from REST
	 * @description Default response structure of error from SFMC Soap API
	 */
	public class GenericResponse {
		public string OverallStatus;
		public List<GenericResponseResult> Results;
	}

	public class GenericResponseResult {
		public string StatusMessage;
		public integer ErrorCode;
		public string StatusCode;
	}

	/**
	 * @description Send to SFMC using Soap API
	 * @param payload stringified payload
	 * @param action soap action in sfmc
	 * @return  `HttpResponse`
	 */
	public HttpResponse send(String payload, String action) {
		MktAuth.TokenResponse auth = MktAuth.authenticate(this.accountId);
		Http h = new Http();
		HttpRequest req = new HttpRequest();
		req.setEndpoint(auth.Soap_instance_url + '/Service.asmx');
		req.setMethod('POST');
		req.setHeader('Content-Type', 'text/xml');
		req.setHeader('SOAPAction', action);
		req.setBody(String.format(payload, new List<String>{ auth.access_token }));
		HttpResponse res = h.send(req);
		// force reauthentication and try again (assuming not already doing so)
		if (res.getStatusCode() == 401 && this.isRetry == false) {
			MktAuth.authenticate(this.accountId, true);
			return send(payload, action);
		} else if (res.getStatusCode() > 299) {
			throw new MktSoap.SoapException(
				res.getStatus(),
				res.getStatusCode(),
				res.getBody()
			);
		} else {
			return res;
		}
	}
}