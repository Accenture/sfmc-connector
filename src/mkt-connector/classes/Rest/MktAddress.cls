// Planned for MktAddress validation
public with sharing class MktAddress extends MktRest {
	public MktAddress(String accountId) {
		super(accountId);
	}
	@SuppressWarnings('PMD.VariableNamingConventions')
	public enum EmailMktAddressValidators {
		SyntaxValidator,
		MXValidator,
		ListDetectiveValidator
	}

	public class ValidateEmailRequest {
		public String email;
		public EmailMktAddressValidators[] validators;
	}

	public class ValidateEmailResponse {
		public String email;
		public Boolean valid;
		public EmailMktAddressValidators failedValidation;
	}
	/**
	 * Used to validate against SFMC servers if the email is valid
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