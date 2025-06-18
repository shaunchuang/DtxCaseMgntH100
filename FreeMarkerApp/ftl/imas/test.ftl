<#import "/util/spring.ftl" as spring />


<!DOCTYPE html>
<html>
    <body>

        <select id='lang' onchange='document.cookie = "_freemarker_lang=" + this.value + "; path=/;"' >
            <option value=''> 其他 </option>
            <option value='zh_TW' >中文</option>
            <option value='en_US' >英文</option>

        </select>

        <h1>Welcome ${user!""}!</h1>

        <div class='text' >
        </div>

        <div class='text' >
            ${string}
        </div>

        <#-- String.replace -->
        <div class='text' >
            ${string?replace("bc","BC")}
        </div>

        <div class='text'>
        ${now?string("yyyy年MM月dd日 HH:mm:ss")}
        </div>

        <div class='lang' >
            <@spring.message "message" />
            <br>
            <@spring.message "message1" />
        </div>
    </body>

</html>
