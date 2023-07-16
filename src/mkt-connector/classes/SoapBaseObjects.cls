@SuppressWarnings('PMD')
public with sharing class SoapBaseObjects {
	public static final String s_ns0 = 'http://exacttarget.com/wsdl/partnerAPI';
	public static DateTime parseDateTime(String nodeText) {
		JSONParser parser = JSON.createParser('{"t":"' + nodeText + '"}');
		parser.nextToken();
		parser.nextValue();
		return parser.getDateTimeValue();
	}
	//Extends http://exacttarget.com/wsdl/partnerAPI:Options
	public class UpdateOptions {
		public soapBaseObjects.ClientID Client;
		public soapBaseObjects.AsyncResponse[] SendResponseTo;
		public soapBaseObjects.Options_SaveOptions_element SaveOptions;
		public Integer Priority;
		public String ConversationID;
		public Integer SequenceCode;
		public Integer CallsInConversation;
		public DateTime ScheduledTime;
		// Restriction enumeration: Synchronous, Asynchronous
		public String RequestType;
		// Restriction enumeration: Low, Medium, High
		public String QueuePriority;

		public String Action;

		public UpdateOptions() {
		}
		public UpdateOptions(DOM.XmlNode responseNode) {
			Set<DOM.XmlNode> nodesParsed = new Set<DOM.XmlNode>();

			Dom.XmlNode[] SendResponseToChildren = responseNode.getChildElements();
			soapBaseObjects.AsyncResponse[] SendResponseToList = new List<soapBaseObjects.AsyncResponse>();
			if (
				SendResponseToChildren == null ||
				SendResponseToChildren.size() == 0
			) {
				this.SendResponseTo = null;
			} else {
				for (DOM.XmlNode childNode : SendResponseToChildren) {
					if (childNode.GetName() == 'SendResponseTo') {
						soapBaseObjects.AsyncResponse Obj = new soapBaseObjects.AsyncResponse(
							childNode
						);
						SendResponseToList.Add(Obj);
						nodesParsed.add(childNode);
					}
				}
				this.SendResponseTo = SendResponseToList;
			}
			DOM.XmlNode SaveOptionsNode = responseNode.getChildElement(
				'SaveOptions',
				s_ns0
			);
			if (SaveOptionsNode == null) {
				this.SaveOptions = null;
			} else {
				soapBaseObjects.Options_SaveOptions_element SaveOptionsObj = new soapBaseObjects.Options_SaveOptions_element(
					SaveOptionsNode
				);
				nodesParsed.add(SaveOptionsNode);
				this.SaveOptions = SaveOptionsObj;
			}
			DOM.XmlNode PriorityNode = responseNode.getChildElement(
				'Priority',
				s_ns0
			);
			this.Priority = (PriorityNode == null)
				? null
				: Integer.valueOf(PriorityNode.getText());
			nodesParsed.add(PriorityNode);
			DOM.XmlNode ConversationIDNode = responseNode.getChildElement(
				'ConversationID',
				s_ns0
			);
			this.ConversationID = (ConversationIDNode == null)
				? null
				: ConversationIDNode.getText();
			nodesParsed.add(ConversationIDNode);
			DOM.XmlNode SequenceCodeNode = responseNode.getChildElement(
				'SequenceCode',
				s_ns0
			);
			this.SequenceCode = (SequenceCodeNode == null)
				? null
				: Integer.valueOf(SequenceCodeNode.getText());
			nodesParsed.add(SequenceCodeNode);
			DOM.XmlNode CallsInConversationNode = responseNode.getChildElement(
				'CallsInConversation',
				s_ns0
			);
			this.CallsInConversation = (CallsInConversationNode == null)
				? null
				: Integer.valueOf(CallsInConversationNode.getText());
			nodesParsed.add(CallsInConversationNode);
			DOM.XmlNode ScheduledTimeNode = responseNode.getChildElement(
				'ScheduledTime',
				s_ns0
			);
			this.ScheduledTime = (ScheduledTimeNode == null)
				? null
				: soapBaseObjects.parseDateTime(ScheduledTimeNode.getText());
			nodesParsed.add(ScheduledTimeNode);
			DOM.XmlNode RequestTypeNode = responseNode.getChildElement(
				'RequestType',
				s_ns0
			);
			this.RequestType = (RequestTypeNode == null)
				? null
				: RequestTypeNode.getText();
			nodesParsed.add(RequestTypeNode);
			DOM.XmlNode QueuePriorityNode = responseNode.getChildElement(
				'QueuePriority',
				s_ns0
			);
			this.QueuePriority = (QueuePriorityNode == null)
				? null
				: QueuePriorityNode.getText();
			nodesParsed.add(QueuePriorityNode);

			DOM.XmlNode ActionNode = responseNode.getChildElement('Action', s_ns0);
			this.Action = (ActionNode == null) ? null : ActionNode.getText();
			nodesParsed.add(ActionNode);
		}
		public void populateXmlNode(Dom.XmlNode outerNode) {
			soapBaseObjects.ClientID ClientObj = this.Client;
			Dom.XmlNode ClientNode = outerNode.addChildElement('Client', s_ns0, '');
			if (ClientObj != null) {
				ClientObj.populateXmlNode(ClientNode);
			}

			soapBaseObjects.AsyncResponse[] SendResponseToObj = this.SendResponseTo;
			if (SendResponseToObj != null) {
				for (soapBaseObjects.AsyncResponse element : SendResponseToObj) {
					Dom.XmlNode SendResponseToNode = outerNode.addChildElement(
						'SendResponseTo',
						s_ns0,
						''
					);
					element.populateXmlNode(SendResponseToNode);
				}
			}

			soapBaseObjects.Options_SaveOptions_element SaveOptionsObj = this.SaveOptions;
			Dom.XmlNode SaveOptionsNode = outerNode.addChildElement(
				'SaveOptions',
				s_ns0,
				''
			);
			if (SaveOptionsObj != null) {
				SaveOptionsObj.populateXmlNode(SaveOptionsNode);
			}
			Dom.XmlNode PriorityNode = outerNode.addChildElement(
				'Priority',
				s_ns0,
				''
			);
			PriorityNode.addTextNode(
				(this.Priority == null) ? '' : String.valueOf(this.Priority)
			);
			Dom.XmlNode ConversationIDNode = outerNode.addChildElement(
				'ConversationID',
				s_ns0,
				''
			);
			ConversationIDNode.addTextNode(
				(this.ConversationID == null) ? '' : this.ConversationID
			);
			Dom.XmlNode SequenceCodeNode = outerNode.addChildElement(
				'SequenceCode',
				s_ns0,
				''
			);
			SequenceCodeNode.addTextNode(
				(this.SequenceCode == null) ? '' : String.valueOf(this.SequenceCode)
			);
			Dom.XmlNode CallsInConversationNode = outerNode.addChildElement(
				'CallsInConversation',
				s_ns0,
				''
			);
			CallsInConversationNode.addTextNode(
				(this.CallsInConversation == null)
					? ''
					: String.valueOf(this.CallsInConversation)
			);
			Dom.XmlNode ScheduledTimeNode = outerNode.addChildElement(
				'ScheduledTime',
				s_ns0,
				''
			);
			ScheduledTimeNode.addTextNode(
				(this.ScheduledTime == null) ? '' : String.valueOf(this.ScheduledTime)
			);
			Dom.XmlNode RequestTypeNode = outerNode.addChildElement(
				'RequestType',
				s_ns0,
				''
			);
			RequestTypeNode.addTextNode(
				(this.RequestType == null) ? '' : this.RequestType
			);
			Dom.XmlNode QueuePriorityNode = outerNode.addChildElement(
				'QueuePriority',
				s_ns0,
				''
			);
			QueuePriorityNode.addTextNode(
				(this.QueuePriority == null) ? '' : this.QueuePriority
			);

			Dom.XmlNode ActionNode = outerNode.addChildElement('Action', s_ns0, '');
			ActionNode.addTextNode((this.Action == null) ? '' : this.Action);
		}
	}
	public class UpdateRequest_element {
		public soapBaseObjects.UpdateOptions Options;
		public soapBaseObjects.APIObject[] Objects;

		public UpdateRequest_element() {
		}
		public UpdateRequest_element(
			soapBaseObjects.UpdateOptions Options,
			soapBaseObjects.APIObject[] Objects
		) {
			this.Options = Options;
			this.Objects = Objects;
		}
		public void populateXmlNode(Dom.XmlNode outerNode) {
			soapBaseObjects.UpdateOptions OptionsObj = this.Options;
			Dom.XmlNode OptionsNode = outerNode.addChildElement('Options', s_ns0, '');
			if (OptionsObj != null) {
				OptionsObj.populateXmlNode(OptionsNode);
			}

			soapBaseObjects.APIObject[] ObjectsObj = this.Objects;
			if (ObjectsObj != null) {
				for (soapBaseObjects.APIObject element : ObjectsObj) {
					Dom.XmlNode ObjectsNode = outerNode.addChildElement(
						'Objects',
						s_ns0,
						''
					);
					element.populateXmlNode(ObjectsNode);
				}
			}
		}
	}
	public class UpdateResponse_element {
		public soapBaseObjects.UpdateResult[] Results;
		public String RequestID;
		public String OverallStatus;

		public UpdateResponse_element() {
		}
		public UpdateResponse_element(DOM.XmlNode responseNode) {
			Set<DOM.XmlNode> nodesParsed = new Set<DOM.XmlNode>();

			Dom.XmlNode[] ResultsChildren = responseNode.getChildElements();
			soapBaseObjects.UpdateResult[] ResultsList = new List<soapBaseObjects.UpdateResult>();
			if (ResultsChildren == null || ResultsChildren.size() == 0) {
				this.Results = null;
			} else {
				for (DOM.XmlNode childNode : ResultsChildren) {
					if (childNode.GetName() == 'Results') {
						soapBaseObjects.UpdateResult Obj = new soapBaseObjects.UpdateResult(
							childNode
						);
						ResultsList.Add(Obj);
						nodesParsed.add(childNode);
					}
				}
				this.Results = ResultsList;
			}
			DOM.XmlNode RequestIDNode = responseNode.getChildElement(
				'RequestID',
				s_ns0
			);
			this.RequestID = (RequestIDNode == null) ? null : RequestIDNode.getText();
			nodesParsed.add(RequestIDNode);
			DOM.XmlNode OverallStatusNode = responseNode.getChildElement(
				'OverallStatus',
				s_ns0
			);
			this.OverallStatus = (OverallStatusNode == null)
				? null
				: OverallStatusNode.getText();
			nodesParsed.add(OverallStatusNode);
		}
	}

	//Extends http://exacttarget.com/wsdl/partnerAPI:Result
	public class UpdateResult {
		public String StatusCode;
		public String StatusMessage;
		public Integer OrdinalID;
		public Integer ErrorCode;
		public String RequestID;
		public String ConversationID;
		public String OverallStatusCode;
		// Restriction enumeration: Synchronous, Asynchronous
		public String RequestType;
		public String ResultType;
		public String ResultDetailXML;

		public soapBaseObjects.APIObject Object_x;
		public soapBaseObjects.UpdateResult[] UpdateResults;
		public String ParentPropertyName;

		public UpdateResult() {
		}
		public UpdateResult(DOM.XmlNode responseNode) {
			Set<DOM.XmlNode> nodesParsed = new Set<DOM.XmlNode>();
			DOM.XmlNode StatusCodeNode = responseNode.getChildElement(
				'StatusCode',
				s_ns0
			);
			this.StatusCode = (StatusCodeNode == null)
				? null
				: StatusCodeNode.getText();
			nodesParsed.add(StatusCodeNode);
			DOM.XmlNode StatusMessageNode = responseNode.getChildElement(
				'StatusMessage',
				s_ns0
			);
			this.StatusMessage = (StatusMessageNode == null)
				? null
				: StatusMessageNode.getText();
			nodesParsed.add(StatusMessageNode);
			DOM.XmlNode OrdinalIDNode = responseNode.getChildElement(
				'OrdinalID',
				s_ns0
			);
			this.OrdinalID = (OrdinalIDNode == null)
				? null
				: Integer.valueOf(OrdinalIDNode.getText());
			nodesParsed.add(OrdinalIDNode);
			DOM.XmlNode ErrorCodeNode = responseNode.getChildElement(
				'ErrorCode',
				s_ns0
			);
			this.ErrorCode = (ErrorCodeNode == null)
				? null
				: Integer.valueOf(ErrorCodeNode.getText());
			nodesParsed.add(ErrorCodeNode);
			DOM.XmlNode RequestIDNode = responseNode.getChildElement(
				'RequestID',
				s_ns0
			);
			this.RequestID = (RequestIDNode == null) ? null : RequestIDNode.getText();
			nodesParsed.add(RequestIDNode);
			DOM.XmlNode ConversationIDNode = responseNode.getChildElement(
				'ConversationID',
				s_ns0
			);
			this.ConversationID = (ConversationIDNode == null)
				? null
				: ConversationIDNode.getText();
			nodesParsed.add(ConversationIDNode);
			DOM.XmlNode OverallStatusCodeNode = responseNode.getChildElement(
				'OverallStatusCode',
				s_ns0
			);
			this.OverallStatusCode = (OverallStatusCodeNode == null)
				? null
				: OverallStatusCodeNode.getText();
			nodesParsed.add(OverallStatusCodeNode);
			DOM.XmlNode RequestTypeNode = responseNode.getChildElement(
				'RequestType',
				s_ns0
			);
			this.RequestType = (RequestTypeNode == null)
				? null
				: RequestTypeNode.getText();
			nodesParsed.add(RequestTypeNode);
			DOM.XmlNode ResultTypeNode = responseNode.getChildElement(
				'ResultType',
				s_ns0
			);
			this.ResultType = (ResultTypeNode == null)
				? null
				: ResultTypeNode.getText();
			nodesParsed.add(ResultTypeNode);
			DOM.XmlNode ResultDetailXMLNode = responseNode.getChildElement(
				'ResultDetailXML',
				s_ns0
			);
			this.ResultDetailXML = (ResultDetailXMLNode == null)
				? null
				: ResultDetailXMLNode.getText();
			nodesParsed.add(ResultDetailXMLNode);
			DOM.XmlNode Object_xNode = responseNode.getChildElement('Object', s_ns0);
			if (Object_xNode == null) {
				this.Object_x = null;
			} else {
				soapBaseObjects.APIObject Object_xObj = new soapBaseObjects.APIObject(
					Object_xNode
				);
				nodesParsed.add(Object_xNode);
				this.Object_x = Object_xObj;
			}
			Dom.XmlNode[] UpdateResultsChildren = responseNode.getChildElements();
			soapBaseObjects.UpdateResult[] UpdateResultsList = new List<soapBaseObjects.UpdateResult>();
			if (UpdateResultsChildren == null || UpdateResultsChildren.size() == 0) {
				this.UpdateResults = null;
			} else {
				for (DOM.XmlNode childNode : UpdateResultsChildren) {
					if (childNode.GetName() == 'UpdateResults') {
						soapBaseObjects.UpdateResult Obj = new soapBaseObjects.UpdateResult(
							childNode
						);
						UpdateResultsList.Add(Obj);
						nodesParsed.add(childNode);
					}
				}
				this.UpdateResults = UpdateResultsList;
			}
			DOM.XmlNode ParentPropertyNameNode = responseNode.getChildElement(
				'ParentPropertyName',
				s_ns0
			);
			this.ParentPropertyName = (ParentPropertyNameNode == null)
				? null
				: ParentPropertyNameNode.getText();
			nodesParsed.add(ParentPropertyNameNode);
		}
		public void populateXmlNode(Dom.XmlNode outerNode) {
			Dom.XmlNode StatusCodeNode = outerNode.addChildElement(
				'StatusCode',
				s_ns0,
				''
			);
			if (this.StatusCode != null) {
				StatusCodeNode.addTextNode(this.StatusCode);
			}
			Dom.XmlNode StatusMessageNode = outerNode.addChildElement(
				'StatusMessage',
				s_ns0,
				''
			);
			if (this.StatusMessage != null) {
				StatusMessageNode.addTextNode(this.StatusMessage);
			}
			Dom.XmlNode OrdinalIDNode = outerNode.addChildElement(
				'OrdinalID',
				s_ns0,
				''
			);
			OrdinalIDNode.addTextNode(
				(this.OrdinalID == null) ? '' : String.valueOf(this.OrdinalID)
			);
			Dom.XmlNode ErrorCodeNode = outerNode.addChildElement(
				'ErrorCode',
				s_ns0,
				''
			);
			ErrorCodeNode.addTextNode(
				(this.ErrorCode == null) ? '' : String.valueOf(this.ErrorCode)
			);
			Dom.XmlNode RequestIDNode = outerNode.addChildElement(
				'RequestID',
				s_ns0,
				''
			);
			RequestIDNode.addTextNode((this.RequestID == null) ? '' : this.RequestID);
			Dom.XmlNode ConversationIDNode = outerNode.addChildElement(
				'ConversationID',
				s_ns0,
				''
			);
			ConversationIDNode.addTextNode(
				(this.ConversationID == null) ? '' : this.ConversationID
			);
			Dom.XmlNode OverallStatusCodeNode = outerNode.addChildElement(
				'OverallStatusCode',
				s_ns0,
				''
			);
			OverallStatusCodeNode.addTextNode(
				(this.OverallStatusCode == null) ? '' : this.OverallStatusCode
			);
			Dom.XmlNode RequestTypeNode = outerNode.addChildElement(
				'RequestType',
				s_ns0,
				''
			);
			RequestTypeNode.addTextNode(
				(this.RequestType == null) ? '' : this.RequestType
			);
			Dom.XmlNode ResultTypeNode = outerNode.addChildElement(
				'ResultType',
				s_ns0,
				''
			);
			ResultTypeNode.addTextNode(
				(this.ResultType == null) ? '' : this.ResultType
			);
			Dom.XmlNode ResultDetailXMLNode = outerNode.addChildElement(
				'ResultDetailXML',
				s_ns0,
				''
			);
			ResultDetailXMLNode.addTextNode(
				(this.ResultDetailXML == null) ? '' : this.ResultDetailXML
			);

			soapBaseObjects.APIObject Object_xObj = this.Object_x;
			Dom.XmlNode Object_xNode = outerNode.addChildElement('Object', s_ns0, '');
			if (Object_xObj != null) {
				Object_xObj.populateXmlNode(Object_xNode);
			}

			soapBaseObjects.UpdateResult[] UpdateResultsObj = this.UpdateResults;
			if (UpdateResultsObj != null) {
				for (soapBaseObjects.UpdateResult element : UpdateResultsObj) {
					Dom.XmlNode UpdateResultsNode = outerNode.addChildElement(
						'UpdateResults',
						s_ns0,
						''
					);
					element.populateXmlNode(UpdateResultsNode);
				}
			}
			Dom.XmlNode ParentPropertyNameNode = outerNode.addChildElement(
				'ParentPropertyName',
				s_ns0,
				''
			);
			ParentPropertyNameNode.addTextNode(
				(this.ParentPropertyName == null) ? '' : this.ParentPropertyName
			);
		}
	}
	//Extends http://exacttarget.com/wsdl/partnerAPI:APIObject
	public class AsyncRequestResult {
		public DateTime CreatedDate;
		public DateTime ModifiedDate;
		public Integer ID;
		public String ObjectID;
		public String CustomerKey;

		public String ObjectState;

		public String Status;
		public DateTime CompleteDate;
		public String CallStatus;
		public String CallMessage;

		public AsyncRequestResult() {
		}
		public AsyncRequestResult(DOM.XmlNode responseNode) {
			Set<DOM.XmlNode> nodesParsed = new Set<DOM.XmlNode>();
			DOM.XmlNode CreatedDateNode = responseNode.getChildElement(
				'CreatedDate',
				s_ns0
			);
			this.CreatedDate = (CreatedDateNode == null)
				? null
				: soapBaseObjects.parseDateTime(CreatedDateNode.getText());
			nodesParsed.add(CreatedDateNode);
			DOM.XmlNode ModifiedDateNode = responseNode.getChildElement(
				'ModifiedDate',
				s_ns0
			);
			this.ModifiedDate = (ModifiedDateNode == null ||
				ModifiedDateNode.getAttributeValue(
					'nil',
					'http://www.w3.org/2001/XMLSchema-instance'
				) == 'true')
				? null
				: soapBaseObjects.parseDateTime(ModifiedDateNode.getText());
			nodesParsed.add(ModifiedDateNode);
			DOM.XmlNode IDNode = responseNode.getChildElement('ID', s_ns0);
			this.ID = (IDNode == null) ? null : Integer.valueOf(IDNode.getText());
			nodesParsed.add(IDNode);
			DOM.XmlNode ObjectIDNode = responseNode.getChildElement(
				'ObjectID',
				s_ns0
			);
			this.ObjectID = (ObjectIDNode == null ||
				ObjectIDNode.getAttributeValue(
					'nil',
					'http://www.w3.org/2001/XMLSchema-instance'
				) == 'true')
				? null
				: ObjectIDNode.getText();
			nodesParsed.add(ObjectIDNode);
			DOM.XmlNode CustomerKeyNode = responseNode.getChildElement(
				'CustomerKey',
				s_ns0
			);
			this.CustomerKey = (CustomerKeyNode == null)
				? null
				: CustomerKeyNode.getText();
			nodesParsed.add(CustomerKeyNode);

			DOM.XmlNode ObjectStateNode = responseNode.getChildElement(
				'ObjectState',
				s_ns0
			);
			this.ObjectState = (ObjectStateNode == null)
				? null
				: ObjectStateNode.getText();
			nodesParsed.add(ObjectStateNode);
			DOM.XmlNode StatusNode = responseNode.getChildElement('Status', s_ns0);
			this.Status = (StatusNode == null) ? null : StatusNode.getText();
			nodesParsed.add(StatusNode);
			DOM.XmlNode CompleteDateNode = responseNode.getChildElement(
				'CompleteDate',
				s_ns0
			);
			this.CompleteDate = (CompleteDateNode == null)
				? null
				: soapBaseObjects.parseDateTime(CompleteDateNode.getText());
			nodesParsed.add(CompleteDateNode);
			DOM.XmlNode CallStatusNode = responseNode.getChildElement(
				'CallStatus',
				s_ns0
			);
			this.CallStatus = (CallStatusNode == null)
				? null
				: CallStatusNode.getText();
			nodesParsed.add(CallStatusNode);
			DOM.XmlNode CallMessageNode = responseNode.getChildElement(
				'CallMessage',
				s_ns0
			);
			this.CallMessage = (CallMessageNode == null)
				? null
				: CallMessageNode.getText();
			nodesParsed.add(CallMessageNode);
		}
		public void populateXmlNode(Dom.XmlNode outerNode) {
			Dom.XmlNode CreatedDateNode = outerNode.addChildElement(
				'CreatedDate',
				s_ns0,
				''
			);
			CreatedDateNode.addTextNode(
				(this.CreatedDate == null) ? '' : String.valueOf(this.CreatedDate)
			);
			Dom.XmlNode ModifiedDateNode = outerNode.addChildElement(
				'ModifiedDate',
				s_ns0,
				''
			);
			ModifiedDateNode.addTextNode(
				(this.ModifiedDate == null) ? '' : String.valueOf(this.ModifiedDate)
			);
			Dom.XmlNode IDNode = outerNode.addChildElement('ID', s_ns0, '');
			IDNode.addTextNode((this.ID == null) ? '' : String.valueOf(this.ID));
			Dom.XmlNode ObjectIDNode = outerNode.addChildElement(
				'ObjectID',
				s_ns0,
				''
			);
			ObjectIDNode.addTextNode((this.ObjectID == null) ? '' : this.ObjectID);
			Dom.XmlNode CustomerKeyNode = outerNode.addChildElement(
				'CustomerKey',
				s_ns0,
				''
			);
			CustomerKeyNode.addTextNode(
				(this.CustomerKey == null) ? '' : this.CustomerKey
			);

			Dom.XmlNode ObjectStateNode = outerNode.addChildElement(
				'ObjectState',
				s_ns0,
				''
			);
			ObjectStateNode.addTextNode(
				(this.ObjectState == null) ? '' : this.ObjectState
			);
			Dom.XmlNode StatusNode = outerNode.addChildElement('Status', s_ns0, '');
			StatusNode.addTextNode((this.Status == null) ? '' : this.Status);
			Dom.XmlNode CompleteDateNode = outerNode.addChildElement(
				'CompleteDate',
				s_ns0,
				''
			);
			CompleteDateNode.addTextNode(
				(this.CompleteDate == null) ? '' : String.valueOf(this.CompleteDate)
			);
			Dom.XmlNode CallStatusNode = outerNode.addChildElement(
				'CallStatus',
				s_ns0,
				''
			);
			CallStatusNode.addTextNode(
				(this.CallStatus == null) ? '' : this.CallStatus
			);
			Dom.XmlNode CallMessageNode = outerNode.addChildElement(
				'CallMessage',
				s_ns0,
				''
			);
			CallMessageNode.addTextNode(
				(this.CallMessage == null) ? '' : this.CallMessage
			);
		}
	}
	public class AsyncResponse {
		// Restriction enumeration: None, email, FTP, HTTPPost
		public String ResponseType;
		public String ResponseAddress;
		// Restriction enumeration: Never, OnError, Always, OnConversationError, OnConversationComplete, OnCallComplete
		public String RespondWhen;
		public Boolean IncludeResults;
		public Boolean IncludeObjects;
		public Boolean OnlyIncludeBase;

		public AsyncResponse() {
		}
		public AsyncResponse(DOM.XmlNode responseNode) {
			Set<DOM.XmlNode> nodesParsed = new Set<DOM.XmlNode>();
			DOM.XmlNode ResponseTypeNode = responseNode.getChildElement(
				'ResponseType',
				s_ns0
			);
			this.ResponseType = (ResponseTypeNode == null)
				? null
				: ResponseTypeNode.getText();
			nodesParsed.add(ResponseTypeNode);
			DOM.XmlNode ResponseAddressNode = responseNode.getChildElement(
				'ResponseAddress',
				s_ns0
			);
			this.ResponseAddress = (ResponseAddressNode == null)
				? null
				: ResponseAddressNode.getText();
			nodesParsed.add(ResponseAddressNode);
			DOM.XmlNode RespondWhenNode = responseNode.getChildElement(
				'RespondWhen',
				s_ns0
			);
			this.RespondWhen = (RespondWhenNode == null)
				? null
				: RespondWhenNode.getText();
			nodesParsed.add(RespondWhenNode);
			DOM.XmlNode IncludeResultsNode = responseNode.getChildElement(
				'IncludeResults',
				s_ns0
			);
			this.IncludeResults = (IncludeResultsNode == null)
				? null
				: Boolean.valueOf(IncludeResultsNode.getText());
			nodesParsed.add(IncludeResultsNode);
			DOM.XmlNode IncludeObjectsNode = responseNode.getChildElement(
				'IncludeObjects',
				s_ns0
			);
			this.IncludeObjects = (IncludeObjectsNode == null)
				? null
				: Boolean.valueOf(IncludeObjectsNode.getText());
			nodesParsed.add(IncludeObjectsNode);
			DOM.XmlNode OnlyIncludeBaseNode = responseNode.getChildElement(
				'OnlyIncludeBase',
				s_ns0
			);
			this.OnlyIncludeBase = (OnlyIncludeBaseNode == null)
				? null
				: Boolean.valueOf(OnlyIncludeBaseNode.getText());
			nodesParsed.add(OnlyIncludeBaseNode);
		}
		public void populateXmlNode(Dom.XmlNode outerNode) {
			Dom.XmlNode ResponseTypeNode = outerNode.addChildElement(
				'ResponseType',
				s_ns0,
				''
			);
			if (this.ResponseType != null) {
				ResponseTypeNode.addTextNode(this.ResponseType);
			}
			Dom.XmlNode ResponseAddressNode = outerNode.addChildElement(
				'ResponseAddress',
				s_ns0,
				''
			);
			if (this.ResponseAddress != null) {
				ResponseAddressNode.addTextNode(this.ResponseAddress);
			}
			Dom.XmlNode RespondWhenNode = outerNode.addChildElement(
				'RespondWhen',
				s_ns0,
				''
			);
			RespondWhenNode.addTextNode(
				(this.RespondWhen == null) ? '' : this.RespondWhen
			);
			Dom.XmlNode IncludeResultsNode = outerNode.addChildElement(
				'IncludeResults',
				s_ns0,
				''
			);
			IncludeResultsNode.addTextNode(
				(this.IncludeResults == null) ? '' : String.valueOf(this.IncludeResults)
			);
			Dom.XmlNode IncludeObjectsNode = outerNode.addChildElement(
				'IncludeObjects',
				s_ns0,
				''
			);
			IncludeObjectsNode.addTextNode(
				(this.IncludeObjects == null) ? '' : String.valueOf(this.IncludeObjects)
			);
			Dom.XmlNode OnlyIncludeBaseNode = outerNode.addChildElement(
				'OnlyIncludeBase',
				s_ns0,
				''
			);
			OnlyIncludeBaseNode.addTextNode(
				(this.OnlyIncludeBase == null)
					? ''
					: String.valueOf(this.OnlyIncludeBase)
			);
		}
	}

	//Extends http://exacttarget.com/wsdl/partnerAPI:Options
	public class CreateOptions {
		public soapBaseObjects.ClientID Client;
		public soapBaseObjects.AsyncResponse[] SendResponseTo;
		public soapBaseObjects.Options_SaveOptions_element SaveOptions;
		public Integer Priority;
		public String ConversationID;
		public Integer SequenceCode;
		public Integer CallsInConversation;
		public DateTime ScheduledTime;
		// Restriction enumeration: Synchronous, Asynchronous
		public String RequestType;
		// Restriction enumeration: Low, Medium, High
		public String QueuePriority;

		public CreateOptions() {
		}
		public CreateOptions(DOM.XmlNode responseNode) {
			Set<DOM.XmlNode> nodesParsed = new Set<DOM.XmlNode>();

			Dom.XmlNode[] SendResponseToChildren = responseNode.getChildElements();
			soapBaseObjects.AsyncResponse[] SendResponseToList = new List<soapBaseObjects.AsyncResponse>();
			if (
				SendResponseToChildren == null ||
				SendResponseToChildren.size() == 0
			) {
				this.SendResponseTo = null;
			} else {
				for (DOM.XmlNode childNode : SendResponseToChildren) {
					if (childNode.GetName() == 'SendResponseTo') {
						soapBaseObjects.AsyncResponse Obj = new soapBaseObjects.AsyncResponse(
							childNode
						);
						SendResponseToList.Add(Obj);
						nodesParsed.add(childNode);
					}
				}
				this.SendResponseTo = SendResponseToList;
			}
			DOM.XmlNode SaveOptionsNode = responseNode.getChildElement(
				'SaveOptions',
				s_ns0
			);
			if (SaveOptionsNode == null) {
				this.SaveOptions = null;
			} else {
				soapBaseObjects.Options_SaveOptions_element SaveOptionsObj = new soapBaseObjects.Options_SaveOptions_element(
					SaveOptionsNode
				);
				nodesParsed.add(SaveOptionsNode);
				this.SaveOptions = SaveOptionsObj;
			}
			DOM.XmlNode PriorityNode = responseNode.getChildElement(
				'Priority',
				s_ns0
			);
			this.Priority = (PriorityNode == null)
				? null
				: Integer.valueOf(PriorityNode.getText());
			nodesParsed.add(PriorityNode);
			DOM.XmlNode ConversationIDNode = responseNode.getChildElement(
				'ConversationID',
				s_ns0
			);
			this.ConversationID = (ConversationIDNode == null)
				? null
				: ConversationIDNode.getText();
			nodesParsed.add(ConversationIDNode);
			DOM.XmlNode SequenceCodeNode = responseNode.getChildElement(
				'SequenceCode',
				s_ns0
			);
			this.SequenceCode = (SequenceCodeNode == null)
				? null
				: Integer.valueOf(SequenceCodeNode.getText());
			nodesParsed.add(SequenceCodeNode);
			DOM.XmlNode CallsInConversationNode = responseNode.getChildElement(
				'CallsInConversation',
				s_ns0
			);
			this.CallsInConversation = (CallsInConversationNode == null)
				? null
				: Integer.valueOf(CallsInConversationNode.getText());
			nodesParsed.add(CallsInConversationNode);
			DOM.XmlNode ScheduledTimeNode = responseNode.getChildElement(
				'ScheduledTime',
				s_ns0
			);
			this.ScheduledTime = (ScheduledTimeNode == null)
				? null
				: soapBaseObjects.parseDateTime(ScheduledTimeNode.getText());
			nodesParsed.add(ScheduledTimeNode);
			DOM.XmlNode RequestTypeNode = responseNode.getChildElement(
				'RequestType',
				s_ns0
			);
			this.RequestType = (RequestTypeNode == null)
				? null
				: RequestTypeNode.getText();
			nodesParsed.add(RequestTypeNode);
			DOM.XmlNode QueuePriorityNode = responseNode.getChildElement(
				'QueuePriority',
				s_ns0
			);
			this.QueuePriority = (QueuePriorityNode == null)
				? null
				: QueuePriorityNode.getText();
			nodesParsed.add(QueuePriorityNode);
		}
		public void populateXmlNode(Dom.XmlNode outerNode) {
			soapBaseObjects.ClientID ClientObj = this.Client;
			Dom.XmlNode ClientNode = outerNode.addChildElement('Client', s_ns0, '');
			if (ClientObj != null) {
				ClientObj.populateXmlNode(ClientNode);
			}

			soapBaseObjects.AsyncResponse[] SendResponseToObj = this.SendResponseTo;
			if (SendResponseToObj != null) {
				for (soapBaseObjects.AsyncResponse element : SendResponseToObj) {
					Dom.XmlNode SendResponseToNode = outerNode.addChildElement(
						'SendResponseTo',
						s_ns0,
						''
					);
					element.populateXmlNode(SendResponseToNode);
				}
			}

			soapBaseObjects.Options_SaveOptions_element SaveOptionsObj = this.SaveOptions;
			Dom.XmlNode SaveOptionsNode = outerNode.addChildElement(
				'SaveOptions',
				s_ns0,
				''
			);
			if (SaveOptionsObj != null) {
				SaveOptionsObj.populateXmlNode(SaveOptionsNode);
			}
			Dom.XmlNode PriorityNode = outerNode.addChildElement(
				'Priority',
				s_ns0,
				''
			);
			PriorityNode.addTextNode(
				(this.Priority == null) ? '' : String.valueOf(this.Priority)
			);
			Dom.XmlNode ConversationIDNode = outerNode.addChildElement(
				'ConversationID',
				s_ns0,
				''
			);
			ConversationIDNode.addTextNode(
				(this.ConversationID == null) ? '' : this.ConversationID
			);
			Dom.XmlNode SequenceCodeNode = outerNode.addChildElement(
				'SequenceCode',
				s_ns0,
				''
			);
			SequenceCodeNode.addTextNode(
				(this.SequenceCode == null) ? '' : String.valueOf(this.SequenceCode)
			);
			Dom.XmlNode CallsInConversationNode = outerNode.addChildElement(
				'CallsInConversation',
				s_ns0,
				''
			);
			CallsInConversationNode.addTextNode(
				(this.CallsInConversation == null)
					? ''
					: String.valueOf(this.CallsInConversation)
			);
			Dom.XmlNode ScheduledTimeNode = outerNode.addChildElement(
				'ScheduledTime',
				s_ns0,
				''
			);
			ScheduledTimeNode.addTextNode(
				(this.ScheduledTime == null) ? '' : String.valueOf(this.ScheduledTime)
			);
			Dom.XmlNode RequestTypeNode = outerNode.addChildElement(
				'RequestType',
				s_ns0,
				''
			);
			RequestTypeNode.addTextNode(
				(this.RequestType == null) ? '' : this.RequestType
			);
			Dom.XmlNode QueuePriorityNode = outerNode.addChildElement(
				'QueuePriority',
				s_ns0,
				''
			);
			QueuePriorityNode.addTextNode(
				(this.QueuePriority == null) ? '' : this.QueuePriority
			);
		}
	}
	public class CreateRequest_element {
		public soapBaseObjects.CreateOptions Options;
		public soapBaseObjects.APIObject[] Objects;

		public CreateRequest_element() {
		}
		public CreateRequest_element(
			soapBaseObjects.CreateOptions Options,
			soapBaseObjects.APIObject[] Objects
		) {
			this.Options = Options;
			this.Objects = Objects;
		}
		public void populateXmlNode(Dom.XmlNode outerNode) {
			soapBaseObjects.CreateOptions OptionsObj = this.Options;
			Dom.XmlNode OptionsNode = outerNode.addChildElement('Options', s_ns0, '');
			if (OptionsObj != null) {
				OptionsObj.populateXmlNode(OptionsNode);
			}

			soapBaseObjects.APIObject[] ObjectsObj = this.Objects;
			if (ObjectsObj != null) {
				for (soapBaseObjects.APIObject element : ObjectsObj) {
					Dom.XmlNode ObjectsNode = outerNode.addChildElement(
						'Objects',
						s_ns0,
						''
					);
					element.populateXmlNode(ObjectsNode);
				}
			}
		}
	}
	public class CreateResponse_element {
		public soapBaseObjects.CreateResult[] Results;
		public String RequestID;
		public String OverallStatus;

		public CreateResponse_element() {
		}
		public CreateResponse_element(DOM.XmlNode responseNode) {
			Set<DOM.XmlNode> nodesParsed = new Set<DOM.XmlNode>();

			Dom.XmlNode[] ResultsChildren = responseNode.getChildElements();
			soapBaseObjects.CreateResult[] ResultsList = new List<soapBaseObjects.CreateResult>();
			if (ResultsChildren == null || ResultsChildren.size() == 0) {
				this.Results = null;
			} else {
				for (DOM.XmlNode childNode : ResultsChildren) {
					if (childNode.GetName() == 'Results') {
						soapBaseObjects.CreateResult Obj = new soapBaseObjects.CreateResult(
							childNode
						);
						ResultsList.Add(Obj);
						nodesParsed.add(childNode);
					}
				}
				this.Results = ResultsList;
			}
			DOM.XmlNode RequestIDNode = responseNode.getChildElement(
				'RequestID',
				s_ns0
			);
			this.RequestID = (RequestIDNode == null) ? null : RequestIDNode.getText();
			nodesParsed.add(RequestIDNode);
			DOM.XmlNode OverallStatusNode = responseNode.getChildElement(
				'OverallStatus',
				s_ns0
			);
			this.OverallStatus = (OverallStatusNode == null)
				? null
				: OverallStatusNode.getText();
			nodesParsed.add(OverallStatusNode);
		}
	}

	//Extends http://exacttarget.com/wsdl/partnerAPI:Result
	public class CreateResult {
		public String StatusCode;
		public String StatusMessage;
		public Integer OrdinalID;
		public Integer ErrorCode;
		public String RequestID;
		public String ConversationID;
		public String OverallStatusCode;
		// Restriction enumeration: Synchronous, Asynchronous
		public String RequestType;
		public String ResultType;
		public String ResultDetailXML;

		public Integer NewID;
		public String NewObjectID;
		public soapBaseObjects.APIObject Object_x;
		public soapBaseObjects.CreateResult[] CreateResults;
		public String ParentPropertyName;

		public CreateResult() {
		}
		public CreateResult(DOM.XmlNode responseNode) {
			Set<DOM.XmlNode> nodesParsed = new Set<DOM.XmlNode>();
			DOM.XmlNode StatusCodeNode = responseNode.getChildElement(
				'StatusCode',
				s_ns0
			);
			this.StatusCode = (StatusCodeNode == null)
				? null
				: StatusCodeNode.getText();
			nodesParsed.add(StatusCodeNode);
			DOM.XmlNode StatusMessageNode = responseNode.getChildElement(
				'StatusMessage',
				s_ns0
			);
			this.StatusMessage = (StatusMessageNode == null)
				? null
				: StatusMessageNode.getText();
			nodesParsed.add(StatusMessageNode);
			DOM.XmlNode OrdinalIDNode = responseNode.getChildElement(
				'OrdinalID',
				s_ns0
			);
			this.OrdinalID = (OrdinalIDNode == null)
				? null
				: Integer.valueOf(OrdinalIDNode.getText());
			nodesParsed.add(OrdinalIDNode);
			DOM.XmlNode ErrorCodeNode = responseNode.getChildElement(
				'ErrorCode',
				s_ns0
			);
			this.ErrorCode = (ErrorCodeNode == null)
				? null
				: Integer.valueOf(ErrorCodeNode.getText());
			nodesParsed.add(ErrorCodeNode);
			DOM.XmlNode RequestIDNode = responseNode.getChildElement(
				'RequestID',
				s_ns0
			);
			this.RequestID = (RequestIDNode == null) ? null : RequestIDNode.getText();
			nodesParsed.add(RequestIDNode);
			DOM.XmlNode ConversationIDNode = responseNode.getChildElement(
				'ConversationID',
				s_ns0
			);
			this.ConversationID = (ConversationIDNode == null)
				? null
				: ConversationIDNode.getText();
			nodesParsed.add(ConversationIDNode);
			DOM.XmlNode OverallStatusCodeNode = responseNode.getChildElement(
				'OverallStatusCode',
				s_ns0
			);
			this.OverallStatusCode = (OverallStatusCodeNode == null)
				? null
				: OverallStatusCodeNode.getText();
			nodesParsed.add(OverallStatusCodeNode);
			DOM.XmlNode RequestTypeNode = responseNode.getChildElement(
				'RequestType',
				s_ns0
			);
			this.RequestType = (RequestTypeNode == null)
				? null
				: RequestTypeNode.getText();
			nodesParsed.add(RequestTypeNode);
			DOM.XmlNode ResultTypeNode = responseNode.getChildElement(
				'ResultType',
				s_ns0
			);
			this.ResultType = (ResultTypeNode == null)
				? null
				: ResultTypeNode.getText();
			nodesParsed.add(ResultTypeNode);
			DOM.XmlNode ResultDetailXMLNode = responseNode.getChildElement(
				'ResultDetailXML',
				s_ns0
			);
			this.ResultDetailXML = (ResultDetailXMLNode == null)
				? null
				: ResultDetailXMLNode.getText();
			nodesParsed.add(ResultDetailXMLNode);
			DOM.XmlNode NewIDNode = responseNode.getChildElement('NewID', s_ns0);
			this.NewID = (NewIDNode == null)
				? null
				: Integer.valueOf(NewIDNode.getText());
			nodesParsed.add(NewIDNode);
			DOM.XmlNode NewObjectIDNode = responseNode.getChildElement(
				'NewObjectID',
				s_ns0
			);
			this.NewObjectID = (NewObjectIDNode == null)
				? null
				: NewObjectIDNode.getText();
			nodesParsed.add(NewObjectIDNode);

			DOM.XmlNode Object_xNode = responseNode.getChildElement('Object', s_ns0);
			if (Object_xNode == null) {
				this.Object_x = null;
			} else {
				soapBaseObjects.APIObject Object_xObj = new soapBaseObjects.APIObject(
					Object_xNode
				);
				nodesParsed.add(Object_xNode);
				this.Object_x = Object_xObj;
			}
			Dom.XmlNode[] CreateResultsChildren = responseNode.getChildElements();
			soapBaseObjects.CreateResult[] CreateResultsList = new List<soapBaseObjects.CreateResult>();
			if (CreateResultsChildren == null || CreateResultsChildren.size() == 0) {
				this.CreateResults = null;
			} else {
				for (DOM.XmlNode childNode : CreateResultsChildren) {
					if (childNode.GetName() == 'CreateResults') {
						soapBaseObjects.CreateResult Obj = new soapBaseObjects.CreateResult(
							childNode
						);
						CreateResultsList.Add(Obj);
						nodesParsed.add(childNode);
					}
				}
				this.CreateResults = CreateResultsList;
			}
			DOM.XmlNode ParentPropertyNameNode = responseNode.getChildElement(
				'ParentPropertyName',
				s_ns0
			);
			this.ParentPropertyName = (ParentPropertyNameNode == null)
				? null
				: ParentPropertyNameNode.getText();
			nodesParsed.add(ParentPropertyNameNode);
		}
		public void populateXmlNode(Dom.XmlNode outerNode) {
			Dom.XmlNode StatusCodeNode = outerNode.addChildElement(
				'StatusCode',
				s_ns0,
				''
			);
			if (this.StatusCode != null) {
				StatusCodeNode.addTextNode(this.StatusCode);
			}
			Dom.XmlNode StatusMessageNode = outerNode.addChildElement(
				'StatusMessage',
				s_ns0,
				''
			);
			if (this.StatusMessage != null) {
				StatusMessageNode.addTextNode(this.StatusMessage);
			}
			Dom.XmlNode OrdinalIDNode = outerNode.addChildElement(
				'OrdinalID',
				s_ns0,
				''
			);
			OrdinalIDNode.addTextNode(
				(this.OrdinalID == null) ? '' : String.valueOf(this.OrdinalID)
			);
			Dom.XmlNode ErrorCodeNode = outerNode.addChildElement(
				'ErrorCode',
				s_ns0,
				''
			);
			ErrorCodeNode.addTextNode(
				(this.ErrorCode == null) ? '' : String.valueOf(this.ErrorCode)
			);
			Dom.XmlNode RequestIDNode = outerNode.addChildElement(
				'RequestID',
				s_ns0,
				''
			);
			RequestIDNode.addTextNode((this.RequestID == null) ? '' : this.RequestID);
			Dom.XmlNode ConversationIDNode = outerNode.addChildElement(
				'ConversationID',
				s_ns0,
				''
			);
			ConversationIDNode.addTextNode(
				(this.ConversationID == null) ? '' : this.ConversationID
			);
			Dom.XmlNode OverallStatusCodeNode = outerNode.addChildElement(
				'OverallStatusCode',
				s_ns0,
				''
			);
			OverallStatusCodeNode.addTextNode(
				(this.OverallStatusCode == null) ? '' : this.OverallStatusCode
			);
			Dom.XmlNode RequestTypeNode = outerNode.addChildElement(
				'RequestType',
				s_ns0,
				''
			);
			RequestTypeNode.addTextNode(
				(this.RequestType == null) ? '' : this.RequestType
			);
			Dom.XmlNode ResultTypeNode = outerNode.addChildElement(
				'ResultType',
				s_ns0,
				''
			);
			ResultTypeNode.addTextNode(
				(this.ResultType == null) ? '' : this.ResultType
			);
			Dom.XmlNode ResultDetailXMLNode = outerNode.addChildElement(
				'ResultDetailXML',
				s_ns0,
				''
			);
			ResultDetailXMLNode.addTextNode(
				(this.ResultDetailXML == null) ? '' : this.ResultDetailXML
			);
			Dom.XmlNode NewIDNode = outerNode.addChildElement('NewID', s_ns0, '');
			if (this.NewID != null) {
				NewIDNode.addTextNode(String.valueOf(this.NewID));
			}
			Dom.XmlNode NewObjectIDNode = outerNode.addChildElement(
				'NewObjectID',
				s_ns0,
				''
			);
			NewObjectIDNode.addTextNode(
				(this.NewObjectID == null) ? '' : this.NewObjectID
			);
			soapBaseObjects.APIObject Object_xObj = this.Object_x;
			Dom.XmlNode Object_xNode = outerNode.addChildElement('Object', s_ns0, '');
			if (Object_xObj != null) {
				Object_xObj.populateXmlNode(Object_xNode);
			}

			soapBaseObjects.CreateResult[] CreateResultsObj = this.CreateResults;
			if (CreateResultsObj != null) {
				for (soapBaseObjects.CreateResult element : CreateResultsObj) {
					Dom.XmlNode CreateResultsNode = outerNode.addChildElement(
						'CreateResults',
						s_ns0,
						''
					);
					element.populateXmlNode(CreateResultsNode);
				}
			}
			Dom.XmlNode ParentPropertyNameNode = outerNode.addChildElement(
				'ParentPropertyName',
				s_ns0,
				''
			);
			ParentPropertyNameNode.addTextNode(
				(this.ParentPropertyName == null) ? '' : this.ParentPropertyName
			);
		}
	}

	//Extends http://exacttarget.com/wsdl/partnerAPI:Options
	public class DeleteOptions {
		public soapBaseObjects.ClientID Client;
		public soapBaseObjects.AsyncResponse[] SendResponseTo;
		public soapBaseObjects.Options_SaveOptions_element SaveOptions;
		public Integer Priority;
		public String ConversationID;
		public Integer SequenceCode;
		public Integer CallsInConversation;
		public DateTime ScheduledTime;
		// Restriction enumeration: Synchronous, Asynchronous
		public String RequestType;
		// Restriction enumeration: Low, Medium, High
		public String QueuePriority;

		public DeleteOptions() {
		}
		public DeleteOptions(DOM.XmlNode responseNode) {
			Set<DOM.XmlNode> nodesParsed = new Set<DOM.XmlNode>();

			Dom.XmlNode[] SendResponseToChildren = responseNode.getChildElements();
			soapBaseObjects.AsyncResponse[] SendResponseToList = new List<soapBaseObjects.AsyncResponse>();
			if (
				SendResponseToChildren == null ||
				SendResponseToChildren.size() == 0
			) {
				this.SendResponseTo = null;
			} else {
				for (DOM.XmlNode childNode : SendResponseToChildren) {
					if (childNode.GetName() == 'SendResponseTo') {
						soapBaseObjects.AsyncResponse Obj = new soapBaseObjects.AsyncResponse(
							childNode
						);
						SendResponseToList.Add(Obj);
						nodesParsed.add(childNode);
					}
				}
				this.SendResponseTo = SendResponseToList;
			}
			DOM.XmlNode SaveOptionsNode = responseNode.getChildElement(
				'SaveOptions',
				s_ns0
			);
			if (SaveOptionsNode == null) {
				this.SaveOptions = null;
			} else {
				soapBaseObjects.Options_SaveOptions_element SaveOptionsObj = new soapBaseObjects.Options_SaveOptions_element(
					SaveOptionsNode
				);
				nodesParsed.add(SaveOptionsNode);
				this.SaveOptions = SaveOptionsObj;
			}
			DOM.XmlNode PriorityNode = responseNode.getChildElement(
				'Priority',
				s_ns0
			);
			this.Priority = (PriorityNode == null)
				? null
				: Integer.valueOf(PriorityNode.getText());
			nodesParsed.add(PriorityNode);
			DOM.XmlNode ConversationIDNode = responseNode.getChildElement(
				'ConversationID',
				s_ns0
			);
			this.ConversationID = (ConversationIDNode == null)
				? null
				: ConversationIDNode.getText();
			nodesParsed.add(ConversationIDNode);
			DOM.XmlNode SequenceCodeNode = responseNode.getChildElement(
				'SequenceCode',
				s_ns0
			);
			this.SequenceCode = (SequenceCodeNode == null)
				? null
				: Integer.valueOf(SequenceCodeNode.getText());
			nodesParsed.add(SequenceCodeNode);
			DOM.XmlNode CallsInConversationNode = responseNode.getChildElement(
				'CallsInConversation',
				s_ns0
			);
			this.CallsInConversation = (CallsInConversationNode == null)
				? null
				: Integer.valueOf(CallsInConversationNode.getText());
			nodesParsed.add(CallsInConversationNode);
			DOM.XmlNode ScheduledTimeNode = responseNode.getChildElement(
				'ScheduledTime',
				s_ns0
			);
			this.ScheduledTime = (ScheduledTimeNode == null)
				? null
				: soapBaseObjects.parseDateTime(ScheduledTimeNode.getText());
			nodesParsed.add(ScheduledTimeNode);
			DOM.XmlNode RequestTypeNode = responseNode.getChildElement(
				'RequestType',
				s_ns0
			);
			this.RequestType = (RequestTypeNode == null)
				? null
				: RequestTypeNode.getText();
			nodesParsed.add(RequestTypeNode);
			DOM.XmlNode QueuePriorityNode = responseNode.getChildElement(
				'QueuePriority',
				s_ns0
			);
			this.QueuePriority = (QueuePriorityNode == null)
				? null
				: QueuePriorityNode.getText();
			nodesParsed.add(QueuePriorityNode);
		}
		public void populateXmlNode(Dom.XmlNode outerNode) {
			soapBaseObjects.ClientID ClientObj = this.Client;
			Dom.XmlNode ClientNode = outerNode.addChildElement('Client', s_ns0, '');
			if (ClientObj != null) {
				ClientObj.populateXmlNode(ClientNode);
			}

			soapBaseObjects.AsyncResponse[] SendResponseToObj = this.SendResponseTo;
			if (SendResponseToObj != null) {
				for (soapBaseObjects.AsyncResponse element : SendResponseToObj) {
					Dom.XmlNode SendResponseToNode = outerNode.addChildElement(
						'SendResponseTo',
						s_ns0,
						''
					);
					element.populateXmlNode(SendResponseToNode);
				}
			}

			soapBaseObjects.Options_SaveOptions_element SaveOptionsObj = this.SaveOptions;
			Dom.XmlNode SaveOptionsNode = outerNode.addChildElement(
				'SaveOptions',
				s_ns0,
				''
			);
			if (SaveOptionsObj != null) {
				SaveOptionsObj.populateXmlNode(SaveOptionsNode);
			}
			Dom.XmlNode PriorityNode = outerNode.addChildElement(
				'Priority',
				s_ns0,
				''
			);
			PriorityNode.addTextNode(
				(this.Priority == null) ? '' : String.valueOf(this.Priority)
			);
			Dom.XmlNode ConversationIDNode = outerNode.addChildElement(
				'ConversationID',
				s_ns0,
				''
			);
			ConversationIDNode.addTextNode(
				(this.ConversationID == null) ? '' : this.ConversationID
			);
			Dom.XmlNode SequenceCodeNode = outerNode.addChildElement(
				'SequenceCode',
				s_ns0,
				''
			);
			SequenceCodeNode.addTextNode(
				(this.SequenceCode == null) ? '' : String.valueOf(this.SequenceCode)
			);
			Dom.XmlNode CallsInConversationNode = outerNode.addChildElement(
				'CallsInConversation',
				s_ns0,
				''
			);
			CallsInConversationNode.addTextNode(
				(this.CallsInConversation == null)
					? ''
					: String.valueOf(this.CallsInConversation)
			);
			Dom.XmlNode ScheduledTimeNode = outerNode.addChildElement(
				'ScheduledTime',
				s_ns0,
				''
			);
			ScheduledTimeNode.addTextNode(
				(this.ScheduledTime == null) ? '' : String.valueOf(this.ScheduledTime)
			);
			Dom.XmlNode RequestTypeNode = outerNode.addChildElement(
				'RequestType',
				s_ns0,
				''
			);
			RequestTypeNode.addTextNode(
				(this.RequestType == null) ? '' : this.RequestType
			);
			Dom.XmlNode QueuePriorityNode = outerNode.addChildElement(
				'QueuePriority',
				s_ns0,
				''
			);
			QueuePriorityNode.addTextNode(
				(this.QueuePriority == null) ? '' : this.QueuePriority
			);
		}
	}
	public class DeleteRequest_element {
		public soapBaseObjects.DeleteOptions Options;
		public soapBaseObjects.APIObject[] Objects;

		public DeleteRequest_element() {
		}
		public DeleteRequest_element(
			soapBaseObjects.DeleteOptions Options,
			soapBaseObjects.APIObject[] Objects
		) {
			this.Options = Options;
			this.Objects = Objects;
		}
		public void populateXmlNode(Dom.XmlNode outerNode) {
			soapBaseObjects.DeleteOptions OptionsObj = this.Options;
			Dom.XmlNode OptionsNode = outerNode.addChildElement('Options', s_ns0, '');
			if (OptionsObj != null) {
				OptionsObj.populateXmlNode(OptionsNode);
			}

			soapBaseObjects.APIObject[] ObjectsObj = this.Objects;
			if (ObjectsObj != null) {
				for (soapBaseObjects.APIObject element : ObjectsObj) {
					Dom.XmlNode ObjectsNode = outerNode.addChildElement(
						'Objects',
						s_ns0,
						''
					);
					element.populateXmlNode(ObjectsNode);
				}
			}
		}
	}
	public class DeleteResponse_element {
		public soapBaseObjects.DeleteResult[] Results;
		public String RequestID;
		public String OverallStatus;

		public DeleteResponse_element() {
		}
		public DeleteResponse_element(DOM.XmlNode responseNode) {
			Set<DOM.XmlNode> nodesParsed = new Set<DOM.XmlNode>();

			Dom.XmlNode[] ResultsChildren = responseNode.getChildElements();
			soapBaseObjects.DeleteResult[] ResultsList = new List<soapBaseObjects.DeleteResult>();
			if (ResultsChildren == null || ResultsChildren.size() == 0) {
				this.Results = null;
			} else {
				for (DOM.XmlNode childNode : ResultsChildren) {
					if (childNode.GetName() == 'Results') {
						soapBaseObjects.DeleteResult Obj = new soapBaseObjects.DeleteResult(
							childNode
						);
						ResultsList.Add(Obj);
						nodesParsed.add(childNode);
					}
				}
				this.Results = ResultsList;
			}
			DOM.XmlNode RequestIDNode = responseNode.getChildElement(
				'RequestID',
				s_ns0
			);
			this.RequestID = (RequestIDNode == null) ? null : RequestIDNode.getText();
			nodesParsed.add(RequestIDNode);
			DOM.XmlNode OverallStatusNode = responseNode.getChildElement(
				'OverallStatus',
				s_ns0
			);
			this.OverallStatus = (OverallStatusNode == null)
				? null
				: OverallStatusNode.getText();
			nodesParsed.add(OverallStatusNode);
		}
	}

	//Extends http://exacttarget.com/wsdl/partnerAPI:Result
	public class DeleteResult {
		public String StatusCode;
		public String StatusMessage;
		public Integer OrdinalID;
		public Integer ErrorCode;
		public String RequestID;
		public String ConversationID;
		public String OverallStatusCode;
		// Restriction enumeration: Synchronous, Asynchronous
		public String RequestType;
		public String ResultType;
		public String ResultDetailXML;

		public soapBaseObjects.APIObject Object_x;

		public DeleteResult() {
		}
		public DeleteResult(DOM.XmlNode responseNode) {
			Set<DOM.XmlNode> nodesParsed = new Set<DOM.XmlNode>();
			DOM.XmlNode StatusCodeNode = responseNode.getChildElement(
				'StatusCode',
				s_ns0
			);
			this.StatusCode = (StatusCodeNode == null)
				? null
				: StatusCodeNode.getText();
			nodesParsed.add(StatusCodeNode);
			DOM.XmlNode StatusMessageNode = responseNode.getChildElement(
				'StatusMessage',
				s_ns0
			);
			this.StatusMessage = (StatusMessageNode == null)
				? null
				: StatusMessageNode.getText();
			nodesParsed.add(StatusMessageNode);
			DOM.XmlNode OrdinalIDNode = responseNode.getChildElement(
				'OrdinalID',
				s_ns0
			);
			this.OrdinalID = (OrdinalIDNode == null)
				? null
				: Integer.valueOf(OrdinalIDNode.getText());
			nodesParsed.add(OrdinalIDNode);
			DOM.XmlNode ErrorCodeNode = responseNode.getChildElement(
				'ErrorCode',
				s_ns0
			);
			this.ErrorCode = (ErrorCodeNode == null)
				? null
				: Integer.valueOf(ErrorCodeNode.getText());
			nodesParsed.add(ErrorCodeNode);
			DOM.XmlNode RequestIDNode = responseNode.getChildElement(
				'RequestID',
				s_ns0
			);
			this.RequestID = (RequestIDNode == null) ? null : RequestIDNode.getText();
			nodesParsed.add(RequestIDNode);
			DOM.XmlNode ConversationIDNode = responseNode.getChildElement(
				'ConversationID',
				s_ns0
			);
			this.ConversationID = (ConversationIDNode == null)
				? null
				: ConversationIDNode.getText();
			nodesParsed.add(ConversationIDNode);
			DOM.XmlNode OverallStatusCodeNode = responseNode.getChildElement(
				'OverallStatusCode',
				s_ns0
			);
			this.OverallStatusCode = (OverallStatusCodeNode == null)
				? null
				: OverallStatusCodeNode.getText();
			nodesParsed.add(OverallStatusCodeNode);
			DOM.XmlNode RequestTypeNode = responseNode.getChildElement(
				'RequestType',
				s_ns0
			);
			this.RequestType = (RequestTypeNode == null)
				? null
				: RequestTypeNode.getText();
			nodesParsed.add(RequestTypeNode);
			DOM.XmlNode ResultTypeNode = responseNode.getChildElement(
				'ResultType',
				s_ns0
			);
			this.ResultType = (ResultTypeNode == null)
				? null
				: ResultTypeNode.getText();
			nodesParsed.add(ResultTypeNode);
			DOM.XmlNode ResultDetailXMLNode = responseNode.getChildElement(
				'ResultDetailXML',
				s_ns0
			);
			this.ResultDetailXML = (ResultDetailXMLNode == null)
				? null
				: ResultDetailXMLNode.getText();
			nodesParsed.add(ResultDetailXMLNode);
			DOM.XmlNode Object_xNode = responseNode.getChildElement('Object', s_ns0);
			if (Object_xNode == null) {
				this.Object_x = null;
			} else {
				soapBaseObjects.APIObject Object_xObj = new soapBaseObjects.APIObject(
					Object_xNode
				);
				nodesParsed.add(Object_xNode);
				this.Object_x = Object_xObj;
			}
		}
		public void populateXmlNode(Dom.XmlNode outerNode) {
			Dom.XmlNode StatusCodeNode = outerNode.addChildElement(
				'StatusCode',
				s_ns0,
				''
			);
			if (this.StatusCode != null) {
				StatusCodeNode.addTextNode(this.StatusCode);
			}
			Dom.XmlNode StatusMessageNode = outerNode.addChildElement(
				'StatusMessage',
				s_ns0,
				''
			);
			if (this.StatusMessage != null) {
				StatusMessageNode.addTextNode(this.StatusMessage);
			}
			Dom.XmlNode OrdinalIDNode = outerNode.addChildElement(
				'OrdinalID',
				s_ns0,
				''
			);
			OrdinalIDNode.addTextNode(
				(this.OrdinalID == null) ? '' : String.valueOf(this.OrdinalID)
			);
			Dom.XmlNode ErrorCodeNode = outerNode.addChildElement(
				'ErrorCode',
				s_ns0,
				''
			);
			ErrorCodeNode.addTextNode(
				(this.ErrorCode == null) ? '' : String.valueOf(this.ErrorCode)
			);
			Dom.XmlNode RequestIDNode = outerNode.addChildElement(
				'RequestID',
				s_ns0,
				''
			);
			RequestIDNode.addTextNode((this.RequestID == null) ? '' : this.RequestID);
			Dom.XmlNode ConversationIDNode = outerNode.addChildElement(
				'ConversationID',
				s_ns0,
				''
			);
			ConversationIDNode.addTextNode(
				(this.ConversationID == null) ? '' : this.ConversationID
			);
			Dom.XmlNode OverallStatusCodeNode = outerNode.addChildElement(
				'OverallStatusCode',
				s_ns0,
				''
			);
			OverallStatusCodeNode.addTextNode(
				(this.OverallStatusCode == null) ? '' : this.OverallStatusCode
			);
			Dom.XmlNode RequestTypeNode = outerNode.addChildElement(
				'RequestType',
				s_ns0,
				''
			);
			RequestTypeNode.addTextNode(
				(this.RequestType == null) ? '' : this.RequestType
			);
			Dom.XmlNode ResultTypeNode = outerNode.addChildElement(
				'ResultType',
				s_ns0,
				''
			);
			ResultTypeNode.addTextNode(
				(this.ResultType == null) ? '' : this.ResultType
			);
			Dom.XmlNode ResultDetailXMLNode = outerNode.addChildElement(
				'ResultDetailXML',
				s_ns0,
				''
			);
			ResultDetailXMLNode.addTextNode(
				(this.ResultDetailXML == null) ? '' : this.ResultDetailXML
			);

			soapBaseObjects.APIObject Object_xObj = this.Object_x;
			Dom.XmlNode Object_xNode = outerNode.addChildElement('Object', s_ns0, '');
			if (Object_xObj != null) {
				Object_xObj.populateXmlNode(Object_xNode);
			}
		}
	}
	public class Request {
		public Request(DOM.XmlNode responseNode) {
			Set<DOM.XmlNode> nodesParsed = new Set<DOM.XmlNode>();
		}
		public void populateXmlNode(Dom.XmlNode outerNode) {
		}
	}

	public class Result {
		public String StatusCode;
		public String StatusMessage;
		public Integer OrdinalID;
		public Integer ErrorCode;
		public String RequestID;
		public String ConversationID;
		public String OverallStatusCode;
		// Restriction enumeration: Synchronous, Asynchronous
		public String RequestType;
		public String ResultType;
		public String ResultDetailXML;

		public Result() {
		}
		public Result(DOM.XmlNode responseNode) {
			Set<DOM.XmlNode> nodesParsed = new Set<DOM.XmlNode>();
			DOM.XmlNode StatusCodeNode = responseNode.getChildElement(
				'StatusCode',
				s_ns0
			);
			this.StatusCode = (StatusCodeNode == null)
				? null
				: StatusCodeNode.getText();
			nodesParsed.add(StatusCodeNode);
			DOM.XmlNode StatusMessageNode = responseNode.getChildElement(
				'StatusMessage',
				s_ns0
			);
			this.StatusMessage = (StatusMessageNode == null)
				? null
				: StatusMessageNode.getText();
			nodesParsed.add(StatusMessageNode);
			DOM.XmlNode OrdinalIDNode = responseNode.getChildElement(
				'OrdinalID',
				s_ns0
			);
			this.OrdinalID = (OrdinalIDNode == null)
				? null
				: Integer.valueOf(OrdinalIDNode.getText());
			nodesParsed.add(OrdinalIDNode);
			DOM.XmlNode ErrorCodeNode = responseNode.getChildElement(
				'ErrorCode',
				s_ns0
			);
			this.ErrorCode = (ErrorCodeNode == null)
				? null
				: Integer.valueOf(ErrorCodeNode.getText());
			nodesParsed.add(ErrorCodeNode);
			DOM.XmlNode RequestIDNode = responseNode.getChildElement(
				'RequestID',
				s_ns0
			);
			this.RequestID = (RequestIDNode == null) ? null : RequestIDNode.getText();
			nodesParsed.add(RequestIDNode);
			DOM.XmlNode ConversationIDNode = responseNode.getChildElement(
				'ConversationID',
				s_ns0
			);
			this.ConversationID = (ConversationIDNode == null)
				? null
				: ConversationIDNode.getText();
			nodesParsed.add(ConversationIDNode);
			DOM.XmlNode OverallStatusCodeNode = responseNode.getChildElement(
				'OverallStatusCode',
				s_ns0
			);
			this.OverallStatusCode = (OverallStatusCodeNode == null)
				? null
				: OverallStatusCodeNode.getText();
			nodesParsed.add(OverallStatusCodeNode);
			DOM.XmlNode RequestTypeNode = responseNode.getChildElement(
				'RequestType',
				s_ns0
			);
			this.RequestType = (RequestTypeNode == null)
				? null
				: RequestTypeNode.getText();
			nodesParsed.add(RequestTypeNode);
			DOM.XmlNode ResultTypeNode = responseNode.getChildElement(
				'ResultType',
				s_ns0
			);
			this.ResultType = (ResultTypeNode == null)
				? null
				: ResultTypeNode.getText();
			nodesParsed.add(ResultTypeNode);
			DOM.XmlNode ResultDetailXMLNode = responseNode.getChildElement(
				'ResultDetailXML',
				s_ns0
			);
			this.ResultDetailXML = (ResultDetailXMLNode == null)
				? null
				: ResultDetailXMLNode.getText();
			nodesParsed.add(ResultDetailXMLNode);
		}
		public void populateXmlNode(Dom.XmlNode outerNode) {
			Dom.XmlNode StatusCodeNode = outerNode.addChildElement(
				'StatusCode',
				s_ns0,
				''
			);
			if (this.StatusCode != null) {
				StatusCodeNode.addTextNode(this.StatusCode);
			}
			Dom.XmlNode StatusMessageNode = outerNode.addChildElement(
				'StatusMessage',
				s_ns0,
				''
			);
			if (this.StatusMessage != null) {
				StatusMessageNode.addTextNode(this.StatusMessage);
			}
			Dom.XmlNode OrdinalIDNode = outerNode.addChildElement(
				'OrdinalID',
				s_ns0,
				''
			);
			OrdinalIDNode.addTextNode(
				(this.OrdinalID == null) ? '' : String.valueOf(this.OrdinalID)
			);
			Dom.XmlNode ErrorCodeNode = outerNode.addChildElement(
				'ErrorCode',
				s_ns0,
				''
			);
			ErrorCodeNode.addTextNode(
				(this.ErrorCode == null) ? '' : String.valueOf(this.ErrorCode)
			);
			Dom.XmlNode RequestIDNode = outerNode.addChildElement(
				'RequestID',
				s_ns0,
				''
			);
			RequestIDNode.addTextNode((this.RequestID == null) ? '' : this.RequestID);
			Dom.XmlNode ConversationIDNode = outerNode.addChildElement(
				'ConversationID',
				s_ns0,
				''
			);
			ConversationIDNode.addTextNode(
				(this.ConversationID == null) ? '' : this.ConversationID
			);
			Dom.XmlNode OverallStatusCodeNode = outerNode.addChildElement(
				'OverallStatusCode',
				s_ns0,
				''
			);
			OverallStatusCodeNode.addTextNode(
				(this.OverallStatusCode == null) ? '' : this.OverallStatusCode
			);
			Dom.XmlNode RequestTypeNode = outerNode.addChildElement(
				'RequestType',
				s_ns0,
				''
			);
			RequestTypeNode.addTextNode(
				(this.RequestType == null) ? '' : this.RequestType
			);
			Dom.XmlNode ResultTypeNode = outerNode.addChildElement(
				'ResultType',
				s_ns0,
				''
			);
			ResultTypeNode.addTextNode(
				(this.ResultType == null) ? '' : this.ResultType
			);
			Dom.XmlNode ResultDetailXMLNode = outerNode.addChildElement(
				'ResultDetailXML',
				s_ns0,
				''
			);
			ResultDetailXMLNode.addTextNode(
				(this.ResultDetailXML == null) ? '' : this.ResultDetailXML
			);
		}
	}

	//Extends http://exacttarget.com/wsdl/partnerAPI:APIObject
	public class ResultItem {
		public DateTime CreatedDate;
		public DateTime ModifiedDate;
		public Integer ID;
		public String ObjectID;
		public String CustomerKey;

		public String ObjectState;

		public String RequestID;
		public String ConversationID;
		public String StatusCode;
		public String StatusMessage;
		public Integer OrdinalID;
		public Integer ErrorCode;
		// Restriction enumeration: Synchronous, Asynchronous
		public String RequestType;
		public String RequestObjectType;

		public ResultItem() {
		}
		public ResultItem(DOM.XmlNode responseNode) {
			Set<DOM.XmlNode> nodesParsed = new Set<DOM.XmlNode>();
			DOM.XmlNode CreatedDateNode = responseNode.getChildElement(
				'CreatedDate',
				s_ns0
			);
			this.CreatedDate = (CreatedDateNode == null)
				? null
				: soapBaseObjects.parseDateTime(CreatedDateNode.getText());
			nodesParsed.add(CreatedDateNode);
			DOM.XmlNode ModifiedDateNode = responseNode.getChildElement(
				'ModifiedDate',
				s_ns0
			);
			this.ModifiedDate = (ModifiedDateNode == null ||
				ModifiedDateNode.getAttributeValue(
					'nil',
					'http://www.w3.org/2001/XMLSchema-instance'
				) == 'true')
				? null
				: soapBaseObjects.parseDateTime(ModifiedDateNode.getText());
			nodesParsed.add(ModifiedDateNode);
			DOM.XmlNode IDNode = responseNode.getChildElement('ID', s_ns0);
			this.ID = (IDNode == null) ? null : Integer.valueOf(IDNode.getText());
			nodesParsed.add(IDNode);
			DOM.XmlNode ObjectIDNode = responseNode.getChildElement(
				'ObjectID',
				s_ns0
			);
			this.ObjectID = (ObjectIDNode == null ||
				ObjectIDNode.getAttributeValue(
					'nil',
					'http://www.w3.org/2001/XMLSchema-instance'
				) == 'true')
				? null
				: ObjectIDNode.getText();
			nodesParsed.add(ObjectIDNode);
			DOM.XmlNode CustomerKeyNode = responseNode.getChildElement(
				'CustomerKey',
				s_ns0
			);
			this.CustomerKey = (CustomerKeyNode == null)
				? null
				: CustomerKeyNode.getText();
			nodesParsed.add(CustomerKeyNode);

			DOM.XmlNode ObjectStateNode = responseNode.getChildElement(
				'ObjectState',
				s_ns0
			);
			this.ObjectState = (ObjectStateNode == null)
				? null
				: ObjectStateNode.getText();
			nodesParsed.add(ObjectStateNode);
			DOM.XmlNode RequestIDNode = responseNode.getChildElement(
				'RequestID',
				s_ns0
			);
			this.RequestID = (RequestIDNode == null) ? null : RequestIDNode.getText();
			nodesParsed.add(RequestIDNode);
			DOM.XmlNode ConversationIDNode = responseNode.getChildElement(
				'ConversationID',
				s_ns0
			);
			this.ConversationID = (ConversationIDNode == null)
				? null
				: ConversationIDNode.getText();
			nodesParsed.add(ConversationIDNode);
			DOM.XmlNode StatusCodeNode = responseNode.getChildElement(
				'StatusCode',
				s_ns0
			);
			this.StatusCode = (StatusCodeNode == null)
				? null
				: StatusCodeNode.getText();
			nodesParsed.add(StatusCodeNode);
			DOM.XmlNode StatusMessageNode = responseNode.getChildElement(
				'StatusMessage',
				s_ns0
			);
			this.StatusMessage = (StatusMessageNode == null)
				? null
				: StatusMessageNode.getText();
			nodesParsed.add(StatusMessageNode);
			DOM.XmlNode OrdinalIDNode = responseNode.getChildElement(
				'OrdinalID',
				s_ns0
			);
			this.OrdinalID = (OrdinalIDNode == null)
				? null
				: Integer.valueOf(OrdinalIDNode.getText());
			nodesParsed.add(OrdinalIDNode);
			DOM.XmlNode ErrorCodeNode = responseNode.getChildElement(
				'ErrorCode',
				s_ns0
			);
			this.ErrorCode = (ErrorCodeNode == null)
				? null
				: Integer.valueOf(ErrorCodeNode.getText());
			nodesParsed.add(ErrorCodeNode);
			DOM.XmlNode RequestTypeNode = responseNode.getChildElement(
				'RequestType',
				s_ns0
			);
			this.RequestType = (RequestTypeNode == null)
				? null
				: RequestTypeNode.getText();
			nodesParsed.add(RequestTypeNode);
			DOM.XmlNode RequestObjectTypeNode = responseNode.getChildElement(
				'RequestObjectType',
				s_ns0
			);
			this.RequestObjectType = (RequestObjectTypeNode == null)
				? null
				: RequestObjectTypeNode.getText();
			nodesParsed.add(RequestObjectTypeNode);
		}
		public void populateXmlNode(Dom.XmlNode outerNode) {
			Dom.XmlNode CreatedDateNode = outerNode.addChildElement(
				'CreatedDate',
				s_ns0,
				''
			);
			CreatedDateNode.addTextNode(
				(this.CreatedDate == null) ? '' : String.valueOf(this.CreatedDate)
			);
			Dom.XmlNode ModifiedDateNode = outerNode.addChildElement(
				'ModifiedDate',
				s_ns0,
				''
			);
			ModifiedDateNode.addTextNode(
				(this.ModifiedDate == null) ? '' : String.valueOf(this.ModifiedDate)
			);
			Dom.XmlNode IDNode = outerNode.addChildElement('ID', s_ns0, '');
			IDNode.addTextNode((this.ID == null) ? '' : String.valueOf(this.ID));
			Dom.XmlNode ObjectIDNode = outerNode.addChildElement(
				'ObjectID',
				s_ns0,
				''
			);
			ObjectIDNode.addTextNode((this.ObjectID == null) ? '' : this.ObjectID);
			Dom.XmlNode CustomerKeyNode = outerNode.addChildElement(
				'CustomerKey',
				s_ns0,
				''
			);
			CustomerKeyNode.addTextNode(
				(this.CustomerKey == null) ? '' : this.CustomerKey
			);

			Dom.XmlNode ObjectStateNode = outerNode.addChildElement(
				'ObjectState',
				s_ns0,
				''
			);
			ObjectStateNode.addTextNode(
				(this.ObjectState == null) ? '' : this.ObjectState
			);
			Dom.XmlNode RequestIDNode = outerNode.addChildElement(
				'RequestID',
				s_ns0,
				''
			);
			RequestIDNode.addTextNode((this.RequestID == null) ? '' : this.RequestID);
			Dom.XmlNode ConversationIDNode = outerNode.addChildElement(
				'ConversationID',
				s_ns0,
				''
			);
			ConversationIDNode.addTextNode(
				(this.ConversationID == null) ? '' : this.ConversationID
			);
			Dom.XmlNode StatusCodeNode = outerNode.addChildElement(
				'StatusCode',
				s_ns0,
				''
			);
			if (this.StatusCode != null) {
				StatusCodeNode.addTextNode(this.StatusCode);
			}
			Dom.XmlNode StatusMessageNode = outerNode.addChildElement(
				'StatusMessage',
				s_ns0,
				''
			);
			if (this.StatusMessage != null) {
				StatusMessageNode.addTextNode(this.StatusMessage);
			}
			Dom.XmlNode OrdinalIDNode = outerNode.addChildElement(
				'OrdinalID',
				s_ns0,
				''
			);
			OrdinalIDNode.addTextNode(
				(this.OrdinalID == null) ? '' : String.valueOf(this.OrdinalID)
			);
			Dom.XmlNode ErrorCodeNode = outerNode.addChildElement(
				'ErrorCode',
				s_ns0,
				''
			);
			ErrorCodeNode.addTextNode(
				(this.ErrorCode == null) ? '' : String.valueOf(this.ErrorCode)
			);
			Dom.XmlNode RequestTypeNode = outerNode.addChildElement(
				'RequestType',
				s_ns0,
				''
			);
			RequestTypeNode.addTextNode(
				(this.RequestType == null) ? '' : this.RequestType
			);
			Dom.XmlNode RequestObjectTypeNode = outerNode.addChildElement(
				'RequestObjectType',
				s_ns0,
				''
			);
			RequestObjectTypeNode.addTextNode(
				(this.RequestObjectType == null) ? '' : this.RequestObjectType
			);
		}
	}

	//Extends http://exacttarget.com/wsdl/partnerAPI:APIObject
	public class ResultMessage {
		public DateTime CreatedDate;
		public DateTime ModifiedDate;
		public Integer ID;
		public String ObjectID;
		public String CustomerKey;

		public String ObjectState;

		public String RequestID;
		public String ConversationID;
		public String OverallStatusCode;
		public String StatusCode;
		public String StatusMessage;
		public Integer ErrorCode;
		// Restriction enumeration: Synchronous, Asynchronous
		public String RequestType;
		public String ResultType;
		public String ResultDetailXML;
		public Integer SequenceCode;
		public Integer CallsInConversation;

		public ResultMessage() {
		}
		public ResultMessage(DOM.XmlNode responseNode) {
			Set<DOM.XmlNode> nodesParsed = new Set<DOM.XmlNode>();
			DOM.XmlNode CreatedDateNode = responseNode.getChildElement(
				'CreatedDate',
				s_ns0
			);
			this.CreatedDate = (CreatedDateNode == null)
				? null
				: soapBaseObjects.parseDateTime(CreatedDateNode.getText());
			nodesParsed.add(CreatedDateNode);
			DOM.XmlNode ModifiedDateNode = responseNode.getChildElement(
				'ModifiedDate',
				s_ns0
			);
			this.ModifiedDate = (ModifiedDateNode == null ||
				ModifiedDateNode.getAttributeValue(
					'nil',
					'http://www.w3.org/2001/XMLSchema-instance'
				) == 'true')
				? null
				: soapBaseObjects.parseDateTime(ModifiedDateNode.getText());
			nodesParsed.add(ModifiedDateNode);
			DOM.XmlNode IDNode = responseNode.getChildElement('ID', s_ns0);
			this.ID = (IDNode == null) ? null : Integer.valueOf(IDNode.getText());
			nodesParsed.add(IDNode);
			DOM.XmlNode ObjectIDNode = responseNode.getChildElement(
				'ObjectID',
				s_ns0
			);
			this.ObjectID = (ObjectIDNode == null ||
				ObjectIDNode.getAttributeValue(
					'nil',
					'http://www.w3.org/2001/XMLSchema-instance'
				) == 'true')
				? null
				: ObjectIDNode.getText();
			nodesParsed.add(ObjectIDNode);
			DOM.XmlNode CustomerKeyNode = responseNode.getChildElement(
				'CustomerKey',
				s_ns0
			);
			this.CustomerKey = (CustomerKeyNode == null)
				? null
				: CustomerKeyNode.getText();
			nodesParsed.add(CustomerKeyNode);

			DOM.XmlNode ObjectStateNode = responseNode.getChildElement(
				'ObjectState',
				s_ns0
			);
			this.ObjectState = (ObjectStateNode == null)
				? null
				: ObjectStateNode.getText();
			nodesParsed.add(ObjectStateNode);
			DOM.XmlNode RequestIDNode = responseNode.getChildElement(
				'RequestID',
				s_ns0
			);
			this.RequestID = (RequestIDNode == null) ? null : RequestIDNode.getText();
			nodesParsed.add(RequestIDNode);
			DOM.XmlNode ConversationIDNode = responseNode.getChildElement(
				'ConversationID',
				s_ns0
			);
			this.ConversationID = (ConversationIDNode == null)
				? null
				: ConversationIDNode.getText();
			nodesParsed.add(ConversationIDNode);
			DOM.XmlNode OverallStatusCodeNode = responseNode.getChildElement(
				'OverallStatusCode',
				s_ns0
			);
			this.OverallStatusCode = (OverallStatusCodeNode == null)
				? null
				: OverallStatusCodeNode.getText();
			nodesParsed.add(OverallStatusCodeNode);
			DOM.XmlNode StatusCodeNode = responseNode.getChildElement(
				'StatusCode',
				s_ns0
			);
			this.StatusCode = (StatusCodeNode == null)
				? null
				: StatusCodeNode.getText();
			nodesParsed.add(StatusCodeNode);
			DOM.XmlNode StatusMessageNode = responseNode.getChildElement(
				'StatusMessage',
				s_ns0
			);
			this.StatusMessage = (StatusMessageNode == null)
				? null
				: StatusMessageNode.getText();
			nodesParsed.add(StatusMessageNode);
			DOM.XmlNode ErrorCodeNode = responseNode.getChildElement(
				'ErrorCode',
				s_ns0
			);
			this.ErrorCode = (ErrorCodeNode == null)
				? null
				: Integer.valueOf(ErrorCodeNode.getText());
			nodesParsed.add(ErrorCodeNode);
			DOM.XmlNode RequestTypeNode = responseNode.getChildElement(
				'RequestType',
				s_ns0
			);
			this.RequestType = (RequestTypeNode == null)
				? null
				: RequestTypeNode.getText();
			nodesParsed.add(RequestTypeNode);
			DOM.XmlNode ResultTypeNode = responseNode.getChildElement(
				'ResultType',
				s_ns0
			);
			this.ResultType = (ResultTypeNode == null)
				? null
				: ResultTypeNode.getText();
			nodesParsed.add(ResultTypeNode);
			DOM.XmlNode ResultDetailXMLNode = responseNode.getChildElement(
				'ResultDetailXML',
				s_ns0
			);
			this.ResultDetailXML = (ResultDetailXMLNode == null)
				? null
				: ResultDetailXMLNode.getText();
			nodesParsed.add(ResultDetailXMLNode);
			DOM.XmlNode SequenceCodeNode = responseNode.getChildElement(
				'SequenceCode',
				s_ns0
			);
			this.SequenceCode = (SequenceCodeNode == null)
				? null
				: Integer.valueOf(SequenceCodeNode.getText());
			nodesParsed.add(SequenceCodeNode);
			DOM.XmlNode CallsInConversationNode = responseNode.getChildElement(
				'CallsInConversation',
				s_ns0
			);
			this.CallsInConversation = (CallsInConversationNode == null)
				? null
				: Integer.valueOf(CallsInConversationNode.getText());
			nodesParsed.add(CallsInConversationNode);
		}
		public void populateXmlNode(Dom.XmlNode outerNode) {
			Dom.XmlNode CreatedDateNode = outerNode.addChildElement(
				'CreatedDate',
				s_ns0,
				''
			);
			CreatedDateNode.addTextNode(
				(this.CreatedDate == null) ? '' : String.valueOf(this.CreatedDate)
			);
			Dom.XmlNode ModifiedDateNode = outerNode.addChildElement(
				'ModifiedDate',
				s_ns0,
				''
			);
			ModifiedDateNode.addTextNode(
				(this.ModifiedDate == null) ? '' : String.valueOf(this.ModifiedDate)
			);
			Dom.XmlNode IDNode = outerNode.addChildElement('ID', s_ns0, '');
			IDNode.addTextNode((this.ID == null) ? '' : String.valueOf(this.ID));
			Dom.XmlNode ObjectIDNode = outerNode.addChildElement(
				'ObjectID',
				s_ns0,
				''
			);
			ObjectIDNode.addTextNode((this.ObjectID == null) ? '' : this.ObjectID);
			Dom.XmlNode CustomerKeyNode = outerNode.addChildElement(
				'CustomerKey',
				s_ns0,
				''
			);
			CustomerKeyNode.addTextNode(
				(this.CustomerKey == null) ? '' : this.CustomerKey
			);

			Dom.XmlNode ObjectStateNode = outerNode.addChildElement(
				'ObjectState',
				s_ns0,
				''
			);
			ObjectStateNode.addTextNode(
				(this.ObjectState == null) ? '' : this.ObjectState
			);
			Dom.XmlNode RequestIDNode = outerNode.addChildElement(
				'RequestID',
				s_ns0,
				''
			);
			RequestIDNode.addTextNode((this.RequestID == null) ? '' : this.RequestID);
			Dom.XmlNode ConversationIDNode = outerNode.addChildElement(
				'ConversationID',
				s_ns0,
				''
			);
			ConversationIDNode.addTextNode(
				(this.ConversationID == null) ? '' : this.ConversationID
			);
			Dom.XmlNode OverallStatusCodeNode = outerNode.addChildElement(
				'OverallStatusCode',
				s_ns0,
				''
			);
			OverallStatusCodeNode.addTextNode(
				(this.OverallStatusCode == null) ? '' : this.OverallStatusCode
			);
			Dom.XmlNode StatusCodeNode = outerNode.addChildElement(
				'StatusCode',
				s_ns0,
				''
			);
			StatusCodeNode.addTextNode(
				(this.StatusCode == null) ? '' : this.StatusCode
			);
			Dom.XmlNode StatusMessageNode = outerNode.addChildElement(
				'StatusMessage',
				s_ns0,
				''
			);
			StatusMessageNode.addTextNode(
				(this.StatusMessage == null) ? '' : this.StatusMessage
			);
			Dom.XmlNode ErrorCodeNode = outerNode.addChildElement(
				'ErrorCode',
				s_ns0,
				''
			);
			ErrorCodeNode.addTextNode(
				(this.ErrorCode == null) ? '' : String.valueOf(this.ErrorCode)
			);
			Dom.XmlNode RequestTypeNode = outerNode.addChildElement(
				'RequestType',
				s_ns0,
				''
			);
			RequestTypeNode.addTextNode(
				(this.RequestType == null) ? '' : this.RequestType
			);
			Dom.XmlNode ResultTypeNode = outerNode.addChildElement(
				'ResultType',
				s_ns0,
				''
			);
			ResultTypeNode.addTextNode(
				(this.ResultType == null) ? '' : this.ResultType
			);
			Dom.XmlNode ResultDetailXMLNode = outerNode.addChildElement(
				'ResultDetailXML',
				s_ns0,
				''
			);
			ResultDetailXMLNode.addTextNode(
				(this.ResultDetailXML == null) ? '' : this.ResultDetailXML
			);
			Dom.XmlNode SequenceCodeNode = outerNode.addChildElement(
				'SequenceCode',
				s_ns0,
				''
			);
			SequenceCodeNode.addTextNode(
				(this.SequenceCode == null) ? '' : String.valueOf(this.SequenceCode)
			);
			Dom.XmlNode CallsInConversationNode = outerNode.addChildElement(
				'CallsInConversation',
				s_ns0,
				''
			);
			CallsInConversationNode.addTextNode(
				(this.CallsInConversation == null)
					? ''
					: String.valueOf(this.CallsInConversation)
			);
		}
	}

	//Extends http://exacttarget.com/wsdl/partnerAPI:Options
	public class RetrieveOptions {
		public soapBaseObjects.ClientID Client;
		public soapBaseObjects.AsyncResponse[] SendResponseTo;
		public soapBaseObjects.Options_SaveOptions_element SaveOptions;
		public Integer Priority;
		public String ConversationID;
		public Integer SequenceCode;
		public Integer CallsInConversation;
		public DateTime ScheduledTime;
		// Restriction enumeration: Synchronous, Asynchronous
		public String RequestType;
		// Restriction enumeration: Low, Medium, High
		public String QueuePriority;

		public Integer BatchSize;
		public Boolean IncludeObjects;
		public Boolean OnlyIncludeBase;

		public RetrieveOptions() {
		}
		public RetrieveOptions(DOM.XmlNode responseNode) {
			Set<DOM.XmlNode> nodesParsed = new Set<DOM.XmlNode>();

			Dom.XmlNode[] SendResponseToChildren = responseNode.getChildElements();
			soapBaseObjects.AsyncResponse[] SendResponseToList = new List<soapBaseObjects.AsyncResponse>();
			if (
				SendResponseToChildren == null ||
				SendResponseToChildren.size() == 0
			) {
				this.SendResponseTo = null;
			} else {
				for (DOM.XmlNode childNode : SendResponseToChildren) {
					if (childNode.GetName() == 'SendResponseTo') {
						soapBaseObjects.AsyncResponse Obj = new soapBaseObjects.AsyncResponse(
							childNode
						);
						SendResponseToList.Add(Obj);
						nodesParsed.add(childNode);
					}
				}
				this.SendResponseTo = SendResponseToList;
			}
			DOM.XmlNode SaveOptionsNode = responseNode.getChildElement(
				'SaveOptions',
				s_ns0
			);
			if (SaveOptionsNode == null) {
				this.SaveOptions = null;
			} else {
				soapBaseObjects.Options_SaveOptions_element SaveOptionsObj = new soapBaseObjects.Options_SaveOptions_element(
					SaveOptionsNode
				);
				nodesParsed.add(SaveOptionsNode);
				this.SaveOptions = SaveOptionsObj;
			}
			DOM.XmlNode PriorityNode = responseNode.getChildElement(
				'Priority',
				s_ns0
			);
			this.Priority = (PriorityNode == null)
				? null
				: Integer.valueOf(PriorityNode.getText());
			nodesParsed.add(PriorityNode);
			DOM.XmlNode ConversationIDNode = responseNode.getChildElement(
				'ConversationID',
				s_ns0
			);
			this.ConversationID = (ConversationIDNode == null)
				? null
				: ConversationIDNode.getText();
			nodesParsed.add(ConversationIDNode);
			DOM.XmlNode SequenceCodeNode = responseNode.getChildElement(
				'SequenceCode',
				s_ns0
			);
			this.SequenceCode = (SequenceCodeNode == null)
				? null
				: Integer.valueOf(SequenceCodeNode.getText());
			nodesParsed.add(SequenceCodeNode);
			DOM.XmlNode CallsInConversationNode = responseNode.getChildElement(
				'CallsInConversation',
				s_ns0
			);
			this.CallsInConversation = (CallsInConversationNode == null)
				? null
				: Integer.valueOf(CallsInConversationNode.getText());
			nodesParsed.add(CallsInConversationNode);
			DOM.XmlNode ScheduledTimeNode = responseNode.getChildElement(
				'ScheduledTime',
				s_ns0
			);
			this.ScheduledTime = (ScheduledTimeNode == null)
				? null
				: soapBaseObjects.parseDateTime(ScheduledTimeNode.getText());
			nodesParsed.add(ScheduledTimeNode);
			DOM.XmlNode RequestTypeNode = responseNode.getChildElement(
				'RequestType',
				s_ns0
			);
			this.RequestType = (RequestTypeNode == null)
				? null
				: RequestTypeNode.getText();
			nodesParsed.add(RequestTypeNode);
			DOM.XmlNode QueuePriorityNode = responseNode.getChildElement(
				'QueuePriority',
				s_ns0
			);
			this.QueuePriority = (QueuePriorityNode == null)
				? null
				: QueuePriorityNode.getText();
			nodesParsed.add(QueuePriorityNode);
			DOM.XmlNode BatchSizeNode = responseNode.getChildElement(
				'BatchSize',
				s_ns0
			);
			this.BatchSize = (BatchSizeNode == null)
				? null
				: Integer.valueOf(BatchSizeNode.getText());
			nodesParsed.add(BatchSizeNode);
			DOM.XmlNode IncludeObjectsNode = responseNode.getChildElement(
				'IncludeObjects',
				s_ns0
			);
			this.IncludeObjects = (IncludeObjectsNode == null)
				? null
				: Boolean.valueOf(IncludeObjectsNode.getText());
			nodesParsed.add(IncludeObjectsNode);
			DOM.XmlNode OnlyIncludeBaseNode = responseNode.getChildElement(
				'OnlyIncludeBase',
				s_ns0
			);
			this.OnlyIncludeBase = (OnlyIncludeBaseNode == null)
				? null
				: Boolean.valueOf(OnlyIncludeBaseNode.getText());
			nodesParsed.add(OnlyIncludeBaseNode);
		}
		public void populateXmlNode(Dom.XmlNode outerNode) {
			soapBaseObjects.ClientID ClientObj = this.Client;
			Dom.XmlNode ClientNode = outerNode.addChildElement('Client', s_ns0, '');
			if (ClientObj != null) {
				ClientObj.populateXmlNode(ClientNode);
			}

			soapBaseObjects.AsyncResponse[] SendResponseToObj = this.SendResponseTo;
			if (SendResponseToObj != null) {
				for (soapBaseObjects.AsyncResponse element : SendResponseToObj) {
					Dom.XmlNode SendResponseToNode = outerNode.addChildElement(
						'SendResponseTo',
						s_ns0,
						''
					);
					element.populateXmlNode(SendResponseToNode);
				}
			}

			soapBaseObjects.Options_SaveOptions_element SaveOptionsObj = this.SaveOptions;
			Dom.XmlNode SaveOptionsNode = outerNode.addChildElement(
				'SaveOptions',
				s_ns0,
				''
			);
			if (SaveOptionsObj != null) {
				SaveOptionsObj.populateXmlNode(SaveOptionsNode);
			}
			Dom.XmlNode PriorityNode = outerNode.addChildElement(
				'Priority',
				s_ns0,
				''
			);
			PriorityNode.addTextNode(
				(this.Priority == null) ? '' : String.valueOf(this.Priority)
			);
			Dom.XmlNode ConversationIDNode = outerNode.addChildElement(
				'ConversationID',
				s_ns0,
				''
			);
			ConversationIDNode.addTextNode(
				(this.ConversationID == null) ? '' : this.ConversationID
			);
			Dom.XmlNode SequenceCodeNode = outerNode.addChildElement(
				'SequenceCode',
				s_ns0,
				''
			);
			SequenceCodeNode.addTextNode(
				(this.SequenceCode == null) ? '' : String.valueOf(this.SequenceCode)
			);
			Dom.XmlNode CallsInConversationNode = outerNode.addChildElement(
				'CallsInConversation',
				s_ns0,
				''
			);
			CallsInConversationNode.addTextNode(
				(this.CallsInConversation == null)
					? ''
					: String.valueOf(this.CallsInConversation)
			);
			Dom.XmlNode ScheduledTimeNode = outerNode.addChildElement(
				'ScheduledTime',
				s_ns0,
				''
			);
			ScheduledTimeNode.addTextNode(
				(this.ScheduledTime == null) ? '' : String.valueOf(this.ScheduledTime)
			);
			Dom.XmlNode RequestTypeNode = outerNode.addChildElement(
				'RequestType',
				s_ns0,
				''
			);
			RequestTypeNode.addTextNode(
				(this.RequestType == null) ? '' : this.RequestType
			);
			Dom.XmlNode QueuePriorityNode = outerNode.addChildElement(
				'QueuePriority',
				s_ns0,
				''
			);
			QueuePriorityNode.addTextNode(
				(this.QueuePriority == null) ? '' : this.QueuePriority
			);
			Dom.XmlNode BatchSizeNode = outerNode.addChildElement(
				'BatchSize',
				s_ns0,
				''
			);
			BatchSizeNode.addTextNode(
				(this.BatchSize == null) ? '' : String.valueOf(this.BatchSize)
			);
			Dom.XmlNode IncludeObjectsNode = outerNode.addChildElement(
				'IncludeObjects',
				s_ns0,
				''
			);
			IncludeObjectsNode.addTextNode(
				(this.IncludeObjects == null) ? '' : String.valueOf(this.IncludeObjects)
			);
			Dom.XmlNode OnlyIncludeBaseNode = outerNode.addChildElement(
				'OnlyIncludeBase',
				s_ns0,
				''
			);
			OnlyIncludeBaseNode.addTextNode(
				(this.OnlyIncludeBase == null)
					? ''
					: String.valueOf(this.OnlyIncludeBase)
			);
		}
	}
	public class RetrieveRequest {
		public soapBaseObjects.ClientID[] ClientIDs;
		public String ObjectType;
		public String[] Properties;
		public soapBaseObjects.FilterPart Filter;
		public soapBaseObjects.AsyncResponse[] RespondTo;

		public String ContinueRequest;
		public Boolean QueryAllAccounts;
		public Boolean RetrieveAllSinceLastBatch;
		public Boolean RepeatLastResult;
		public soapBaseObjects.RetrieveRequest_Retrieves_element Retrieves;
		public soapBaseObjects.RetrieveOptions Options;

		public RetrieveRequest() {
		}
		public RetrieveRequest(DOM.XmlNode responseNode) {
			Set<DOM.XmlNode> nodesParsed = new Set<DOM.XmlNode>();
			Dom.XmlNode[] ClientIDsChildren = responseNode.getChildElements();
			soapBaseObjects.ClientID[] ClientIDsList = new List<soapBaseObjects.ClientID>();
			if (ClientIDsChildren == null || ClientIDsChildren.size() == 0) {
				this.ClientIDs = null;
			} else {
				for (DOM.XmlNode childNode : ClientIDsChildren) {
					if (childNode.GetName() == 'ClientIDs') {
						soapBaseObjects.ClientID Obj = new soapBaseObjects.ClientID(
							childNode
						);
						ClientIDsList.Add(Obj);
						nodesParsed.add(childNode);
					}
				}
				this.ClientIDs = ClientIDsList;
			}
			DOM.XmlNode ObjectTypeNode = responseNode.getChildElement(
				'ObjectType',
				s_ns0
			);
			this.ObjectType = (ObjectTypeNode == null)
				? null
				: ObjectTypeNode.getText();
			nodesParsed.add(ObjectTypeNode);
			String[] PropertiesList = new List<String>();
			if (responseNode.getChildElements() == null) {
				this.Properties = null;
			} else {
				for (DOM.XmlNode childNode : responseNode.getChildElements()) {
					if (childNode.GetName() == 'Properties') {
						PropertiesList.Add(
							(childNode == null ||
								childNode.getAttributeValue(
									'nil',
									'http://www.w3.org/2001/XMLSchema-instance'
								) == 'true')
								? null
								: String.valueOf(childNode.getText())
						);
						nodesParsed.add(childNode);
					}
				}
				this.Properties = PropertiesList;
			}
			DOM.XmlNode FilterNode = responseNode.getChildElement('Filter', s_ns0);
			if (FilterNode == null) {
				this.Filter = null;
			} else {
				soapBaseObjects.FilterPart FilterObj = new soapBaseObjects.FilterPart(
					FilterNode
				);
				nodesParsed.add(FilterNode);
				this.Filter = FilterObj;
			}
			Dom.XmlNode[] RespondToChildren = responseNode.getChildElements();
			soapBaseObjects.AsyncResponse[] RespondToList = new List<soapBaseObjects.AsyncResponse>();
			if (RespondToChildren == null || RespondToChildren.size() == 0) {
				this.RespondTo = null;
			} else {
				for (DOM.XmlNode childNode : RespondToChildren) {
					if (childNode.GetName() == 'RespondTo') {
						soapBaseObjects.AsyncResponse Obj = new soapBaseObjects.AsyncResponse(
							childNode
						);
						RespondToList.Add(Obj);
						nodesParsed.add(childNode);
					}
				}
				this.RespondTo = RespondToList;
			}
			DOM.XmlNode ContinueRequestNode = responseNode.getChildElement(
				'ContinueRequest',
				s_ns0
			);
			this.ContinueRequest = (ContinueRequestNode == null)
				? null
				: ContinueRequestNode.getText();
			nodesParsed.add(ContinueRequestNode);
			DOM.XmlNode QueryAllAccountsNode = responseNode.getChildElement(
				'QueryAllAccounts',
				s_ns0
			);
			this.QueryAllAccounts = (QueryAllAccountsNode == null)
				? null
				: Boolean.valueOf(QueryAllAccountsNode.getText());
			nodesParsed.add(QueryAllAccountsNode);
			DOM.XmlNode RetrieveAllSinceLastBatchNode = responseNode.getChildElement(
				'RetrieveAllSinceLastBatch',
				s_ns0
			);
			this.RetrieveAllSinceLastBatch = (RetrieveAllSinceLastBatchNode == null)
				? null
				: Boolean.valueOf(RetrieveAllSinceLastBatchNode.getText());
			nodesParsed.add(RetrieveAllSinceLastBatchNode);
			DOM.XmlNode RepeatLastResultNode = responseNode.getChildElement(
				'RepeatLastResult',
				s_ns0
			);
			this.RepeatLastResult = (RepeatLastResultNode == null)
				? null
				: Boolean.valueOf(RepeatLastResultNode.getText());
			nodesParsed.add(RepeatLastResultNode);
			DOM.XmlNode RetrievesNode = responseNode.getChildElement(
				'Retrieves',
				s_ns0
			);
			if (RetrievesNode == null) {
				this.Retrieves = null;
			} else {
				soapBaseObjects.RetrieveRequest_Retrieves_element RetrievesObj = new soapBaseObjects.RetrieveRequest_Retrieves_element(
					RetrievesNode
				);
				nodesParsed.add(RetrievesNode);
				this.Retrieves = RetrievesObj;
			}
			DOM.XmlNode OptionsNode = responseNode.getChildElement('Options', s_ns0);
			if (OptionsNode == null) {
				this.Options = null;
			} else {
				soapBaseObjects.RetrieveOptions OptionsObj = new soapBaseObjects.RetrieveOptions(
					OptionsNode
				);
				nodesParsed.add(OptionsNode);
				this.Options = OptionsObj;
			}
		}
		public void populateXmlNode(Dom.XmlNode outerNode) {
			soapBaseObjects.ClientID[] ClientIDsObj = this.ClientIDs;
			if (ClientIDsObj != null) {
				for (soapBaseObjects.ClientID element : ClientIDsObj) {
					Dom.XmlNode ClientIDsNode = outerNode.addChildElement(
						'ClientIDs',
						s_ns0,
						''
					);
					element.populateXmlNode(ClientIDsNode);
				}
			}
			Dom.XmlNode ObjectTypeNode = outerNode.addChildElement(
				'ObjectType',
				s_ns0,
				''
			);
			if (this.ObjectType != null) {
				ObjectTypeNode.addTextNode(this.ObjectType);
			}
			if (this.Properties != null) {
				for (String element : this.Properties) {
					Dom.XmlNode PropertiesNode = outerNode.addChildElement(
						'Properties',
						s_ns0,
						''
					);
					PropertiesNode.addTextNode(String.valueOf(element));
				}
			}

			if (this.Filter != null) {
				Dom.XmlNode FilterNode = outerNode.addChildElement('Filter', s_ns0, '');
				this.Filter.populateXmlNode(FilterNode);
			}

			soapBaseObjects.AsyncResponse[] RespondToObj = this.RespondTo;
			if (RespondToObj != null) {
				for (soapBaseObjects.AsyncResponse element : RespondToObj) {
					Dom.XmlNode RespondToNode = outerNode.addChildElement(
						'RespondTo',
						s_ns0,
						''
					);
					element.populateXmlNode(RespondToNode);
				}
			}
			if (this.ContinueRequest != null) {
				Dom.XmlNode ContinueRequestNode = outerNode.addChildElement(
					'ContinueRequest',
					s_ns0,
					''
				);
				ContinueRequestNode.addTextNode(this.ContinueRequest);
			}

			if (this.QueryAllAccounts != null) {
				Dom.XmlNode QueryAllAccountsNode = outerNode.addChildElement(
					'QueryAllAccounts',
					s_ns0,
					''
				);
				QueryAllAccountsNode.addTextNode(String.valueOf(this.QueryAllAccounts));
			}
			if (this.RetrieveAllSinceLastBatch != null) {
				Dom.XmlNode RetrieveAllSinceLastBatchNode = outerNode.addChildElement(
					'RetrieveAllSinceLastBatch',
					s_ns0,
					''
				);
				RetrieveAllSinceLastBatchNode.addTextNode(
					String.valueOf(this.RetrieveAllSinceLastBatch)
				);
			}

			if (this.RepeatLastResult != null) {
				Dom.XmlNode RepeatLastResultNode = outerNode.addChildElement(
					'RepeatLastResult',
					s_ns0,
					''
				);
				RepeatLastResultNode.addTextNode(String.valueOf(this.RepeatLastResult));
			}

			if (this.Retrieves != null) {
				Dom.XmlNode RetrievesNode = outerNode.addChildElement(
					'Retrieves',
					s_ns0,
					''
				);
				this.Retrieves.populateXmlNode(RetrievesNode);
			}

			if (this.Options != null) {
				Dom.XmlNode OptionsNode = outerNode.addChildElement(
					'Options',
					s_ns0,
					''
				);
				this.Options.populateXmlNode(OptionsNode);
			}
		}
	}
	public class RetrieveRequest_Retrieves_element {
		public soapBaseObjects.Request[] Request;

		public RetrieveRequest_Retrieves_element() {
		}
		public RetrieveRequest_Retrieves_element(DOM.XmlNode responseNode) {
			Set<DOM.XmlNode> nodesParsed = new Set<DOM.XmlNode>();
			Dom.XmlNode[] RequestChildren = responseNode.getChildElements();
			soapBaseObjects.Request[] RequestList = new List<soapBaseObjects.Request>();
			if (RequestChildren == null || RequestChildren.size() == 0) {
				this.Request = null;
			} else {
				for (DOM.XmlNode childNode : RequestChildren) {
					if (childNode.GetName() == 'Request') {
						soapBaseObjects.Request Obj = new soapBaseObjects.Request(
							childNode
						);
						RequestList.Add(Obj);
						nodesParsed.add(childNode);
					}
				}
				this.Request = RequestList;
			}
		}
		public void populateXmlNode(Dom.XmlNode outerNode) {
			soapBaseObjects.Request[] RequestObj = this.Request;
			if (RequestObj != null) {
				for (soapBaseObjects.Request element : RequestObj) {
					Dom.XmlNode RequestNode = outerNode.addChildElement(
						'Request',
						s_ns0,
						''
					);
					element.populateXmlNode(RequestNode);
				}
			}
		}
	}
	public class RetrieveRequestMsg_element {
		public soapBaseObjects.RetrieveRequest RetrieveRequest;

		public RetrieveRequestMsg_element() {
		}
		public RetrieveRequestMsg_element(
			soapBaseObjects.RetrieveRequest RetrieveRequest
		) {
			this.RetrieveRequest = RetrieveRequest;
		}
		public void populateXmlNode(Dom.XmlNode outerNode) {
			soapBaseObjects.RetrieveRequest RetrieveRequestObj = this.RetrieveRequest;
			Dom.XmlNode RetrieveRequestNode = outerNode.addChildElement(
				'RetrieveRequest',
				s_ns0,
				''
			);
			if (RetrieveRequestObj != null) {
				RetrieveRequestObj.populateXmlNode(RetrieveRequestNode);
			}
		}
	}
	public class RetrieveResponseMsg_element {
		public String OverallStatus;
		public String RequestID;
		public Dom.XmlNode[] Results;
		// public soapBaseObjects.APIObject[] Results;

		public RetrieveResponseMsg_element() {
		}
		public RetrieveResponseMsg_element(DOM.XmlNode responseNode) {
			Set<DOM.XmlNode> nodesParsed = new Set<DOM.XmlNode>();

			DOM.XmlNode OverallStatusNode = responseNode.getChildElement(
				'OverallStatus',
				s_ns0
			);
			this.OverallStatus = (OverallStatusNode == null)
				? null
				: OverallStatusNode.getText();
			nodesParsed.add(OverallStatusNode);
			DOM.XmlNode RequestIDNode = responseNode.getChildElement(
				'RequestID',
				s_ns0
			);
			this.RequestID = (RequestIDNode == null) ? null : RequestIDNode.getText();
			nodesParsed.add(RequestIDNode);
			this.Results = responseNode.getChildElements();
			// Dom.XmlNode[] ResultsChildren = responseNode.getChildElements();
			// soapBaseObjects.APIObject[] ResultsList = new List<soapBaseObjects.APIObject>();
			// if (ResultsChildren == null || ResultsChildren.size() == 0) {
			// 	this.Results = null;
			// } else {
			// 	for (DOM.XmlNode childNode : ResultsChildren) {
			// 		if (childNode.GetName() == 'Results') {
			// 			soapBaseObjects.APIObject Obj = new soapBaseObjects.APIObject(
			// 				childNode
			// 			);
			// 			ResultsList.Add(Obj);
			// 			nodesParsed.add(childNode);
			// 		}
			// 	}
			// 	this.Results = ResultsList;
			// }
		}
	}

	public class SaveOption {
		public String PropertyName;
		// Restriction enumeration: AddOnly, Default, Nothing, UpdateAdd, UpdateOnly, Delete
		public String SaveAction;
		public Boolean TrackChanges;

		public SaveOption() {
		}
		public SaveOption(DOM.XmlNode responseNode) {
			Set<DOM.XmlNode> nodesParsed = new Set<DOM.XmlNode>();
			DOM.XmlNode PropertyNameNode = responseNode.getChildElement(
				'PropertyName',
				s_ns0
			);
			this.PropertyName = (PropertyNameNode == null)
				? null
				: PropertyNameNode.getText();
			nodesParsed.add(PropertyNameNode);
			DOM.XmlNode SaveActionNode = responseNode.getChildElement(
				'SaveAction',
				s_ns0
			);
			this.SaveAction = (SaveActionNode == null)
				? null
				: SaveActionNode.getText();
			nodesParsed.add(SaveActionNode);
			DOM.XmlNode TrackChangesNode = responseNode.getChildElement(
				'TrackChanges',
				s_ns0
			);
			this.TrackChanges = (TrackChangesNode == null)
				? null
				: Boolean.valueOf(TrackChangesNode.getText());
			nodesParsed.add(TrackChangesNode);
		}
		public void populateXmlNode(Dom.XmlNode outerNode) {
			Dom.XmlNode PropertyNameNode = outerNode.addChildElement(
				'PropertyName',
				s_ns0,
				''
			);
			if (this.PropertyName != null) {
				PropertyNameNode.addTextNode(this.PropertyName);
			}
			Dom.XmlNode SaveActionNode = outerNode.addChildElement(
				'SaveAction',
				s_ns0,
				''
			);
			if (this.SaveAction != null) {
				SaveActionNode.addTextNode(this.SaveAction);
			}
			Dom.XmlNode TrackChangesNode = outerNode.addChildElement(
				'TrackChanges',
				s_ns0,
				''
			);
			TrackChangesNode.addTextNode(
				(this.TrackChanges == null) ? '' : String.valueOf(this.TrackChanges)
			);
		}
	}
	public class APIObject {
		public DateTime CreatedDate;
		public DateTime ModifiedDate;
		public Integer ID;
		public String ObjectID;
		public String CustomerKey;
		public String ObjectState;

		public APIObject() {
		}
		public APIObject(DOM.XmlNode responseNode) {
			Set<DOM.XmlNode> nodesParsed = new Set<DOM.XmlNode>();
			DOM.XmlNode CreatedDateNode = responseNode.getChildElement(
				'CreatedDate',
				s_ns0
			);
			this.CreatedDate = (CreatedDateNode == null)
				? null
				: soapBaseObjects.parseDateTime(CreatedDateNode.getText());
			nodesParsed.add(CreatedDateNode);
			DOM.XmlNode ModifiedDateNode = responseNode.getChildElement(
				'ModifiedDate',
				s_ns0
			);
			this.ModifiedDate = (ModifiedDateNode == null ||
				ModifiedDateNode.getAttributeValue(
					'nil',
					'http://www.w3.org/2001/XMLSchema-instance'
				) == 'true')
				? null
				: soapBaseObjects.parseDateTime(ModifiedDateNode.getText());
			nodesParsed.add(ModifiedDateNode);
			DOM.XmlNode IDNode = responseNode.getChildElement('ID', s_ns0);
			this.ID = (IDNode == null) ? null : Integer.valueOf(IDNode.getText());
			nodesParsed.add(IDNode);
			DOM.XmlNode ObjectIDNode = responseNode.getChildElement(
				'ObjectID',
				s_ns0
			);
			this.ObjectID = (ObjectIDNode == null ||
				ObjectIDNode.getAttributeValue(
					'nil',
					'http://www.w3.org/2001/XMLSchema-instance'
				) == 'true')
				? null
				: ObjectIDNode.getText();
			nodesParsed.add(ObjectIDNode);
			DOM.XmlNode CustomerKeyNode = responseNode.getChildElement(
				'CustomerKey',
				s_ns0
			);
			this.CustomerKey = (CustomerKeyNode == null)
				? null
				: CustomerKeyNode.getText();
			nodesParsed.add(CustomerKeyNode);

			DOM.XmlNode ObjectStateNode = responseNode.getChildElement(
				'ObjectState',
				s_ns0
			);
			this.ObjectState = (ObjectStateNode == null)
				? null
				: ObjectStateNode.getText();
			nodesParsed.add(ObjectStateNode);
		}
		public void populateXmlNode(Dom.XmlNode outerNode) {
			Dom.XmlNode CreatedDateNode = outerNode.addChildElement(
				'CreatedDate',
				s_ns0,
				''
			);
			CreatedDateNode.addTextNode(
				(this.CreatedDate == null) ? '' : String.valueOf(this.CreatedDate)
			);
			Dom.XmlNode ModifiedDateNode = outerNode.addChildElement(
				'ModifiedDate',
				s_ns0,
				''
			);
			ModifiedDateNode.addTextNode(
				(this.ModifiedDate == null) ? '' : String.valueOf(this.ModifiedDate)
			);
			Dom.XmlNode IDNode = outerNode.addChildElement('ID', s_ns0, '');
			IDNode.addTextNode((this.ID == null) ? '' : String.valueOf(this.ID));
			Dom.XmlNode ObjectIDNode = outerNode.addChildElement(
				'ObjectID',
				s_ns0,
				''
			);
			ObjectIDNode.addTextNode((this.ObjectID == null) ? '' : this.ObjectID);
			Dom.XmlNode CustomerKeyNode = outerNode.addChildElement(
				'CustomerKey',
				s_ns0,
				''
			);
			CustomerKeyNode.addTextNode(
				(this.CustomerKey == null) ? '' : this.CustomerKey
			);

			Dom.XmlNode ObjectStateNode = outerNode.addChildElement(
				'ObjectState',
				s_ns0,
				''
			);
			ObjectStateNode.addTextNode(
				(this.ObjectState == null) ? '' : this.ObjectState
			);
		}
	}
	public class APIProperty {
		public String Name;
		public String Value;

		public APIProperty() {
		}
		public APIProperty(DOM.XmlNode responseNode) {
			Set<DOM.XmlNode> nodesParsed = new Set<DOM.XmlNode>();
			DOM.XmlNode NameNode = responseNode.getChildElement('Name', s_ns0);
			this.Name = (NameNode == null) ? null : NameNode.getText();
			nodesParsed.add(NameNode);
			DOM.XmlNode ValueNode = responseNode.getChildElement('Value', s_ns0);
			this.Value = (ValueNode == null) ? null : ValueNode.getText();
			nodesParsed.add(ValueNode);
		}
		public void populateXmlNode(Dom.XmlNode outerNode) {
			Dom.XmlNode NameNode = outerNode.addChildElement('Name', s_ns0, '');
			if (this.Name != null) {
				NameNode.addTextNode(this.Name);
			}
			Dom.XmlNode ValueNode = outerNode.addChildElement('Value', s_ns0, '');
			if (this.Value != null) {
				ValueNode.addTextNode(this.Value);
			}
		}
	}

	public class ClientID {
		public Integer ClientID;
		public Integer ID;
		public String PartnerClientKey;
		public Integer UserID;
		public String PartnerUserKey;
		public Integer CreatedBy;
		public Integer ModifiedBy;
		public Long EnterpriseID;
		public String CustomerKey;
		public String CustomerID;

		public ClientID() {
		}
		public ClientID(DOM.XmlNode responseNode) {
			Set<DOM.XmlNode> nodesParsed = new Set<DOM.XmlNode>();
			DOM.XmlNode ClientIDNode = responseNode.getChildElement(
				'ClientID',
				s_ns0
			);
			this.ClientID = (ClientIDNode == null)
				? null
				: Integer.valueOf(ClientIDNode.getText());
			nodesParsed.add(ClientIDNode);
			DOM.XmlNode IDNode = responseNode.getChildElement('ID', s_ns0);
			this.ID = (IDNode == null) ? null : Integer.valueOf(IDNode.getText());
			nodesParsed.add(IDNode);
			DOM.XmlNode PartnerClientKeyNode = responseNode.getChildElement(
				'PartnerClientKey',
				s_ns0
			);
			this.PartnerClientKey = (PartnerClientKeyNode == null)
				? null
				: PartnerClientKeyNode.getText();
			nodesParsed.add(PartnerClientKeyNode);
			DOM.XmlNode UserIDNode = responseNode.getChildElement('UserID', s_ns0);
			this.UserID = (UserIDNode == null)
				? null
				: Integer.valueOf(UserIDNode.getText());
			nodesParsed.add(UserIDNode);
			DOM.XmlNode PartnerUserKeyNode = responseNode.getChildElement(
				'PartnerUserKey',
				s_ns0
			);
			this.PartnerUserKey = (PartnerUserKeyNode == null)
				? null
				: PartnerUserKeyNode.getText();
			nodesParsed.add(PartnerUserKeyNode);
			DOM.XmlNode CreatedByNode = responseNode.getChildElement(
				'CreatedBy',
				s_ns0
			);
			this.CreatedBy = (CreatedByNode == null)
				? null
				: Integer.valueOf(CreatedByNode.getText());
			nodesParsed.add(CreatedByNode);
			DOM.XmlNode ModifiedByNode = responseNode.getChildElement(
				'ModifiedBy',
				s_ns0
			);
			this.ModifiedBy = (ModifiedByNode == null)
				? null
				: Integer.valueOf(ModifiedByNode.getText());
			nodesParsed.add(ModifiedByNode);
			DOM.XmlNode EnterpriseIDNode = responseNode.getChildElement(
				'EnterpriseID',
				s_ns0
			);
			this.EnterpriseID = (EnterpriseIDNode == null)
				? null
				: Long.valueOf(EnterpriseIDNode.getText());
			nodesParsed.add(EnterpriseIDNode);
			DOM.XmlNode CustomerKeyNode = responseNode.getChildElement(
				'CustomerKey',
				s_ns0
			);
			this.CustomerKey = (CustomerKeyNode == null)
				? null
				: CustomerKeyNode.getText();
			nodesParsed.add(CustomerKeyNode);
			DOM.XmlNode CustomerIDNode = responseNode.getChildElement(
				'CustomerID',
				s_ns0
			);
			this.CustomerID = (CustomerIDNode == null)
				? null
				: CustomerIDNode.getText();
			nodesParsed.add(CustomerIDNode);
		}
		public void populateXmlNode(Dom.XmlNode outerNode) {
			Dom.XmlNode ClientIDNode = outerNode.addChildElement(
				'ClientID',
				s_ns0,
				''
			);
			ClientIDNode.addTextNode(
				(this.ClientID == null) ? '' : String.valueOf(this.ClientID)
			);
			Dom.XmlNode IDNode = outerNode.addChildElement('ID', s_ns0, '');
			IDNode.addTextNode((this.ID == null) ? '' : String.valueOf(this.ID));
			Dom.XmlNode PartnerClientKeyNode = outerNode.addChildElement(
				'PartnerClientKey',
				s_ns0,
				''
			);
			PartnerClientKeyNode.addTextNode(
				(this.PartnerClientKey == null) ? '' : this.PartnerClientKey
			);
			Dom.XmlNode UserIDNode = outerNode.addChildElement('UserID', s_ns0, '');
			UserIDNode.addTextNode(
				(this.UserID == null) ? '' : String.valueOf(this.UserID)
			);
			Dom.XmlNode PartnerUserKeyNode = outerNode.addChildElement(
				'PartnerUserKey',
				s_ns0,
				''
			);
			PartnerUserKeyNode.addTextNode(
				(this.PartnerUserKey == null) ? '' : this.PartnerUserKey
			);
			Dom.XmlNode CreatedByNode = outerNode.addChildElement(
				'CreatedBy',
				s_ns0,
				''
			);
			CreatedByNode.addTextNode(
				(this.CreatedBy == null) ? '' : String.valueOf(this.CreatedBy)
			);
			Dom.XmlNode ModifiedByNode = outerNode.addChildElement(
				'ModifiedBy',
				s_ns0,
				''
			);
			ModifiedByNode.addTextNode(
				(this.ModifiedBy == null) ? '' : String.valueOf(this.ModifiedBy)
			);
			Dom.XmlNode EnterpriseIDNode = outerNode.addChildElement(
				'EnterpriseID',
				s_ns0,
				''
			);
			EnterpriseIDNode.addTextNode(
				(this.EnterpriseID == null) ? '' : String.valueOf(this.EnterpriseID)
			);
			Dom.XmlNode CustomerKeyNode = outerNode.addChildElement(
				'CustomerKey',
				s_ns0,
				''
			);
			CustomerKeyNode.addTextNode(
				(this.CustomerKey == null) ? '' : this.CustomerKey
			);
			Dom.XmlNode CustomerIDNode = outerNode.addChildElement(
				'CustomerID',
				s_ns0,
				''
			);
			CustomerIDNode.addTextNode(
				(this.CustomerID == null) ? '' : this.CustomerID
			);
		}
	}

	//Extends http://exacttarget.com/wsdl/partnerAPI:FilterPart
	public class ComplexFilterPart {
		public soapBaseObjects.FilterPart LeftOperand;
		// Restriction enumeration: OR, AND
		public String LogicalOperator;
		public soapBaseObjects.FilterPart RightOperand;
		public soapBaseObjects.ComplexFilterPart_AdditionalOperands_element AdditionalOperands;

		public ComplexFilterPart() {
		}
		public ComplexFilterPart(DOM.XmlNode responseNode) {
			Set<DOM.XmlNode> nodesParsed = new Set<DOM.XmlNode>();
			DOM.XmlNode LeftOperandNode = responseNode.getChildElement(
				'LeftOperand',
				s_ns0
			);
			if (LeftOperandNode == null) {
				this.LeftOperand = null;
			} else {
				soapBaseObjects.FilterPart LeftOperandObj = new soapBaseObjects.FilterPart(
					LeftOperandNode
				);
				nodesParsed.add(LeftOperandNode);
				this.LeftOperand = LeftOperandObj;
			}
			DOM.XmlNode LogicalOperatorNode = responseNode.getChildElement(
				'LogicalOperator',
				s_ns0
			);
			this.LogicalOperator = (LogicalOperatorNode == null)
				? null
				: LogicalOperatorNode.getText();
			nodesParsed.add(LogicalOperatorNode);
			DOM.XmlNode RightOperandNode = responseNode.getChildElement(
				'RightOperand',
				s_ns0
			);
			if (RightOperandNode == null) {
				this.RightOperand = null;
			} else {
				soapBaseObjects.FilterPart RightOperandObj = new soapBaseObjects.FilterPart(
					RightOperandNode
				);
				nodesParsed.add(RightOperandNode);
				this.RightOperand = RightOperandObj;
			}
			DOM.XmlNode AdditionalOperandsNode = responseNode.getChildElement(
				'AdditionalOperands',
				s_ns0
			);
			if (AdditionalOperandsNode == null) {
				this.AdditionalOperands = null;
			} else {
				soapBaseObjects.ComplexFilterPart_AdditionalOperands_element AdditionalOperandsObj = new soapBaseObjects.ComplexFilterPart_AdditionalOperands_element(
					AdditionalOperandsNode
				);
				nodesParsed.add(AdditionalOperandsNode);
				this.AdditionalOperands = AdditionalOperandsObj;
			}
		}
		public void populateXmlNode(Dom.XmlNode outerNode) {
			soapBaseObjects.FilterPart LeftOperandObj = this.LeftOperand;
			Dom.XmlNode LeftOperandNode = outerNode.addChildElement(
				'LeftOperand',
				s_ns0,
				''
			);
			if (LeftOperandObj != null) {
				LeftOperandObj.populateXmlNode(LeftOperandNode);
			}
			Dom.XmlNode LogicalOperatorNode = outerNode.addChildElement(
				'LogicalOperator',
				s_ns0,
				''
			);
			if (this.LogicalOperator != null) {
				LogicalOperatorNode.addTextNode(this.LogicalOperator);
			}

			soapBaseObjects.FilterPart RightOperandObj = this.RightOperand;
			Dom.XmlNode RightOperandNode = outerNode.addChildElement(
				'RightOperand',
				s_ns0,
				''
			);
			if (RightOperandObj != null) {
				RightOperandObj.populateXmlNode(RightOperandNode);
			}

			soapBaseObjects.ComplexFilterPart_AdditionalOperands_element AdditionalOperandsObj = this.AdditionalOperands;
			Dom.XmlNode AdditionalOperandsNode = outerNode.addChildElement(
				'AdditionalOperands',
				s_ns0,
				''
			);
			if (AdditionalOperandsObj != null) {
				AdditionalOperandsObj.populateXmlNode(AdditionalOperandsNode);
			}
		}
	}
	public class ComplexFilterPart_AdditionalOperands_element {
		public soapBaseObjects.FilterPart[] Operand;

		public ComplexFilterPart_AdditionalOperands_element() {
		}
		public ComplexFilterPart_AdditionalOperands_element(
			DOM.XmlNode responseNode
		) {
			Set<DOM.XmlNode> nodesParsed = new Set<DOM.XmlNode>();
			Dom.XmlNode[] OperandChildren = responseNode.getChildElements();
			soapBaseObjects.FilterPart[] OperandList = new List<soapBaseObjects.FilterPart>();
			if (OperandChildren == null || OperandChildren.size() == 0) {
				this.Operand = null;
			} else {
				for (DOM.XmlNode childNode : OperandChildren) {
					if (childNode.GetName() == 'Operand') {
						soapBaseObjects.FilterPart Obj = new soapBaseObjects.FilterPart(
							childNode
						);
						OperandList.Add(Obj);
						nodesParsed.add(childNode);
					}
				}
				this.Operand = OperandList;
			}
		}
		public void populateXmlNode(Dom.XmlNode outerNode) {
			soapBaseObjects.FilterPart[] OperandObj = this.Operand;
			if (OperandObj != null) {
				for (soapBaseObjects.FilterPart element : OperandObj) {
					Dom.XmlNode OperandNode = outerNode.addChildElement(
						'Operand',
						s_ns0,
						''
					);
					element.populateXmlNode(OperandNode);
				}
			}
		}
	}
	//Extends http://exacttarget.com/wsdl/partnerAPI:APIProperty
	public class NullAPIProperty {
		public String Name;
		public String Value;

		public NullAPIProperty() {
		}
		public NullAPIProperty(DOM.XmlNode responseNode) {
			Set<DOM.XmlNode> nodesParsed = new Set<DOM.XmlNode>();
			DOM.XmlNode NameNode = responseNode.getChildElement('Name', s_ns0);
			this.Name = (NameNode == null) ? null : NameNode.getText();
			nodesParsed.add(NameNode);
			DOM.XmlNode ValueNode = responseNode.getChildElement('Value', s_ns0);
			this.Value = (ValueNode == null) ? null : ValueNode.getText();
			nodesParsed.add(ValueNode);
		}
		public void populateXmlNode(Dom.XmlNode outerNode) {
			Dom.XmlNode NameNode = outerNode.addChildElement('Name', s_ns0, '');
			if (this.Name != null) {
				NameNode.addTextNode(this.Name);
			}
			Dom.XmlNode ValueNode = outerNode.addChildElement('Value', s_ns0, '');
			if (this.Value != null) {
				ValueNode.addTextNode(this.Value);
			}
		}
	}
	//Extends http://exacttarget.com/wsdl/partnerAPI:FilterPart
	public class SimpleFilterPart {
		public String Property;
		// Restriction enumeration: equals, notEquals, greaterThan, lessThan, isNull, isNotNull, greaterThanOrEqual, lessThanOrEqual, between, IN, like, existsInString, existsInStringAsAWord, notExistsInString, beginsWith, endsWith, contains, notContains, isAnniversary, isNotAnniversary, greaterThanAnniversary, lessThanAnniversary
		public String SimpleOperator;
		public String[] Value;
		public DateTime[] DateValue;

		public SimpleFilterPart() {
		}
		public SimpleFilterPart(DOM.XmlNode responseNode) {
			Set<DOM.XmlNode> nodesParsed = new Set<DOM.XmlNode>();
			DOM.XmlNode PropertyNode = responseNode.getChildElement(
				'Property',
				s_ns0
			);
			this.Property = (PropertyNode == null) ? null : PropertyNode.getText();
			nodesParsed.add(PropertyNode);
			DOM.XmlNode SimpleOperatorNode = responseNode.getChildElement(
				'SimpleOperator',
				s_ns0
			);
			this.SimpleOperator = (SimpleOperatorNode == null)
				? null
				: SimpleOperatorNode.getText();
			nodesParsed.add(SimpleOperatorNode);
			String[] ValueList = new List<String>();
			if (responseNode.getChildElements() == null) {
				this.Value = null;
			} else {
				for (DOM.XmlNode childNode : responseNode.getChildElements()) {
					if (childNode.GetName() == 'Value') {
						ValueList.Add(
							(childNode == null ||
								childNode.getAttributeValue(
									'nil',
									'http://www.w3.org/2001/XMLSchema-instance'
								) == 'true')
								? null
								: String.valueOf(childNode.getText())
						);
						nodesParsed.add(childNode);
					}
				}
				this.Value = ValueList;
			}
			DateTime[] DateValueList = new List<DateTime>();
			if (responseNode.getChildElements() == null) {
				this.DateValue = null;
			} else {
				for (DOM.XmlNode childNode : responseNode.getChildElements()) {
					if (childNode.GetName() == 'DateValue') {
						DateValueList.Add(
							(childNode == null ||
								childNode.getAttributeValue(
									'nil',
									'http://www.w3.org/2001/XMLSchema-instance'
								) == 'true')
								? null
								: DateTime.valueOf(childNode.getText())
						);
						nodesParsed.add(childNode);
					}
				}
				this.DateValue = DateValueList;
			}
		}
		public void populateXmlNode(Dom.XmlNode outerNode) {
			Dom.XmlNode PropertyNode = outerNode.addChildElement(
				'Property',
				s_ns0,
				''
			);
			if (this.Property != null) {
				PropertyNode.addTextNode(this.Property);
			}
			Dom.XmlNode SimpleOperatorNode = outerNode.addChildElement(
				'SimpleOperator',
				s_ns0,
				''
			);
			if (this.SimpleOperator != null) {
				SimpleOperatorNode.addTextNode(this.SimpleOperator);
			}
			if (this.Value != null) {
				for (String element : this.Value) {
					Dom.XmlNode ValueNode = outerNode.addChildElement('Value', s_ns0, '');
					ValueNode.addTextNode(String.valueOf(element));
				}
			}
			if (this.DateValue != null) {
				for (DateTime element : this.DateValue) {
					Dom.XmlNode DateValueNode = outerNode.addChildElement(
						'DateValue',
						s_ns0,
						''
					);
					DateValueNode.addTextNode(String.valueOf(element));
				}
			}
		}
	}
	public class FilterPart {
		private transient String[] apex_schema_type_info = new List<String>{
			s_ns0,
			'true',
			'false'
		};
		private transient String[] field_order_type_info = new List<String>{};
		public FilterPart(DOM.XmlNode responseNode) {
			Set<DOM.XmlNode> nodesParsed = new Set<DOM.XmlNode>();
		}
		public void populateXmlNode(Dom.XmlNode outerNode) {
		}
	}

	public class Options_SaveOptions_element {
		public soapBaseObjects.SaveOption[] SaveOption;
		private transient String[] SaveOption_type_info = new List<String>{
			'SaveOption',
			s_ns0,
			'SaveOption',
			'0',
			'-1',
			'false'
		};
		private transient String[] apex_schema_type_info = new List<String>{
			s_ns0,
			'true',
			'false'
		};
		private transient String[] field_order_type_info = new List<String>{
			'SaveOption'
		};
		public Options_SaveOptions_element() {
		}
		public Options_SaveOptions_element(DOM.XmlNode responseNode) {
			Set<DOM.XmlNode> nodesParsed = new Set<DOM.XmlNode>();
			Dom.XmlNode[] SaveOptionChildren = responseNode.getChildElements();
			soapBaseObjects.SaveOption[] SaveOptionList = new List<soapBaseObjects.SaveOption>();
			if (SaveOptionChildren == null || SaveOptionChildren.size() == 0) {
				this.SaveOption = null;
			} else {
				for (DOM.XmlNode childNode : SaveOptionChildren) {
					if (childNode.GetName() == 'SaveOption') {
						soapBaseObjects.SaveOption Obj = new soapBaseObjects.SaveOption(
							childNode
						);
						SaveOptionList.Add(Obj);
						nodesParsed.add(childNode);
					}
				}
				this.SaveOption = SaveOptionList;
			}
		}
		public void populateXmlNode(Dom.XmlNode outerNode) {
			soapBaseObjects.SaveOption[] SaveOptionObj = this.SaveOption;
			if (SaveOptionObj != null) {
				for (soapBaseObjects.SaveOption element : SaveOptionObj) {
					Dom.XmlNode SaveOptionNode = outerNode.addChildElement(
						'SaveOption',
						s_ns0,
						''
					);
					element.populateXmlNode(SaveOptionNode);
				}
			}
		}
	}
	public class Attribute {
		public String Name;
		public String Value;
		public Attribute() {
		}
		public Attribute(DOM.XmlNode responseNode) {
			Set<DOM.XmlNode> nodesParsed = new Set<DOM.XmlNode>();
			DOM.XmlNode NameNode = responseNode.getChildElement('Name', s_ns0);
			this.Name = (NameNode == null) ? null : NameNode.getText();
			nodesParsed.add(NameNode);
			DOM.XmlNode ValueNode = responseNode.getChildElement('Value', s_ns0);
			this.Value = (ValueNode == null) ? null : ValueNode.getText();
			nodesParsed.add(ValueNode);
		}
		public void populateXmlNode(Dom.XmlNode outerNode) {
			Dom.XmlNode NameNode = outerNode.addChildElement('Name', s_ns0, '');
			if (this.Name != null) {
				NameNode.addTextNode(this.Name);
			}
			Dom.XmlNode ValueNode = outerNode.addChildElement('Value', s_ns0, '');
			if (this.Value != null) {
				ValueNode.addTextNode(this.Value);
			}
		}
	}
}