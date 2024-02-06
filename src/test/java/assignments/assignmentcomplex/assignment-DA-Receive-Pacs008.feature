Feature: Participant Bank deposits from their off-chain account to their On-chain account

Background:
  * url complexBaseUrl
  * header MsgId = karate.get('msgId')

Scenario: DA receive pacs.008

    #3 : DA receive pacs.008
    Given path '/acknowledge/pacs008'
    And request {}
    When method post
    Then status 200

