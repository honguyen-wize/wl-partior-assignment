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
