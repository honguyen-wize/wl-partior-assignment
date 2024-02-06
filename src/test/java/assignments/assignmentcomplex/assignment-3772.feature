Feature: Payment Cancelling Request Workflow

Scenario Outline: Payment Cancelling Request

  * karate.call('classpath:assignments/assignmentcomplex/assignment-DA-SendCreditInstruction-Admi007Resp.feature')
  * karate.call('classpath:assignments/assignmentcomplex/assignment-DA-Receive-Pacs008.feature')
  * karate.call('classpath:assignments/assignmentcomplex/assignment-DA-SendPacs.002-ACFC.feature')
  * karate.call('classpath:assignments/assignmentcomplex/assignment-IA-SendPacs.002-ACSP-ServerDown.feature')
  * karate.call('classpath:assignments/assignmentcomplex/assignment-CA-SendPacs.002-ACSP-ServerDown.feature')
  * karate.call('classpath:assignments/assignmentcomplex/assignment-DA-SendCamt.056-ServerDown.feature')
  * karate.call('classpath:assignments/assignmentcomplex/assignment-DA-Receive-Admi004-QRTY.feature')
  * karate.call('classpath:assignments/assignmentcomplex/assignment-DA-Receive-Admi004-RESM-Camt056.feature')
  * karate.call('classpath:assignments/assignmentcomplex/assignment-DA-Receive-Admi007-ACTC.feature')
  * karate.call('classpath:assignments/assignmentcomplex/assignment-CA-Receive-Camt056.feature')
  * karate.call('classpath:assignments/assignmentcomplex/assignment-IA-Receive-Camt056.feature')
  * karate.call('classpath:assignments/assignmentcomplex/assignment-CA-Receive-Admi004-RESM-Pacs002.feature')
  * karate.call('classpath:assignments/assignmentcomplex/assignment-IA-Receive-Admi004-RESM-Pacs002.feature')
  * karate.call('classpath:assignments/assignmentcomplex/assignment-DA-Receive-Pacs002-ACSP.feature')
  * karate.call('classpath:assignments/assignmentcomplex/assignment-DA-Receive-Camt029-CNCL.feature')
  * karate.call('classpath:assignments/assignmentcomplex/assignment-DA-Receive-Pacs002-CANC.feature')
  * karate.call('classpath:assignments/assignmentcomplex/assignment-CA-Receive-Pacs002-CANC.feature')
  * karate.call('classpath:assignments/assignmentcomplex/assignment-IA-Receive-Pacs002-CANC.feature')

  Examples:
    |testcasId    |msgId   	          |instrId 	             |endToEndId 	          |txId                 |currency	|amount  |daMsgPacs002Id|caMsgPacs002Id|iaMsgPacs002Id|daMsgCamt056Id|
    |3.1.1 		  |Pacs00820240251530 |InstrId202402051636 	 |EndToEndId202402051636  |TxId202402051636 	|USD 		|100     |DAPacs00200820240251530|CAPacs00200820240251530 |IAPacs00200820240251530      |DACamt05600820240251530|