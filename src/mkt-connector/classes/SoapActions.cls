@SuppressWarnings('PMD')
public with sharing class SoapActions {
	public Integer timeout;
	private String account_id;

	public SoapActions(String account_id) {
		this.account_id = account_id;
	}

	private DOM.XmlNode populateDoc(DOM.Document doc, String token) {
		String env = 'http://schemas.xmlsoap.org/soap/envelope/';
		DOM.XmlNode envelope = doc.createRootElement('Envelope', env, 'env');
		envelope.setNamespace('xsd', 'http://www.w3.org/2001/XMLSchema');
		envelope.setNamespace('xsi', 'http://www.w3.org/2001/XMLSchema-instance');
		DOM.XmlNode header = envelope.addChildElement('Header', env, '');
		DOM.XmlNode security = header.addChildElement(
			'fueloauth',
			'http://exacttarget.com',
			''
		);
		security.addTextNode(token);
		DOM.XmlNode body = envelope.addChildElement('Body', env, '');
		return body;
	}

	// private void AddHeader(DOM.XmlNode header) {
	// }

	public SoapBaseObjects.CreateResponse_element CreateRequest(
		SoapBaseObjects.CreateOptions Options,
		SoapBaseObjects.APIObject[] Objects
	) {
		DOM.Document doc = new DOM.Document();
		Auth.TokenResponse auth = Auth.authenticate(this.account_id);
		DOM.XmlNode body = populateDoc(doc, auth.access_token);
		DOM.XmlNode methodNode = body.addChildElement('Create', SoapUtils.NS, '');
		SoapBaseObjects.CreateRequest_element request_x = new SoapBaseObjects.CreateRequest_element(
			Options,
			Objects
		);
		request_x.populateXmlNode(methodNode);
		Dom.XmlNode CreateResponseNode = baseRequest(auth, 'Create', doc)
			.getChildElement('CreateResponse', SoapUtils.NS);
		SoapBaseObjects.CreateResponse_element response_x = new SoapBaseObjects.CreateResponse_element(
			CreateResponseNode
		);
		return response_x;
	}

	public SoapBaseObjects.DeleteResponse_element DeleteRequest(
		SoapBaseObjects.DeleteOptions Options,
		SoapBaseObjects.APIObject[] Objects
	) {
		DOM.Document doc = new DOM.Document();
		Auth.TokenResponse auth = Auth.authenticate(this.account_id);
		DOM.XmlNode body = populateDoc(doc, auth.access_token);
		DOM.XmlNode methodNode = body.addChildElement('Delete', SoapUtils.NS, '');
		SoapBaseObjects.DeleteRequest_element request_x = new SoapBaseObjects.DeleteRequest_element(
			Options,
			Objects
		);
		request_x.populateXmlNode(methodNode);
		Dom.XmlNode DeleteResponseNode = baseRequest(auth, 'Delete', doc)
			.getChildElement('DeleteResponse', SoapUtils.NS);
		return new SoapBaseObjects.DeleteResponse_element(DeleteResponseNode);
	}

	public SoapBaseObjects.RetrieveResponseMsg_element RetrieveRequest(
		SoapBaseObjects.RetrieveRequest RetrieveRequest
	) {
		DOM.Document doc = new DOM.Document();
		Auth.TokenResponse auth = Auth.authenticate(this.account_id);
		DOM.XmlNode body = populateDoc(doc, auth.access_token);
		DOM.XmlNode methodNode = body.addChildElement(
			'RetrieveRequestMsg',
			SoapUtils.NS,
			''
		);
		SoapBaseObjects.RetrieveRequestMsg_element request_x = new SoapBaseObjects.RetrieveRequestMsg_element(
			RetrieveRequest
		);
		request_x.populateXmlNode(methodNode);
		Dom.XmlNode RetrieveResponseMsgNode = baseRequest(auth, 'Retrieve', doc)
			.getChildElement('RetrieveResponseMsg', SoapUtils.NS);
		return new SoapBaseObjects.RetrieveResponseMsg_element(
			RetrieveResponseMsgNode
		);
	}

	public SoapBaseObjects.UpdateResponse_element UpdateRequest(
		SoapBaseObjects.UpdateOptions Options,
		SoapBaseObjects.APIObject[] Objects
	) {
		DOM.Document doc = new DOM.Document();
		Auth.TokenResponse auth = Auth.authenticate(this.account_id);
		DOM.XmlNode body = populateDoc(doc, auth.access_token);
		DOM.XmlNode methodNode = body.addChildElement('Update', SoapUtils.NS, '');
		SoapBaseObjects.UpdateRequest_element request_x = new SoapBaseObjects.UpdateRequest_element(
			Options,
			Objects
		);
		request_x.populateXmlNode(methodNode);
		Dom.XmlNode UpdateResponseNode = baseRequest(auth, 'Update', doc)
			.getChildElement('UpdateResponse', SoapUtils.NS);
		SoapBaseObjects.UpdateResponse_element response_x = new SoapBaseObjects.UpdateResponse_element(
			UpdateResponseNode
		);
		return response_x;
	}

	public Dom.XmlNode baseRequest(
		Auth.TokenResponse auth,
		String action,
		DOM.Document doc
	) {
		HttpRequest req = new HttpRequest();
		req.setEndpoint(auth.soap_instance_url + 'Service.asmx');
		req.setMethod('POST');
		req.setHeader('Content-Type', 'text/xml; charset=UTF-8');
		req.setHeader('SOAPAction', action);
		req.setBodyDocument(doc);
		if(this.timeout != null){
			req.setTimeout(this.timeout);
		}
		Http http = new Http();
		HTTPResponse res = http.send(req);
		Dom.Document responseDoc = res.getBodyDocument();
		Dom.XmlNode rootNode = responseDoc.getRootElement();
		Dom.XmlNode bodyNode = rootNode.getChildElement(
			'Body',
			'http://schemas.xmlsoap.org/soap/envelope/'
		);
		return bodyNode;
	}
}