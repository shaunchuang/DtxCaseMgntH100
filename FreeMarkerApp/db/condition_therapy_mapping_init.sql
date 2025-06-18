-- 建立適應症與治療類別對應表
CREATE TABLE IF NOT EXISTS "indication_therapy_mapping" (
    "id" BIGINT IDENTITY PRIMARY KEY,
    "indication_id" BIGINT NOT NULL,
    "therapy_type" VARCHAR(10) NOT NULL,
    CONSTRAINT "unique_indication_therapy" UNIQUE ("indication_id", "therapy_type")
);

-- 插入對應關係資料
-- 1: 注意力不足過動症 → 職能治療、心理治療
INSERT INTO "indication_therapy_mapping" ("indication_id", "therapy_type") VALUES (1, 'OT');
INSERT INTO "indication_therapy_mapping" ("indication_id", "therapy_type") VALUES (1, 'CP');

-- 2: 憂鬱症 → 心理治療
INSERT INTO "indication_therapy_mapping" ("indication_id", "therapy_type") VALUES (2, 'CP');

-- 3: 創傷後壓力症候群 → 心理治療
INSERT INTO "indication_therapy_mapping" ("indication_id", "therapy_type") VALUES (3, 'CP');

-- 4: 自閉症 → 語言治療、職能治療
INSERT INTO "indication_therapy_mapping" ("indication_id", "therapy_type") VALUES (4, 'ST');
INSERT INTO "indication_therapy_mapping" ("indication_id", "therapy_type") VALUES (4, 'OT');

-- 5: 焦慮症 → 心理治療
INSERT INTO "indication_therapy_mapping" ("indication_id", "therapy_type") VALUES (5, 'CP');

-- 6: 強迫症 → 心理治療
INSERT INTO "indication_therapy_mapping" ("indication_id", "therapy_type") VALUES (6, 'CP');

-- 7: 躁鬱症 → 心理治療
INSERT INTO "indication_therapy_mapping" ("indication_id", "therapy_type") VALUES (7, 'CP');

-- 8: 精神分裂症 → 心理治療
INSERT INTO "indication_therapy_mapping" ("indication_id", "therapy_type") VALUES (8, 'CP');

-- 9: 社交恐懼症 → 心理治療
INSERT INTO "indication_therapy_mapping" ("indication_id", "therapy_type") VALUES (9, 'CP');

-- 10: 進食障礙 → 心理治療
INSERT INTO "indication_therapy_mapping" ("indication_id", "therapy_type") VALUES (10, 'CP');

-- 11: 帕金森氏症 → 物理治療
INSERT INTO "indication_therapy_mapping" ("indication_id", "therapy_type") VALUES (11, 'PT');

-- 12: 阿茲海默症 → 職能治療、語言治療
INSERT INTO "indication_therapy_mapping" ("indication_id", "therapy_type") VALUES (12, 'OT');
INSERT INTO "indication_therapy_mapping" ("indication_id", "therapy_type") VALUES (12, 'ST');

-- 13: 關節炎 → 物理治療
INSERT INTO "indication_therapy_mapping" ("indication_id", "therapy_type") VALUES (13, 'PT');

-- 14: 發展遲緩 → 職能治療
INSERT INTO "indication_therapy_mapping" ("indication_id", "therapy_type") VALUES (14, 'OT');

-- 15: 失語症 → 語言治療
INSERT INTO "indication_therapy_mapping" ("indication_id", "therapy_type") VALUES (15, 'ST');

-- 16: 語用障礙 → 語言治療
INSERT INTO "indication_therapy_mapping" ("indication_id", "therapy_type") VALUES (16, 'ST');

-- 17: 構音障礙 → 語言治療
INSERT INTO "indication_therapy_mapping" ("indication_id", "therapy_type") VALUES (17, 'ST');

-- 18: 語言發展遲緩 → 語言治療
INSERT INTO "indication_therapy_mapping" ("indication_id", "therapy_type") VALUES (18, 'ST');

-- 19: 語言障礙 → 語言治療
INSERT INTO "indication_therapy_mapping" ("indication_id", "therapy_type") VALUES (19, 'ST');

-- 20: 恐慌症 → 心理治療
INSERT INTO "indication_therapy_mapping" ("indication_id", "therapy_type") VALUES (20, 'PS');

-- 21: 自律神經失調 → 心理治療
INSERT INTO "indication_therapy_mapping" ("indication_id", "therapy_type") VALUES (21, 'PS');

-- 22: 神經衰弱症 → 心理治療
INSERT INTO "indication_therapy_mapping" ("indication_id", "therapy_type") VALUES (22, 'PS');

-- 23: 慢性疼痛 → 物理治療
INSERT INTO "indication_therapy_mapping" ("indication_id", "therapy_type") VALUES (23, 'PT');
