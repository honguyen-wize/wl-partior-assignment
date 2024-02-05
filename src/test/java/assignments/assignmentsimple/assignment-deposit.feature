Feature: Deposit Feature

Scenario Outline: Participant Bank successfully deposits

    * karate.call('classpath:assignments/assignmentsimple/assignment-3129.feature')

    Examples:
    |testcasId      |settlementBankBIC   	|participantBankBIC 	|currency	|depositAmount  |
    |3.1.1 		    |CHASUS33 		        |CHASSGSG 		        |USD 		|200000         |
    # |3.1.2 		    |DBSSSGSG 		        |DBSSSGSG 		        |SGD 		|200000         |
    # |3.1.3 		    |CHASUS33 		        |DBSSSGSG 		        |USD 		|200000         |
    # |3.1.4		    |DBSSSGSG 		        |CHASSGSG 		        |SGD 		|20000          |