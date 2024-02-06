@ignore
Feature: Participant Bank deposits from their off-chain account to their On-chain account

Background:
  * url complexBaseUrl
  * def testcasId = karate.get('testcasId')
  * def messageId = karate.get('msgId')
  * def currency = karate.get('currency')
  * def amount = karate.get('amount')

Scenario: DA sends credit transfer instruction as pacs.008 with {amount} {currency}
    #Step 1: DA sends credit transfer instruction as pacs.008 to [Mock server]
    Given path 'sendCreditTransfer'
    And request read('classpath:assignments/requestpayload/complex/request_pacs.008.json')
    When method post
    Then status 200

    #Step 2: DA receives admi.007 ACTC
    # Karate validates fields in admi.007 should be validated
    * def statusResponse = response.BusMsg.Document.RctAck.RspnSts.Sts
    * match statusResponse == 'ACTC'

