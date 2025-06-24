-- 健保紀錄查詢範例 SQL
-- 根據醫師或治療師角色查詢最後看診時間

-- 查詢指定病患的醫師最後看診記錄 (角色ID = 3)
SELECT h.* 
FROM health_insurance_record h 
WHERE h.patient_id = ? 
  AND h.creator IN (
    SELECT ur.user_id 
    FROM user_role ur 
    WHERE ur.role_id = 3
  ) 
ORDER BY h.create_time DESC 
LIMIT 1;

-- 查詢指定病患的治療師最後看診記錄 (角色ID = 4,5,6,7)
-- 4: DTX_PSY (心理治療師)
-- 5: DTX_ST (語言治療師) 
-- 6: DTX_OT (職能治療師)
-- 7: DTX_PI (物理治療師)
SELECT h.* 
FROM health_insurance_record h 
WHERE h.patient_id = ? 
  AND h.creator IN (
    SELECT ur.user_id 
    FROM user_role ur 
    WHERE ur.role_id IN (4, 5, 6, 7)
  ) 
ORDER BY h.create_time DESC 
LIMIT 1;

-- 查詢指定病患的特定角色最後看診記錄
SELECT h.* 
FROM health_insurance_record h 
WHERE h.patient_id = ? 
  AND h.creator IN (
    SELECT ur.user_id 
    FROM user_role ur 
    WHERE ur.role_id = ?
  ) 
ORDER BY h.create_time DESC 
LIMIT 1;

-- 計算治療週數的參考查詢
-- 取得指定病患的第一次治療記錄
SELECT MIN(h.create_time) as first_treatment_date
FROM health_insurance_record h 
WHERE h.patient_id = ?;

-- 角色對照表
/*
1  CASE      個案
2  ADMIN     管理者
3  DOCTOR    醫師
4  DTX_PSY   心理治療師
5  DTX_ST    語言治療師
6  DTX_OT    職能治療師
7  DTX_PI    物理治療師
*/

-- 測試資料範例查詢
-- 查看特定病患的所有看診記錄及執行人員角色
SELECT 
    h.id,
    h.patient_id,
    h.create_time,
    h.creator,
    u.username as doctor_name,
    r.name as role_name,
    r.alias as role_alias
FROM health_insurance_record h
JOIN user u ON h.creator = u.id
JOIN user_role ur ON u.id = ur.user_id
JOIN role r ON ur.role_id = r.id
WHERE h.patient_id = ?
ORDER BY h.create_time DESC;
