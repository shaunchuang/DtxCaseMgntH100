package demo.freemarker.core;

import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.json.JSONObject;

public class JsonUtil {
    /**
     * 將 lessonDescription 中所有未跳脫的雙引號都替換成 \"
     */
    public static String escapeLessonDescription(String rawJson) {
        Pattern p = Pattern.compile(
            "\"lessonDescription\"\\s*:\\s*\"(.*?)\"(?=\\s*,\\s*\"[^\"]+\"\\s*:)", 
            Pattern.DOTALL
        );
        Matcher m = p.matcher(rawJson);
        if (m.find()) {
            String desc = m.group(1);
            String escaped = desc.replace("\"", "\\\"");
            rawJson = rawJson.substring(0, m.start(1))
                    + escaped
                    + rawJson.substring(m.end(1));
        }
        return rawJson;
    }

    public static JSONObject toJSONObject(String rawJson) {
        // 先處理 lessonDescription
        String fixedJson = escapeLessonDescription(rawJson);
        // 再用 org.json 解析
        return new JSONObject(fixedJson);
    }
}
