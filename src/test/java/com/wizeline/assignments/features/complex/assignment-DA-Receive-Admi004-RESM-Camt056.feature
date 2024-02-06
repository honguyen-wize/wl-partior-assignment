@ignore
Feature: Participant Bank deposits from their off-chain account to their On-chain account

Background:
  * url complexBaseUrl
  * def originalMsgCamt056Id = karate.get('daMsgCamt056Id')
  * def NodeServerUtils = Java.type('com.wizeline.assignments.utils.NodeServerUtils')
  * def daNodeBIC = NodeServerUtils.getNodeStatus(karate.get('daNode.bic'), karate.get('daNode.status'))
  * def caNodeBIC = NodeServerUtils.getNodeStatus(karate.get('caNode.bic'), karate.get('caNode.status'))
  * def iaNodeBIC = NodeServerUtils.getNodeStatus(karate.get('iaNode.bic'), karate.get('iaNode.status'))
  * header MsgId = karate.get('msgId')

Scenario: DA receives admi.004 RESM for camt.056

    #12 : DA receive admi004 RESM for camt.056
    Given path '/acknowledge/admi004/resm'
    And request {}
    When method post
    Then status 200

    # Karate validates fields in admi004 RESM should be validated
    * def eventsResponse = response.BusMsg.Document.AdminRspn.RspnSts.AddtlInf
    * match eventsResponse[0] == 'eventCode = RESM'
    * match eventsResponse[1] == 'eventDescription = Inflight Payment is ready to resume'
    * match eventsResponse[2] == 'eventParam1 = ' + daNodeBIC
    * match eventsResponse[3] == 'eventParam2 = ' + caNodeBIC
    * match eventsResponse[4] == 'eventParam3 = ' + iaNodeBIC
    * match eventsResponse[7] == 'eventParam6 = ' + originalMsgId
    * match eventsResponse[9] == 'eventParam8 = PATC'
    * match eventsResponse[11] == 'eventParam10 = ' + originalMsgCamt056Id
    * match eventsResponse[12] == 'eventParam11 = camt.056.001.06'
    * match eventsResponse[13] == 'eventParam12 = ACSP'
    * match eventsResponse[14] == 'eventParam13 = ' + originalInstructionId
    * match eventsResponse[15] == 'eventParam14 = ' + originalTransactionId
    * match eventsResponse[16] == 'eventParam15 = ' + originalEndToEndId


