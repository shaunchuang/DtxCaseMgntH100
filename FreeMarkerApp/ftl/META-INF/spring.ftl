<#ftl strip_whitespace=true> 
<#assign number_format="############.###">
<#assign boolean_format="true,false">
<#assign date_format="yyyy-MM-dd">
<#assign time_format="HH:mm:ss">
<#assign time_format2="HH:mm">
<#assign datetime_format="yyyy-MM-dd HH:mm:ss">
<#assign datetime_format2="yyyy-MM-dd HH:mm">
<#--
 * spring.ftl
 *
 * This file consists of a collection of FreeMarker macros aimed at easing
 * some of the common requirements of web applications - in particular
 * handling of forms.
 *
 * Spring's FreeMarker support will automatically make this file and therefore
 * all macros within it available to any application using Spring's
 * FreeMarkerConfigurer.
 *
 * To take advantage of these macros, the "exposeSpringMacroHelpers" property
 * of the FreeMarker class needs to be set to "true". This will expose a
 * RequestContext under the name "springMacroRequestContext", as needed by
 * the macros in this library.
 *
 * @author Darren Davison
 * @author Juergen Hoeller
 * @since 1.1 
 * modified by kernoli 2014/07/31
 -->

<#--
 * message
 *
 * Macro to translate a message code into a message.
 -->
<#macro message code>${springMacroRequestContext.getMessage(code)}</#macro>

<#--
 * messageText
 *
 * Macro to translate a message code into a message,
 * using the given default text if no message found.
 -->
<#macro messageText code, text>${springMacroRequestContext.getMessage(code, text)}</#macro>

<#--
 * messageArgs
 *
 * Macro to translate a message code with arguments into a message.
 -->
<#macro messageArgs code, args>${springMacroRequestContext.getMessage(code, args)}</#macro>

<#--
 * messageArgsText
 *
 * Macro to translate a message code with arguments into a message,
 * using the given default text if no message found.
 -->
<#macro messageArgsText code, args, text>${springMacroRequestContext.getMessage(code, args, text)}</#macro>

<#--
 * theme
 *
 * Macro to translate a theme message code into a message.
 -->
<#macro theme code>${springMacroRequestContext.getThemeMessage(code)}</#macro>

<#--
 * themeText
 *
 * Macro to translate a theme message code into a message,
 * using the given default text if no message found.
 -->
<#macro themeText code, text>${springMacroRequestContext.getThemeMessage(code, text)}</#macro>

<#--
 * themeArgs
 *
 * Macro to translate a theme message code with arguments into a message.
 -->
<#macro themeArgs code, args>${springMacroRequestContext.getThemeMessage(code, args)}</#macro>

<#--
 * themeArgsText
 *
 * Macro to translate a theme message code with arguments into a message,
 * using the given default text if no message found.
 -->
<#macro themeArgsText code, args, text>${springMacroRequestContext.getThemeMessage(code, args, text)}</#macro>

<#--
 * url
 *
 * Takes a relative URL and makes it absolute from the server root by
 * adding the context root for the web application.
 -->
<#macro url relativeUrl>${springMacroRequestContext.getContextUrl(relativeUrl)}</#macro>

<#--
 * bind
 *
 * Exposes a BindStatus object for the given bind path, which can be
 * a bean (e.g. "person") to get global errors, or a bean property
 * (e.g. "person.name") to get field errors. Can be called multiple times
 * within a form to bind to multiple command objects and/or field names.
 *
 * This macro will participate in the default HTML escape setting for the given
 * RequestContext. This can be customized by calling "setDefaultHtmlEscape"
 * on the "springMacroRequestContext" context variable, or via the
 * "defaultHtmlEscape" context-param in web.xml (same as for the JSP bind tag).
 * Also regards a "htmlEscape" variable in the namespace of this library.
 *
 * Producing no output, the following context variable will be available
 * each time this macro is referenced (assuming you import this library in
 * your templates with the namespace 'spring'):
 *
 *   spring.status : a BindStatus instance holding the command object name,
 *   expression, value, and error messages and codes for the path supplied
 *
 * @param path : the path (string value) of the value required to bind to.
 *   Spring defaults to a command name of "command" but this can be overridden
 *   by user config.
 -->
<#macro bind path>
    <#if htmlEscape?exists>
        <#assign status = springMacroRequestContext.getBindStatus(path, htmlEscape)>
    <#else>
        <#assign status = springMacroRequestContext.getBindStatus(path)>
    </#if>
    <#-- assign a temporary value, forcing a string representation for any
    kind of variable. This temp value is only used in this macro lib -->
    <#if status.value?exists && status.value?is_boolean>
        <#assign stringStatusValue=status.value?string>
    <#else>
        <#assign stringStatusValue=status.value?default("")>
    </#if>
</#macro>

<#--
 * bindEscaped
 *
 * Similar to spring:bind, but takes an explicit HTML escape flag rather
 * than relying on the default HTML escape setting.
 -->
<#macro bindEscaped path, htmlEscape>
    <#assign status = springMacroRequestContext.getBindStatus(path, htmlEscape)>
    <#-- assign a temporary value, forcing a string representation for any
    kind of variable. This temp value is only used in this macro lib -->
    <#if status.value?exists && status.value?is_boolean>
        <#assign stringStatusValue=status.value?string>
    <#else>
        <#assign stringStatusValue=status.value?default("")>
    </#if>
</#macro>

<#--
 * formInput
 *
 * Display a form input field of type 'text' and bind it to an attribute
 * of a command or bean.
 *
 * @param path the name of the field to bind to
 * @param attributes any additional attributes for the element (such as class
 *    or CSS styles or size
 -->
<#macro formInput path attributes="" fieldType="text" defaultValue="">
    <@bind path/>
    <#-- <input type="${fieldType}" id="${status.expression}" name="${status.expression}" value="<#if fieldType!="password">${stringStatusValue}</#if>" ${attributes}<@closeTag/> -->
    <input type="${fieldType}" id="${status.expression}" name="${status.expression}" value="<#if fieldType!="password"><#if stringStatusValue?has_content >${stringStatusValue}<#else>${defaultValue}</#if></#if>" ${attributes}<@closeTag/>
</#macro>

<#macro formFHIRInput value name attributes="" fieldType="" format="">
	<input type="${fieldType}" id="${name}" name="${name}" value="${value}" ${attributes}/>
</#macro> 

<#macro formPasswordInput path attributes="" fieldType="password" defaultValue="">
    <@bind path/>
    <#-- <input type="${fieldType}" id="${status.expression}" name="${status.expression}" value="<#if fieldType!="password">${stringStatusValue}</#if>" ${attributes}<@closeTag/> -->
    <input type="${fieldType}" id="${status.expression}" name="${status.expression}" value="<#if fieldType!="password"><#if stringStatusValue?has_content >${stringStatusValue}<#else>${defaultValue}</#if></#if>" ${attributes}<@closeTag/>
</#macro>

<#--
 * formDateInput
 -->
<#macro formDateInput path attributes="" fieldType="text" format="">
	<@bind path/>
	<input type="${fieldType}" id="${status.expression}" name="${status.expression}" value="<#if fieldType!="password"><#if stringStatusValue?has_content ><#assign datetime=stringStatusValue?datetime("yyyy-MM-dd HH:mm")><#else><#assign datetime=.now></#if><#if format?exists && format?has_content>${datetime?string(format)}<#else>${datetime}</#if></#if>" ${attributes}<@closeTag/>
</#macro>

<#macro formDateStrInput value name attributes="" fieldType="text" format="">	
	<input type="${fieldType}" id="${name}" name="${name}" value="<#if value?has_content>${value?string(format)}</#if>" ${attributes}/>
</#macro>
<#--
 * formPasswordInput
 *
 * Display a form input field of type 'password' and bind it to an attribute
 * of a command or bean. No value will ever be displayed. This functionality
 * can also be obtained by calling the formInput macro with a 'type' parameter
 * of 'password'.
 *
 * @param path the name of the field to bind to
 * @param attributes any additional attributes for the element (such as class
 *    or CSS styles or size
 -->
<#macro formPasswordInput path attributes="">
    <@formInput path, attributes, "password"/>
</#macro>

<#--
 * formHiddenInput
 *
 * Generate a form input field of type 'hidden' and bind it to an attribute
 * of a command or bean. This functionality can also be obtained by calling
 * the formInput macro with a 'type' parameter of 'hidden'.
 *
 * @param path the name of the field to bind to
 * @param attributes any additional attributes for the element (such as class
 *    or CSS styles or size
 -->
<#macro formHiddenInput path attributes="" defaultValue="">
    <@formInput path, attributes, "hidden" defaultValue/>
</#macro>

<#--
 * formTextarea
 *
 * Display a text area and bind it to an attribute of a command or bean.
 *
 * @param path the name of the field to bind to
 * @param attributes any additional attributes for the element (such as class
 *    or CSS styles or size
 -->
<#macro formTextarea path attributes="">
    <@bind path/>
    <textarea id="${status.expression}" name="${status.expression}" ${attributes}>${stringStatusValue}</textarea>
</#macro>

<#macro formSpan path attributes="">
    <@bind path/>
    <span id="${status.expression}" name="${status.expression}" ${attributes}>${stringStatusValue}</span>
</#macro>

<#--
 * formSingleSelect
 *
 * Show a selectbox (dropdown) input element allowing a single value to be chosen
 * from a list of options.
 *
 * @param path the name of the field to bind to
 * @param options a map (value=label) of all the available options
 * @param attributes any additional attributes for the element (such as class
 *    or CSS styles or size
-->
<#--
<#macro formSingleSelect path options attributes="">
    <@bind path/>
    <select id="${status.expression}" name="${status.expression}" ${attributes}>
        <#if options?is_hash>
            <#list options?keys as value>
            <option value="${value?html}"<@checkSelected value/>>${options[value]?html}</option>
            </#list>
        <#else> 
            <#list options as value>
            <option value="${value?html}"<@checkSelected value/>>${value?html}</option>
            </#list>
        </#if>
    </select>
</#macro>
-->
<#-- modify by Gao Youbo -->
<#--<#macro formSingleSelect path options valueAttr="id" textAttr="name" attributes="" has_default=true>
    <@bind path/>
    <select id="${status.expression}" name="${status.expression}" ${attributes}>
    	<#if has_default>
    		<option value="">--請選擇--</option>
    	<#else>
    		<option value="">--Choose--</option>	
    	</#if>
        <#if options?is_hash>
            <#list options?keys as value>
            	<option value="${value?html}"<@checkSelected value/>>${options[value]?html}</option>
            </#list>
        <#else>
            <#list options as value>
	            <#assign v = value['${valueAttr}']?html />
	            <#assign text = value['${textAttr}']?html />
	            <option value="${v}"<@checkSelected v/>>${text}</option>
            </#list>
        </#if>
    </select>
</#macro>-->

<#macro enumWidget name enum options className="">
	<#if enum=="">
  		<#assign code = "">
	<#else>
		<#assign code = enum.toCode()>
	</#if>
	<@selectWidget name code options className />
</#macro>

<#macro selectWidget name value options className>
	 <select class="form-control ${className}" name="${name}" >
	 	<option value="" <#if value=="">selected</#if>>請選擇</option>
	 	<#list options?keys as key>
	 		<#if key??>
	 			<option value="${key}" <#if value==key>selected</#if>>${options[key]}</option>
	 		</#if>
	 	</#list>
	</select> 
</#macro>

<#macro criteriaSelectWidget options className placeholder>
	 <select class="form-control ${className}" aria-describedby="basic-addon1" >
	 	<option value="" selected>請選擇${placeholder}</option>
	 	<#list options?keys as key>
	 		<#if key??>
	 			<option value="${key}" >${options[key]}</option>
	 		</#if>
	 	</#list>
	</select> 
</#macro>

<#--
 * formMultiSelect
 *
 * Show a listbox of options allowing the user to make 0 or more choices from
 * the list of options.
 *
 * @param path the name of the field to bind to
 * @param options a map (value=label) of all the available options
 * @param attributes any additional attributes for the element (such as class
 *    or CSS styles or size
-->
<#macro formSingleSelect path options attributes="">
	<@bind path/>
	 <select id="${status.expression}" name="${status.expression}" ${attributes} >
	 	<option value="" <#if stringStatusValue=="">selected</#if>>請選擇</option>
	 	<#list options?keys as value>
		<option value="${value}" <#if stringStatusValue==value>selected</#if>>${options[value]}</option>
	 	</#list>
	</select> 
</#macro>

<#macro formMultiSelect path options attributes="">
    <@bind path/>
    <select multiple="multiple" id="${status.expression}" name="${status.expression}" ${attributes}>
        <#list options?keys as value>
        <#assign isSelected = contains(status.value?default([""]), value)>
        <option value="${value?html}"<#if isSelected> selected="selected"</#if>>${options[value]?html}</option>
        </#list>
    </select>
</#macro>

<#--
 * formRadioButtons
 *
 * Show radio buttons.
 *
 * @param path the name of the field to bind to
 * @param options a map (value=label) of all the available options
 * @param separator the html tag or other character list that should be used to
 *    separate each option. Typically '&nbsp;' or '<br>'
 * @param attributes any additional attributes for the element (such as class
 *    or CSS styles or size
-->
<#macro formRadioButtons path options separator defaultValue=null attributes="">
    <@bind path/>
    <#list options?keys as value>
    	<#assign id="${status.expression}${value_index}">
    	<#assign radio_checked="" />
    	<#if stringStatusValue?exists && stringStatusValue?has_content>
    		<#if stringStatusValue == value><#assign radio_checked='checked="checked"' /></#if>
    	<#else>
    		<#if defaultValue == value><#assign radio_checked='checked="checked"' /></#if>
    	</#if>
    	<#-- <input type="radio" id="${id}" name="${status.expression}" value="${value?html}"<#if stringStatusValue == value> checked="checked"</#if> ${attributes}<@closeTag/> -->
    	<label for="${id}"><input type="radio" id="${id}" name="${status.expression}" value="${value?html}" ${radio_checked} ${attributes}<@closeTag/>${options[value]?html}</label>${separator}
    </#list>
</#macro>

<#-- modify by Jian Hong -->
<#macro formEnumRadio path options separator defaultValue=null attributes="">
    <@bind path/>
	<#assign listEnums=enums[options] />
	<#list listEnums?values as enum>
	   	<#assign id="${status.expression}${enum_index}">
	   	<#assign radio_checked="" />
	   	<#if stringStatusValue?exists && stringStatusValue?has_content>
	   		<#if stringStatusValue == enum.id><#assign radio_checked='checked="checked"' /></#if>
	   	<#else>
	   		<#if defaultValue == enum.id><#assign radio_checked='checked="checked"' /></#if>
	   	</#if>
	   	<label for="${id}"><input type="radio" id="${id}" name="${status.expression}" value="${enum.id}" ${radio_checked} ${attributes}<@closeTag/>${enum.text}</label>${separator}
	</#list>
</#macro>

<#-- modify by Jian Hong -->
<#macro formEnumSelect path options attributes="" has_default=false>
    <@bind path/>
    <select id="${status.expression}" name="${status.expression}" ${attributes}>
    	<#if has_default>
    		<option value="">--請選擇--</option>
    	</#if>
    	<#assign listEnums=enums[options] />
    	<#list listEnums?values as enum>
    		<#assign v = enum.id />
	        <#assign text = enum.text />
	        <option value="${v}"<@checkSelected v/>>${text}</option>
    	</#list>
    	<#--
        <#if options?is_hash>
            <#list options?keys as value>
            	<option value="${value?html}"<@checkSelected value/>>${options[value]?html}</option>
            </#list>
        <#else>
            <#list options as value>
	            <#assign v = value['${valueAttr}']?html />
	            <#assign text = value['${textAttr}']?html />
	            <option value="${v}"<@checkSelected v/>>${text}</option>
            </#list>
        </#if>
        -->
    </select>
</#macro>

<#--
 * formCheckboxes
 *
 * Show checkboxes.
 *
 * @param path the name of the field to bind to
 * @param options a map (value=label) of all the available options
 * @param separator the html tag or other character list that should be used to
 *    separate each option. Typically '&nbsp;' or '<br>'
 * @param attributes any additional attributes for the element (such as class
 *    or CSS styles or size
-->
<#macro formCheckboxes path options separator attributes="">
    <@bind path/>
    <#list options?keys as value>
    <#assign id="${status.expression}${value_index}">
    <#assign isSelected = contains(status.value?default([""]), value)>
    <input type="checkbox" id="${id}" name="${status.expression}" value="${value?html}"<#if isSelected> checked="checked"</#if> ${attributes}<@closeTag/>
    <label for="${id}">${options[value]?html}</label>${separator}
    </#list>
    <input type="hidden" name="_${status.expression}" value="on"/>
</#macro>

<#--
 * formCheckbox
 *
 * Show a single checkbox.
 *
 * @param path the name of the field to bind to
 * @param attributes any additional attributes for the element (such as class
 *    or CSS styles or size
-->
<#macro formCheckbox path attributes="">
	<@bind path />
    <#assign id="${status.expression}">
    <#assign isSelected = status.value?? && (status.value?string=="true" || status.value?string=="1")>
	<input type="hidden" name="_${id}" value="on"/>
	<input type="checkbox" id="${id}" name="${id}"<#if isSelected> checked="checked"</#if> ${attributes}/>
</#macro>

<#macro formCheckboxOn path attributes="">
	<@bind path />
    <#assign id="${status.expression}">
    <#assign isSelected = status.value?? && status.value?string=="on">
	<input type="hidden" name="_${id}" value="on"/>
	<input type="checkbox" id="${id}" name="${id}"<#if isSelected> checked="checked"</#if> ${attributes}/>
</#macro>

<#macro formCheckboxOne path attributes="">
	<@bind path />
    <#assign id="${status.expression}">
    <#assign isSelected = status.value?? && status.value?string=="1">
	<input type="hidden" name="_${id}" value="1"/>
	<input type="checkbox" id="${id}" name="${id}"<#if isSelected> checked="checked"</#if> ${attributes}/>
</#macro>

<#macro formCheckboxTrue path attributes="">
	<@bind path />
    <#assign id="${status.expression}">
    <#assign isSelected = status.value?? && status.value?string=="true">
	<input type="hidden" name="_${id}" value="true"/>
	<input type="checkbox" id="${id}" name="${id}"<#if isSelected> checked="checked"</#if> ${attributes}/>
</#macro>

<#--
 * showErrors
 *
 * Show validation errors for the currently bound field, with
 * optional style attributes.
 *
 * @param separator the html tag or other character list that should be used to
 *    separate each option. Typically '<br>'.
 * @param classOrStyle either the name of a CSS class element (which is defined in
 *    the template or an external CSS file) or an inline style. If the value passed in here
 *    contains a colon (:) then a 'style=' attribute will be used, else a 'class=' attribute
 *    will be used.
-->
<#macro showErrors separator classOrStyle="">
    <#list status.errorMessages as error>
    <#if classOrStyle == "">
        <b>${error}</b>
    <#else>
        <#if classOrStyle?index_of(":") == -1><#assign attr="class"><#else><#assign attr="style"></#if>
        <span ${attr}="${classOrStyle}">${error}</span>
    </#if>
    <#if error_has_next>${separator}</#if>
    </#list>
</#macro>

<#--
 * checkSelected
 *
 * Check a value in a list to see if it is the currently selected value.
 * If so, add the 'selected="selected"' text to the output.
 * Handles values of numeric and string types.
 * This function is used internally but can be accessed by user code if required.
 *
 * @param value the current value in a list iteration
-->
<#macro checkSelected value>
    <#if stringStatusValue?is_number && stringStatusValue == value?number>selected="selected"</#if>
    <#if stringStatusValue?is_string && stringStatusValue == value>selected="selected"</#if>
</#macro>


<#--
 * contains
 *
 * Macro to return true if the list contains the scalar, false if not.
 * Surprisingly not a FreeMarker builtin.
 * This function is used internally but can be accessed by user code if required.
 *
 * @param list the list to search for the item
 * @param item the item to search for in the list
 * @return true if item is found in the list, false otherwise
-->
<#function contains list item>
    <#list list as nextInList>
    <#if nextInList == item><#return true></#if>
    </#list>
    <#return false>
</#function>

<#--
 * closeTag
 *
 * Simple macro to close an HTML tag that has no body with '>' or '/>',
 * depending on the value of a 'xhtmlCompliant' variable in the namespace
 * of this library.
-->
<#macro closeTag>
    <#if xhtmlCompliant?exists && xhtmlCompliant>/><#else>></#if>
</#macro>
