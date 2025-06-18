package demo.freemarker.core;

import java.util.Collection;

public class StringUtils extends org.apache.commons.lang3.StringUtils {

    /**
     * 將字串中從指定位置開始到結尾的字元替換為指定字元
     */
    public static String replace(String old, int start, char c) {
        if (old == null) return old;
        return replace(old, start, old.length(), c);
    }

    /**
     * 將字串中指定範圍的字元替換為指定字元
     */
    public static String replace(String old, int start, int end, char c) {
        if (old == null || start > end || start >= old.length()) return old;
        StringBuilder sb = new StringBuilder(old);
        for (int i = start; i < end; i++) {
            sb.setCharAt(i, c);
        }
        return sb.toString();
    }

    /**
     * 將 null 字串轉換為空字串
     */
    public static String null2Empty(String str) {
        if (str == null) return "";
        return str;
    }

    /**
     * 檢查字串是否包含指定關鍵字
     */
    public static boolean contains(String str, String keyword) {
        return isNotEmpty(str) && str.contains(keyword);
    }

    /**
     * 建立 SQL IN 子句的參數佔位符
     */
    public static <T> String buildInClause(Collection<T> list) {
        if (list == null || list.size() == 0) return "";
        if (list.size() == 1) return "?";
        return "?" + StringUtils.repeat(",?", list.size() - 1);
    }

    /**
     * 建立 SQL IN 子句的參數佔位符（陣列版本）
     */
    public static <T> String buildInClause(T[] arr) {
        if (arr == null || arr.length == 0) return "";
        if (arr.length == 1) return "?";
        return "?" + StringUtils.repeat(",?", arr.length - 1);
    }

    /**
     * 計算字串的 UTF-8 編碼長度
     */
    public static int utf8LenCounter(CharSequence sequence) {
        int count = 0;
        for (int i = 0, len = sequence.length(); i < len; i++) {
            char ch = sequence.charAt(i);
            if (ch <= 0x7F) {
                count++;
            } else if (ch <= 0x7FF) {
                count += 2;
            } else if (Character.isHighSurrogate(ch)) {
                count += 4;
                ++i;
            } else {
                count += 3;
            }
        }
        return count;
    }
}
