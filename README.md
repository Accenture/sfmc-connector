# Accenture Custom Connector for SFMC

Some templated code for anyone to integrate with SFMC using API. This attempts to demonstrate but not cover all use cases.
Feel free to request features/propose pull requests.

## Auth Classes

### Auth

- authenticate - used to request access token OR retreive existing token from platform cache
  - includes retry support
  - handles platform cache expiry
  - handles mutliple access tokens based on business unit (MID)

## Rest Classes

### Address

- validateEmail - Validate Email Addresses using SFMC endpoint

### Contact

- deleteBeyKey - Request deletion of contact from SFMC

### Data Sync

- send - Send either a list of maps or a list of sobjects to SFMC.
  - Any sObject child records will be automatically stringified to JSON

### Journey

- sendEvent - trigger entry event to SFMC either a list of maps or a list of sobjects to SFMC.
  - Any sObject child records will be automatically stringified to JSON

### Transactional Messaging

- sendEmail - send transactional email
- sendSms - send transactional sms
- getEmailStatus - get status of transactional email send
- getSmsStatus - get status of transactional sms send

# Setup Sets

- Create External Credential
  -- Name = MKTCustomConnector
  -- Type = Custom
  -- Principle Name = 'MKTCustomConnector'
  -- Authenticaiton Parameters "client_id" and "client_secret"
- Create Named Credential
  -- Name = MKTCustomConnector
  -- URL = Add auth url in format "https://TENANTID.auth.marketingcloudapis.com"
  -- Generate Auth Header = false

- Add External Credential to Permission Set
- Create Remote Site Settings for
  -- REST - example https://TENANTID.rest.marketingcloudapis.com
  -- SOAP - example https://TENANTID.soap.marketingcloudapis.com
