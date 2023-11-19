@isTest(isParallel=true)
private with sharing class MKTPhoneFieldSelectorTest {
	@isTest
	static void getObjectFields() {
		VisualEditor.DesignTimePageContext context = new VisualEditor.DesignTimePageContext();
		context.entityName = 'Contact';

		MKTPhoneFieldSelector m = new MKTPhoneFieldSelector(context);
		Test.startTest();
		VisualEditor.DynamicPickListRows allRows = m.getValues();
		Boolean mobileField;
		Boolean landlineField;
		for (VisualEditor.DataRow r : allRows.getDataRows()) {
			if (r.getValue() == 'Contact.MobilePhone') {
				mobileField = true;
			} else if (r.getValue() == 'Contact.HomePhone') {
				landlineField = true;
			}
		}
		Test.stopTest();
		Assert.isTrue(
			mobileField,
			'Expected Contact Mobile Phone field to be returned'
		);
		Assert.isTrue(
			landlineField,
			'Expected Contact Home Phone field to be returned'
		);
		VisualEditor.DataRow r = m.getDefaultValue();
		String defaultString = (String) r.getValue();
		Assert.isTrue(
			defaultString.startsWith('Contact.'),
			'Expected field value starting with "Contact."'
		);
	}
}