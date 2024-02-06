@ignore
Feature: Participant Bank deposits from their off-chain account to their On-chain account

Background:
  * url complexBaseUrl
  * header MsgId = karate.get('msgId')

Scenario: DA receive pacs.002 CANC

    #29 : DA receive pacs.002 ACSP
    Given path '/acknowledge/pacs002'
    And request {}
    When method post
    Then status 200

    # Karate validates fields should be validated
    * def statusResponse = response.BusMsg.Document.FIToFIPmtStsRpt.OrgnlGrpInfAndSts.GrpSts
    * def orgnlMsgIdResponse = response.BusMsg.Document.FIToFIPmtStsRpt.OrgnlGrpInfAndSts.OrgnlMsgId
    * def orgnlTxIdResponse = response.BusMsg.Document.FIToFIPmtStsRpt.TxInfAndSts.StsId
    * def orgnlInstructionResponse = response.BusMsg.Document.FIToFIPmtStsRpt.TxInfAndSts.OrgnlInstrId
    * def orgnlEndToEnIdResponse = response.BusMsg.Document.FIToFIPmtStsRpt.TxInfAndSts.OrgnlEndToEndId
    * match statusResponse == 'CANC'
    * match orgnlMsgIdResponse == originalMsgId
    * match orgnlInstructionResponse == originalInstructionId
    * match orgnlTxIdResponse == originalTransactionId
    * match orgnlEndToEnIdResponse == originalEndToEndId

