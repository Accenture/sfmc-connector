%dw 2.0

input payload application/xml
output application/apex  
---

{
    OverallStatus : payload.Envelope.Body.ExecuteResponseMsg.OverallStatus,
    Results : payload.Envelope.Body.ExecuteResponseMsg.*Results map(val) -> {
        StatusMessage: val.StatusMessage,
        ErrorCode: val.ErrorCode,
        StatusCode: val.StatusCode
    }
} as Object {class: "MktSubscriber.LogUnsubEventResponse"}