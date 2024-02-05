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
  * def settlementDate = "ACSC"
  * def statusDescription = "AcceptedSettlementCompletedDebitorAccount"

Scenario: Participant Bank successfully deposits from their off-chain account to their On-chain account with settlement bank
    * def depositValidationPayload =
    """
        {
            "BusMsg": {
              "AppHdr": {
                "xmlns": "head.001.001.01",
                "Fr": {
                  "FIId": {
                    "FinInstnId": {
                      "BICFI": "#(participantBankBIC)"
                    }
                  }
                },
                "To": {
                  "FIId": {
                    "FinInstnId": {
                      "BICFI": "#(participantBankNodeBIC)"
                    }
                  }
                },
                "BizMsgIdr": "#(generatedMsgId)",
                "MsgDefIdr": "camt.050.001.05",
                "CreDt": "#(generatedDateTime)"
              },
              "Document": {
                "LqdtyCdtTrf": {
                  "MsgHdr": {
                    "MsgId": "#(generatedMsgId)",
                    "CreDtTm": "#(generatedDateTime)"
                  },
                  "LqdtyCdtTrf": {
                    "LqdtyTrfId": {
                      "InstrId": "SY050#(currentDate)0001#(generatedRef)",
                      "EndToEndId": "#(generatedRef)",
                      "TxId": "str#(generatedRef)",
                      "UETR": "71cc8a4e-83a9-4a19-a60f-78dacbb0#(generatedRef)"
                    },
                    "Cdtr": {
                      "FinInstnId": {
                        "BICFI": "#(participantBankBIC)"
                      }
                    },
                    "CdtrAcct": {
                      "Id": {
                        "Othr": {
                          "Id": "#(participantOnPlatformAccountId)",
                          "Issr": "#(settlementBankBIC)"
                        }
                      },
                      "Ccy": "#(currency)"
                    },
                    "TrfdAmt": {
                      "AmtWthCcy": {
                        "Ccy": "#(currency)",
                        "Amount": "#(depositAmount)"
                      }
                    },
                    "Dbtr": {
                      "FinInstnId": {
                        "BICFI": "#(participantBankBIC)"
                      }
                    },
                    "DbtrAcct": {
                      "Id": {
                        "Othr": {
                          "Id": "str#(generatedRef)",
                          "Issr": "#(settlementBankBIC)"
                        }
                      },
                      "Ccy": "#(currency)"
                    },
                    "SttlmDt": "#(settlementDate)"
                  }
                }
              }
            }
          }
    """
    * print 'testcasId: ', testcasId
    * print 'settlementBankBIC: ', settlementBankBIC
    * print 'participantBankBIC: ', participantBankBIC
    * print 'currency: ', currency
    * print 'depositAmount: ', depositAmount
    * print 'generatedMsgId:', generatedMsgId
    * print 'generatedRef:', generatedRef
    
    Given path 'validateDeposit'
    And request depositValidationPayload
    When method post
    Then status 200

    * def descValueResponse = response.BusMsg.Document.RctAck.Rpt.ReqHdlg.Desc
    * def statusValueResponse = response.BusMsg.Document.RctAck.Rpt.ReqHdlg.StsCd
    * def bankBICValueResponse = response.BusMsg.AppHdr.Fr.FIId.FinInstnId.BICFI
    * def bankBICNodeResponse = response.BusMsg.AppHdr.To.FIId.FinInstnId.BICFI
    * def originalRequestMsgIdValueResponse = response.BusMsg.Document.RctAck.Rpt.RltdRef.Ref
    
    * print 'statusValueResponse Value:', statusValueResponse
    * print 'descValueResponse Value:', descValueResponse
    * print 'bankBICValueResponse Value:', bankBICValueResponse
    * print 'bankBICNodeResponse Value:', bankBICNodeResponse
    * print 'originalRequestMsgIdValueResponse Value:', originalRequestMsgIdValueResponse

    * match statusValueResponse == 'ACTC'
    * match descValueResponse == 'AcceptedTechnicalValidation'
