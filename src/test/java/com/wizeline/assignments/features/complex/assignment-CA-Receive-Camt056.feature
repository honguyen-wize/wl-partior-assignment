@ignore
Feature: Participant Bank deposits from their off-chain account to their On-chain account

Background:
  * url complexBaseUrl
  * def messageId = karate.get('daMsgCamt056Id')
  * header MsgId = karate.get('msgId')

Scenario: CA receive camt.056

    #18 : CA receive camt.056
    Given path '/acknowledge/camt056'
    And request {}
    When method post
    Then status 200

    # Karate validates fields in admi.007 should be validated
    * def messageIdResponse = response.BusMsg.Document.PmtCxlReq.Assgnmt.Id
    * match messageIdResponse == messageId

