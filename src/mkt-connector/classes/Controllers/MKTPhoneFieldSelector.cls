/**
 * @description Class to select fields from object
 */
@SuppressWarnings('PMD.AvoidGlobalModifier')
global class MKTPhoneFieldSelector extends VisualEditor.DynamicPickList {
	VisualEditor.DesignTimePageContext context;
	VisualEditor.DynamicPickListRows rows = new VisualEditor.DynamicPickListRows();
	/**
	 * @description constructor method
	 * @param context default context from Visual Editor
	 */
	global MKTPhoneFieldSelector(VisualEditor.DesignTimePageContext context) {
		this.context = context;
		Map<String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe()
			.get(context.entityName)
			.getDescribe(SObjectDescribeOptions.DEFERRED)
			.fields.getMap();
		for (Schema.SObjectField sField : fieldMap.values()) {
			schema.DescribeFieldResult dField = sField.getDescribe();
			if (dField.getType() == Schema.DisplayType.PHONE) {
				this.rows.addRow(
					new VisualEditor.DataRow(
						dField.getLabel(),
						context.entityName + '.' + dField.getName()
					)
				);
			}
		}
	}

	global override VisualEditor.DataRow getDefaultValue() {
		return this.rows.get(0);
	}

	global override VisualEditor.DynamicPickListRows getValues() {
		return this.rows;
	}
}