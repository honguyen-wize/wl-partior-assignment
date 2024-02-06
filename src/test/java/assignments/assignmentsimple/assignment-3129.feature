Feature: Participant Bank deposits from their off-chain account to their On-chain account

Background:  
  * call read('classpath:assignments/Utils/common.feature')

  * url 'https://api.dev.runner.wizerace.net/mockApi/simple'

  * def testcasId = karate.get('testcasId')
  * def settlementBankBIC = karate.get('settlementBankBIC')
  * def settlementBankNodeBIC = settlementBankBIC + "-ND"
  * def participantBankBIC = karate.get('participantBankBIC')
  * def participantBankNodeBIC = participantBankBIC + "-ND"
  * def currency = karate.get('currency')
  * def depositAmount = karate.get('depositAmount')
  * def amount = depositAmount
  * def uuid = java.util.UUID.randomUUID().toString()
  * def generatedMsgId = 'msgid-' + uuid.substring(0, 10)
  * def originalRequestMsgId = generatedMsgId
  * def generatedRef = 'ref-' + uuid.substring(0, 10)
  * def participantOnPlatformAccountId = 'accp-' + uuid.substring(0, 6)
  * def settlementOnPlatformAccountId = 'accs-' + uuid.substring(0, 6)

Scenario: Participant Bank successfully deposits from their off-chain account to their On-chain account with settlement bank
    
    #Step 1.1: Karate sends deposit REQUEST camt.050 to [Mock server Partior] 
    * def currentDateTime = getCurrentUTCDate()
    * def generatedDateTime = currentDateTime
    * def settlementDate = currentDateTime

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

    * match bankBICResponse == participantBankBIC
    * match bankBICNodeResponse == participantBankNodeBIC
    * match statusResponse == 'ACTC'
    * match descResponse == 'AcceptedTechnicalValidation'
    * match originalRequestMsgIdResponse == generatedMsgId

    #Step 2.1 Karate sends REQUEST camp.050 to [Mock Server Settlement Bank]
    * def currentDateTime = getCurrentUTCDate()
    * def generatedDateTime = currentDateTime
    * def settlementDate = currentDateTime
    * def currentDate = getDatePart(currentDateTime)

    Given path 'sendToSettlementBank'
    And request read('classpath:assignments/requestpayload/request_camt.050.001.05.json')
    When method post
    Then status 200

    # Karate validates the RESPONSE of camp.050
    * def postingEntry = response.BusMsg.Document.LqdtyCdtTrf.SplmtryData.Envlp.Document.PostingSuplDataV01.PostingEntry[0]
    * def actualCreditDebit = postingEntry.CdtDbtInd
    * def actualBookingDate = getDatePart(postingEntry.BookgDt)
    * def actualValueDate = getDatePart(postingEntry.ValueDt)
    * def actualExposureDate = getDatePart(postingEntry.ExposureDt)
    * def actualSettlementDate = getDatePart(postingEntry.StlmntDt)
    * def actualExecutionStatus = postingEntry.ExecStatus
    * def actualPostingRefNum = postingEntry.PostingRefNum

    * match actualCreditDebit == 'CREDIT' || actualCreditDebit == 'DEBIT'
    * match actualBookingDate == currentDate
    * match actualValueDate == currentDate
    * match actualExposureDate == currentDate
    * match actualSettlementDate == currentDate
    * match actualExecutionStatus == 'GENERATED'
    * match actualPostingRefNum !=  ''

    #Step 3.1 Karate sends REQUEST camt.025 with ACSC  to [Mock Server Settlement Bank Node]
    * def currentDateTime = getCurrentUTCDate()
    * def generatedDateTime = currentDateTime
    * def settlementDate = currentDateTime
    * def currentDate = getDatePart(currentDateTime)
    * def statusCode = 'ACSC'
    * def statusDescription = 'AcceptedSettlementCompletedDebitorAccount'

    Given path 'sendToSettlementBankNode'
    And request read('classpath:assignments/requestpayload/request_camt.025.001.05.json')
    When method post
    Then status 200

   # Step 3.2.1 Karate validates the response json
    * def postingEntry = response.BusMsg.Document.Rct.SplmtryData.Envlp.Document.PostingSuplDataV01.PostingEntry[0]
    * def actualCreditDebit = postingEntry.CdtDbtInd
    * def actualBookingDate = getDatePart(postingEntry.BookgDt)
    * def actualValueDate = getDatePart(postingEntry.ValueDt)
    * def actualExposureDate = getDatePart(postingEntry.ExposureDt)
    * def actualSettlementDate = getDatePart(postingEntry.StlmntDt)
    * def actualExecutionStatus = postingEntry.ExecStatus
    * def actualPostingRefNum = postingEntry.PostingRefNum

   * match actualCreditDebit == 'CREDIT' || actualCreditDebit == 'DEBIT'
   * match actualBookingDate == currentDate
   * match actualValueDate == currentDate
   * match actualExposureDate == currentDate
   * match actualSettlementDate == currentDate
   * match actualExecutionStatus == 'SETTLED'
   * match actualPostingRefNum !=  ''

    #4.1 Karate sends a REQUEST  camt.025 to [Mock Server Participant Bank Node]
    * def currentDateTime = getCurrentUTCDate()
    * def generatedDateTime = currentDateTime
    * def settlementDate = currentDateTime
    * def statusCode = 'ACCC'
    
    Given path 'notifyToParticipantBank'
    And request read('classpath:assignments/requestpayload/request_camt.025.001.05.json')
    When method post
    Then status 200

    * def actualStatusCode = response.BusMsg.Document.Rct.RctDtls.ReqHdlg.StsCd
    * def actualDescription = response.BusMsg.Document.Rct.RctDtls.ReqHdlg.Desc
    * def hasSplmtryData = response.BusMsg.Document.Rct.SplmtryData

    * match actualStatusCode == 'ACCC'
    * match actualDescription == 'AcceptedSettlementCompletedCreditorAccount'
    * assert hasSplmtryData == null