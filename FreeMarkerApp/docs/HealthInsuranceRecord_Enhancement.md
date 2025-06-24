# 健保紀錄查詢功能擴充文件

## 概述
本次更新為 HealthInsuranceRecord 相關功能新增了根據醫師或治療師角色查詢最後看診時間的功能。

## 新增功能

### 1. 資料模型更新 (HealthInsuranceRecord.java)
新增了以下 Named Queries：
- `HealthInsuranceRecord.findLatestRecordByPatientAndDoctorRole`: 查詢病患的醫師最後看診記錄
- `HealthInsuranceRecord.findLatestRecordByPatientAndTherapistRoles`: 查詢病患的治療師最後看診記錄  
- `HealthInsuranceRecord.findLatestRecordByPatientAndSpecificRole`: 查詢病患的特定角色最後看診記錄

### 2. 資料存取層更新 (HealthInsuranceRecordDAO.java)
新增了以下方法：
- `findLatestDoctorRecordByPatient(Long patientId)`: 取得醫師最後看診記錄
- `findLatestTherapistRecordByPatient(Long patientId)`: 取得治療師最後看診記錄
- `findLatestRecordByPatientAndRole(Long patientId, Long roleId)`: 取得特定角色最後看診記錄
- `findDoctorRecordsByPatient(Long patientId)`: 取得所有醫師看診記錄
- `findTherapistRecordsByPatient(Long patientId)`: 取得所有治療師看診記錄

### 3. 業務邏輯層更新 (HealthInsuranceRecordAPI.java)
新增了以下方法：
- `getLatestDoctorVisitByPatient(Long patientId)`: 取得醫師最後看診記錄
- `getLatestTherapistVisitByPatient(Long patientId)`: 取得治療師最後看診記錄
- `getLatestVisitByPatientAndRole(Long patientId, Long roleId)`: 取得特定角色最後看診記錄
- `getDoctorVisitsByPatient(Long patientId)`: 取得醫師看診記錄列表
- `getTherapistVisitsByPatient(Long patientId)`: 取得治療師看診記錄列表
- `getLastDoctorVisitTime(Long patientId)`: 取得格式化的醫師最後看診時間
- `getLastTherapistVisitTime(Long patientId)`: 取得格式化的治療師最後看診時間
- `calculateTreatmentWeeks(Long patientId)`: 計算治療週數

### 4. REST API 更新 (HealthInsuranceRecordRESTfulAPI.java)
新增了以下端點：
- `GET /HealthInsuranceRecord/api/patient/{patientId}/latest-doctor-visit`: 取得醫師最後看診時間
- `GET /HealthInsuranceRecord/api/patient/{patientId}/latest-therapist-visit`: 取得治療師最後看診時間
- `GET /HealthInsuranceRecord/api/patient/{patientId}/treatment-weeks`: 取得治療週數
- `GET /HealthInsuranceRecord/api/patient/{patientId}/visit-summary`: 取得看診摘要
- `GET /HealthInsuranceRecord/api/patient/{patientId}/role/{roleId}/latest-visit`: 取得特定角色最後看診時間

### 5. 頁面控制器更新 (DtxCaseMgntPage.java)
更新了 `caseFormVisits` 方法，現在會自動填入：
- `lastDoctorVisit`: 醫師最後看診時間
- `lastTherapistVisit`: 治療師最後看診時間
- `treatmentWeeks`: 治療週數

## 角色對照表
```
1  CASE      個案
2  ADMIN     管理者
3  DOCTOR    醫師
4  DTX_PSY   心理治療師
5  DTX_ST    語言治療師
6  DTX_OT    職能治療師
7  DTX_PI    物理治療師
```

## API 使用範例

### 1. 取得醫師最後看診時間
```http
GET /HealthInsuranceRecord/api/patient/123/latest-doctor-visit
```

回應：
```json
{
  "patientId": 123,
  "lastDoctorVisit": "2024-06-20 (四) 14:30"
}
```

### 2. 取得治療師最後看診時間
```http
GET /HealthInsuranceRecord/api/patient/123/latest-therapist-visit
```

回應：
```json
{
  "patientId": 123,
  "lastTherapistVisit": "2024-06-22 (六) 10:15"
}
```

### 3. 取得治療週數
```http
GET /HealthInsuranceRecord/api/patient/123/treatment-weeks
```

回應：
```json
{
  "patientId": 123,
  "treatmentWeeks": 8
}
```

### 4. 取得完整看診摘要
```http
GET /HealthInsuranceRecord/api/patient/123/visit-summary
```

回應：
```json
{
  "patientId": 123,
  "lastDoctorVisit": "2024-06-20 (四) 14:30",
  "lastTherapistVisit": "2024-06-22 (六) 10:15",
  "treatmentWeeks": 8
}
```

### 5. 取得特定角色最後看診時間
```http
GET /HealthInsuranceRecord/api/patient/123/role/4/latest-visit
```

回應：
```json
{
  "patientId": 123,
  "roleId": 4,
  "lastVisitTime": "2024-06-22 (六) 10:15",
  "recordId": 456
}
```

## 前端模板使用
在 `visits.ftl` 模板中，現在可以直接使用以下變數：
- `${lastDoctorVisit}`: 醫師最後看診時間
- `${lastTherapistVisit}`: 治療師最後看診時間
- `${treatmentWeeks}`: 治療週數

這些變數會自動從後端填入，無需前端額外調用 API。

## 注意事項
1. 當沒有對應角色的看診記錄時，相關方法會回傳 `null`
2. 治療週數計算基於第一次治療記錄到當前時間的週數差
3. 所有時間格式都使用 `fullDateFormat` 方法進行格式化，格式為 "yyyy-MM-dd (週) HH:mm"
4. 查詢使用 JOIN 查詢 user_role 表來判斷使用者角色

## 測試建議
1. 建立測試資料：不同角色的使用者和對應的健保記錄
2. 測試邊界情況：無記錄、單一角色記錄、多角色記錄
3. 驗證時間格式化和週數計算的正確性
4. 測試 REST API 端點的回應格式
