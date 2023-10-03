/**
 * @description Handles Address Validation on SFMC API
 */
@SuppressWarnings('PMD.ExcessivePublicCount')
public with sharing class MktAddress extends MktRest {
	/**
	 * @description Constructor for handling calls to Address endpoints
	 * @param accountId MID of business unit
	 */
	public MktAddress(String accountId) {
		super(accountId);
	}
	/**
	 * @description Address Validator options enum
	 */
	@SuppressWarnings('PMD.FieldNamingConventions,PMD.VariableNamingConventions')
	public enum EmailMktAddressValidators {
		SyntaxValidator,
		MXValidator,
		ListDetectiveValidator
	}
	/**
	 * @description Request structure for Validation
	 */
	public class ValidateEmailRequest {
		public String email;
		public EmailMktAddressValidators[] validators;
	}
	/**
	 * @description Response structure for Validation
	 */
	public class ValidateEmailResponse {
		public String email;
		public Boolean valid;
		public EmailMktAddressValidators failedValidation;
	}
	/**
	 * @description Used to validate against SFMC servers if the email is valid
	 * @param payload ValidateEmailRequest object to validate
	 * @return  `ValidateEmailResponse`
	 */
	public ValidateEmailResponse validateEmail(ValidateEmailRequest payload) {
		HttpResponse res = send(
			'/MktAddress/v1/validateEmail',
			'POST',
			JSON.serialize(payload)
		);
		return (ValidateEmailResponse) JSON.deserialize(
			res.getBody(),
			ValidateEmailResponse.class
		);
	}
}