/**
 * @description Handles Authentication towards sfmc api
 */
@SuppressWarnings('PMD.ExcessivePublicCount')
public without sharing class MktAuth {
	/**
	 * @description Auth specific exception
	 */
	public class AuthException extends Exception {
		public string description;
		public string uri;
		public integer errorCode;

		AuthException(TokenResponseError errorRes) {
			this(errorRes.error == null ? errorRes.message : errorRes.error);
			this.description = errorRes.error_description;
			this.uri = errorRes.error_uri == null
				? errorRes.documentation
				: errorRes.error_uri;
			this.errorCode = errorRes.errorcode;
		}
	}
	/**
	 * @description standard sfmc api for Token Request
	 */
	@SuppressWarnings('PMD.FieldNamingConventions,PMD.VariableNamingConventions')
	public class TokenRequest {
		public string grant_type = 'client_credentials';
		public string client_id = '{!$Credential.TrainingCustom.client_id}';
		public string client_secret = '{!$Credential.TrainingCustom.client_secret}';
		public string scope;
		public string account_id;
	}
	/**
	 * @description standard sfmc api response from Token Request
	 */
	@SuppressWarnings('PMD.FieldNamingConventions,PMD.VariableNamingConventions')
	public class TokenResponse {
		public string access_token;
		public integer expires_in;
		public string token_type;
		public string rest_instance_url;
		public string soap_instance_url;
		public string scope;
	}
	/**
	 * @description standard sfmc api error response from Token Request
	 */
	@SuppressWarnings('PMD.FieldNamingConventions,PMD.VariableNamingConventions')
	public class TokenResponseError {
		public string error;
		public string error_description;
		public string error_uri;
		public string documentation;
		public integer errorcode;
		public string message;
	}

	/**
	 * @description run authentication against sfmc, first attempting to get from cache
	 * @param accountId MID in SFMC
	 * @return  `TokenResponse`
	 */
	public static TokenResponse authenticate(String accountId) {
		return authenticate(accountId, false);
	}

	/**
	 * @description run authentication against sfmc, first attempting to get from cache
	 * @param accountId MID in SFMC
	 * @param force parameter to skip cache check
	 * @return  `TokenResponse`
	 */
	public static TokenResponse authenticate(String accountId, Boolean force) {
		Cache.OrgPartition mktCache = Cache.Org.getPartition('local.mkt');
		string cacheRes = (string) mktCache.get(accountId);
		// if no cache or force authenticate (for example in case of expired token being returned correctly)
		if (cacheRes == null || force == true) {
			Http h = new Http();
			HttpRequest req = new HttpRequest();
			req.setEndpoint('callout:SFMC_Custom/v2/token');
			req.setMethod('POST');
			req.setHeader('Content-Type', 'application/json');
			TokenRequest reqBody = new TokenRequest();
			reqBody.account_id = accountId;
			req.setBody(JSON.serialize(reqBody));
			HttpResponse res = h.send(req);
			if (res.getStatusCode() == 200) {
				TokenResponse authRes = (TokenResponse) JSON.deserialize(
					res.getBody(),
					TokenResponse.class
				);
				mktCache.put(accountId, JSON.serialize(authRes), authRes.expires_in);
				return authRes;
			} else {
				TokenResponseError errorRes = (TokenResponseError) JSON.deserialize(
					res.getBody(),
					TokenResponseError.class
				);
				throw new AuthException(errorRes);
			}
		} else {
			return (TokenResponse) JSON.deserializeStrict(
				cacheRes,
				TokenResponse.class
			);
		}
	}
}