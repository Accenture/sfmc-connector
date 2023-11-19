%dw 2.0
input payload application/json  
output application/xml  
---

  Envelope @(xmlns: "http://schemas.xmlsoap.org/soap/envelope/", "xmlns:xsi": 'http://www.w3.org/2001/XMLSchema-instance'): {
    Body: 
      ExecuteRequestMsg @(xmlns: "http://exacttarget.com/wsdl/partnerAPI"): payload map (item) -> {
        Requests: item mapObject (value, key) -> 
            {
              (key): value
            }
      }
,
    Header: 
      fueloauth @(xmlns: "http://exacttarget.com"): "{0}"

  }
