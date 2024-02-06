@ignore
Feature: Participant Bank deposits from their off-chain account to their On-chain account

Background:
  * call read('classpath:com/wizeline/assignments/features/testHelpers/common.feature')
  * url simpleBaseUrl
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
    
    # Step 1.1: Send deposit REQUEST camt.050 to [Partior] 
    * def currentDateTime = getCurrentUTCDate()
    * def generatedDateTime = currentDateTime
    * def settlementDate = currentDateTime

    Given path 'validateDeposit'
    And request read('classpath:assignments/requestpayload/request_camt.050.001.05.json')
    When method post
    Then status 200

    #  Step 1.2: Validates response of admi.007
    * def actualDesc = response.BusMsg.Document.RctAck.Rpt.ReqHdlg.Desc
    * def actualStatusCode = response.BusMsg.Document.RctAck.Rpt.ReqHdlg.StsCd
    * def actualBankBIC = response.BusMsg.AppHdr.Fr.FIId.FinInstnId.BICFI
    * def actualBankBICNode = response.BusMsg.AppHdr.To.FIId.FinInstnId.BICFI
    * def actualOriginalRequestMsgId = response.BusMsg.Document.RctAck.Rpt.RltdRef.Ref

    * match actualBankBIC == participantBankBIC
    * match actualBankBICNode == participantBankNodeBIC
    * match actualStatusCode == 'ACTC'
    * match actualDesc == 'AcceptedTechnicalValidation'
    * match actualOriginalRequestMsgId == generatedMsgId

    # Step 2.1: Send REQUEST camp.050 to [Settlement Bank]
    * def currentDateTime = getCurrentUTCDate()
    * def generatedDateTime = currentDateTime
    * def settlementDate = currentDateTime
    * def currentDate = getDatePart(currentDateTime)

    Given path 'sendToSettlementBank'
    And request read('classpath:assignments/requestpayload/request_camt.050.001.05.json')
    When method post
    Then status 200

    # Step 2.2: Validate the RESPONSE of camp.050
    * def postingEntry = response.BusMsg.Document.LqdtyCdtTrf.SplmtryData.Envlp.Document.PostingSuplDataV01.PostingEntry[0]
    * validatePostingEntry(postingEntry, currentDate, 'GENERATED')

    # Step 3.1: Sends REQUEST camt.025 with ACSC to [Settlement Bank Node]
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

   # Step 3.2: Validates the response json
    * def postingEntry = response.BusMsg.Document.Rct.SplmtryData.Envlp.Document.PostingSuplDataV01.PostingEntry[0]
    * validatePostingEntry(postingEntry, currentDate, 'SETTLED')

    # Step 4.1: Send a REQUEST  camt.025 to [Participant Bank Node]
    * def currentDateTime = getCurrentUTCDate()
    * def generatedDateTime = currentDateTime
    * def settlementDate = currentDateTime
    * def statusCode = 'ACCC'
    
    Given path 'notifyToParticipantBank'
    And request read('classpath:assignments/requestpayload/request_camt.025.001.05.json')
    When method post
    Then status 200

    # Step 4.2: Validates the response json
    * def actualStatusCode = response.BusMsg.Document.Rct.RctDtls.ReqHdlg.StsCd
    * def actualDescription = response.BusMsg.Document.Rct.RctDtls.ReqHdlg.Desc
    * def hasSplmtryData = response.BusMsg.Document.Rct.SplmtryData

    * match actualStatusCode == 'ACCC'
    * match actualDescription == 'AcceptedSettlementCompletedCreditorAccount'
    * assert hasSplmtryData == null