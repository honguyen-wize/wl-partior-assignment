@ignore
Feature: Participant Bank deposits from their off-chain account to their On-chain account

Background:
  * url complexBaseUrl
  * def requestJson = read('classpath:assignments/requestpayload/complex/request_camt.056.json')
  * header MsgId = karate.get('msgId')

Scenario: DA receive admi.007 ACTC for camt.056

    #16 : DA receive admi.007 ACTC for camt.056
    Given path '/acknowledge/admi004/qrty'
    And request requestJson
    When method post
    Then status 200


