package demo.freemarker.core;

import java.util.HashMap;

import org.json.JSONObject;

import demo.freemarker.api.ConfigPropertyAPI;
import demo.freemarker.dto.SyndromeDTO;
import java.util.ArrayList;
import java.util.List;
import org.json.JSONArray;

public class CrossPlatformUtil {
    
    private final static CrossPlatformUtil INSTANCE = new CrossPlatformUtil();

    public final static CrossPlatformUtil getInstance() {
        return INSTANCE;
    }

    private CrossPlatformUtil() {
    }

    public String findSyndromeById(Long tagId){
        String dtxStoreUrl = ConfigPropertyAPI.getInstance().getValueByKey("DtxStoreUrl");
        String url = dtxStoreUrl + "/DtxTag/api/get/id/" + tagId;
        HashMap<String, String> headers = new HashMap<>();
        headers.put("Content-Type", "application/json");
        try {
            String tagContent = HttpClientUtil.sendGetRequest(url, headers);
            JSONObject json = new JSONObject(tagContent);
            JSONObject tagItem = json.getJSONObject("tagItem");
            String syndrome = tagItem.optString("tagName");
            return syndrome;
        } catch (Exception e ){
            e.printStackTrace();
        }
        return null;

    }

    public List<SyndromeDTO> listSyndrome(){
        String dtxStoreUrl = ConfigPropertyAPI.getInstance().getValueByKey("DtxStoreUrl");
        String url = dtxStoreUrl + "/DtxTag/api/list/type/1";
        HashMap<String, String> headers = new HashMap<>();
        headers.put("Content-Type", "application/json");
        try {
            String tagContent = HttpClientUtil.sendGetRequest(url, headers);
            JSONObject jsonContent = new JSONObject(tagContent);
            JSONArray syndromeList = jsonContent.getJSONArray("tagList");
            List<SyndromeDTO> syndromeDTOList = new ArrayList<>();
            for (int i = 0; i < syndromeList.length(); i++) {
                JSONObject json = syndromeList.getJSONObject(i);
                SyndromeDTO syndromeDTO = new SyndromeDTO();
                syndromeDTO.setId(json.getLong("id"));
                syndromeDTO.setName(json.getString("tagName"));
                syndromeDTOList.add(syndromeDTO);
            }
            return syndromeDTOList;
        } catch (Exception e ){
            e.printStackTrace();
        }
        return null;
    }

    public String getLessonName(Long lessonId) {
        String dtxStoreUrl = ConfigPropertyAPI.getInstance().getValueByKey("DtxStoreUrl");
        String url = dtxStoreUrl + "/LessonMainInfo/api/get/lessonId/" + lessonId;
        HashMap<String, String> headers = new HashMap<>();
        headers.put("Content-Type", "application/json");
        try {
            String lesson = HttpClientUtil.sendGetRequest(url, headers);
            JSONObject json = new JSONObject(lesson);
            // 獲取 "lessonMain" 字串
            return json.getString("lessonName");
        } catch (Exception e ){
            e.printStackTrace();
        }
        return null;
    }
}
