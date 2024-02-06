Feature: Participant Bank deposits from their off-chain account to their On-chain account

Background:
  * url complexBaseUrl
  * def messageId = karate.get('caMsgPacs002Id')
  * def originalMsgId = karate.get('msgId')
  * def originalInstructionId = karate.get('instrId')
  * def originalEndToEndId = karate.get('endToEndId')
  * def originalTransactionId = karate.get('txId')
  * header MsgId = karate.get('msgId')
  * header NodeDownStatus = karate.get('caDownNode')
  * header BIC = karate.get('caBIC')

Scenario: DA sends pacs.002 ACSP - Server Down
    #8. CA sends REQUEST pacs.002 with ACSP to [Mock server] - Server Down
    Given path 'caSendPacs002'
    And request read('classpath:assignments/requestpayload/complex/request_pacs.002_acsp.json')
    When method post
    Then status 500



