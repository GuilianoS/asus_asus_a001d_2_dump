/*
  Copyright (c) 2016 Qualcomm Technologies, Inc.
  All Rights Reserved.
  Confidential and Proprietary - Qualcomm Technologies, Inc.
*/

BEGIN TRANSACTION;

CREATE TABLE IF NOT EXISTS qcril_properties_table (property TEXT,value TEXT, PRIMARY KEY(property));
INSERT OR REPLACE INTO qcril_properties_table (property, value) VALUES ('qcrildb_version', 5);

--BEGIN wangyaokai BR 
DELETE FROM qcril_emergency_source_mcc_table where MCC = '724' AND NUMBER = '100';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '724' AND NUMBER = '128';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '724' AND NUMBER = '180';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '724' AND NUMBER = '181';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '724' AND NUMBER = '191';

DELETE FROM qcril_emergency_source_mcc_table where MCC = '724' AND NUMBER = '194';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '724' AND NUMBER = '197';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '724' AND NUMBER = '198';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '724' AND NUMBER = '199';

INSERT INTO qcril_emergency_source_mcc_table VALUES('724','100','','limited');
INSERT INTO qcril_emergency_source_mcc_table VALUES('724','128','','limited');
INSERT INTO qcril_emergency_source_mcc_table VALUES('724','180','','limited');
INSERT INTO qcril_emergency_source_mcc_table VALUES('724','181','','limited');
INSERT INTO qcril_emergency_source_mcc_table VALUES('724','191','','limited');

INSERT INTO qcril_emergency_source_mcc_table VALUES('724','194','','limited');
INSERT INTO qcril_emergency_source_mcc_table VALUES('724','197','','limited');
INSERT INTO qcril_emergency_source_mcc_table VALUES('724','198','','limited');
INSERT INTO qcril_emergency_source_mcc_table VALUES('724','199','','limited');
--END

--BEGIN ,wangyaokai BR
DELETE FROM qcril_emergency_source_voice_table where MCC = '724' AND NUMBER = '100';
DELETE FROM qcril_emergency_source_voice_table where MCC = '724' AND NUMBER = '128';
DELETE FROM qcril_emergency_source_voice_table where MCC = '724' AND NUMBER = '180';
DELETE FROM qcril_emergency_source_voice_table where MCC = '724' AND NUMBER = '181';
DELETE FROM qcril_emergency_source_voice_table where MCC = '724' AND NUMBER = '191';

DELETE FROM qcril_emergency_source_voice_table where MCC = '724' AND NUMBER = '194';
DELETE FROM qcril_emergency_source_voice_table where MCC = '724' AND NUMBER = '197';
DELETE FROM qcril_emergency_source_voice_table where MCC = '724' AND NUMBER = '198';
DELETE FROM qcril_emergency_source_voice_table where MCC = '724' AND NUMBER = '199';

INSERT INTO qcril_emergency_source_voice_table VALUES('724','100','','full');
INSERT INTO qcril_emergency_source_voice_table VALUES('724','128','','full');
INSERT INTO qcril_emergency_source_voice_table VALUES('724','180','','full');
INSERT INTO qcril_emergency_source_voice_table VALUES('724','181','','full');
INSERT INTO qcril_emergency_source_voice_table VALUES('724','191','','full');

INSERT INTO qcril_emergency_source_voice_table VALUES('724','194','','full');
INSERT INTO qcril_emergency_source_voice_table VALUES('724','197','','full');
INSERT INTO qcril_emergency_source_voice_table VALUES('724','198','','full');
INSERT INTO qcril_emergency_source_voice_table VALUES('724','199','','full');
--END

--BEGIN,wangyaokai,add BR Emergency call
DELETE FROM qcril_emergency_source_hard_mcc_table where MCC = '724' AND NUMBER = '100';
DELETE FROM qcril_emergency_source_hard_mcc_table where MCC = '724' AND NUMBER = '128';
DELETE FROM qcril_emergency_source_hard_mcc_table where MCC = '724' AND NUMBER = '180';
DELETE FROM qcril_emergency_source_hard_mcc_table where MCC = '724' AND NUMBER = '181';

DELETE FROM qcril_emergency_source_hard_mcc_table where MCC = '724' AND NUMBER = '190';
DELETE FROM qcril_emergency_source_hard_mcc_table where MCC = '724' AND NUMBER = '191';
DELETE FROM qcril_emergency_source_hard_mcc_table where MCC = '724' AND NUMBER = '192';
DELETE FROM qcril_emergency_source_hard_mcc_table where MCC = '724' AND NUMBER = '193';

DELETE FROM qcril_emergency_source_hard_mcc_table where MCC = '724' AND NUMBER = '194';
DELETE FROM qcril_emergency_source_hard_mcc_table where MCC = '724' AND NUMBER = '197';
DELETE FROM qcril_emergency_source_hard_mcc_table where MCC = '724' AND NUMBER = '198';
DELETE FROM qcril_emergency_source_hard_mcc_table where MCC = '724' AND NUMBER = '199';

INSERT INTO qcril_emergency_source_hard_mcc_table VALUES('724','100','','');
INSERT INTO qcril_emergency_source_hard_mcc_table VALUES('724','128','','');
INSERT INTO qcril_emergency_source_hard_mcc_table VALUES('724','180','','');
INSERT INTO qcril_emergency_source_hard_mcc_table VALUES('724','181','','');

INSERT INTO qcril_emergency_source_hard_mcc_table VALUES('724','190','','');
INSERT INTO qcril_emergency_source_hard_mcc_table VALUES('724','191','','');
INSERT INTO qcril_emergency_source_hard_mcc_table VALUES('724','192','','');
INSERT INTO qcril_emergency_source_hard_mcc_table VALUES('724','193','','');

INSERT INTO qcril_emergency_source_hard_mcc_table VALUES('724','194','','');
INSERT INTO qcril_emergency_source_hard_mcc_table VALUES('724','197','','');
INSERT INTO qcril_emergency_source_hard_mcc_table VALUES('724','198','','');
INSERT INTO qcril_emergency_source_hard_mcc_table VALUES('724','199','','');
--END

COMMIT TRANSACTION;
