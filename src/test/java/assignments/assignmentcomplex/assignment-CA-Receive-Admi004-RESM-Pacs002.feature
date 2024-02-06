Feature: Participant Bank deposits from their off-chain account to their On-chain account

Background:
  * url complexBaseUrl
  * def originalMsgId = karate.get('msgId')
  * def originalMsgDefId = 'pacs.008.001.02'
  * def originalInstructionId = karate.get('instrId')
  * def originalEndToEndId = karate.get('endToEndId')
  * def originalTransactionId = karate.get('txId')
  * header MsgId = karate.get('msgId')

Scenario: CA receives of admin.004 RESM for pacs.002

    #22 : CA receives of admin.004 RESM for pacs.002
    Given path '/acknowledge/admi004/resm'
    And request {}
    When method post
    Then status 200

    # Karate validates fields in admi.007 should be validated
    * def eventsResponse = response.BusMsg.Document.AdminRspn.RspnSts.AddtlInf
    * match eventsResponse[0] == 'eventCode = RESM'
    * match eventsResponse[1] == 'eventDescription = Inflight Payment is ready to resume'
    * match eventsResponse[7] == 'eventParam6 = Pacs00820240251530'
    * match eventsResponse[9] == 'eventParam8 = PATC'
    * match eventsResponse[11] == 'eventParam10 = DAPacs00200820240251530'
    * match eventsResponse[12] == 'eventParam11 = pacs.002.001.01'
    * match eventsResponse[13] == 'eventParam12 = ACSP'
    * match eventsResponse[14] == 'eventParam13 = InstrId202402051636'
    * match eventsResponse[15] == 'eventParam14 = TxId202402051636'
    * match eventsResponse[16] == 'eventParam15 = EndToEndId202402051636'


