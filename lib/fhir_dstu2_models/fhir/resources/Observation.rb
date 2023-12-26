module FHIR
  module DSTU2
    class Observation < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      MULTIPLE_TYPES = {
        'effective' => ['dateTime', 'Period'],
        'value' => ['Quantity', 'CodeableConcept', 'string', 'Range', 'Ratio', 'SampledData', 'Attachment', 'time', 'dateTime', 'Period']
      }
      SEARCH_PARAMS = ['category', 'code', 'component-code', 'component-data-absent-reason', 'component-value-concept', 'component-value-quantity', 'component-value-string', 'data-absent-reason', 'date', 'device', 'encounter', 'identifier', 'patient', 'performer', 'related-target', 'related-type', 'specimen', 'status', 'subject', 'value-concept', 'value-date', 'value-quantity', 'value-string']
      METADATA = {
        'id' => { 'type' => 'id', 'path' => 'Observation.id', 'min' => 0, 'max' => 1 },
        'meta' => { 'type' => 'Meta', 'path' => 'Observation.meta', 'min' => 0, 'max' => 1 },
        'implicitRules' => { 'type' => 'uri', 'path' => 'Observation.implicitRules', 'min' => 0, 'max' => 1 },
        'language' => { 'type' => 'code', 'path' => 'Observation.language', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'required', 'uri' => 'http://tools.ietf.org/html/bcp47' } },
        'text' => { 'type' => 'Narrative', 'path' => 'Observation.text', 'min' => 0, 'max' => 1 },
        'contained' => { 'type' => 'Resource', 'path' => 'Observation.contained', 'min' => 0, 'max' => Float::INFINITY },
        'extension' => { 'type' => 'Extension', 'path' => 'Observation.extension', 'min' => 0, 'max' => Float::INFINITY },
        'modifierExtension' => { 'type' => 'Extension', 'path' => 'Observation.modifierExtension', 'min' => 0, 'max' => Float::INFINITY },
        'identifier' => { 'type' => 'Identifier', 'path' => 'Observation.identifier', 'min' => 0, 'max' => Float::INFINITY },
        'status' => { 'valid_codes' => { 'http://hl7.org/fhir/observation-status' => ['registered', 'preliminary', 'final', 'amended', 'cancelled', 'entered-in-error', 'unknown'] }, 'type' => 'code', 'path' => 'Observation.status', 'min' => 1, 'max' => 1, 'binding' => { 'strength' => 'required', 'uri' => 'http://hl7.org/fhir/ValueSet/observation-status' } },
        'category' => { 'valid_codes' => { 'http://hl7.org/fhir/observation-category' => ['social-history', 'vital-signs', 'imaging', 'laboratory', 'procedure', 'survey', 'exam', 'therapy'] }, 'type' => 'CodeableConcept', 'path' => 'Observation.category', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'example', 'uri' => 'http://hl7.org/fhir/ValueSet/observation-category' } },
        'code' => { 'valid_codes' => { 'http://loinc.org' => [] }, 'type' => 'CodeableConcept', 'path' => 'Observation.code', 'min' => 1, 'max' => 1, 'binding' => { 'strength' => 'example', 'uri' => 'http://hl7.org/fhir/ValueSet/observation-codes' } },
        'subject' => { 'type' => 'Reference', 'path' => 'Observation.subject', 'min' => 0, 'max' => 1 },
        'encounter' => { 'type' => 'Reference', 'path' => 'Observation.encounter', 'min' => 0, 'max' => 1 },
        'effectiveDateTime' => { 'type' => 'dateTime', 'path' => 'Observation.effective[x]', 'min' => 0, 'max' => 1 },
        'effectivePeriod' => { 'type' => 'Period', 'path' => 'Observation.effective[x]', 'min' => 0, 'max' => 1 },
        'issued' => { 'type' => 'instant', 'path' => 'Observation.issued', 'min' => 0, 'max' => 1 },
        'performer' => { 'type' => 'Reference', 'path' => 'Observation.performer', 'min' => 0, 'max' => Float::INFINITY },
        'valueQuantity' => { 'type' => 'Quantity', 'path' => 'Observation.value[x]', 'min' => 0, 'max' => 1 },
        'valueCodeableConcept' => { 'type' => 'CodeableConcept', 'path' => 'Observation.value[x]', 'min' => 0, 'max' => 1 },
        'valueString' => { 'type' => 'string', 'path' => 'Observation.value[x]', 'min' => 0, 'max' => 1 },
        'valueRange' => { 'type' => 'Range', 'path' => 'Observation.value[x]', 'min' => 0, 'max' => 1 },
        'valueRatio' => { 'type' => 'Ratio', 'path' => 'Observation.value[x]', 'min' => 0, 'max' => 1 },
        'valueSampledData' => { 'type' => 'SampledData', 'path' => 'Observation.value[x]', 'min' => 0, 'max' => 1 },
        'valueAttachment' => { 'type' => 'Attachment', 'path' => 'Observation.value[x]', 'min' => 0, 'max' => 1 },
        'valueTime' => { 'type' => 'time', 'path' => 'Observation.value[x]', 'min' => 0, 'max' => 1 },
        'valueDateTime' => { 'type' => 'dateTime', 'path' => 'Observation.value[x]', 'min' => 0, 'max' => 1 },
        'valuePeriod' => { 'type' => 'Period', 'path' => 'Observation.value[x]', 'min' => 0, 'max' => 1 },
        'dataAbsentReason' => { 'valid_codes' => { 'http://hl7.org/fhir/data-absent-reason' => ['unknown', 'asked', 'temp', 'not-asked', 'masked', 'unsupported', 'astext', 'error', 'NaN'] }, 'type' => 'CodeableConcept', 'path' => 'Observation.dataAbsentReason', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'extensible', 'uri' => 'http://hl7.org/fhir/ValueSet/observation-valueabsentreason' } },
        'interpretation' => { 'valid_codes' => { 'http://hl7.org/fhir/v2/0078' => ['<', '>', 'A', 'AA', 'AC', 'B', 'D', 'DET', 'H', 'HH', 'HM', 'HU', 'I', 'IE', 'IND', 'L', 'LL', 'LU', 'MS', 'N', 'ND', 'NEG', 'NR', 'NS', 'OBX', 'POS', 'QCF', 'R', 'RR', 'S', 'SDD', 'SYN-R', 'SYN-S', 'TOX', 'U', 'VS', 'W', 'WR', 'null'] }, 'type' => 'CodeableConcept', 'path' => 'Observation.interpretation', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'extensible', 'uri' => 'http://hl7.org/fhir/ValueSet/observation-interpretation' } },
        'comments' => { 'type' => 'string', 'path' => 'Observation.comments', 'min' => 0, 'max' => 1 },
        'bodySite' => { 'valid_codes' => { 'http://snomed.info/sct' => [] }, 'type' => 'CodeableConcept', 'path' => 'Observation.bodySite', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'example', 'uri' => 'http://hl7.org/fhir/ValueSet/body-site' } },
        'method' => { 'local_name' => 'local_method', 'valid_codes' => { 'http://hl7.org/fhir/v3/ObservationMethod' => ['_DecisionObservationMethod', 'ALGM', 'BYCL', 'GINT', '_GeneticObservationMethod', 'PCR', '_ObservationMethodAggregate', 'AVERAGE', 'COUNT', 'MAX', 'MEDIAN', 'MIN', 'MODE', 'STDEV.P', 'STDEV.S', 'SUM', 'VARIANCE.P', 'VARIANCE.S', '_VerificationMethod', 'VDOC', 'VREG', 'VTOKEN', 'VVOICE', '0001', '0002', '0003', '0004', '0005', '0006', '0007', '0008', '0009', '0010', '0011', '0012', '0013', '0014', '0015', '0016', '0017', '0018', '0019', '0020', '0021', '0022', '0023', '0024', '0025', '0026', '0027', '0028', '0029', '0030', '0031', '0032', '0033', '0034', '0035', '0036', '0037', '0038', '0039', '0040', '0041', '0042', '0043', '0044', '0045', '0046', '0047', '0048', '0049', '0050', '0051', '0052', '0053', '0054', '0055', '0056', '0057', '0058', '0059', '0060', '0061', '0062', '0063', '0064', '0065', '0066', '0067', '0068', '0069', '0070', '0071', '0072', '0073', '0074', '0075', '0076', '0077', '0078', '0079', '0080', '0081', '0082', '0083', '0084', '0085', '0086', '0087', '0088', '0089', '0090', '0091', '0092', '0093', '0094', '0095', '0096', '0097', '0098', '0099', '0100', '0101', '0102', '0103', '0104', '0105', '0106', '0107', '0108', '0109', '0110', '0111', '0112', '0113', '0114', '0115', '0116', '0117', '0118', '0119', '0120', '0121', '0122', '0123', '0124', '0125', '0126', '0128', '0129', '0130', '0131', '0132', '0133', '0134', '0135', '0136', '0137', '0138', '0139', '0140', '0141', '0142', '0143', '0144', '0145', '0146', '0147', '0148', '0149', '0150', '0151', '0152', '0153', '0154', '0155', '0156', '0157', '0158', '0159', '0160', '0161', '0162', '0163', '0164', '0165', '0166', '0167', '0168', '0169', '0170', '0171', '0172', '0173', '0174', '0175', '0176', '0177', '0178', '0179', '0180', '0181', '0182', '0183', '0184', '0185', '0186', '0187', '0188', '0189', '0190', '0191', '0192', '0193', '0194', '0195', '0196', '0197', '0198', '0199', '0200', '0201', '0202', '0203', '0204', '0205', '0206', '0207', '0208', '0209', '0210', '0211', '0212', '0213', '0214', '0215', '0216', '0217', '0218', '0219', '0220', '0221', '0222', '0223', '0224', '0225', '0226', '0227', '0228', '0229', '0230', '0231', '0232', '0233', '0234', '0235', '0236', '0237', '0238', '0239', '0243', '0244', '0247', '0248', '0249', '0250', '0251', '0252', '0253', '0254', '0255', '0256', '0257', '0258', '0259', '0260', '0261', '0262', '0263', '0264', '0265', '0266', '0267', '0268', '0269', '0270', '0271', '0280', '0240', '0241', '0242', '0272', '0245', '0246', '0273', '0274', '0275', '0275a', '0276', '0277', '0278', '0279', '0127'], 'http://snomed.info/sct' => [] }, 'type' => 'CodeableConcept', 'path' => 'Observation.method', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'example', 'uri' => 'http://hl7.org/fhir/ValueSet/observation-methods' } },
        'specimen' => { 'type' => 'Reference', 'path' => 'Observation.specimen', 'min' => 0, 'max' => 1 },
        'device' => { 'type' => 'Reference', 'path' => 'Observation.device', 'min' => 0, 'max' => 1 },
        'referenceRange' => { 'type' => 'Observation::ReferenceRange', 'path' => 'Observation.referenceRange', 'min' => 0, 'max' => Float::INFINITY },
        'related' => { 'type' => 'Observation::Related', 'path' => 'Observation.related', 'min' => 0, 'max' => Float::INFINITY },
        'component' => { 'type' => 'Observation::Component', 'path' => 'Observation.component', 'min' => 0, 'max' => Float::INFINITY }
      }

      class ReferenceRange < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => { 'type' => 'id', 'path' => 'ReferenceRange.id', 'min' => 0, 'max' => 1 },
          'extension' => { 'type' => 'Extension', 'path' => 'ReferenceRange.extension', 'min' => 0, 'max' => Float::INFINITY },
          'modifierExtension' => { 'type' => 'Extension', 'path' => 'ReferenceRange.modifierExtension', 'min' => 0, 'max' => Float::INFINITY },
          'low' => { 'type' => 'Quantity', 'path' => 'ReferenceRange.low', 'min' => 0, 'max' => 1 },
          'high' => { 'type' => 'Quantity', 'path' => 'ReferenceRange.high', 'min' => 0, 'max' => 1 },
          'meaning' => { 'valid_codes' => { 'http://hl7.org/fhir/referencerange-meaning' => ['type', 'normal', 'recommended', 'treatment', 'therapeutic', 'pre', 'post', 'endocrine', 'pre-puberty', 'follicular', 'midcycle', 'luteal', 'postmeopausal'], 'http://snomed.info/sct' => ['248153007', '248152002', '77386006'], 'http://hl7.org/fhir/v3/Race' => ['1002-5', '1004-1', '1006-6', '1008-2', '1010-8', '1011-6', '1012-4', '1013-2', '1014-0', '1015-7', '1016-5', '1017-3', '1018-1', '1019-9', '1021-5', '1022-3', '1023-1', '1024-9', '1026-4', '1028-0', '1030-6', '1031-4', '1033-0', '1035-5', '1037-1', '1039-7', '1041-3', '1042-1', '1044-7', '1045-4', '1046-2', '1047-0', '1048-8', '1049-6', '1050-4', '1051-2', '1053-8', '1054-6', '1055-3', '1056-1', '1057-9', '1058-7', '1059-5', '1060-3', '1061-1', '1062-9', '1063-7', '1064-5', '1065-2', '1066-0', '1068-6', '1069-4', '1070-2', '1071-0', '1072-8', '1073-6', '1074-4', '1076-9', '1741-8', '1742-6', '1743-4', '1744-2', '1745-9', '1746-7', '1747-5', '1748-3', '1749-1', '1750-9', '1751-7', '1752-5', '1753-3', '1754-1', '1755-8', '1756-6', '1757-4', '1758-2', '1759-0', '1760-8', '1761-6', '1762-4', '1763-2', '1764-0', '1765-7', '1766-5', '1767-3', '1768-1', '1769-9', '1770-7', '1771-5', '1772-3', '1773-1', '1774-9', '1775-6', '1776-4', '1777-2', '1778-0', '1779-8', '1780-6', '1781-4', '1782-2', '1783-0', '1784-8', '1785-5', '1786-3', '1787-1', '1788-9', '1789-7', '1790-5', '1791-3', '1792-1', '1793-9', '1794-7', '1795-4', '1796-2', '1797-0', '1798-8', '1799-6', '1800-2', '1801-0', '1802-8', '1803-6', '1804-4', '1805-1', '1806-9', '1807-7', '1808-5', '1809-3', '1078-5', '1080-1', '1082-7', '1083-5', '1084-3', '1086-8', '1088-4', '1089-2', '1090-0', '1091-8', '1092-6', '1093-4', '1094-2', '1095-9', '1096-7', '1097-5', '1098-3', '1100-7', '1102-3', '1103-1', '1104-9', '1106-4', '1108-0', '1109-8', '1110-6', '1112-2', '1114-8', '1115-5', '1116-3', '1117-1', '1118-9', '1119-7', '1120-5', '1121-3', '1123-9', '1124-7', '1125-4', '1126-2', '1127-0', '1128-8', '1129-6', '1130-4', '1131-2', '1132-0', '1133-8', '1134-6', '1135-3', '1136-1', '1137-9', '1138-7', '1139-5', '1140-3', '1141-1', '1142-9', '1143-7', '1144-5', '1145-2', '1146-0', '1147-8', '1148-6', '1150-2', '1151-0', '1153-6', '1155-1', '1156-9', '1157-7', '1158-5', '1159-3', '1160-1', '1162-7', '1163-5', '1165-0', '1167-6', '1169-2', '1171-8', '1173-4', '1175-9', '1176-7', '1178-3', '1180-9', '1182-5', '1184-1', '1186-6', '1187-4', '1189-0', '1191-6', '1193-2', '1194-0', '1195-7', '1196-5', '1197-3', '1198-1', '1199-9', '1200-5', '1201-3', '1202-1', '1203-9', '1204-7', '1205-4', '1207-0', '1209-6', '1211-2', '1212-0', '1214-6', '1215-3', '1216-1', '1217-9', '1218-7', '1219-5', '1220-3', '1222-9', '1223-7', '1224-5', '1225-2', '1226-0', '1227-8', '1228-6', '1229-4', '1230-2', '1231-0', '1233-6', '1234-4', '1235-1', '1236-9', '1237-7', '1238-5', '1239-3', '1240-1', '1241-9', '1242-7', '1243-5', '1244-3', '1245-0', '1246-8', '1247-6', '1248-4', '1250-0', '1252-6', '1254-2', '1256-7', '1258-3', '1260-9', '1262-5', '1264-1', '1265-8', '1267-4', '1269-0', '1271-6', '1272-4', '1273-2', '1275-7', '1277-3', '1279-9', '1281-5', '1282-3', '1283-1', '1285-6', '1286-4', '1287-2', '1288-0', '1289-8', '1290-6', '1291-4', '1292-2', '1293-0', '1294-8', '1295-5', '1297-1', '1299-7', '1301-1', '1303-7', '1305-2', '1306-0', '1307-8', '1309-4', '1310-2', '1312-8', '1313-6', '1314-4', '1315-1', '1317-7', '1319-3', '1321-9', '1323-5', '1325-0', '1326-8', '1327-6', '1328-4', '1329-2', '1331-8', '1332-6', '1333-4', '1334-2', '1335-9', '1336-7', '1337-5', '1338-3', '1340-9', '1342-5', '1344-1', '1345-8', '1346-6', '1348-2', '1350-8', '1352-4', '1354-0', '1356-5', '1358-1', '1359-9', '1360-7', '1361-5', '1363-1', '1365-6', '1366-4', '1368-0', '1370-6', '1372-2', '1374-8', '1376-3', '1378-9', '1380-5', '1382-1', '1383-9', '1384-7', '1385-4', '1387-0', '1389-6', '1391-2', '1392-0', '1393-8', '1394-6', '1395-3', '1396-1', '1397-9', '1398-7', '1399-5', '1400-1', '1401-9', '1403-5', '1405-0', '1407-6', '1409-2', '1411-8', '1412-6', '1413-4', '1414-2', '1416-7', '1417-5', '1418-3', '1419-1', '1420-9', '1421-7', '1422-5', '1423-3', '1424-1', '1425-8', '1426-6', '1427-4', '1428-2', '1429-0', '1430-8', '1431-6', '1432-4', '1433-2', '1434-0', '1435-7', '1436-5', '1437-3', '1439-9', '1441-5', '1442-3', '1443-1', '1445-6', '1446-4', '1448-0', '1450-6', '1451-4', '1453-0', '1454-8', '1456-3', '1457-1', '1458-9', '1460-5', '1462-1', '1464-7', '1465-4', '1466-2', '1467-0', '1468-8', '1469-6', '1470-4', '1471-2', '1472-0', '1474-6', '1475-3', '1476-1', '1478-7', '1479-5', '1480-3', '1481-1', '1482-9', '1483-7', '1484-5', '1485-2', '1487-8', '1489-4', '1490-2', '1491-0', '1492-8', '1493-6', '1494-4', '1495-1', '1496-9', '1497-7', '1498-5', '1499-3', '1500-8', '1501-6', '1502-4', '1503-2', '1504-0', '1505-7', '1506-5', '1507-3', '1508-1', '1509-9', '1510-7', '1511-5', '1512-3', '1513-1', '1514-9', '1515-6', '1516-4', '1518-0', '1519-8', '1520-6', '1521-4', '1522-2', '1523-0', '1524-8', '1525-5', '1526-3', '1527-1', '1528-9', '1529-7', '1530-5', '1531-3', '1532-1', '1533-9', '1534-7', '1535-4', '1536-2', '1537-0', '1538-8', '1539-6', '1541-2', '1543-8', '1545-3', '1547-9', '1549-5', '1551-1', '1552-9', '1553-7', '1554-5', '1556-0', '1558-6', '1560-2', '1562-8', '1564-4', '1566-9', '1567-7', '1568-5', '1569-3', '1570-1', '1571-9', '1573-5', '1574-3', '1576-8', '1578-4', '1579-2', '1580-0', '1582-6', '1584-2', '1586-7', '1587-5', '1588-3', '1589-1', '1590-9', '1591-7', '1592-5', '1593-3', '1594-1', '1595-8', '1596-6', '1597-4', '1598-2', '1599-0', '1600-6', '1602-2', '1603-0', '1604-8', '1605-5', '1607-1', '1609-7', '1610-5', '1611-3', '1612-1', '1613-9', '1614-7', '1615-4', '1616-2', '1617-0', '1618-8', '1619-6', '1620-4', '1621-2', '1622-0', '1623-8', '1624-6', '1625-3', '1626-1', '1627-9', '1628-7', '1629-5', '1630-3', '1631-1', '1632-9', '1633-7', '1634-5', '1635-2', '1636-0', '1637-8', '1638-6', '1639-4', '1640-2', '1641-0', '1643-6', '1645-1', '1647-7', '1649-3', '1651-9', '1653-5', '1654-3', '1655-0', '1656-8', '1657-6', '1659-2', '1661-8', '1663-4', '1665-9', '1667-5', '1668-3', '1670-9', '1671-7', '1672-5', '1673-3', '1675-8', '1677-4', '1679-0', '1680-8', '1681-6', '1683-2', '1685-7', '1687-3', '1688-1', '1689-9', '1690-7', '1692-3', '1694-9', '1696-4', '1697-2', '1698-0', '1700-4', '1702-0', '1704-6', '1705-3', '1707-9', '1709-5', '1711-1', '1712-9', '1713-7', '1715-2', '1717-8', '1718-6', '1719-4', '1720-2', '1722-8', '1724-4', '1725-1', '1726-9', '1727-7', '1728-5', '1729-3', '1730-1', '1731-9', '1732-7', '1733-5', '1735-0', '1737-6', '1739-2', '1740-0', '1811-9', '1813-5', '1814-3', '1815-0', '1816-8', '1817-6', '1818-4', '1819-2', '1820-0', '1821-8', '1822-6', '1823-4', '1824-2', '1825-9', '1826-7', '1827-5', '1828-3', '1829-1', '1830-9', '1831-7', '1832-5', '1833-3', '1834-1', '1835-8', '1837-4', '1838-2', '1840-8', '1842-4', '1844-0', '1845-7', '1846-5', '1847-3', '1848-1', '1849-9', '1850-7', '1851-5', '1852-3', '1853-1', '1854-9', '1855-6', '1856-4', '1857-2', '1858-0', '1859-8', '1860-6', '1861-4', '1862-2', '1863-0', '1864-8', '1865-5', '1866-3', '1867-1', '1868-9', '1869-7', '1870-5', '1871-3', '1872-1', '1873-9', '1874-7', '1875-4', '1876-2', '1877-0', '1878-8', '1879-6', '1880-4', '1881-2', '1882-0', '1883-8', '1884-6', '1885-3', '1886-1', '1887-9', '1888-7', '1889-5', '1891-1', '1892-9', '1893-7', '1894-5', '1896-0', '1897-8', '1898-6', '1899-4', '1900-0', '1901-8', '1902-6', '1903-4', '1904-2', '1905-9', '1906-7', '1907-5', '1908-3', '1909-1', '1910-9', '1911-7', '1912-5', '1913-3', '1914-1', '1915-8', '1916-6', '1917-4', '1918-2', '1919-0', '1920-8', '1921-6', '1922-4', '1923-2', '1924-0', '1925-7', '1926-5', '1927-3', '1928-1', '1929-9', '1930-7', '1931-5', '1932-3', '1933-1', '1934-9', '1935-6', '1936-4', '1937-2', '1938-0', '1939-8', '1940-6', '1941-4', '1942-2', '1943-0', '1944-8', '1945-5', '1946-3', '1947-1', '1948-9', '1949-7', '1950-5', '1951-3', '1952-1', '1953-9', '1954-7', '1955-4', '1956-2', '1957-0', '1958-8', '1959-6', '1960-4', '1961-2', '1962-0', '1963-8', '1964-6', '1966-1', '1968-7', '1969-5', '1970-3', '1972-9', '1973-7', '1974-5', '1975-2', '1976-0', '1977-8', '1978-6', '1979-4', '1980-2', '1981-0', '1982-8', '1984-4', '1985-1', '1986-9', '1987-7', '1988-5', '1990-1', '1992-7', '1993-5', '1994-3', '1995-0', '1996-8', '1997-6', '1998-4', '1999-2', '2000-8', '2002-4', '2004-0', '2006-5', '2007-3', '2008-1', '2009-9', '2010-7', '2011-5', '2012-3', '2013-1', '2014-9', '2015-6', '2016-4', '2017-2', '2018-0', '2019-8', '2020-6', '2021-4', '2022-2', '2023-0', '2024-8', '2025-5', '2026-3', '2028-9', '2029-7', '2030-5', '2031-3', '2032-1', '2033-9', '2034-7', '2035-4', '2036-2', '2037-0', '2038-8', '2039-6', '2040-4', '2041-2', '2042-0', '2043-8', '2044-6', '2045-3', '2046-1', '2047-9', '2048-7', '2049-5', '2050-3', '2051-1', '2052-9', '2054-5', '2056-0', '2058-6', '2060-2', '2061-0', '2062-8', '2063-6', '2064-4', '2065-1', '2066-9', '2067-7', '2068-5', '2069-3', '2070-1', '2071-9', '2072-7', '2073-5', '2074-3', '2075-0', '2076-8', '2078-4', '2079-2', '2080-0', '2081-8', '2082-6', '2083-4', '2085-9', '2086-7', '2087-5', '2088-3', '2089-1', '2090-9', '2091-7', '2092-5', '2093-3', '2094-1', '2095-8', '2096-6', '2097-4', '2098-2', '2100-6', '2101-4', '2102-2', '2103-0', '2104-8', '2500-7', '2106-3', '2108-9', '2109-7', '2110-5', '2111-3', '2112-1', '2113-9', '2114-7', '2115-4', '2116-2', '2118-8', '2119-6', '2120-4', '2121-2', '2122-0', '2123-8', '2124-6', '2125-3', '2126-1', '2127-9', '2129-5', '2131-1'] }, 'type' => 'CodeableConcept', 'path' => 'ReferenceRange.meaning', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'example', 'uri' => 'http://hl7.org/fhir/ValueSet/referencerange-meaning' } },
          'age' => { 'type' => 'Range', 'path' => 'ReferenceRange.age', 'min' => 0, 'max' => 1 },
          'text' => { 'type' => 'string', 'path' => 'ReferenceRange.text', 'min' => 0, 'max' => 1 }
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :low               # 0-1 Quantity
        attr_accessor :high              # 0-1 Quantity
        attr_accessor :meaning           # 0-1 CodeableConcept
        attr_accessor :age               # 0-1 Range
        attr_accessor :text              # 0-1 string
      end

      class Related < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        METADATA = {
          'id' => { 'type' => 'id', 'path' => 'Related.id', 'min' => 0, 'max' => 1 },
          'extension' => { 'type' => 'Extension', 'path' => 'Related.extension', 'min' => 0, 'max' => Float::INFINITY },
          'modifierExtension' => { 'type' => 'Extension', 'path' => 'Related.modifierExtension', 'min' => 0, 'max' => Float::INFINITY },
          'type' => { 'valid_codes' => { 'http://hl7.org/fhir/observation-relationshiptypes' => ['has-member', 'derived-from', 'sequel-to', 'replaces', 'qualified-by', 'interfered-by'] }, 'type' => 'code', 'path' => 'Related.type', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'required', 'uri' => 'http://hl7.org/fhir/ValueSet/observation-relationshiptypes' } },
          'target' => { 'type' => 'Reference', 'path' => 'Related.target', 'min' => 1, 'max' => 1 }
        }

        attr_accessor :id                # 0-1 id
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :type              # 0-1 code
        attr_accessor :target            # 1-1 Reference()
      end

      class Component < FHIR::DSTU2::Model
        include FHIR::DSTU2::Hashable
        include FHIR::DSTU2::Json
        include FHIR::DSTU2::Xml

        MULTIPLE_TYPES = {
          'value' => ['Quantity', 'CodeableConcept', 'string', 'Range', 'Ratio', 'SampledData', 'Attachment', 'time', 'dateTime', 'Period']
        }
        METADATA = {
          'id' => { 'type' => 'id', 'path' => 'Component.id', 'min' => 0, 'max' => 1 },
          'extension' => { 'type' => 'Extension', 'path' => 'Component.extension', 'min' => 0, 'max' => Float::INFINITY },
          'modifierExtension' => { 'type' => 'Extension', 'path' => 'Component.modifierExtension', 'min' => 0, 'max' => Float::INFINITY },
          'code' => { 'valid_codes' => { 'http://loinc.org' => [] }, 'type' => 'CodeableConcept', 'path' => 'Component.code', 'min' => 1, 'max' => 1, 'binding' => { 'strength' => 'example', 'uri' => 'http://hl7.org/fhir/ValueSet/observation-codes' } },
          'valueQuantity' => { 'type' => 'Quantity', 'path' => 'Component.value[x]', 'min' => 0, 'max' => 1 },
          'valueCodeableConcept' => { 'type' => 'CodeableConcept', 'path' => 'Component.value[x]', 'min' => 0, 'max' => 1 },
          'valueString' => { 'type' => 'string', 'path' => 'Component.value[x]', 'min' => 0, 'max' => 1 },
          'valueRange' => { 'type' => 'Range', 'path' => 'Component.value[x]', 'min' => 0, 'max' => 1 },
          'valueRatio' => { 'type' => 'Ratio', 'path' => 'Component.value[x]', 'min' => 0, 'max' => 1 },
          'valueSampledData' => { 'type' => 'SampledData', 'path' => 'Component.value[x]', 'min' => 0, 'max' => 1 },
          'valueAttachment' => { 'type' => 'Attachment', 'path' => 'Component.value[x]', 'min' => 0, 'max' => 1 },
          'valueTime' => { 'type' => 'time', 'path' => 'Component.value[x]', 'min' => 0, 'max' => 1 },
          'valueDateTime' => { 'type' => 'dateTime', 'path' => 'Component.value[x]', 'min' => 0, 'max' => 1 },
          'valuePeriod' => { 'type' => 'Period', 'path' => 'Component.value[x]', 'min' => 0, 'max' => 1 },
          'dataAbsentReason' => { 'valid_codes' => { 'http://hl7.org/fhir/data-absent-reason' => ['unknown', 'asked', 'temp', 'not-asked', 'masked', 'unsupported', 'astext', 'error', 'NaN'] }, 'type' => 'CodeableConcept', 'path' => 'Component.dataAbsentReason', 'min' => 0, 'max' => 1, 'binding' => { 'strength' => 'extensible', 'uri' => 'http://hl7.org/fhir/ValueSet/observation-valueabsentreason' } },
          'referenceRange' => { 'type' => 'Observation::ReferenceRange', 'path' => 'Component.referenceRange', 'min' => 0, 'max' => Float::INFINITY }
        }

        attr_accessor :id                   # 0-1 id
        attr_accessor :extension            # 0-* [ Extension ]
        attr_accessor :modifierExtension    # 0-* [ Extension ]
        attr_accessor :code                 # 1-1 CodeableConcept
        attr_accessor :valueQuantity        # 0-1 Quantity
        attr_accessor :valueCodeableConcept # 0-1 CodeableConcept
        attr_accessor :valueString          # 0-1 string
        attr_accessor :valueRange           # 0-1 Range
        attr_accessor :valueRatio           # 0-1 Ratio
        attr_accessor :valueSampledData     # 0-1 SampledData
        attr_accessor :valueAttachment      # 0-1 Attachment
        attr_accessor :valueTime            # 0-1 time
        attr_accessor :valueDateTime        # 0-1 dateTime
        attr_accessor :valuePeriod          # 0-1 Period
        attr_accessor :dataAbsentReason     # 0-1 CodeableConcept
        attr_accessor :referenceRange       # 0-* [ Observation::ReferenceRange ]
      end

      attr_accessor :id                   # 0-1 id
      attr_accessor :meta                 # 0-1 Meta
      attr_accessor :implicitRules        # 0-1 uri
      attr_accessor :language             # 0-1 code
      attr_accessor :text                 # 0-1 Narrative
      attr_accessor :contained            # 0-* [ Resource ]
      attr_accessor :extension            # 0-* [ Extension ]
      attr_accessor :modifierExtension    # 0-* [ Extension ]
      attr_accessor :identifier           # 0-* [ Identifier ]
      attr_accessor :status               # 1-1 code
      attr_accessor :category             # 0-1 CodeableConcept
      attr_accessor :code                 # 1-1 CodeableConcept
      attr_accessor :subject              # 0-1 Reference()
      attr_accessor :encounter            # 0-1 Reference()
      attr_accessor :effectiveDateTime    # 0-1 dateTime
      attr_accessor :effectivePeriod      # 0-1 Period
      attr_accessor :issued               # 0-1 instant
      attr_accessor :performer            # 0-* [ Reference() ]
      attr_accessor :valueQuantity        # 0-1 Quantity
      attr_accessor :valueCodeableConcept # 0-1 CodeableConcept
      attr_accessor :valueString          # 0-1 string
      attr_accessor :valueRange           # 0-1 Range
      attr_accessor :valueRatio           # 0-1 Ratio
      attr_accessor :valueSampledData     # 0-1 SampledData
      attr_accessor :valueAttachment      # 0-1 Attachment
      attr_accessor :valueTime            # 0-1 time
      attr_accessor :valueDateTime        # 0-1 dateTime
      attr_accessor :valuePeriod          # 0-1 Period
      attr_accessor :dataAbsentReason     # 0-1 CodeableConcept
      attr_accessor :interpretation       # 0-1 CodeableConcept
      attr_accessor :comments             # 0-1 string
      attr_accessor :bodySite             # 0-1 CodeableConcept
      attr_accessor :local_method         # 0-1 CodeableConcept
      attr_accessor :specimen             # 0-1 Reference()
      attr_accessor :device               # 0-1 Reference()
      attr_accessor :referenceRange       # 0-* [ Observation::ReferenceRange ]
      attr_accessor :related              # 0-* [ Observation::Related ]
      attr_accessor :component            # 0-* [ Observation::Component ]

      def resourceType
        'Observation'
      end
    end
  end
end
