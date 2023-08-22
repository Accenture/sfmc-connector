// Planned for address validation
public with sharing class Address extends Rest {

	public Address(String accountId) {
		super(accountId);
	} 
	@SuppressWarnings('PMD.VariableNamingConventions')
	public enum EmailAddressValidators {
		SyntaxValidator,
		MXValidator,
		ListDetectiveValidator
	}

	public class ValidateEmailRequest {
		public String email;
		public EmailAddressValidators[] validators;
	}

	public class ValidateEmailResponse {
		public String email;
		public Boolean valid;
		public EmailAddressValidators failedValidation;
	}
	public ValidateEmailResponse validateEmail(
		ValidateEmailRequest payload
	) {
		HttpResponse res = send(
			'/address/v1/validateEmail',
			'POST',
			JSON.serialize(payload)
		);
		return (ValidateEmailResponse) JSON.deserialize(
			res.getBody(),
			ValidateEmailResponse.class
		);
	}
}