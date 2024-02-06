Feature: Participant Bank deposits from their off-chain account to their On-chain account

Background:
  * url complexBaseUrl
  * header MsgId = karate.get('msgId')

Scenario: DA receive camt.029 CNCL

    #28 : DA receive camt.029 CNCL
    Given path '/acknowledge/camt029'
    And request {}
    When method post
    Then status 200

    # Karate validates fields in admi.007 should be validated
    * def statusResponse = response.BusMsg.Document.RsltnOfInvstgtn.CxlDtls.RslvdCase.Sts
    * def orgnlTxIdResponse = response.BusMsg.Document.RsltnOfInvstgtn.CxlDtls.OrgnlTxId
    * def orgnlInstructionResponse = response.BusMsg.Document.RsltnOfInvstgtn.CxlDtls.OrgnlInstrId
    * def orgnlEndToEnIdResponse = response.BusMsg.Document.RsltnOfInvstgtn.CxlDtls.OrgnlEndToEndId
    * match statusResponse == 'CNCL'
    * match orgnlInstructionResponse == originalInstructionId
    * match orgnlTxIdResponse == originalTransactionId
    * match orgnlEndToEnIdResponse == originalEndToEndId

