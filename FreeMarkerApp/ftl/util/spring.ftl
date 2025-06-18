<#--
 * message
 *
 * Macro to translate a message code into a message.
 -->
<#macro message code>${requestContext.getMessage(code, "")}</#macro>

