Feature: Payment Cancelling Request Workflow

Scenario Outline: DA init pacs.008, DA pass screening, DA's node status: <daDownNode>, CA's node status: <caDownNode>, IA's node status: <iaDownNode>, Both CA and IA send pacs.002 ACSP, DA stop payment, node(s) up
  * def requestParameters =
  """
    {
    'daNode': {'bic': '#(daBIC)', status: '#(daDownNode)'},
    'caNode': {'bic': '#(caBIC)', status: '#(caDownNode)'},
    'iaNode': {'bic': '#(iaBIC)', status: '#(iaDownNode)'},
    'originalMsgId': '#(msgId)',
    'originalMsgDefId': 'pacs.008.001.02',
    'originalInstructionId': '#(instrId)',
    'originalEndToEndId': '#(endToEndId)',
    'originalTransactionId': '#(txId)'
    }
  """
  * karate.call('classpath:com/wizeline/assignments/features/complex/assignment-DA-SendCreditInstruction-Admi007Resp.feature')
  * karate.call('classpath:com/wizeline/assignments/features/complex/assignment-DA-Receive-Pacs008.feature')
  * karate.call('classpath:com/wizeline/assignments/features/complex/assignment-DA-SendPacs.002-ACFC.feature')
  * karate.call('classpath:com/wizeline/assignments/features/complex/assignment-IA-SendPacs.002-ACSP-ServerDown.feature')
  * karate.call('classpath:com/wizeline/assignments/features/complex/assignment-CA-SendPacs.002-ACSP-ServerDown.feature')
  * karate.call('classpath:com/wizeline/assignments/features/complex/assignment-DA-SendCamt.056-ServerDown.feature')
  * karate.call('classpath:com/wizeline/assignments/features/complex/assignment-DA-Receive-Admi004-QRTY.feature', requestParameters)
  * karate.call('classpath:com/wizeline/assignments/features/complex/assignment-DA-Receive-Admi004-RESM-Camt056.feature', requestParameters)
  * karate.call('classpath:com/wizeline/assignments/features/complex/assignment-DA-Receive-Admi007-ACTC.feature', requestParameters)
  * karate.call('classpath:com/wizeline/assignments/features/complex/assignment-CA-Receive-Camt056.feature', requestParameters)
  * karate.call('classpath:com/wizeline/assignments/features/complex/assignment-IA-Receive-Camt056.feature', requestParameters)
  * karate.call('classpath:com/wizeline/assignments/features/complex/assignment-CA-Receive-Admi004-RESM-Pacs002.feature', requestParameters)
  * karate.call('classpath:com/wizeline/assignments/features/complex/assignment-IA-Receive-Admi004-RESM-Pacs002.feature', requestParameters)
  * karate.call('classpath:com/wizeline/assignments/features/complex/assignment-DA-Receive-Pacs002-ACSP.feature', requestParameters)
  * karate.call('classpath:com/wizeline/assignments/features/complex/assignment-DA-Receive-Camt029-CNCL.feature', requestParameters)
  * karate.call('classpath:com/wizeline/assignments/features/complex/assignment-DA-Receive-Pacs002-CANC.feature', requestParameters)
  * karate.call('classpath:com/wizeline/assignments/features/complex/assignment-CA-Receive-Pacs002-CANC.feature', requestParameters)
  * karate.call('classpath:com/wizeline/assignments/features/complex/assignment-IA-Receive-Pacs002-CANC.feature', requestParameters)

  Examples:
    |testcasId | daBIC | caBIC | iaBIC   |msgId   	          |instrId 	             |endToEndId 	          |txId                 |currency	|amount  |daMsgPacs002Id|caMsgPacs002Id|iaMsgPacs002Id|daMsgCamt056Id|daDownNode|caDownNode|iaDownNode|
    |1 	    | CHASSGSG | DBSSSGSG | CHASUS33	  |Pacs00820240251636 |InstrId202402051636 	 |EndToEndId202402051636  |TxId202402051636 	|SGD 		|100     |DAPacs00200820240251530|CAPacs00200820240251530 |IAPacs00200820240251530|DACamt05600820240251530|NA|Tessera|NA|
    |2 		| CHASSGSG | DBSSSGSG | CHASUS33	  |Pacs00820240261430 |InstrId20240261430 	 |EndToEndId20240261430   |TxId20240261430 	|SGD 		|100     |DAPacs00200820240261430|CAPacs00200820240261430 |IAPacs00200820240261430|DACamt05600820240261430|NA|NA|Tessera|
    |3 		| CHASSGSG | DBSSSGSG | CHASUS33	  |Pacs00820240270808 |InstrId20240270808 	 |EndToEndId20240270808   |TxId20240270808 	|SGD 		|100     |DAPacs00200820240270808|CAPacs00200820240270808 |IAPacs00200820240270808|DACamt05600820240270808|Tessera|Tessera|Quorum|