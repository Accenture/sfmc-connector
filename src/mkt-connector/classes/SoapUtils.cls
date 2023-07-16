public with sharing class SoapUtils {
	public static final String NS = 'http://exacttarget.com/wsdl/partnerAPI';

	public static DateTime parseDateTime(String nodeText) {
		JSONParser parser = JSON.createParser('{"t":"' + nodeText + '"}');
		parser.nextToken();
		parser.nextValue();
		return parser.getDateTimeValue();
	}

	private static Time stringToTime(String strTimeChange) {
		String[] strTimeSplit = strTimeChange.split(':');
		return Time.newInstance(
			Integer.valueOf(strTimeSplit[0]), //hour
			Integer.valueOf(strTimeSplit[1]), //min
			0, //sec
			0
		);
	}
}