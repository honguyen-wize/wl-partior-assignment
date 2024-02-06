Feature: Participant Bank deposits from their off-chain account to their On-chain account

Background:
  * url complexBaseUrl
  * def messageId = karate.get('iaMsgPacs002Id')
  * def originalMsgId = karate.get('msgId')
  * def originalInstructionId = karate.get('instrId')
  * def originalEndToEndId = karate.get('endToEndId')
  * def originalTransactionId = karate.get('txId')
  * def requestPacs002Json = read('classpath:assignments/requestpayload/complex/request_pacs.002_acsp.json')
  * header MsgId = karate.get('msgId')
  * header NodeDownStatus = karate.get('iaDownNode')
  * header BIC = karate.get('iaBIC')

Scenario: DA sends pacs.002 ACSP - Server Down

    #6. IA sends REQUEST pacs.002 with ACSP to [Mock server] - Server Down
    Given path 'iaSendPacs002'
    And request requestPacs002Json
    When method post
    Then status 500



