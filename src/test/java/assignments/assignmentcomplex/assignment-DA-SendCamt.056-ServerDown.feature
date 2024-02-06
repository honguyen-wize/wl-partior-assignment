Feature: Participant Bank deposits from their off-chain account to their On-chain account

Background:
  * url complexBaseUrl
  * def messageId = karate.get('daMsgCamt056Id')
  * def originalMsgDefId = 'pacs.008.001.02'
  * def originalMsgId = karate.get('msgId')
  * def originalInstructionId = karate.get('instrId')
  * def originalEndToEndId = karate.get('endToEndId')
  * def originalTransactionId = karate.get('txId')
  * header MsgId = karate.get('msgId')
  * def requestJson = read('classpath:assignments/requestpayload/complex/request_camt.056.json')

Scenario: DA sends camt.056 - Server Down

    #10 : DA sends REQUEST camt.056 - Server Down
    Given path 'daSendCamt056'
    And request requestJson
    When method post
    Then status 500



