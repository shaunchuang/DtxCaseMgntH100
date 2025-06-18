/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package demo.freemarker.core;

/**
 *
 * @author zhush
 */

import itri.sstc.framework.core.database.BaseDAO;
import java.lang.reflect.Method;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.reflections.Reflections;

/**
 * DAOManager：負責掃描 demo.freemarker.dao 套件底下，所有繼承 BaseDAO 的 DAO，
 * 然後呼叫它們各自的 sync() (flush) 方法。
 */
public class DAOManager {
    private static final Logger logger = Logger.getLogger(DAOManager.class.getName());

    // 指定要掃描的 package
    private static final String DAO_PACKAGE = "demo.freemarker.dao";

    /**
     * 掃描並呼叫所有 DAO 的 sync()
     */
    public static void flushAllDAOs() {
        // 1. 建立 Reflections 物件，指定要掃描的 package
        Reflections reflections = new Reflections(DAO_PACKAGE);

        // 2. 找出所有繼承自 BaseDAO 的子類別
        Set<Class<? extends BaseDAO>> daoClasses = reflections.getSubTypesOf(BaseDAO.class);

        // 3. 逐一處理
        for (Class<? extends BaseDAO> daoClazz : daoClasses) {
            try {
                // 3-1. 嘗試呼叫「public static getInstance()」這種常見的單例方法，取得 DAO 實例
                //     注意：假設所有 DAO 都有一個無參數的 public static getInstance() 方法
                Method getInstanceMethod = daoClazz.getMethod("getInstance");
                Object daoInstance = getInstanceMethod.invoke(null);

                if (daoInstance instanceof BaseDAO) {
                    BaseDAO dao = (BaseDAO) daoInstance;
                    // 3-2. 呼叫 sync()
                    dao.sync();
                    logger.log(Level.INFO, "已對 {0} 呼叫 sync()", daoClazz.getSimpleName());
                } else {
                    logger.log(Level.WARNING, "{0}.getInstance() 回傳結果並非 BaseDAO", daoClazz.getSimpleName());
                }
            } catch (NoSuchMethodException nsme) {
                logger.log(Level.WARNING, "{0} 類別沒有定義 public static getInstance() 方法，無法取得實例。", daoClazz.getSimpleName());
            } catch (Exception ex) {
                logger.log(Level.SEVERE, "呼叫 {0}.sync() 時發生例外", new Object[]{daoClazz.getSimpleName()});
                logger.log(Level.SEVERE, ex.getMessage(), ex);
            }
        }
    }
}
