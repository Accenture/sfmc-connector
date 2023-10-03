public without sharing class Auth {

	public class AuthException extends Exception {
		public string description;
		public string uri;
		public integer errorCode;

		AuthException (TokenResponseError errorRes ){
			this(errorRes.error == null ? errorRes.message : errorRes.error);
			this.description = errorRes.error_description;
			this.uri = errorRes.error_uri == null? errorRes.documentation : errorRes.error_uri;
			this.errorCode = errorRes.errorcode;
		}
	}

	@SuppressWarnings('PMD.VariableNamingConventions')
	public class TokenRequest {
		public string grant_type = 'client_credentials';
		public string client_id = '{!$Credential.TrainingCustom.client_id}';
		public string client_secret = '{!$Credential.TrainingCustom.client_secret}';
		public string scope;
		public string account_id;
	}

	@SuppressWarnings('PMD.VariableNamingConventions')
	public class TokenResponse {
		public string access_token;
		public integer expires_in;
		public string token_type;
		public string rest_instance_url;
		public string soap_instance_url;
		public string scope;
	}
	@SuppressWarnings('PMD.VariableNamingConventions')
	public class TokenResponseError {
		public string error;
		public string error_description;
		public string error_uri;
		public string documentation;
		public integer errorcode;
		public string message;
	}

	public static TokenResponse authenticate(String accountId) {
		Cache.OrgPartition mktCache = Cache.Org.getPartition('local.mkt');
		system.debug(mktCache.getKeys());
		string cacheRes = (string) mktCache.get(accountId);
		if (cacheRes == null) {
			Http h = new Http();
			HttpRequest req = new HttpRequest();
			req.setEndpoint('callout:SFMC_Custom/v2/token');
			req.setMethod('POST');
			req.setHeader('Content-Type', 'application/json');
			TokenRequest reqBody = new TokenRequest();
			reqBody.account_id = accountId;
			req.setBody(JSON.serialize(reqBody));
			system.debug(JSON.serialize(req.toString()));
			HttpResponse res = h.send(req);
			if(res.getStatusCode()==200){
				TokenResponse  authRes = (TokenResponse) JSON.deserialize(
					res.getBody(),
					TokenResponse.class
				);
				mktCache.put(accountId, JSON.serialize(authRes), authRes.expires_in);
				return authRes;
			} else {
				system.debug(res.getBody());
				system.debug(res.getStatus());
				TokenResponseError errorRes = (TokenResponseError) JSON.deserialize(res.getBody(), TokenResponseError.class);
				throw new AuthException(errorRes);
			}

		} else {
			return (TokenResponse) JSON.deserializeStrict(cacheRes, TokenResponse.class);
		}

	}

	public static string makeKey(integer accountId) {
		return cache.Partition.createFullyQualifiedKey(
			'local',
			'mkt',
			String.valueOf(accountId)
		);
	}
}

// TokenResponse authRes = (TokenResponse) Cache.Org.get(AuthCache.class, ‘00541000000ek4c');