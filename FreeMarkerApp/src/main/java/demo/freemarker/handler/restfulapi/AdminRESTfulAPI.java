package demo.freemarker.handler.restfulapi;

import com.sun.net.httpserver.HttpExchange;
import demo.freemarker.core.DAOManager;
import itri.sstc.framework.core.api.RESTfulAPI;
import itri.sstc.framework.core.api.RESTfulAPI.RESTfulAPIDefine;
import java.io.IOException;
import java.net.HttpURLConnection;

public class AdminRESTfulAPI extends RESTfulAPI {

    public AdminRESTfulAPI() {
    }

    @Override
    public String getContextPath() {
        return "/admin/api/";
    }

    @RESTfulAPIDefine(url = "flush", methods = "get", description = "")
    private String flush(HttpExchange exchange) throws IOException {
        try {
            DAOManager.flushAllDAOs();
        } catch (Exception ex) {
            ex.printStackTrace();
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_NOT_FOUND, 0);
            return null;
        }
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return null;
    }
}
