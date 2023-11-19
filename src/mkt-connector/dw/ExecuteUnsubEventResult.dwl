%dw 2.0

input payload application/xml
output application/apex  
---

{
    OverallStatus : payload.Envelope.Body.ExecuteResponseMsg.OverallStatus,
    Results : payload.Envelope.Body.ExecuteResponseMsg.*Results
} as Object {class: "MktSoap.LogUnsubEventResponse"}