%dw 2.0

fun arrayToObject(data): Object =
  data reduce ((option, child = {}) -> child ++ {
      (option.Name): option.Value
    })

input payload application/xml
output application/apex  
---
payload.Envelope.Body.RetrieveResponseMsg.*Results.*Properties map ((val) -> val.*Property) map ((val) -> arrayToObject(val)) as Object {class:"MktSoap.GenericResponse"}