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
  * def currentDateTime = java.time.format.DateTimeFormatter.ofPattern('yyyy-MM-dd HH:mm:ss.SSS').format(java.time.LocalDateTime.now())
  * def currentDatePart = java.time.format.DateTimeFormatter.ofPattern('yyyy-MM-dd').format(java.time.LocalDateTime.now())
  * def generatedDateTime = currentDateTime
  * def settlementDate = currentDateTime
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

    #Step 2.1 Karate sends REQUEST camp.050 to [Mock Server Settlement Bank]
    * def blockchainDate = java.time.format.DateTimeFormatter.ofPattern('yyyy-MM-dd').format(java.time.LocalDateTime.now())
    
    Given path 'sendToSettlementBank'
    And request read('classpath:assignments/requestpayload/request_camt.050.001.05.json')
    When method post
    Then status 200

    #Karate validates the RESPONSE of camp.050
    * def actualCreditDebit = response.BusMsg.Document.LqdtyCdtTrf.SplmtryData.Envlp.Document.PostingSuplDataV01.PostingEntry[0].CdtDbtInd
    * def actualBookingDate = response.BusMsg.Document.LqdtyCdtTrf.SplmtryData.Envlp.Document.PostingSuplDataV01.PostingEntry[0].BookgDt
    * def actualValueDate = response.BusMsg.Document.LqdtyCdtTrf.SplmtryData.Envlp.Document.PostingSuplDataV01.PostingEntry[0].ValueDt
    * def actualExposureDate = response.BusMsg.Document.LqdtyCdtTrf.SplmtryData.Envlp.Document.PostingSuplDataV01.PostingEntry[0].ExposureDt
    * def actualSettlementDate = response.BusMsg.Document.LqdtyCdtTrf.SplmtryData.Envlp.Document.PostingSuplDataV01.PostingEntry[0].StlmntDt
    * def actualExecutionStatus = response.BusMsg.Document.LqdtyCdtTrf.SplmtryData.Envlp.Document.PostingSuplDataV01.PostingEntry[0].ExecStatus
    * def actualPostingRefNum = response.BusMsg.Document.LqdtyCdtTrf.SplmtryData.Envlp.Document.PostingSuplDataV01.PostingEntry[0].PostingRefNum
   
    * def actualBookingDatePart = java.time.LocalDateTime.parse(actualBookingDate, java.time.format.DateTimeFormatter.ISO_DATE_TIME).toLocalDate().toString()
    * def actualValueDatePart = java.time.LocalDateTime.parse(actualValueDate, java.time.format.DateTimeFormatter.ISO_DATE_TIME).toLocalDate().toString()
    * def actualExposureDatePart = java.time.LocalDateTime.parse(actualExposureDate, java.time.format.DateTimeFormatter.ISO_DATE_TIME).toLocalDate().toString()
    * def actualSettlementDatePart = java.time.LocalDateTime.parse(actualSettlementDate, java.time.format.DateTimeFormatter.ISO_DATE_TIME).toLocalDate().toString()

    * print 'actualCreditDebit:', actualCreditDebit
    * print 'actualBookingDatePart:', actualBookingDatePart
    * print 'actualValueDatePart:', actualValueDatePart
    * print 'actualExposureDatePart:', actualExposureDatePart
    * print 'actualSettlementDatePart:', actualSettlementDatePart
    * print 'actualExecutionStatus:', actualExecutionStatus
    * print 'actualPostingRefNum:', actualPostingRefNum 

    * match actualCreditDebit == 'CREDIT' || actualCreditDebit == 'DEBIT]'
    * match actualBookingDatePart == currentDatePart
    * match actualValueDatePart == currentDatePart
    * match actualExposureDatePart == currentDatePart
    * match actualSettlementDatePart == currentDatePart
    * match actualExecutionStatus == 'GENERATED'
    * match actualPostingRefNum !=  ''

