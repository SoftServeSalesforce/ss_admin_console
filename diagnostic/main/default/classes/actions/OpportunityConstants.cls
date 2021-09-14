public with sharing class OpportunityConstants {

    public final static List<DataWrapper> OPPORTUNITY_DATA = new List<DataWrapper>{
            new DataWrapper('OPP_TEST-0001', new Opportunity(Name = 'OPP_TEST-0001', StageName = 'Prospecting', Amount = 72.1, CloseDate = Date.today() + 91), new Map<String, String> {'AccountId'=>'Social Software' , 'Pricebook2Id' => 'Test PriceBook1'}),
            new DataWrapper('OPP_TEST-0002', new Opportunity(Name = 'OPP_TEST-0002', StageName = 'Prospecting', Amount = 15.24, CloseDate = Date.today() + 145), new Map<String, String> {'AccountId'=>'Adept Software' , 'Pricebook2Id' => 'Test PriceBook1'}),
            new DataWrapper('OPP_TEST-0003', new Opportunity(Name = 'OPP_TEST-0003', StageName = 'Prospecting', Amount = 75.91, CloseDate = Date.today() + 131), new Map<String, String> {'AccountId'=>'Boss Software' , 'Pricebook2Id' => 'Test PriceBook1'}),
            new DataWrapper('OPP_TEST-0004', new Opportunity(Name = 'OPP_TEST-0004', StageName = 'Prospecting', Amount = 39.66, CloseDate = Date.today() + 75), new Map<String, String> {'AccountId'=>'Scope Software' , 'Pricebook2Id' => 'Test PriceBook1'}),
            new DataWrapper('OPP_TEST-0005', new Opportunity(Name = 'OPP_TEST-0005', StageName = 'Prospecting', Amount = 55.74, CloseDate = Date.today() + 207), new Map<String, String> {'AccountId'=>'Variable Software' , 'Pricebook2Id' => 'Test PriceBook1'}),
            new DataWrapper('OPP_TEST-0006', new Opportunity(Name = 'OPP_TEST-0006', StageName = 'Prospecting', Amount = 77.63, CloseDate = Date.today() + 42), new Map<String, String> {'AccountId'=>'Cornerstone Software' , 'Pricebook2Id' => 'Test PriceBook1'}),
            new DataWrapper('OPP_TEST-0007', new Opportunity(Name = 'OPP_TEST-0007', StageName = 'Prospecting', Amount = 7.95, CloseDate = Date.today() + 214), new Map<String, String> {'AccountId'=>'Ascend Software' , 'Pricebook2Id' => 'Test PriceBook1'}),
            new DataWrapper('OPP_TEST-0008', new Opportunity(Name = 'OPP_TEST-0008', StageName = 'Prospecting', Amount = 53.75, CloseDate = Date.today() + 73), new Map<String, String> {'AccountId'=>'Consumer Software' , 'Pricebook2Id' => 'Test PriceBook1'}),
            new DataWrapper('OPP_TEST-0009', new Opportunity(Name = 'OPP_TEST-0009', StageName = 'Prospecting', Amount = 30.87, CloseDate = Date.today() + 185), new Map<String, String> {'AccountId'=>'Velocity Software' , 'Pricebook2Id' => 'Test PriceBook1'}),
            new DataWrapper('OPP_TEST-0010', new Opportunity(Name = 'OPP_TEST-0010', StageName = 'Prospecting', Amount = 9.23, CloseDate = Date.today() + 207), new Map<String, String> {'AccountId'=>'Urge Software' , 'Pricebook2Id' => 'Test PriceBook1'}),
            new DataWrapper('OPP_TEST-0011', new Opportunity(Name = 'OPP_TEST-0011', StageName = 'Prospecting', Amount = 71.94, CloseDate = Date.today() + 161), new Map<String, String> {'AccountId'=>'Access Software' , 'Pricebook2Id' => 'Test PriceBook1'}),
            new DataWrapper('OPP_TEST-0012', new Opportunity(Name = 'OPP_TEST-0012', StageName = 'Prospecting', Amount = 12.57, CloseDate = Date.today() + 194), new Map<String, String> {'AccountId'=>'Fiber Software' , 'Pricebook2Id' => 'Test PriceBook1'}),
            new DataWrapper('OPP_TEST-0013', new Opportunity(Name = 'OPP_TEST-0013', StageName = 'Prospecting', Amount = 45.64, CloseDate = Date.today() + 217), new Map<String, String> {'AccountId'=>'Ideal Software' , 'Pricebook2Id' => 'Test PriceBook1'}),
            new DataWrapper('OPP_TEST-0014', new Opportunity(Name = 'OPP_TEST-0014', StageName = 'Prospecting', Amount = 80.28, CloseDate = Date.today() + 180), new Map<String, String> {'AccountId'=>'Marine Software' , 'Pricebook2Id' => 'Test PriceBook1'}),
            new DataWrapper('OPP_TEST-0015', new Opportunity(Name = 'OPP_TEST-0015', StageName = 'Prospecting', Amount = 82.81, CloseDate = Date.today() + 55), new Map<String, String> {'AccountId'=>'Intellect Software' , 'Pricebook2Id' => 'Test PriceBook1'}),
            new DataWrapper('OPP_TEST-0016', new Opportunity(Name = 'OPP_TEST-0016', StageName = 'Prospecting', Amount = 71.92, CloseDate = Date.today() + 157), new Map<String, String> {'AccountId'=>'Softwaregenics' , 'Pricebook2Id' => 'Test PriceBook1'}),
            new DataWrapper('OPP_TEST-0017', new Opportunity(Name = 'OPP_TEST-0017', StageName = 'Prospecting', Amount = 27.77, CloseDate = Date.today() + 208), new Map<String, String> {'AccountId'=>'Point Software' , 'Pricebook2Id' => 'Test PriceBook1'}),
            new DataWrapper('OPP_TEST-0018', new Opportunity(Name = 'OPP_TEST-0018', StageName = 'Prospecting', Amount = 66.44, CloseDate = Date.today() + 154), new Map<String, String> {'AccountId'=>'Vision Software' , 'Pricebook2Id' => 'Test PriceBook1'}),
            new DataWrapper('OPP_TEST-0019', new Opportunity(Name = 'OPP_TEST-0019', StageName = 'Prospecting', Amount = 99.83, CloseDate = Date.today() + 60), new Map<String, String> {'AccountId'=>'Softserve' , 'Pricebook2Id' => 'Test PriceBook1'}),
            new DataWrapper('OPP_TEST-0020', new Opportunity(Name = 'OPP_TEST-0020', StageName = 'Prospecting', Amount = 68.83, CloseDate = Date.today() + 99), new Map<String, String> {'AccountId'=>'Clever Software' , 'Pricebook2Id' => 'Test PriceBook1'}),
            new DataWrapper('OPP_TEST-0021', new Opportunity(Name = 'OPP_TEST-0021', StageName = 'Prospecting', Amount = 46.88, CloseDate = Date.today() + 58), new Map<String, String> {'AccountId'=>'Softwareya' , 'Pricebook2Id' => 'Test PriceBook1'}),
            new DataWrapper('OPP_TEST-0022', new Opportunity(Name = 'OPP_TEST-0022', StageName = 'Prospecting', Amount = 24.22, CloseDate = Date.today() + 62), new Map<String, String> {'AccountId'=>'Measured Software' , 'Pricebook2Id' => 'Test PriceBook1'}),
            new DataWrapper('OPP_TEST-0023', new Opportunity(Name = 'OPP_TEST-0023', StageName = 'Prospecting', Amount = 33.81, CloseDate = Date.today() + 206), new Map<String, String> {'AccountId'=>'Task Software' , 'Pricebook2Id' => 'Test PriceBook1'}),
            new DataWrapper('OPP_TEST-0024', new Opportunity(Name = 'OPP_TEST-0024', StageName = 'Prospecting', Amount = 93.4, CloseDate = Date.today() + 100), new Map<String, String> {'AccountId'=>'Progress Software' , 'Pricebook2Id' => 'Test PriceBook1'}),
            new DataWrapper('OPP_TEST-0025', new Opportunity(Name = 'OPP_TEST-0025', StageName = 'Prospecting', Amount = 69.25, CloseDate = Date.today() + 145), new Map<String, String> {'AccountId'=>'Touch Software' , 'Pricebook2Id' => 'Test PriceBook1'}),
            new DataWrapper('OPP_TEST-0026', new Opportunity(Name = 'OPP_TEST-0026', StageName = 'Prospecting', Amount = 34.87, CloseDate = Date.today() + 118), new Map<String, String> {'AccountId'=>'Up Software' , 'Pricebook2Id' => 'Test PriceBook1'}),
            new DataWrapper('OPP_TEST-0027', new Opportunity(Name = 'OPP_TEST-0027', StageName = 'Prospecting', Amount = 31.99, CloseDate = Date.today() + 191), new Map<String, String> {'AccountId'=>'Mega Software' , 'Pricebook2Id' => 'Test PriceBook1'}),
            new DataWrapper('OPP_TEST-0028', new Opportunity(Name = 'OPP_TEST-0028', StageName = 'Prospecting', Amount = 63.38, CloseDate = Date.today() + 51), new Map<String, String> {'AccountId'=>'Super Software' , 'Pricebook2Id' => 'Test PriceBook1'}),
            new DataWrapper('OPP_TEST-0029', new Opportunity(Name = 'OPP_TEST-0029', StageName = 'Prospecting', Amount = 0.96, CloseDate = Date.today() + 107), new Map<String, String> {'AccountId'=>'SuperPuper Software' , 'Pricebook2Id' => 'Test PriceBook1'}),
            new DataWrapper('OPP_TEST-0030', new Opportunity(Name = 'OPP_TEST-0030', StageName = 'Prospecting', Amount = 90.82, CloseDate = Date.today() + 133), new Map<String, String> {'AccountId'=>'SuperNice Software' , 'Pricebook2Id' => 'Test PriceBook1'}),
            new DataWrapper('OPP_TEST-0031', new Opportunity(Name = 'OPP_TEST-0031', StageName = 'Prospecting', Amount = 98.34, CloseDate = Date.today() + 127), new Map<String, String> {'AccountId'=>'Weight Software' , 'Pricebook2Id' => 'Test PriceBook1'}),
            new DataWrapper('OPP_TEST-0032', new Opportunity(Name = 'OPP_TEST-0032', StageName = 'Prospecting', Amount = 97.05, CloseDate = Date.today() + 149), new Map<String, String> {'AccountId'=>'Wild Software', 'Pricebook2Id' => 'Test PriceBook1'})
            };

    public final static Map<String, OpportunityLineItem> OPPORTUNITY_ITEM_DATA = new Map<String, OpportunityLineItem>{
            'TEST-0001' => new OpportunityLineItem(Discount = 17, Quantity = 83),
            'TEST-0002' => new OpportunityLineItem(Discount = 13, Quantity = 91),
            'TEST-0003' => new OpportunityLineItem(Discount = 7, Quantity = 87),
            'TEST-0004' => new OpportunityLineItem(Discount = 14, Quantity = 216),
            'TEST-0005' => new OpportunityLineItem(Discount = 1, Quantity = 90),
            'TEST-0006' => new OpportunityLineItem(Discount = 3, Quantity = 57),
            'TEST-0007' => new OpportunityLineItem(Discount = 2, Quantity = 116),
            'TEST-0008' => new OpportunityLineItem(Discount = 14, Quantity = 130),
            'TEST-0009' => new OpportunityLineItem(Discount = 8, Quantity = 145),
            'TEST-0010' => new OpportunityLineItem(Discount = 2, Quantity = 157),
            'TEST-0011' => new OpportunityLineItem(Discount = 2, Quantity = 224),
            'TEST-0012' => new OpportunityLineItem(Discount = 5, Quantity = 210),
            'TEST-0013' => new OpportunityLineItem(Discount = 7, Quantity = 186),
            'TEST-0014' => new OpportunityLineItem(Discount = 3, Quantity = 139),
            'TEST-0015' => new OpportunityLineItem(Discount = 18, Quantity = 43),
            'TEST-0016' => new OpportunityLineItem(Discount = 11, Quantity = 117),
            'TEST-0017' => new OpportunityLineItem(Discount = 20, Quantity = 46),
            'TEST-0018' => new OpportunityLineItem(Discount = 12, Quantity = 117),
            'TEST-0019' => new OpportunityLineItem(Discount = 8, Quantity = 193),
            'TEST-0020' => new OpportunityLineItem(Discount = 6, Quantity = 211),
            'TEST-0021' => new OpportunityLineItem(Discount = 19, Quantity = 39),
            'TEST-0022' => new OpportunityLineItem(Discount = 13, Quantity = 156),
            'TEST-0023' => new OpportunityLineItem(Discount = 12, Quantity = 143),
            'TEST-0024' => new OpportunityLineItem(Discount = 15, Quantity = 135),
            'TEST-0025' => new OpportunityLineItem(Discount = 11, Quantity = 102),
            'TEST-0026' => new OpportunityLineItem(Discount = 5, Quantity = 170),
            'TEST-0027' => new OpportunityLineItem(Discount = 6, Quantity = 37),
            'TEST-0028' => new OpportunityLineItem(Discount = 14, Quantity = 51),
            'TEST-0029' => new OpportunityLineItem(Discount = 19, Quantity = 104),
            'TEST-0030' => new OpportunityLineItem(Discount = 4, Quantity = 130),
            'TEST-0031' => new OpportunityLineItem(Discount = 8, Quantity = 112),
            'TEST-0032' => new OpportunityLineItem(Discount = 6, Quantity = 104),
            'TEST-0033' => new OpportunityLineItem(Discount = 8, Quantity = 158),
            'TEST-0034' => new OpportunityLineItem(Discount = 12, Quantity = 76),
            'TEST-0035' => new OpportunityLineItem(Discount = 14, Quantity = 44),
            'TEST-0036' => new OpportunityLineItem(Discount = 1, Quantity = 79),
            'TEST-0037' => new OpportunityLineItem(Discount = 5, Quantity = 176),
            'TEST-0038' => new OpportunityLineItem(Discount = 3, Quantity = 176),
            'TEST-0039' => new OpportunityLineItem(Discount = 12, Quantity = 161),
            'TEST-0040' => new OpportunityLineItem(Discount = 16, Quantity = 49),
            'TEST-0041' => new OpportunityLineItem(Discount = 18, Quantity = 109),
            'TEST-0042' => new OpportunityLineItem(Discount = 15, Quantity = 146),
            'TEST-0043' => new OpportunityLineItem(Discount = 9, Quantity = 74),
            'TEST-0044' => new OpportunityLineItem(Discount = 17, Quantity = 137),
            'TEST-0045' => new OpportunityLineItem(Discount = 5, Quantity = 98),
            'TEST-0046' => new OpportunityLineItem(Discount = 19, Quantity = 118),
            'TEST-0047' => new OpportunityLineItem(Discount = 11, Quantity = 88),
            'TEST-0048' => new OpportunityLineItem(Discount = 3, Quantity = 160),
            'TEST-0049' => new OpportunityLineItem(Discount = 17, Quantity = 88),
            'TEST-0050' => new OpportunityLineItem(Discount = 5, Quantity = 51),
            'TEST-0051' => new OpportunityLineItem(Discount = 13, Quantity = 133),
            'TEST-0052' => new OpportunityLineItem(Discount = 11, Quantity = 178),
            'TEST-0053' => new OpportunityLineItem(Discount = 8, Quantity = 164),
            'TEST-0054' => new OpportunityLineItem(Discount = 15, Quantity = 107),
            'TEST-0055' => new OpportunityLineItem(Discount = 7, Quantity = 140),
            'TEST-0056' => new OpportunityLineItem(Discount = 9, Quantity = 50),
            'TEST-0057' => new OpportunityLineItem(Discount = 17, Quantity = 66),
            'TEST-0058' => new OpportunityLineItem(Discount = 6, Quantity = 127),
            'TEST-0059' => new OpportunityLineItem(Discount = 18, Quantity = 149),
            'TEST-0060' => new OpportunityLineItem(Discount = 5, Quantity = 188),
            'TEST-0061' => new OpportunityLineItem(Discount = 15, Quantity = 77),
            'TEST-0062' => new OpportunityLineItem(Discount = 19, Quantity = 93),
            'TEST-0063' => new OpportunityLineItem(Discount = 10, Quantity = 196),
            'TEST-0064' => new OpportunityLineItem(Discount = 2, Quantity = 69),
            'TEST-0065' => new OpportunityLineItem(Discount = 11, Quantity = 52),
            'TEST-0066' => new OpportunityLineItem(Discount = 8, Quantity = 109),
            'TEST-0067' => new OpportunityLineItem(Discount = 6, Quantity = 98),
            'TEST-0068' => new OpportunityLineItem(Discount = 9, Quantity = 81),
            'TEST-0069' => new OpportunityLineItem(Discount = 6, Quantity = 82),
            'TEST-0070' => new OpportunityLineItem(Discount = 15, Quantity = 70),
            'TEST-0071' => new OpportunityLineItem(Discount = 6, Quantity = 78),
            'TEST-0072' => new OpportunityLineItem(Discount = 12, Quantity = 198),
            'TEST-0073' => new OpportunityLineItem(Discount = 17, Quantity = 77),
            'TEST-0074' => new OpportunityLineItem(Discount = 11, Quantity = 55),
            'TEST-0075' => new OpportunityLineItem(Discount = 7, Quantity = 215),
            'TEST-0076' => new OpportunityLineItem(Discount = 10, Quantity = 222),
            'TEST-0077' => new OpportunityLineItem(Discount = 10, Quantity = 48),
            'TEST-0078' => new OpportunityLineItem(Discount = 17, Quantity = 67),
            'TEST-0079' => new OpportunityLineItem(Discount = 8, Quantity = 37),
            'TEST-0080' => new OpportunityLineItem(Discount = 16, Quantity = 125),
            'TEST-0081' => new OpportunityLineItem(Discount = 9, Quantity = 31),
            'TEST-0082' => new OpportunityLineItem(Discount = 8, Quantity = 73),
            'TEST-0083' => new OpportunityLineItem(Discount = 6, Quantity = 142),
            'TEST-0084' => new OpportunityLineItem(Discount = 3, Quantity = 172),
            'TEST-0085' => new OpportunityLineItem(Discount = 19, Quantity = 42),
            'TEST-0086' => new OpportunityLineItem(Discount = 1, Quantity = 119),
            'TEST-0087' => new OpportunityLineItem(Discount = 0, Quantity = 167),
            'TEST-0088' => new OpportunityLineItem(Discount = 8, Quantity = 144),
            'TEST-0089' => new OpportunityLineItem(Discount = 0, Quantity = 64),
            'TEST-0090' => new OpportunityLineItem(Discount = 9, Quantity = 57),
            'TEST-0091' => new OpportunityLineItem(Discount = 2, Quantity = 43),
            'TEST-0092' => new OpportunityLineItem(Discount = 12, Quantity = 56),
            'TEST-0093' => new OpportunityLineItem(Discount = 6, Quantity = 168),
            'TEST-0094' => new OpportunityLineItem(Discount = 13, Quantity = 73),
            'TEST-0095' => new OpportunityLineItem(Discount = 5, Quantity = 133),
            'TEST-0096' => new OpportunityLineItem(Discount = 7, Quantity = 227),
            'TEST-0097' => new OpportunityLineItem(Discount = 11, Quantity = 132),
            'TEST-0098' => new OpportunityLineItem(Discount = 20, Quantity = 150),
            'TEST-0099' => new OpportunityLineItem(Discount = 3, Quantity = 67),
            'TEST-0100' => new OpportunityLineItem(Discount = 2, Quantity = 36),
            'TEST-0101' => new OpportunityLineItem(Discount = 1, Quantity = 212),
            'TEST-0102' => new OpportunityLineItem(Discount = 12, Quantity = 121),
            'TEST-0103' => new OpportunityLineItem(Discount = 19, Quantity = 143),
            'TEST-0104' => new OpportunityLineItem(Discount = 0, Quantity = 194),
            'TEST-0105' => new OpportunityLineItem(Discount = 17, Quantity = 189),
            'TEST-0106' => new OpportunityLineItem(Discount = 10, Quantity = 230),
            'TEST-0107' => new OpportunityLineItem(Discount = 19, Quantity = 188),
            'TEST-0108' => new OpportunityLineItem(Discount = 9, Quantity = 139),
            'TEST-0109' => new OpportunityLineItem(Discount = 18, Quantity = 106),
            'TEST-0110' => new OpportunityLineItem(Discount = 1, Quantity = 181),
            'TEST-0111' => new OpportunityLineItem(Discount = 10, Quantity = 178),
            'TEST-0112' => new OpportunityLineItem(Discount = 9, Quantity = 184),
            'TEST-0113' => new OpportunityLineItem(Discount = 7, Quantity = 105),
            'TEST-0114' => new OpportunityLineItem(Discount = 8, Quantity = 223),
            'TEST-0115' => new OpportunityLineItem(Discount = 12, Quantity = 63),
            'TEST-0116' => new OpportunityLineItem(Discount = 11, Quantity = 66),
            'TEST-0117' => new OpportunityLineItem(Discount = 6, Quantity = 119),
            'TEST-0118' => new OpportunityLineItem(Discount = 16, Quantity = 94),
            'TEST-0119' => new OpportunityLineItem(Discount = 9, Quantity = 136),
            'TEST-0120' => new OpportunityLineItem(Discount = 9, Quantity = 31),
            'TEST-0121' => new OpportunityLineItem(Discount = 9, Quantity = 173),
            'TEST-0122' => new OpportunityLineItem(Discount = 10, Quantity = 104),
            'TEST-0123' => new OpportunityLineItem(Discount = 18, Quantity = 60),
            'TEST-0124' => new OpportunityLineItem(Discount = 15, Quantity = 191),
            'TEST-0125' => new OpportunityLineItem(Discount = 7, Quantity = 201),
            'TEST-0126' => new OpportunityLineItem(Discount = 4, Quantity = 215),
            'TEST-0127' => new OpportunityLineItem(Discount = 19, Quantity = 36),
            'TEST-0128' => new OpportunityLineItem(Discount = 14, Quantity = 162),
            'TEST-0129' => new OpportunityLineItem(Discount = 10, Quantity = 157),
            'TEST-0130' => new OpportunityLineItem(Discount = 10, Quantity = 212),
            'TEST-0131' => new OpportunityLineItem(Discount = 4, Quantity = 104),
            'TEST-0132' => new OpportunityLineItem(Discount = 16, Quantity = 96),
            'TEST-0133' => new OpportunityLineItem(Discount = 5, Quantity = 215),
            'TEST-0134' => new OpportunityLineItem(Discount = 10, Quantity = 46),
            'TEST-0135' => new OpportunityLineItem(Discount = 19, Quantity = 142),
            'TEST-0136' => new OpportunityLineItem(Discount = 11, Quantity = 109),
            'TEST-0137' => new OpportunityLineItem(Discount = 6, Quantity = 83),
            'TEST-0138' => new OpportunityLineItem(Discount = 11, Quantity = 120),
            'TEST-0139' => new OpportunityLineItem(Discount = 2, Quantity = 76),
            'TEST-0140' => new OpportunityLineItem(Discount = 3, Quantity = 200),
            'TEST-0141' => new OpportunityLineItem(Discount = 14, Quantity = 188),
            'TEST-0142' => new OpportunityLineItem(Discount = 2, Quantity = 173),
            'TEST-0143' => new OpportunityLineItem(Discount = 14, Quantity = 62),
            'TEST-0144' => new OpportunityLineItem(Discount = 2, Quantity = 149),
            'TEST-0145' => new OpportunityLineItem(Discount = 6, Quantity = 137),
            'TEST-0146' => new OpportunityLineItem(Discount = 17, Quantity = 73),
            'TEST-0147' => new OpportunityLineItem(Discount = 6, Quantity = 117),
            'TEST-0148' => new OpportunityLineItem(Discount = 10, Quantity = 174),
            'TEST-0149' => new OpportunityLineItem(Discount = 7, Quantity = 204),
            'TEST-0150' => new OpportunityLineItem(Discount = 13, Quantity = 136),
            'TEST-0151' => new OpportunityLineItem(Discount = 0, Quantity = 180),
            'TEST-0152' => new OpportunityLineItem(Discount = 7, Quantity = 223),
            'TEST-0153' => new OpportunityLineItem(Discount = 11, Quantity = 174),
            'TEST-0154' => new OpportunityLineItem(Discount = 19, Quantity = 85),
            'TEST-0155' => new OpportunityLineItem(Discount = 3, Quantity = 75),
            'TEST-0156' => new OpportunityLineItem(Discount = 1, Quantity = 90),
            'TEST-0157' => new OpportunityLineItem(Discount = 1, Quantity = 114),
            'TEST-0158' => new OpportunityLineItem(Discount = 4, Quantity = 152),
            'TEST-0159' => new OpportunityLineItem(Discount = 10, Quantity = 220),
            'TEST-0160' => new OpportunityLineItem(Discount = 16, Quantity = 126),
            'TEST-0161' => new OpportunityLineItem(Discount = 10, Quantity = 173),
            'TEST-0162' => new OpportunityLineItem(Discount = 7, Quantity = 181),
            'TEST-0163' => new OpportunityLineItem(Discount = 4, Quantity = 122),
            'TEST-0164' => new OpportunityLineItem(Discount = 7, Quantity = 175),
            'TEST-0165' => new OpportunityLineItem(Discount = 20, Quantity = 110),
            'TEST-0166' => new OpportunityLineItem(Discount = 15, Quantity = 61),
            'TEST-0167' => new OpportunityLineItem(Discount = 20, Quantity = 110),
            'TEST-0168' => new OpportunityLineItem(Discount = 7, Quantity = 157),
            'TEST-0169' => new OpportunityLineItem(Discount = 14, Quantity = 97),
            'TEST-0170' => new OpportunityLineItem(Discount = 8, Quantity = 102),
            'TEST-0171' => new OpportunityLineItem(Discount = 1, Quantity = 40),
            'TEST-0172' => new OpportunityLineItem(Discount = 4, Quantity = 203),
            'TEST-0173' => new OpportunityLineItem(Discount = 15, Quantity = 119),
            'TEST-0174' => new OpportunityLineItem(Discount = 19, Quantity = 204),
            'TEST-0175' => new OpportunityLineItem(Discount = 4, Quantity = 62),
            'TEST-0176' => new OpportunityLineItem(Discount = 7, Quantity = 113),
            'TEST-0177' => new OpportunityLineItem(Discount = 9, Quantity = 37),
            'TEST-0178' => new OpportunityLineItem(Discount = 15, Quantity = 89),
            'TEST-0179' => new OpportunityLineItem(Discount = 11, Quantity = 149),
            'TEST-0180' => new OpportunityLineItem(Discount = 5, Quantity = 216),
            'TEST-0181' => new OpportunityLineItem(Discount = 12, Quantity = 218),
            'TEST-0182' => new OpportunityLineItem(Discount = 2, Quantity = 200),
            'TEST-0183' => new OpportunityLineItem(Discount = 2, Quantity = 52),
            'TEST-0184' => new OpportunityLineItem(Discount = 13, Quantity = 52),
            'TEST-0185' => new OpportunityLineItem(Discount = 18, Quantity = 124),
            'TEST-0186' => new OpportunityLineItem(Discount = 11, Quantity = 100),
            'TEST-0187' => new OpportunityLineItem(Discount = 3, Quantity = 174),
            'TEST-0188' => new OpportunityLineItem(Discount = 18, Quantity = 160),
            'TEST-0189' => new OpportunityLineItem(Discount = 12, Quantity = 83),
            'TEST-0190' => new OpportunityLineItem(Discount = 10, Quantity = 141),
            'TEST-0191' => new OpportunityLineItem(Discount = 19, Quantity = 215),
            'TEST-0192' => new OpportunityLineItem(Discount = 4, Quantity = 98),
            'TEST-0193' => new OpportunityLineItem(Discount = 16, Quantity = 52),
            'TEST-0194' => new OpportunityLineItem(Discount = 3, Quantity = 139),
            'TEST-0195' => new OpportunityLineItem(Discount = 15, Quantity = 164),
            'TEST-0196' => new OpportunityLineItem(Discount = 1, Quantity = 150),
            'TEST-0197' => new OpportunityLineItem(Discount = 19, Quantity = 140),
            'TEST-0198' => new OpportunityLineItem(Discount = 9, Quantity = 66),
            'TEST-0199' => new OpportunityLineItem(Discount = 5, Quantity = 112),
            'TEST-0200' => new OpportunityLineItem(Discount = 6, Quantity = 113),
            'TEST-0201' => new OpportunityLineItem(Discount = 18, Quantity = 198),
            'TEST-0202' => new OpportunityLineItem(Discount = 16, Quantity = 147),
            'TEST-0203' => new OpportunityLineItem(Discount = 12, Quantity = 222),
            'TEST-0204' => new OpportunityLineItem(Discount = 18, Quantity = 48),
            'TEST-0205' => new OpportunityLineItem(Discount = 17, Quantity = 51),
            'TEST-0206' => new OpportunityLineItem(Discount = 1, Quantity = 37),
            'TEST-0207' => new OpportunityLineItem(Discount = 19, Quantity = 68),
            'TEST-0208' => new OpportunityLineItem(Discount = 7, Quantity = 80),
            'TEST-0209' => new OpportunityLineItem(Discount = 0, Quantity = 95),
            'TEST-0210' => new OpportunityLineItem(Discount = 14, Quantity = 157),
            'TEST-0211' => new OpportunityLineItem(Discount = 1, Quantity = 123),
            'TEST-0212' => new OpportunityLineItem(Discount = 8, Quantity = 203),
            'TEST-0213' => new OpportunityLineItem(Discount = 8, Quantity = 200),
            'TEST-0214' => new OpportunityLineItem(Discount = 5, Quantity = 136),
            'TEST-0215' => new OpportunityLineItem(Discount = 18, Quantity = 73),
            'TEST-0216' => new OpportunityLineItem(Discount = 2, Quantity = 226),
            'TEST-0217' => new OpportunityLineItem(Discount = 3, Quantity = 193),
            'TEST-0218' => new OpportunityLineItem(Discount = 2, Quantity = 36),
            'TEST-0219' => new OpportunityLineItem(Discount = 10, Quantity = 117),
            'TEST-0220' => new OpportunityLineItem(Discount = 19, Quantity = 178),
            'TEST-0221' => new OpportunityLineItem(Discount = 7, Quantity = 59),
            'TEST-0222' => new OpportunityLineItem(Discount = 11, Quantity = 218),
            'TEST-0223' => new OpportunityLineItem(Discount = 19, Quantity = 118),
            'TEST-0224' => new OpportunityLineItem(Discount = 12, Quantity = 105),
            'TEST-0225' => new OpportunityLineItem(Discount = 1, Quantity = 171),
            'TEST-0226' => new OpportunityLineItem(Discount = 7, Quantity = 120),
            'TEST-0227' => new OpportunityLineItem(Discount = 1, Quantity = 84),
            'TEST-0228' => new OpportunityLineItem(Discount = 6, Quantity = 109),
            'TEST-0229' => new OpportunityLineItem(Discount = 0, Quantity = 36),
            'TEST-0230' => new OpportunityLineItem(Discount = 20, Quantity = 120),
            'TEST-0231' => new OpportunityLineItem(Discount = 5, Quantity = 128),
            'TEST-0232' => new OpportunityLineItem(Discount = 17, Quantity = 38),
            'TEST-0233' => new OpportunityLineItem(Discount = 5, Quantity = 138),
            'TEST-0234' => new OpportunityLineItem(Discount = 14, Quantity = 198),
            'TEST-0235' => new OpportunityLineItem(Discount = 19, Quantity = 216),
            'TEST-0236' => new OpportunityLineItem(Discount = 6, Quantity = 81),
            'TEST-0237' => new OpportunityLineItem(Discount = 7, Quantity = 183),
            'TEST-0238' => new OpportunityLineItem(Discount = 8, Quantity = 50),
            'TEST-0239' => new OpportunityLineItem(Discount = 19, Quantity = 176),
            'TEST-0240' => new OpportunityLineItem(Discount = 8, Quantity = 230),
            'TEST-0241' => new OpportunityLineItem(Discount = 3, Quantity = 158),
            'TEST-0242' => new OpportunityLineItem(Discount = 19, Quantity = 63),
            'TEST-0243' => new OpportunityLineItem(Discount = 6, Quantity = 143),
            'TEST-0244' => new OpportunityLineItem(Discount = 13, Quantity = 32),
            'TEST-0245' => new OpportunityLineItem(Discount = 12, Quantity = 91),
            'TEST-0246' => new OpportunityLineItem(Discount = 1, Quantity = 127),
            'TEST-0247' => new OpportunityLineItem(Discount = 3, Quantity = 82),
            'TEST-0248' => new OpportunityLineItem(Discount = 11, Quantity = 168),
            'TEST-0249' => new OpportunityLineItem(Discount = 18, Quantity = 115),
            'TEST-0250' => new OpportunityLineItem(Discount = 17, Quantity = 105),
            'TEST-0251' => new OpportunityLineItem(Discount = 14, Quantity = 61),
            'TEST-0252' => new OpportunityLineItem(Discount = 4, Quantity = 188),
            'TEST-0253' => new OpportunityLineItem(Discount = 19, Quantity = 34),
            'TEST-0254' => new OpportunityLineItem(Discount = 4, Quantity = 84),
            'TEST-0255' => new OpportunityLineItem(Discount = 11, Quantity = 92),
            'TEST-0256' => new OpportunityLineItem(Discount = 12, Quantity = 76),
            'TEST-0257' => new OpportunityLineItem(Discount = 3, Quantity = 193),
            'TEST-0258' => new OpportunityLineItem(Discount = 19, Quantity = 100),
            'TEST-0259' => new OpportunityLineItem(Discount = 3, Quantity = 181),
            'TEST-0260' => new OpportunityLineItem(Discount = 2, Quantity = 40),
            'TEST-0261' => new OpportunityLineItem(Discount = 16, Quantity = 69),
            'TEST-0262' => new OpportunityLineItem(Discount = 11, Quantity = 207),
            'TEST-0263' => new OpportunityLineItem(Discount = 15, Quantity = 200),
            'TEST-0264' => new OpportunityLineItem(Discount = 3, Quantity = 112),
            'TEST-0265' => new OpportunityLineItem(Discount = 15, Quantity = 82),
            'TEST-0266' => new OpportunityLineItem(Discount = 3, Quantity = 65),
            'TEST-0267' => new OpportunityLineItem(Discount = 13, Quantity = 81),
            'TEST-0268' => new OpportunityLineItem(Discount = 18, Quantity = 64),
            'TEST-0269' => new OpportunityLineItem(Discount = 9, Quantity = 136),
            'TEST-0270' => new OpportunityLineItem(Discount = 15, Quantity = 204),
            'TEST-0271' => new OpportunityLineItem(Discount = 1, Quantity = 195),
            'TEST-0272' => new OpportunityLineItem(Discount = 19, Quantity = 178),
            'TEST-0273' => new OpportunityLineItem(Discount = 12, Quantity = 187),
            'TEST-0274' => new OpportunityLineItem(Discount = 14, Quantity = 136),
            'TEST-0275' => new OpportunityLineItem(Discount = 16, Quantity = 204),
            'TEST-0276' => new OpportunityLineItem(Discount = 4, Quantity = 110),
            'TEST-0277' => new OpportunityLineItem(Discount = 4, Quantity = 117),
            'TEST-0278' => new OpportunityLineItem(Discount = 7, Quantity = 31),
            'TEST-0279' => new OpportunityLineItem(Discount = 4, Quantity = 82),
            'TEST-0280' => new OpportunityLineItem(Discount = 12, Quantity = 50),
            'TEST-0281' => new OpportunityLineItem(Discount = 8, Quantity = 31),
            'TEST-0282' => new OpportunityLineItem(Discount = 4, Quantity = 37),
            'TEST-0283' => new OpportunityLineItem(Discount = 17, Quantity = 106),
            'TEST-0284' => new OpportunityLineItem(Discount = 16, Quantity = 166),
            'TEST-0285' => new OpportunityLineItem(Discount = 18, Quantity = 161),
            'TEST-0286' => new OpportunityLineItem(Discount = 8, Quantity = 204),
            'TEST-0287' => new OpportunityLineItem(Discount = 14, Quantity = 186),
            'TEST-0288' => new OpportunityLineItem(Discount = 13, Quantity = 132),
            'TEST-0289' => new OpportunityLineItem(Discount = 9, Quantity = 57),
            'TEST-0290' => new OpportunityLineItem(Discount = 20, Quantity = 192),
            'TEST-0291' => new OpportunityLineItem(Discount = 17, Quantity = 125),
            'TEST-0292' => new OpportunityLineItem(Discount = 0, Quantity = 124),
            'TEST-0293' => new OpportunityLineItem(Discount = 19, Quantity = 178),
            'TEST-0294' => new OpportunityLineItem(Discount = 8, Quantity = 121),
            'TEST-0295' => new OpportunityLineItem(Discount = 15, Quantity = 167),
            'TEST-0296' => new OpportunityLineItem(Discount = 13, Quantity = 180),
            'TEST-0297' => new OpportunityLineItem(Discount = 1, Quantity = 36),
            'TEST-0298' => new OpportunityLineItem(Discount = 11, Quantity = 136),
            'TEST-0299' => new OpportunityLineItem(Discount = 4, Quantity = 208),
            'TEST-0300' => new OpportunityLineItem(Discount = 20, Quantity = 203),
            'TEST-0301' => new OpportunityLineItem(Discount = 13, Quantity = 51),
            'TEST-0302' => new OpportunityLineItem(Discount = 13, Quantity = 160),
            'TEST-0303' => new OpportunityLineItem(Discount = 9, Quantity = 206),
            'TEST-0304' => new OpportunityLineItem(Discount = 4, Quantity = 159),
            'TEST-0305' => new OpportunityLineItem(Discount = 2, Quantity = 103),
            'TEST-0306' => new OpportunityLineItem(Discount = 6, Quantity = 171),
            'TEST-0307' => new OpportunityLineItem(Discount = 0, Quantity = 74),
            'TEST-0308' => new OpportunityLineItem(Discount = 17, Quantity = 112),
            'TEST-0309' => new OpportunityLineItem(Discount = 2, Quantity = 150),
            'TEST-0310' => new OpportunityLineItem(Discount = 12, Quantity = 174),
            'TEST-0311' => new OpportunityLineItem(Discount = 9, Quantity = 48),
            'TEST-0312' => new OpportunityLineItem(Discount = 12, Quantity = 67),
            'TEST-0313' => new OpportunityLineItem(Discount = 3, Quantity = 216),
            'TEST-0314' => new OpportunityLineItem(Discount = 7, Quantity = 88),
            'TEST-0315' => new OpportunityLineItem(Discount = 9, Quantity = 114),
            'TEST-0316' => new OpportunityLineItem(Discount = 15, Quantity = 211),
            'TEST-0317' => new OpportunityLineItem(Discount = 11, Quantity = 47),
            'TEST-0318' => new OpportunityLineItem(Discount = 16, Quantity = 44),
            'TEST-0319' => new OpportunityLineItem(Discount = 1, Quantity = 195),
            'TEST-0320' => new OpportunityLineItem(Discount = 5, Quantity = 157),
            'TEST-0321' => new OpportunityLineItem(Discount = 6, Quantity = 67),
            'TEST-0322' => new OpportunityLineItem(Discount = 2, Quantity = 134),
            'TEST-0323' => new OpportunityLineItem(Discount = 9, Quantity = 136),
            'TEST-0324' => new OpportunityLineItem(Discount = 6, Quantity = 199),
            'TEST-0325' => new OpportunityLineItem(Discount = 13, Quantity = 180),
            'TEST-0326' => new OpportunityLineItem(Discount = 16, Quantity = 210),
            'TEST-0327' => new OpportunityLineItem(Discount = 19, Quantity = 211),
            'TEST-0328' => new OpportunityLineItem(Discount = 0, Quantity = 39),
            'TEST-0329' => new OpportunityLineItem(Discount = 2, Quantity = 73),
            'TEST-0330' => new OpportunityLineItem(Discount = 15, Quantity = 116),
            'TEST-0331' => new OpportunityLineItem(Discount = 6, Quantity = 103),
            'TEST-0332' => new OpportunityLineItem(Discount = 3, Quantity = 219),
            'TEST-0333' => new OpportunityLineItem(Discount = 4, Quantity = 126),
            'TEST-0334' => new OpportunityLineItem(Discount = 13, Quantity = 117),
            'TEST-0335' => new OpportunityLineItem(Discount = 3, Quantity = 197),
            'TEST-0336' => new OpportunityLineItem(Discount = 5, Quantity = 109),
            'TEST-0337' => new OpportunityLineItem(Discount = 3, Quantity = 35),
            'TEST-0338' => new OpportunityLineItem(Discount = 17, Quantity = 96),
            'TEST-0339' => new OpportunityLineItem(Discount = 11, Quantity = 59),
            'TEST-0340' => new OpportunityLineItem(Discount = 19, Quantity = 34),
            'TEST-0341' => new OpportunityLineItem(Discount = 7, Quantity = 109),
            'TEST-0342' => new OpportunityLineItem(Discount = 1, Quantity = 213),
            'TEST-0343' => new OpportunityLineItem(Discount = 13, Quantity = 177),
            'TEST-0344' => new OpportunityLineItem(Discount = 4, Quantity = 104),
            'TEST-0345' => new OpportunityLineItem(Discount = 2, Quantity = 204),
            'TEST-0346' => new OpportunityLineItem(Discount = 10, Quantity = 49),
            'TEST-0347' => new OpportunityLineItem(Discount = 4, Quantity = 129),
            'TEST-0348' => new OpportunityLineItem(Discount = 6, Quantity = 180),
            'TEST-0349' => new OpportunityLineItem(Discount = 17, Quantity = 186),
            'TEST-0350' => new OpportunityLineItem(Discount = 13, Quantity = 116),
            'TEST-0351' => new OpportunityLineItem(Discount = 8, Quantity = 66),
            'TEST-0352' => new OpportunityLineItem(Discount = 1, Quantity = 142),
            'TEST-0353' => new OpportunityLineItem(Discount = 2, Quantity = 113),
            'TEST-0354'  => new OpportunityLineItem(Discount = 17, Quantity = 41)
    };
}