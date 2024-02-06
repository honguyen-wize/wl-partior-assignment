@ignore
Feature: Participant Bank deposits from their off-chain account to their On-chain account

Background:
  * url complexBaseUrl
  * def messageId = karate.get('daMsgPacs002Id')
  * def originalMsgId = karate.get('msgId')
  * def originalInstructionId = karate.get('instrId')
  * def originalEndToEndId = karate.get('endToEndId')
  * def originalTransactionId = karate.get('txId')
  * header MsgId = karate.get('msgId')
  * def requestPacs002Json = read('classpath:assignments/requestpayload/complex/request_pacs.002_acfc.json')

Scenario: DA sends pacs.002 ACFC

    #Step 4 : DA sends REQUEST pacs.002 - ACFC to [Mock server]
    Given path 'daSendPacs002'
    And request requestPacs002Json
    When method post
    Then status 200



