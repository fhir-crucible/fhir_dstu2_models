module FHIR
  module DSTU2
    class Media < FHIR::DSTU2::Model
      include FHIR::DSTU2::Hashable
      include FHIR::DSTU2::Json
      include FHIR::DSTU2::Xml

      SEARCH_PARAMS = ['created', 'identifier', 'operator', 'patient', 'subject', 'subtype', 'type', 'view']
      METADATA = {
        'id' => {'type'=>'id', 'path'=>'Media.id', 'min'=>0, 'max'=>1},
        'meta' => {'type'=>'Meta', 'path'=>'Media.meta', 'min'=>0, 'max'=>1},
        'implicitRules' => {'type'=>'uri', 'path'=>'Media.implicitRules', 'min'=>0, 'max'=>1},
        'language' => {'type'=>'code', 'path'=>'Media.language', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://tools.ietf.org/html/bcp47'}},
        'text' => {'type'=>'Narrative', 'path'=>'Media.text', 'min'=>0, 'max'=>1},
        'contained' => {'type'=>'Resource', 'path'=>'Media.contained', 'min'=>0, 'max'=>Float::INFINITY},
        'extension' => {'type'=>'Extension', 'path'=>'Media.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'Media.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'type' => {'valid_codes'=>{'http://hl7.org/fhir/digital-media-type'=>['photo', 'video', 'audio']}, 'type'=>'code', 'path'=>'Media.type', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/digital-media-type'}},
        'subtype' => {'valid_codes'=>{'http://hl7.org/fhir/media-subtype'=>['diagram', 'fax', 'scan', 'retina', 'fingerprint', 'iris', 'palm', 'face'], 'http://snomed.info/sct'=>[], 'http://nema.org/dicom/dicm'=>['ARCHIVE', 'AR', 'AS', 'AU', 'BDUS', 'BI', 'BMD', 'CAD', 'CAPTURE', 'CD', 'CF', 'COMP', 'CP', 'CR', 'CS', 'CT', 'DD', 'DF', 'DG', 'DM', 'DOCD', 'DS', 'DSS', 'DX', 'EC', 'ECG', 'EPS', 'ES', 'F', 'FA', 'FC', 'FILMD', 'FP', 'FS', 'GM', 'H', 'HC', 'HD', 'IO', 'IVUS', 'KER', 'KO', 'LEN', 'LOG', 'LP', 'LS', 'M', 'MA', 'MC', 'MCD', 'MEDIM', 'MG', 'MP', 'MR', 'MS', 'NEARLINE', 'NM', 'OAM', 'OCT', 'OFFLINE', 'ONLINE', 'OP', 'OPM', 'OPR', 'OPT', 'OPV', 'OT', 'PR', 'PRINT', 'PT', 'PX', 'REG', 'RF', 'RG', 'RT', 'RTDOSE', 'RTIMAGE', 'RTPLAN', 'RTRECORD', 'RTSTRUCT', 'SEG', 'SM', 'SMR', 'SR', 'SRF', 'ST', 'TG', 'U', 'UNAVAILABLE', 'US', 'VA', 'VF', 'VIDD', 'WSD', 'XA', 'XC', '109001', '109002', '109003', '109004', '109005', '109006', '109007', '109008', '109009', '109010', '109011', '109012', '109013', '109014', '109015', '109016', '109017', '109018', '109019', '109020', '109021', '109022', '109023', '109024', '109025', '109026', '109027', '109028', '109029', '109030', '109031', '109032', '109033', '109034', '109035', '109036', '109037', '109038', '109039', '109040', '109041', '109042', '109043', '109044', '109045', '109046', '109047', '109048', '109049', '109050', '109051', '109052', '109053', '109054', '109055', '109056', '109057', '109058', '109059', '109060', '109061', '109063', '109070', '109071', '109072', '109073', '109080', '109081', '109082', '109083', '109091', '109092', '109093', '109094', '109095', '109096', '109101', '109102', '109103', '109104', '109105', '109106', '109110', '109111', '109112', '109113', '109114', '109115', '109116', '109117', '109120', '109121', '109122', '109123', '109124', '109125', '109132', '109133', '109134', '109135', '109136', '109200', '109201', '109202', '109203', '109204', '109205', '109206', '109207', '109208', '109209', '109210', '109211', '109212', '109213', '109214', '109215', '109216', '109217', '109218', '109219', '109220', '109221', '109222', '109701', '109702', '109703', '109704', '109705', '109706', '109707', '109708', '109709', '109710', '109801', '109802', '109803', '109804', '109805', '109806', '109807', '109808', '109809', '109810', '109811', '109812', '109813', '109814', '109815', '109816', '109817', '109818', '109819', '109820', '109821', '109822', '109823', '109824', '109825', '109826', '109827', '109828', '109829', '109830', '109831', '109832', '109833', '109834', '109835', '109836', '109837', '109838', '109839', '109840', '109841', '109842', '109843', '109844', '109845', '109846', '109847', '109848', '109849', '109850', '109851', '109852', '109853', '109854', '109855', '109856', '109857', '109858', '109859', '109860', '109861', '109862', '109863', '109864', '109865', '109866', '109867', '109868', '109869', '109870', '109871', '109872', '109873', '109874', '109875', '109876', '109877', '109878', '109879', '109880', '109881', '109901', '109902', '109903', '109904', '109905', '109906', '109907', '109908', '109909', '109910', '109911', '109912', '109913', '109914', '109915', '109916', '109917', '109918', '109919', '109920', '109921', '109931', '109932', '109933', '109941', '109943', '109991', '109992', '109993', '109994', '109995', '109996', '109997', '109998', '109999', '110001', '110002', '110003', '110004', '110005', '110006', '110007', '110008', '110009', '110010', '110011', '110012', '110013', '110020', '110021', '110022', '110023', '110024', '110025', '110026', '110027', '110028', '110030', '110031', '110032', '110033', '110034', '110035', '110036', '110037', '110038', '110100', '110101', '110102', '110103', '110104', '110105', '110106', '110107', '110108', '110109', '110110', '110111', '110112', '110113', '110114', '110120', '110121', '110122', '110123', '110124', '110125', '110126', '110127', '110128', '110129', '110130', '110131', '110132', '110133', '110134', '110135', '110136', '110137', '110138', '110139', '110140', '110141', '110142', '110150', '110151', '110152', '110153', '110154', '110155', '110180', '110181', '110182', '110190', '110500', '110501', '110502', '110503', '110504', '110505', '110506', '110507', '110508', '110509', '110510', '110511', '110512', '110513', '110514', '110515', '110516', '110518', '110519', '110521', '110522', '110523', '110524', '110526', '110527', '110528', '110529', '110700', '110701', '110702', '110703', '110704', '110705', '110706', '110800', '110801', '110802', '110803', '110804', '110805', '110806', '110807', '110808', '110809', '110810', '110811', '110812', '110813', '110814', '110815', '110816', '110817', '110818', '110819', '110820', '110821', '110822', '110823', '110824', '110825', '110826', '110827', '110828', '110829', '110830', '110831', '110832', '110833', '110834', '110835', '110836', '110837', '110838', '110839', '110840', '110841', '110842', '110843', '110844', '110845', '110846', '110847', '110848', '110849', '110850', '110851', '110852', '110853', '110854', '110855', '110856', '110857', '110858', '110859', '110860', '110861', '110862', '110863', '110864', '110865', '110866', '110867', '110868', '110869', '110870', '110871', '110872', '110873', '110874', '110875', '110876', '110877', '110901', '110902', '110903', '110904', '110905', '110906', '110907', '110908', '110909', '110910', '110911', '111001', '111002', '111003', '111004', '111005', '111006', '111007', '111008', '111009', '111010', '111011', '111012', '111013', '111014', '111015', '111016', '111017', '111018', '111019', '111020', '111021', '111022', '111023', '111024', '111025', '111026', '111027', '111028', '111029', '111030', '111031', '111032', '111033', '111034', '111035', '111036', '111037', '111038', '111039', '111040', '111041', '111042', '111043', '111044', '111045', '111046', '111047', '111048', '111049', '111050', '111051', '111052', '111053', '111054', '111055', '111056', '111057', '111058', '111059', '111060', '111061', '111062', '111063', '111064', '111065', '111066', '111069', '111071', '111072', '111081', '111086', '111087', '111088', '111089', '111090', '111091', '111092', '111093', '111099', '111100', '111101', '111102', '111103', '111104', '111105', '111111', '111112', '111113', '111120', '111121', '111122', '111123', '111124', '111125', '111126', '111127', '111128', '111129', '111130', '111135', '111136', '111137', '111138', '111139', '111140', '111141', '111142', '111143', '111144', '111145', '111146', '111147', '111148', '111149', '111150', '111151', '111152', '111153', '111154', '111155', '111156', '111157', '111158', '111159', '111168', '111170', '111171', '111172', '111173', '111174', '111175', '111176', '111177', '111178', '111179', '111180', '111181', '111182', '111183', '111184', '111185', '111186', '111187', '111188', '111189', '111190', '111191', '111192', '111193', '111194', '111195', '111196', '111197', '111198', '111199', '111200', '111201', '111202', '111203', '111204', '111205', '111206', '111207', '111208', '111209', '111210', '111211', '111212', '111213', '111214', '111215', '111216', '111217', '111218', '111219', '111220', '111221', '111222', '111223', '111224', '111225', '111233', '111234', '111235', '111236', '111237', '111238', '111239', '111240', '111241', '111242', '111243', '111244', '111245', '111248', '111249', '111250', '111251', '111252', '111253', '111254', '111255', '111256', '111257', '111258', '111259', '111260', '111262', '111263', '111264', '111265', '111269', '111271', '111273', '111277', '111278', '111279', '111281', '111283', '111284', '111285', '111286', '111287', '111288', '111290', '111291', '111292', '111293', '111294', '111296', '111297', '111298', '111299', '111300', '111301', '111302', '111303', '111304', '111305', '111306', '111307', '111308', '111309', '111310', '111311', '111312', '111313', '111314', '111315', '111316', '111317', '111318', '111320', '111321', '111322', '111323', '111324', '111325', '111326', '111327', '111328', '111329', '111330', '111331', '111332', '111333', '111334', '111335', '111336', '111338', '111340', '111341', '111342', '111343', '111344', '111345', '111346', '111347', '111350', '111351', '111352', '111353', '111354', '111355', '111356', '111357', '111358', '111359', '111360', '111361', '111362', '111363', '111364', '111365', '111366', '111367', '111368', '111369', '111370', '111371', '111372', '111373', '111374', '111375', '111376', '111377', '111380', '111381', '111382', '111383', '111384', '111385', '111386', '111387', '111388', '111389', '111390', '111391', '111392', '111393', '111394', '111395', '111396', '111397', '111398', '111399', '111400', '111401', '111402', '111403', '111404', '111405', '111406', '111407', '111408', '111409', '111410', '111411', '111412', '111413', '111414', '111415', '111416', '111417', '111418', '111419', '111420', '111421', '111423', '111424', '111425', '111426', '111427', '111428', '111429', '111430', '111431', '111432', '111433', '111434', '111435', '111436', '111437', '111438', '111439', '111440', '111441', '111442', '111443', '111444', '111445', '111446', '111447', '111448', '111449', '111450', '111451', '111452', '111453', '111454', '111455', '111456', '111457', '111458', '111459', '111460', '111461', '111462', '111463', '111464', '111465', '111466', '111467', '111468', '111469', '111470', '111471', '111472', '111473', '111474', '111475', '111476', '111477', '111478', '111479', '111480', '111481', '111482', '111483', '111484', '111485', '111486', '111487', '111488', '111489', '111490', '111491', '111492', '111494', '111495', '111496', '111497', '111498', '111499', '111500', '111501', '111502', '111503', '111504', '111505', '111506', '111507', '111508', '111509', '111510', '111511', '111512', '111513', '111514', '111515', '111516', '111517', '111518', '111519', '111520', '111521', '111522', '111523', '111524', '111525', '111526', '111527', '111528', '111529', '111530', '111531', '111532', '111533', '111534', '111535', '111536', '111537', '111538', '111539', '111540', '111541', '111542', '111543', '111544', '111545', '111546', '111547', '111548', '111549', '111550', '111551', '111552', '111553', '111554', '111555', '111556', '111557', '111558', '111559', '111560', '111561', '111562', '111563', '111564', '111565', '111566', '111567', '111568', '111569', '111570', '111571', '111572', '111573', '111574', '111575', '111576', '111577', '111578', '111579', '111580', '111581', '111582', '111583', '111584', '111585', '111586', '111587', '111590', '111591', '111592', '111593', '111601', '111602', '111603', '111604', '111605', '111606', '111607', '111609', '111621', '111622', '111623', '111625', '111626', '111627', '111628', '111629', '111630', '111631', '111632', '111633', '111634', '111635', '111636', '111637', '111638', '111641', '111642', '111643', '111644', '111645', '111646', '111671', '111672', '111673', '111674', '111675', '111676', '111677', '111678', '111679', '111680', '111685', '111686', '111687', '111688', '111689', '111690', '111691', '111692', '111693', '111694', '111695', '111696', '111697', '111698', '111700', '111701', '111702', '111703', '111704', '111705', '111706', '111707', '111708', '111709', '111710', '111711', '111712', '111718', '111719', '111720', '111721', '111723', '111724', '111726', '111727', '111729', '111741', '111742', '111743', '111744', '111745', '111746', '111747', '111748', '111749', '111750', '111751', '111752', '111753', '111754', '111755', '111756', '111760', '111761', '111762', '111763', '111764', '111765', '111766', '111767', '111768', '111769', '111770', '111771', '111772', '111773', '111776', '111777', '111778', '111779', '111780', '111781', '111782', '111783', '111786', '111787', '111791', '111792', '111800', '111801', '111802', '111803', '111804', '111805', '111806', '111807', '111808', '111809', '111810', '111811', '111812', '111813', '111814', '111815', '111816', '111817', '111818', '111819', '111820', '111821', '111822', '111823', '111824', '111825', '111826', '111827', '111828', '111829', '111830', '111831', '111832', '111833', '111834', '111835', '111836', '111837', '111838', '111839', '111840', '111841', '111842', '111843', '111844', '111845', '111846', '111847', '111848', '111849', '111850', '111851', '111852', '111853', '111854', '111855', '111856', '111900', '111901', '111902', '111903', '111904', '111905', '111906', '111907', '111908', '111909', '111910', '111911', '111912', '111913', '111914', '111915', '111916', '111917', '111918', '111919', '111920', '111921', '111922', '111923', '111924', '111925', '111926', '111927', '111928', '111929', '111930', '111931', '111932', '111933', '111934', '111935', '111936', '111937', '111938', '111939', '111940', '111941', '111942', '111943', '111944', '111945', '111946', '111947', '112000', '112001', '112002', '112003', '112004', '112005', '112006', '112007', '112008', '112009', '112010', '112011', '112012', '112013', '112014', '112015', '112016', '112017', '112018', '112019', '112020', '112021', '112022', '112023', '112024', '112025', '112026', '112027', '112028', '112029', '112030', '112031', '112032', '112033', '112034', '112035', '112036', '112037', '112038', '112039', '112040', '112041', '112042', '112043', '112044', '112045', '112046', '112047', '112048', '112049', '112050', '112051', '112052', '112053', '112054', '112055', '112056', '112057', '112058', '112059', '112060', '112061', '112062', '112063', '112064', '112065', '112066', '112067', '112068', '112069', '112070', '112071', '112072', '112073', '112074', '112075', '112076', '112077', '112078', '112079', '112080', '112081', '112082', '112083', '112084', '112085', '112086', '112087', '112088', '112089', '112090', '112091', '112092', '112093', '112094', '112095', '112096', '112097', '112098', '112099', '112100', '112101', '112102', '112103', '112104', '112105', '112106', '112107', '112108', '112109', '112110', '112111', '112112', '112113', '112114', '112115', '112116', '112117', '112118', '112119', '112120', '112121', '112122', '112123', '112124', '112125', '112126', '112127', '112128', '112129', '112130', '112131', '112132', '112133', '112134', '112135', '112136', '112137', '112138', '112139', '112140', '112141', '112142', '112143', '112144', '112145', '112146', '112147', '112148', '112149', '112150', '112151', '112152', '112153', '112154', '112155', '112156', '112157', '112158', '112159', '112160', '112161', '112162', '112163', '112164', '112165', '112166', '112167', '112168', '112169', '112170', '112171', '112172', '112173', '112174', '112175', '112176', '112177', '112178', '112179', '112180', '112181', '112182', '112183', '112184', '112185', '112186', '112187', '112188', '112189', '112191', '112192', '112193', '112194', '112195', '112196', '112197', '112198', '112199', '112200', '112201', '112220', '112222', '112224', '112225', '112226', '112227', '112228', '112229', '112232', '112233', '112238', '112240', '112241', '112242', '112243', '112244', '112248', '112249', '112300', '112301', '112302', '112303', '112304', '112305', '112306', '112307', '112308', '112309', '112310', '112311', '112312', '112313', '112314', '112315', '112316', '112317', '112318', '112319', '112320', '112321', '112325', '112340', '112341', '112342', '112343', '112344', '112345', '112346', '112347', '112348', '112350', '112351', '112352', '112353', '112354', '112355', '112356', '112357', '112358', '112359', '112360', '112361', '112362', '112363', '112364', '112365', '112366', '112367', '112368', '112369', '112370', '112371', '112372', '112373', '112374', '112375', '112376', '112377', '112378', '112379', '112380', '112381', '112700', '112701', '112702', '112703', '112704', '112705', '112706', '112707', '112708', '112709', '112710', '112711', '112712', '112713', '112714', '112715', '112716', '112717', '112718', '112719', '112720', '112721', '113000', '113001', '113002', '113003', '113004', '113005', '113006', '113007', '113008', '113009', '113010', '113011', '113012', '113013', '113014', '113015', '113016', '113017', '113018', '113020', '113021', '113026', '113030', '113031', '113032', '113033', '113034', '113035', '113036', '113037', '113038', '113039', '113040', '113041', '113042', '113043', '113044', '113045', '113046', '113047', '113048', '113049', '113050', '113051', '113052', '113053', '113054', '113055', '113056', '113057', '113058', '113059', '113060', '113061', '113062', '113063', '113064', '113065', '113066', '113067', '113068', '113069', '113070', '113071', '113072', '113073', '113074', '113075', '113076', '113077', '113078', '113079', '113080', '113081', '113082', '113083', '113085', '113086', '113087', '113088', '113089', '113090', '113091', '113092', '113093', '113094', '113095', '113096', '113097', '113100', '113101', '113102', '113103', '113104', '113105', '113106', '113107', '113108', '113109', '113110', '113111', '113500', '113502', '113503', '113505', '113506', '113507', '113508', '113509', '113510', '113511', '113512', '113513', '113514', '113516', '113517', '113518', '113520', '113521', '113522', '113523', '113526', '113527', '113528', '113529', '113530', '113540', '113541', '113542', '113543', '113550', '113551', '113552', '113560', '113561', '113562', '113563', '113568', '113570', '113571', '113572', '113573', '113574', '113575', '113576', '113577', '113601', '113602', '113603', '113605', '113606', '113607', '113608', '113609', '113611', '113612', '113613', '113620', '113621', '113622', '113630', '113631', '113650', '113651', '113652', '113653', '113661', '113662', '113663', '113664', '113665', '113666', '113669', '113670', '113671', '113680', '113681', '113682', '113683', '113684', '113685', '113686', '113687', '113688', '113689', '113690', '113691', '113692', '113701', '113702', '113704', '113705', '113706', '113710', '113711', '113720', '113721', '113722', '113723', '113724', '113725', '113726', '113727', '113728', '113729', '113730', '113731', '113732', '113733', '113734', '113735', '113736', '113737', '113738', '113739', '113740', '113742', '113743', '113744', '113745', '113748', '113750', '113751', '113752', '113753', '113754', '113755', '113756', '113757', '113758', '113759', '113760', '113761', '113763', '113764', '113766', '113767', '113768', '113769', '113770', '113771', '113772', '113773', '113780', '113788', '113789', '113790', '113791', '113792', '113793', '113794', '113795', '113800', '113801', '113802', '113803', '113804', '113805', '113806', '113807', '113808', '113809', '113810', '113811', '113812', '113813', '113814', '113815', '113816', '113817', '113818', '113819', '113820', '113821', '113822', '113823', '113824', '113825', '113826', '113827', '113828', '113829', '113830', '113831', '113832', '113833', '113834', '113835', '113836', '113837', '113838', '113839', '113840', '113841', '113842', '113845', '113846', '113847', '113850', '113851', '113852', '113853', '113854', '113855', '113856', '113857', '113858', '113859', '113860', '113861', '113862', '113863', '113864', '113865', '113866', '113867', '113868', '113870', '113871', '113872', '113873', '113874', '113875', '113876', '113877', '113878', '113879', '113880', '113890', '113893', '113895', '113896', '113897', '113898', '113899', '113900', '113901', '113902', '113903', '113904', '113905', '113906', '113907', '113908', '113909', '113910', '113911', '113912', '113913', '113914', '113921', '113922', '113923', '113930', '113931', '113932', '113933', '113934', '113935', '113936', '113937', '113940', '113941', '113942', '113943', '113944', '113945', '113946', '113947', '113948', '113949', '113950', '113951', '113952', '113953', '113954', '113955', '113956', '113957', '113958', '113959', '113961', '113962', '113963', '113970', '114000', '114001', '114002', '114003', '114004', '114005', '114006', '114007', '114008', '114009', '114010', '114011', '114201', '114202', '114203', '114204', '114205', '114206', '114207', '114208', '114209', '114210', '114211', '114213', '114215', '114216', '121001', '121002', '121003', '121004', '121005', '121006', '121007', '121008', '121009', '121010', '121011', '121012', '121013', '121014', '121015', '121016', '121017', '121018', '121019', '121020', '121021', '121022', '121023', '121024', '121025', '121026', '121027', '121028', '121029', '121030', '121031', '121032', '121033', '121034', '121035', '121036', '121037', '121038', '121039', '121040', '121041', '121042', '121043', '121044', '121045', '121046', '121047', '121048', '121049', '121050', '121051', '121052', '121053', '121054', '121055', '121056', '121057', '121058', '121059', '121060', '121062', '121064', '121065', '121066', '121068', '121069', '121070', '121071', '121072', '121073', '121074', '121075', '121076', '121077', '121078', '121079', '121080', '121081', '121082', '121083', '121084', '121085', '121086', '121087', '121088', '121089', '121090', '121091', '121092', '121093', '121094', '121095', '121096', '121097', '121098', '121099', '121100', '121101', '121102', '121103', '121104', '121105', '121106', '121109', '121110', '121111', '121112', '121113', '121114', '121115', '121116', '121117', '121118', '121120', '121121', '121122', '121123', '121124', '121125', '121126', '121127', '121128', '121130', '121131', '121132', '121133', '121135', '121136', '121137', '121138', '121139', '121140', '121141', '121142', '121143', '121144', '121145', '121146', '121147', '121148', '121149', '121150', '121151', '121152', '121153', '121154', '121155', '121156', '121157', '121158', '121160', '121161', '121162', '121163', '121165', '121166', '121167', '121168', '121169', '121171', '121172', '121173', '121174', '121180', '121181', '121190', '121191', '121192', '121193', '121194', '121195', '121196', '121197', '121198', '121200', '121201', '121202', '121206', '121207', '121208', '121210', '121211', '121213', '121214', '121216', '121217', '121218', '121219', '121220', '121221', '121222', '121230', '121231', '121232', '121233', '121242', '121243', '121244', '121290', '121291', '121301', '121302', '121303', '121304', '121305', '121306', '121307', '121311', '121312', '121313', '121314', '121315', '121316', '121317', '121318', '121320', '121321', '121322', '121323', '121324', '121325', '121326', '121327', '121328', '121329', '121330', '121331', '121332', '121333', '121334', '121335', '121338', '121339', '121340', '121341', '121342', '121346', '121347', '121348', '121349', '121350', '121351', '121352', '121353', '121354', '121358', '121360', '121361', '121362', '121363', '121370', '121371', '121372', '121380', '121381', '121382', '121383', '121401', '121402', '121403', '121404', '121405', '121406', '121407', '121408', '121410', '121411', '121412', '121414', '121415', '121416', '121417', '121420', '121421', '121422', '121423', '121424', '121425', '121427', '121428', '121430', '121431', '121432', '121433', '121434', '121435', '121436', '121437', '121438', '121439', '121701', '121702', '121703', '121704', '121705', '121706', '121707', '121708', '121709', '121710', '121711', '121712', '121713', '121714', '121715', '121716', '121717', '121718', '121719', '121720', '121721', '121722', '121723', '121724', '121725', '121726', '121727', '121728', '121729', '121730', '121731', '121732', '121733', '121734', '121740', '122001', '122002', '122003', '122004', '122005', '122006', '122007', '122008', '122009', '122010', '122011', '122012', '122020', '122021', '122022', '122023', '122024', '122025', '122026', '122027', '122028', '122029', '122030', '122031', '122032', '122033', '122034', '122035', '122036', '122037', '122038', '122039', '122041', '122042', '122043', '122044', '122045', '122046', '122047', '122048', '122049', '122052', '122053', '122054', '122055', '122056', '122057', '122058', '122059', '122060', '122061', '122062', '122072', '122073', '122075', '122076', '122077', '122078', '122079', '122081', '122082', '122083', '122084', '122085', '122086', '122087', '122088', '122089', '122090', '122091', '122092', '122093', '122094', '122095', '122096', '122097', '122098', '122099', '122101', '122102', '122103', '122104', '122105', '122106', '122107', '122108', '122109', '122110', '122111', '122112', '122113', '122114', '122120', '122121', '122122', '122123', '122124', '122125', '122126', '122127', '122128', '122129', '122130', '122131', '122132', '122133', '122134', '122138', '122139', '122140', '122141', '122142', '122143', '122144', '122145', '122146', '122147', '122148', '122149', '122150', '122151', '122152', '122153', '122154', '122157', '122158', '122159', '122160', '122161', '122162', '122163', '122164', '122165', '122166', '122167', '122170', '122171', '122172', '122173', '122175', '122176', '122177', '122178', '122179', '122180', '122181', '122182', '122183', '122185', '122187', '122188', '122189', '122190', '122191', '122192', '122193', '122194', '122195', '122196', '122197', '122198', '122199', '122201', '122202', '122203', '122204', '122205', '122206', '122207', '122208', '122209', '122210', '122211', '122212', '122213', '122214', '122215', '122216', '122217', '122218', '122219', '122220', '122221', '122222', '122223', '122224', '122225', '122227', '122228', '122229', '122230', '122231', '122232', '122233', '122234', '122235', '122236', '122237', '122238', '122239', '122240', '122241', '122242', '122243', '122244', '122245', '122246', '122247', '122248', '122249', '122250', '122251', '122252', '122253', '122254', '122255', '122256', '122257', '122258', '122259', '122260', '122261', '122262', '122263', '122265', '122266', '122267', '122268', '122269', '122270', '122271', '122272', '122273', '122274', '122275', '122276', '122277', '122278', '122279', '122281', '122282', '122283', '122288', '122291', '122292', '122301', '122302', '122303', '122304', '122305', '122306', '122307', '122308', '122309', '122310', '122311', '122312', '122313', '122319', '122320', '122321', '122322', '122325', '122330', '122331', '122332', '122333', '122334', '122335', '122336', '122337', '122339', '122340', '122341', '122343', '122344', '122345', '122346', '122347', '122348', '122350', '122351', '122352', '122354', '122355', '122356', '122357', '122360', '122361', '122363', '122364', '122367', '122368', '122369', '122370', '122371', '122372', '122374', '122375', '122376', '122380', '122381', '122382', '122383', '122384', '122385', '122386', '122387', '122388', '122389', '122390', '122391', '122393', '122394', '122395', '122398', '122399', '122400', '122401', '122402', '122403', '122404', '122405', '122406', '122407', '122408', '122410', '122411', '122417', '122421', '122422', '122423', '122428', '122429', '122430', '122431', '122432', '122433', '122434', '122435', '122438', '122445', '122446', '122447', '122448', '122449', '122450', '122451', '122452', '122453', '122459', '122461', '122464', '122465', '122466', '122467', '122468', '122469', '122470', '122471', '122472', '122473', '122474', '122475', '122476', '122477', '122480', '122481', '122482', '122485', '122486', '122487', '122488', '122489', '122490', '122491', '122493', '122495', '122496', '122497', '122498', '122499', '122501', '122502', '122503', '122505', '122507', '122508', '122509', '122510', '122511', '122516', '122517', '122528', '122529', '122542', '122544', '122545', '122546', '122547', '122548', '122549', '122550', '122551', '122554', '122555', '122558', '122559', '122560', '122562', '122563', '122564', '122565', '122566', '122572', '122574', '122575', '122582', '122600', '122601', '122602', '122603', '122604', '122605', '122606', '122607', '122608', '122609', '122611', '122612', '122616', '122617', '122618', '122619', '122620', '122621', '122624', '122627', '122628', '122631', '122633', '122634', '122635', '122636', '122637', '122638', '122639', '122640', '122642', '122643', '122645', '122650', '122651', '122652', '122655', '122656', '122657', '122658', '122659', '122660', '122661', '122664', '122665', '122666', '122667', '122668', '122670', '122675', '122680', '122683', '122684', '122685', '122686', '122687', '122698', '122699', '122700', '122701', '122702', '122703', '122704', '122705', '122706', '122707', '122708', '122709', '122710', '122711', '122712', '122713', '122715', '122716', '122717', '122718', '122720', '122721', '122726', '122727', '122728', '122729', '122730', '122731', '122732', '122733', '122734', '122735', '122739', '122740', '122741', '122742', '122743', '122744', '122745', '122748', '122750', '122751', '122752', '122753', '122755', '122756', '122757', '122758', '122759', '122760', '122762', '122764', '122768', '122769', '122770', '122771', '122772', '122773', '122775', '122776', '122781', '122782', '122783', '122784', '122785', '122791', '122792', '122793', '122795', '122796', '122797', '122799', '123001', '123003', '123004', '123005', '123006', '123007', '123009', '123010', '123011', '123012', '123014', '123015', '123016', '123019', '123101', '123102', '123103', '123104', '123105', '123106', '123107', '123108', '123109', '123110', '123111', '125000', '125001', '125002', '125003', '125004', '125005', '125006', '125007', '125008', '125009', '125010', '125011', '125012', '125013', '125015', '125016', '125021', '125022', '125023', '125024', '125025', '125030', '125031', '125032', '125033', '125034', '125035', '125036', '125037', '125038', '125040', '125041', '125100', '125101', '125102', '125105', '125106', '125107', '125195', '125196', '125197', '125200', '125201', '125202', '125203', '125204', '125205', '125206', '125207', '125208', '125209', '125210', '125211', '125212', '125213', '125214', '125215', '125216', '125217', '125218', '125219', '125220', '125221', '125222', '125223', '125224', '125225', '125226', '125227', '125228', '125230', '125231', '125233', '125234', '125235', '125236', '125237', '125238', '125239', '125240', '125241', '125242', '125251', '125252', '125253', '125254', '125255', '125256', '125257', '125258', '125259', '125261', '125262', '125263', '125264', '125265', '125270', '125271', '125272', '125273', '125901', '125902', '125903', '125904', '125905', '125906', '125907', '125908', '126000', '126001', '126002', '126003', '126010', '126011', '126020', '126021', '126022', '126030', '126031', '126032', '126033', '126034', '126035', '126036', '126037', '126038', '126039', '126040', '126050', '126051', '126052', '126060', '126061', '126062', '126063', '126064', '126065', '126066', '126067', '126070', '126071', '126072', '126073', '126074', '126075', '126080', '126081', '126100', '126200', '126201', '126202', '126203', '126220', '126300', '126301', '126302', '126303', '126310', '126311', '126312', '126313', '126314', '126320', '126321', '126322', '126330', '126331', '126340', '126341', '126342', '126343', '126344', '126350', '126351', '126352', '126353', '126360', '126361', '126362', '126363', '126364', '126370', '126371', '126372', '126373', '126374', '126375', '126376', '126377', '126380', '126390', '126391', '126392', '126393', '126394', '126400', '126401', '126402', '126403', '126404', '126410', '126411', '126412', '126413', '126500', '126501', '126502', '126503', '126510', '126511', '126512', '126513', '126514', '126515', '126516', '126517', '126518', '126519', '126520', '126600', '126601', '126602', '126603', '126604', '126605', '126606', '126700', '126701', '126702', '126703', '126704', '126705', '126706', '126707', '126708', '126709', '126710', '126711', '126712', '126713', '126714', '126715', '126716', '126801', '126802', '126803', '126804', '126805', '126806', '126807', '126808', '126809', '126810', '126811', 'IVOCT', 'OSS']}, 'type'=>'CodeableConcept', 'path'=>'Media.subtype', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/digital-media-subtype'}},
        'identifier' => {'type'=>'Identifier', 'path'=>'Media.identifier', 'min'=>0, 'max'=>Float::INFINITY},
        'subject' => {'type'=>'Reference', 'path'=>'Media.subject', 'min'=>0, 'max'=>1},
        'operator' => {'type'=>'Reference', 'path'=>'Media.operator', 'min'=>0, 'max'=>1},
        'view' => {'valid_codes'=>{'http://snomed.info/sct'=>[]}, 'type'=>'CodeableConcept', 'path'=>'Media.view', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/media-view'}},
        'deviceName' => {'type'=>'string', 'path'=>'Media.deviceName', 'min'=>0, 'max'=>1},
        'height' => {'type'=>'positiveInt', 'path'=>'Media.height', 'min'=>0, 'max'=>1},
        'width' => {'type'=>'positiveInt', 'path'=>'Media.width', 'min'=>0, 'max'=>1},
        'frames' => {'type'=>'positiveInt', 'path'=>'Media.frames', 'min'=>0, 'max'=>1},
        'duration' => {'type'=>'unsignedInt', 'path'=>'Media.duration', 'min'=>0, 'max'=>1},
        'content' => {'type'=>'Attachment', 'path'=>'Media.content', 'min'=>1, 'max'=>1}
      }

      attr_accessor :id                # 0-1 id
      attr_accessor :meta              # 0-1 Meta
      attr_accessor :implicitRules     # 0-1 uri
      attr_accessor :language          # 0-1 code
      attr_accessor :text              # 0-1 Narrative
      attr_accessor :contained         # 0-* [ Resource ]
      attr_accessor :extension         # 0-* [ Extension ]
      attr_accessor :modifierExtension # 0-* [ Extension ]
      attr_accessor :type              # 1-1 code
      attr_accessor :subtype           # 0-1 CodeableConcept
      attr_accessor :identifier        # 0-* [ Identifier ]
      attr_accessor :subject           # 0-1 Reference()
      attr_accessor :operator          # 0-1 Reference()
      attr_accessor :view              # 0-1 CodeableConcept
      attr_accessor :deviceName        # 0-1 string
      attr_accessor :height            # 0-1 positiveInt
      attr_accessor :width             # 0-1 positiveInt
      attr_accessor :frames            # 0-1 positiveInt
      attr_accessor :duration          # 0-1 unsignedInt
      attr_accessor :content           # 1-1 Attachment

      def resourceType
        'Media'
      end
    end
  end
end
