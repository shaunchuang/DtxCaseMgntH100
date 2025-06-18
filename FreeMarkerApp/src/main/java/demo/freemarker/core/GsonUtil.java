package demo.freemarker.core;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import java.lang.reflect.Type;
import java.util.List;
import org.json.JSONObject;

public class GsonUtil {

    private static final Gson GSON = new GsonBuilder().setPrettyPrinting().disableHtmlEscaping().create();

    /**
     * 將物件轉換為 JSON 字串
     * @param object 欲轉換的物件
     * @return JSON 字串
     */
    public static String toJson(Object object) {
        return GSON.toJson(object);
    }

    /**
     * 將 JSON 字串轉換為指定類型的 Java 物件
     * @param json JSON 字串
     * @param classOfT 物件類型
     * @param <T> 泛型類型
     * @return 轉換後的物件
     */
    public static <T> T fromJson(String json, Class<T> classOfT) {
        return GSON.fromJson(json, classOfT);
    }

    /**
     * 將 JSON 字串轉換為 List<T>
     * @param json JSON 字串
     * @param typeOfT 目標類型
     * @param <T> 泛型類型
     * @return 轉換後的 List<T>
     */
    public static <T> List<T> fromJsonToList(String json, Type typeOfT) {
        return GSON.fromJson(json, typeOfT);
    }
    
        /**
     * 將任意 Java 物件轉成 Gson 的 JsonElement
     * @param object 欲轉換的物件
     * @return JsonElement 表示的 JSON 樹狀結構
     */
    public static JsonElement toJsonElement(Object object) {
        return GSON.toJsonTree(object);
    }

    /**
     * 將任意 Java 物件轉成 Gson 的 JsonObject
     * @param object 欲轉換的物件
     * @return JsonObject 表示的 JSON 物件（只適用於物件對應到 JSON object 的情況）
     * @throws IllegalStateException 如果 object 序列化後不是 JSON 物件（例如是陣列或原始值），則會丟 IllegalStateException
     */
    public static JSONObject toJsonObject(Object object) {
        return new JSONObject(GsonUtil.toJson(object));
    }
    
}
