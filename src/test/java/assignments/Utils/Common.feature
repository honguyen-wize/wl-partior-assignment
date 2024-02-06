@ignore
Feature: Common

Scenario:
    * def getCurrentUTCDate =
    """
    function() {
        var ZonedDateTime = Java.type('java.time.ZonedDateTime')
        var DateTimeFormatter = Java.type('java.time.format.DateTimeFormatter')
        var currentDateTime = ZonedDateTime.now(Java.type('java.time.ZoneId').of('UTC'))
        var outputFormatter = DateTimeFormatter.ofPattern('yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'')
        return currentDateTime.format(outputFormatter)
    } 
    """

     * def getDatePart =
    """
    function(dateString) {
      return java.time.LocalDateTime.parse(dateString, java.time.format.DateTimeFormatter.ISO_DATE_TIME).toLocalDate().toString()
    } 
    """

    # Function to validate Posting Entry
    * def validatePostingEntry =
    """
    function(postingEntry, currentDate, expectedExecStatus) {
        if (!(postingEntry.CdtDbtInd === 'CREDIT' || postingEntry.CdtDbtInd === 'DEBIT')) {
            karate.fail('Assertion failed: creditDebit should be CREDIT or DEBIT');
        }
        if (getDatePart(postingEntry.BookgDt) !== currentDate) {
            karate.fail('Assertion failed: bookingDate should match current date');
        }
        if (getDatePart(postingEntry.ValueDt) !== currentDate) {
            karate.fail('Assertion failed: valueDate should match current date');
        }
        if (getDatePart(postingEntry.ExposureDt) !== currentDate) {
            karate.fail('Assertion failed: exposureDate should match current date');
        }
        if (getDatePart(postingEntry.StlmntDt) !== currentDate) {
            karate.fail('Assertion failed: settlementDate should match current date');
        }
        if (postingEntry.ExecStatus !== expectedExecStatus) {
            karate.fail('Assertion failed: ExecStatus should be GENERATED');
        }
        if (!postingEntry.PostingRefNum) {
            karate.fail('Assertion failed: PostingRefNum should not be empty');
        }
    }
    """

    # * def getCurrentLocalDate =
    # """
    # function() {
    #   var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
    #   var sdf = new SimpleDateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    #   var date = new java.util.Date();
    #   return sdf.format(date);
    # } 
    # """

    # * def getDateLocalPart =
    # """
    # function(dateString) {
    #   return java.time.LocalDateTime.parse(dateString, java.time.format.DateTimeFormatter.ofPattern('yyyy-MM-dd HH:mm:ss.SSS')).toLocalDate().toString()
    # } 
    # """
