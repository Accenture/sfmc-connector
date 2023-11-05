%dw 2.0
input payload application/java  
output application/xml  
---

  Envelope @(xmlns: "http://schemas.xmlsoap.org/soap/envelope/", "xmlns:xsi": 'http://www.w3.org/2001/XMLSchema-instance'): {
    Body: 
      RetrieveRequestMsg @(xmlns: "http://exacttarget.com/wsdl/partnerAPI"): payload map (item) -> {
        RetrieveRequest: item mapObject (value, key) -> if ((key) ~= "Filter")
            {
              (key) @("xsi:type": "SimpleFilterPart"): value
            }
          else
            {
              (key): value
            }
      }
,
    Header: 
      fueloauth @(xmlns: "http://exacttarget.com"): "{0}"

  }
