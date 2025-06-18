/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package demo.freemarker.core;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.Collections;
import java.util.List;
import java.util.Locale;
import java.util.Properties;
import java.util.ResourceBundle;

/**
 *
 * @author zhush
 */
public class MessageSource {
    public static String getMessage(String key, Locale locale){
        if (key == null || locale == null) {
            return null;
        }
        try {
            ResourceBundle.Control control = new ResourceBundle.Control() {
                @Override
                public List<Locale> getCandidateLocales(String baseName, Locale locale) {
                    // 只允許三種語系
                    if (locale.equals(new Locale("zh", "TW"))) {
                        return Collections.singletonList(new Locale("zh", "TW"));
                    } else if (locale.equals(new Locale("en", "US"))) {
                        return Collections.singletonList(new Locale("en", "US"));
                    } else if (locale.equals(new Locale("th", "TH"))) {
                        return Collections.singletonList(new Locale("th", "TH"));
                    } else {
                        // fallback: 預設語系
                        return Collections.singletonList(new Locale("zh", "TW"));
                    }
                }
                @Override
                public List<String> getFormats(String baseName) {
                    return Collections.singletonList("java.properties");
                }
                @Override
                public ResourceBundle newBundle(String baseName, Locale locale, String format, ClassLoader loader, boolean reload)
                        throws IllegalAccessException, InstantiationException, IOException {
                    String bundleName = toBundleName(baseName, locale);
                    String resourceName = bundleName + ".properties";
                    File file = new File(resourceName);
                    if (file.exists()) {
                        try (InputStream stream = new FileInputStream(file);
                             InputStreamReader reader = new InputStreamReader(stream, StandardCharsets.UTF_8)) {
                            Properties properties = new Properties();
                            properties.load(reader);
                            return new ResourceBundle() {
                                @Override
                                protected Object handleGetObject(String key) {
                                    return properties.getProperty(key);
                                }
                                @Override
                                public java.util.Enumeration<String> getKeys() {
                                    return java.util.Collections.enumeration(properties.stringPropertyNames());
                                }
                            };
                        }
                    }
                    return null;
                }
            };
            ResourceBundle bundle = ResourceBundle.getBundle("messages", locale, control);
            return bundle.getString(key);
        } catch (Exception e) {
            return key;
        }
    }
}
