public with sharing class Journey {
	public class JourneyEvent {
		public string ContactKey;
		public string EventDefinitionKey;
		public Map<String, Object> Data;
	}

	public class JourneyEventResponse {
		public string eventInstanceId;
	}

	public static JourneyEventResponse sendEvent() {
		JourneyEvent e = new JourneyEvent();
		e.ContactKey = 'ABC';
		e.EventDefinitionKey = 'ABC';
		e.Data = new Map<String, Object>{
			'ContactKey' => 'ABC',
			'OrderStatus' => 'Done'
		};
		return (JourneyEventResponse) JSON.deserialize(
			send(e).getBody(),
			JourneyEventResponse.class
		);
	}

	public static JourneyEventResponse sendEvent(
		String eventDefKey,
		string contactKey,
		sObject obj
	) {
		JourneyEvent e = new JourneyEvent();
		e.ContactKey = contactKey;
		e.EventDefinitionKey = eventDefKey;
		Map<String, Object> dataMap = obj.getPopulatedFieldsAsMap();
		Map<String, Object> finalDataMap = new Map<String, Object>();
		for (String key : dataMap.keySet()) {
			Object val = dataMap.get(key);
			// this is a nested object so needs serializing
			if (val instanceof SObject) {
				finalDataMap.put(key, JSON.serialize(val));
			}
			// this is a simple type
			else {
				finalDataMap.put(key, val);
			}
		}
		e.Data = finalDataMap;
		return (JourneyEventResponse) JSON.deserialize(
			send(e).getBody(),
			JourneyEventResponse.class
		);
	}

	private static HttpResponse send(JourneyEvent e) {
		Auth.TokenResponse auth = Auth.authenticate('7281698');
		Http h = new Http();
		HttpRequest req = new HttpRequest();
		req.setEndpoint(auth.rest_instance_url + '/interaction/v1/events');
		req.setMethod('POST');
		req.setHeader('Content-Type', 'application/json');
		req.setHeader('Authorization', 'Bearer ' + auth.access_token);

		req.setBody(JSON.serialize(e));
		system.debug(JSON.serialize(e));
		HttpResponse res = h.send(req);
		if (res.getStatusCode() == 200) {
			return res;
		} else {
			system.debug(res.getBody());
			system.debug(res.getStatus());

			throw new Rest.RestException(
				(Rest.GenericErrorResponse) JSON.deserialize(
					res.getBody(),
					Rest.GenericErrorResponse.class
				)
			);
		}
	}
}