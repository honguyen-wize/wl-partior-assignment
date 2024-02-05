Feature: Participant Bank deposits from their off-chain account to their On-chain account

Background:
  * url 'https://api.dev.runner.wizerace.net/mockApi/simple'
  * def testcasId = karate.get('testcasId')
  * def settlementBankBIC = karate.get('settlementBankBIC')
  * def settlementBankNodeBIC = settlementBankBIC + "-ND"
  * def participantBankBIC = karate.get('participantBankBIC')
  * def participantBankNodeBIC = participantBankBIC + "-ND"
  * def currency = karate.get('currency')
  * def depositAmount = karate.get('depositAmount')
  
  * def uuid = java.util.UUID.randomUUID().toString()
  * def generatedMsgId = 'msgid-' + uuid.substring(0, 10)
  * def generatedRef = 'ref-' + uuid.substring(0, 10)
  * def participantOnPlatformAccountId = 'acc-' + uuid.substring(0, 6)
  * def generatedDateTime = java.time.format.DateTimeFormatter.ofPattern('yyyy-MM-dd HH:mm:ss.SSS').format(java.time.LocalDateTime.now())
  * def currentDate = java.time.format.DateTimeFormatter.ofPattern('yyyy-MM-dd').format(java.time.LocalDateTime.now())
  # * def settlementDate = "ACSC"
  # * def statusDescription = "AcceptedSettlementCompletedDebitorAccount"

Scenario: Participant Bank successfully deposits from their off-chain account to their On-chain account with settlement bank
    * print 'testcasId: ', testcasId
    * print 'settlementBankBIC: ', settlementBankBIC
    * print 'participantBankBIC: ', participantBankBIC
    * print 'currency: ', currency
    * print 'depositAmount: ', depositAmount
    * print 'generatedMsgId:', generatedMsgId
    * print 'generatedRef:', generatedRef
    
    #Step 1.1: Karate sends deposit REQUEST camt.050 to [Mock server Partior] 
    Given path 'validateDeposit'
    And request read('classpath:assignments/requestpayload/request_camt.050.001.05.json')
    When method post
    Then status 200

    # Karate validates fields in admi.007 should be validated
    * def descResponse = response.BusMsg.Document.RctAck.Rpt.ReqHdlg.Desc
    * def statusResponse = response.BusMsg.Document.RctAck.Rpt.ReqHdlg.StsCd
    * def bankBICResponse = response.BusMsg.AppHdr.Fr.FIId.FinInstnId.BICFI
    * def bankBICNodeResponse = response.BusMsg.AppHdr.To.FIId.FinInstnId.BICFI
    * def originalRequestMsgIdResponse = response.BusMsg.Document.RctAck.Rpt.RltdRef.Ref
    
    * print 'statusResponse Value:', statusResponse
    * print 'descResponse Value:', descResponse
    * print 'bankBICResponse Value:', bankBICResponse
    * print 'bankBICNodeResponse Value:', bankBICNodeResponse
    * print 'originalRequestMsgIdResponse Value:', originalRequestMsgIdResponse

    * match bankBICResponse == participantBankBIC
    * match bankBICNodeResponse == participantBankNodeBIC
    * match statusResponse == 'ACTC'
    * match descResponse == 'AcceptedTechnicalValidation'
    * match originalRequestMsgIdResponse == generatedMsgId

