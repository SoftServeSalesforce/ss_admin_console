public with sharing class OpportunityConstants {

    public static final String OPPORTUNITY_API_NAME = 'Opportunity';
    public static final String OPPORTUNITY_KEY_FIELD_NAME = 'Name';
    public static final String OPPORTUNITY_ITEM_API_NAME = 'OpportunityLineItem';
    public static final String OPPORTUNITY_ITEM_KEY_FIELD_NAME = 'ProductCode';

    public static final List<String> EXTERNAL_IDS_API_NAMES_OPPORTUNITY = new List<String>{'Name'};
	public static final List<String> ALL_IDS_API_NAMES_OPPORTUNITY = new List<String>{'Name', 'StageName'};

    public static final List<String> EXTERNAL_IDS_API_NAMES_OPPORTUNITY_ITEM = new List<String>{'Product2.ProductCode'};
	public static final List<String> ALL_IDS_API_NAMES_OPPORTUNITY_ITEM = new List<String>{'Product2.ProductCode', 'Quantity'};
	
    public final static Map<String, String> REFERENCE_FIELD_TO_KEY_FIELD = new Map<String, String>{
            'AccountId' => 'Name',
            'Pricebook2Id' => 'Name',
            'Product2Id' => 'ProductCode',
            'OpportunityId' => 'Name'
    };

    public final static Map<String, String> REFERENCE_FIELD_TO_SOBJECT_NAME = new Map<String, String>{
            'AccountId' => 'Account',
            'Pricebook2Id' => 'Pricebook2',
            'Product2Id' => 'Product2',
            'OpportunityId' => 'Opportunity'
    };

    public final static List<SSACSObjectWrapper> OPPORTUNITY_DATA = new List<SSACSObjectWrapper>{
        	new SSACSObjectWrapper('OPP_TEST-0001', new Opportunity(Name = 'OPP_TEST-0001', StageName = 'Qualification', Amount = 72.1, CloseDate = Date.today() + 91), new Map<String, String>{
					'AccountId' => 'Social Software'
			}),
			new SSACSObjectWrapper('OPP_TEST-0002', new Opportunity(Name = 'OPP_TEST-0002', StageName = 'Prospecting', Amount = 15.24, CloseDate = Date.today() + 145), new Map<String, String>{
					'AccountId' => 'Adept Software'
			}),
			new SSACSObjectWrapper('OPP_TEST-0003', new Opportunity(Name = 'OPP_TEST-0003', StageName = 'Prospecting', Amount = 75.91, CloseDate = Date.today() + 131), new Map<String, String>{
					'AccountId' => 'Boss Software'
			}),
			new SSACSObjectWrapper('OPP_TEST-0004', new Opportunity(Name = 'OPP_TEST-0004', StageName = 'Prospecting', Amount = 39.66, CloseDate = Date.today() + 75), new Map<String, String>{
					'AccountId' => 'Scope Software'
			}),
			new SSACSObjectWrapper('OPP_TEST-0005', new Opportunity(Name = 'OPP_TEST-0005', StageName = 'Prospecting', Amount = 55.74, CloseDate = Date.today() + 207), new Map<String, String>{
					'AccountId' => 'Variable Software'
			}),
			new SSACSObjectWrapper('OPP_TEST-0006', new Opportunity(Name = 'OPP_TEST-0006', StageName = 'Prospecting', Amount = 77.63, CloseDate = Date.today() + 42), new Map<String, String>{
			'AccountId' => 'Cornerstone Software'
			}),
			new SSACSObjectWrapper('OPP_TEST-0007', new Opportunity(Name = 'OPP_TEST-0007', StageName = 'Prospecting', Amount = 7.95, CloseDate = Date.today() + 214), new Map<String, String>{
					'AccountId' => 'Ascend Software'
			}),
			new SSACSObjectWrapper('OPP_TEST-0008', new Opportunity(Name = 'OPP_TEST-0008', StageName = 'Prospecting', Amount = 53.75, CloseDate = Date.today() + 73), new Map<String, String>{
					'AccountId' => 'Consumer Software'
			}),
			new SSACSObjectWrapper('OPP_TEST-0009', new Opportunity(Name = 'OPP_TEST-0009', StageName = 'Prospecting', Amount = 30.87, CloseDate = Date.today() + 185), new Map<String, String>{
					'AccountId' => 'Velocity Software'
			}),
			new SSACSObjectWrapper('OPP_TEST-0010', new Opportunity(Name = 'OPP_TEST-0010', StageName = 'Prospecting', Amount = 9.23, CloseDate = Date.today() + 207), new Map<String, String>{
					'AccountId' => 'Urge Software'
			}),
			new SSACSObjectWrapper('OPP_TEST-0011', new Opportunity(Name = 'OPP_TEST-0011', StageName = 'Prospecting', Amount = 71.94, CloseDate = Date.today() + 161), new Map<String, String>{
					'AccountId' => 'Access Software'
			}),
			new SSACSObjectWrapper('OPP_TEST-0012', new Opportunity(Name = 'OPP_TEST-0012', StageName = 'Prospecting', Amount = 12.57, CloseDate = Date.today() + 194), new Map<String, String>{
					'AccountId' => 'Fiber Software'
			}),
			new SSACSObjectWrapper('OPP_TEST-0013', new Opportunity(Name = 'OPP_TEST-0013', StageName = 'Prospecting', Amount = 45.64, CloseDate = Date.today() + 217), new Map<String, String>{
					'AccountId' => 'Ideal Software'
			}),
			new SSACSObjectWrapper('OPP_TEST-0014', new Opportunity(Name = 'OPP_TEST-0014', StageName = 'Prospecting', Amount = 80.28, CloseDate = Date.today() + 180), new Map<String, String>{
					'AccountId' => 'Marine Software'
			}),
			new SSACSObjectWrapper('OPP_TEST-0015', new Opportunity(Name = 'OPP_TEST-0015', StageName = 'Prospecting', Amount = 82.81, CloseDate = Date.today() + 55), new Map<String, String>{
					'AccountId' => 'Intellect Software'
			}),
			new SSACSObjectWrapper('OPP_TEST-0016', new Opportunity(Name = 'OPP_TEST-0016', StageName = 'Prospecting', Amount = 71.92, CloseDate = Date.today() + 157), new Map<String, String>{
					'AccountId' => 'Softwaregenics'
			}),
			new SSACSObjectWrapper('OPP_TEST-0017', new Opportunity(Name = 'OPP_TEST-0017', StageName = 'Prospecting', Amount = 27.77, CloseDate = Date.today() + 208), new Map<String, String>{
					'AccountId' => 'Point Software'
			}),
			new SSACSObjectWrapper('OPP_TEST-0018', new Opportunity(Name = 'OPP_TEST-0018', StageName = 'Prospecting', Amount = 66.44, CloseDate = Date.today() + 154), new Map<String, String>{
					'AccountId' => 'Vision Software'
			}),
			new SSACSObjectWrapper('OPP_TEST-0019', new Opportunity(Name = 'OPP_TEST-0019', StageName = 'Prospecting', Amount = 99.83, CloseDate = Date.today() + 60), new Map<String, String>{
					'AccountId' => 'Softserve'
			}),
			new SSACSObjectWrapper('OPP_TEST-0020', new Opportunity(Name = 'OPP_TEST-0020', StageName = 'Prospecting', Amount = 68.83, CloseDate = Date.today() + 99), new Map<String, String>{
					'AccountId' => 'Clever Software'
			}),
			new SSACSObjectWrapper('OPP_TEST-0021', new Opportunity(Name = 'OPP_TEST-0021', StageName = 'Prospecting', Amount = 46.88, CloseDate = Date.today() + 58), new Map<String, String>{
					'AccountId' => 'Softwareya'
			}),
			new SSACSObjectWrapper('OPP_TEST-0022', new Opportunity(Name = 'OPP_TEST-0022', StageName = 'Prospecting', Amount = 24.22, CloseDate = Date.today() + 62), new Map<String, String>{
					'AccountId' => 'Measured Software'
			}),
			new SSACSObjectWrapper('OPP_TEST-0023', new Opportunity(Name = 'OPP_TEST-0023', StageName = 'Prospecting', Amount = 33.81, CloseDate = Date.today() + 206), new Map<String, String>{
					'AccountId' => 'Task Software'
			}),
			new SSACSObjectWrapper('OPP_TEST-0024', new Opportunity(Name = 'OPP_TEST-0024', StageName = 'Prospecting', Amount = 93.4, CloseDate = Date.today() + 100), new Map<String, String>{
					'AccountId' => 'Progress Software'
			}),
			new SSACSObjectWrapper('OPP_TEST-0025', new Opportunity(Name = 'OPP_TEST-0025', StageName = 'Prospecting', Amount = 69.25, CloseDate = Date.today() + 145), new Map<String, String>{
					'AccountId' => 'Touch Software'
			}),
			new SSACSObjectWrapper('OPP_TEST-0026', new Opportunity(Name = 'OPP_TEST-0026', StageName = 'Prospecting', Amount = 34.87, CloseDate = Date.today() + 118), new Map<String, String>{
					'AccountId' => 'Up Software'
			}),
			new SSACSObjectWrapper('OPP_TEST-0027', new Opportunity(Name = 'OPP_TEST-0027', StageName = 'Prospecting', Amount = 31.99, CloseDate = Date.today() + 191), new Map<String, String>{
					'AccountId' => 'Mega Software'
			}),
			new SSACSObjectWrapper('OPP_TEST-0028', new Opportunity(Name = 'OPP_TEST-0028', StageName = 'Prospecting', Amount = 63.38, CloseDate = Date.today() + 51), new Map<String, String>{
					'AccountId' => 'Super Software'
			}),
			new SSACSObjectWrapper('OPP_TEST-0029', new Opportunity(Name = 'OPP_TEST-0029', StageName = 'Prospecting', Amount = 0.96, CloseDate = Date.today() + 107), new Map<String, String>{
					'AccountId' => 'SuperPuper Software'
			}),
			new SSACSObjectWrapper('OPP_TEST-0030', new Opportunity(Name = 'OPP_TEST-0030', StageName = 'Prospecting', Amount = 90.82, CloseDate = Date.today() + 133), new Map<String, String>{
					'AccountId' => 'SuperNice Software'
			}),
			new SSACSObjectWrapper('OPP_TEST-0031', new Opportunity(Name = 'OPP_TEST-0031', StageName = 'Prospecting', Amount = 98.34, CloseDate = Date.today() + 127), new Map<String, String>{
					'AccountId' => 'Weight Software'
			}),
			new SSACSObjectWrapper('OPP_TEST-0032', new Opportunity(Name = 'OPP_TEST-0032', StageName = 'Prospecting', Amount = 97.05, CloseDate = Date.today() + 149), new Map<String, String>{
					'AccountId' => 'Wild Software'
			}) 
        };

    public final static List<SSACSObjectWrapper> OPPORTUNITY_ITEM_DATA = new List<SSACSObjectWrapper>{
            new SSACSObjectWrapper('TEST-0001', new OpportunityLineItem(TotalPrice = 578, Quantity = 85.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0001', 'OpportunityId' => 'OPP_TEST-0001'
            }),
            new SSACSObjectWrapper('TEST-0002', new OpportunityLineItem(TotalPrice = 442, Quantity = 91.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0002', 'OpportunityId' => 'OPP_TEST-0001'
            }),
            new SSACSObjectWrapper('TEST-0003', new OpportunityLineItem(TotalPrice = 238, Quantity = 87.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0003', 'OpportunityId' => 'OPP_TEST-0001'
            }),
            new SSACSObjectWrapper('TEST-0004', new OpportunityLineItem(TotalPrice = 476, Quantity = 216.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0004', 'OpportunityId' => 'OPP_TEST-0001'
            }),
            new SSACSObjectWrapper('TEST-0005', new OpportunityLineItem(TotalPrice = 34, Quantity = 90.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0005', 'OpportunityId' => 'OPP_TEST-0001'
            }),
            new SSACSObjectWrapper('TEST-0006', new OpportunityLineItem(TotalPrice = 102, Quantity = 57.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0006', 'OpportunityId' => 'OPP_TEST-0001'
            }),
            new SSACSObjectWrapper('TEST-0007', new OpportunityLineItem(TotalPrice = 68, Quantity = 116.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0007', 'OpportunityId' => 'OPP_TEST-0001'
            }),
            new SSACSObjectWrapper('TEST-0008', new OpportunityLineItem(TotalPrice = 476, Quantity = 130.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0008', 'OpportunityId' => 'OPP_TEST-0001'
            }),
            new SSACSObjectWrapper('TEST-0009', new OpportunityLineItem(TotalPrice = 272, Quantity = 145.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0009', 'OpportunityId' => 'OPP_TEST-0001'
            }),
            new SSACSObjectWrapper('TEST-0010', new OpportunityLineItem(TotalPrice = 68, Quantity = 157.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0010', 'OpportunityId' => 'OPP_TEST-0001'
            }),
            new SSACSObjectWrapper('TEST-0011', new OpportunityLineItem(TotalPrice = 68, Quantity = 224.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0011', 'OpportunityId' => 'OPP_TEST-0001'
            }),
            new SSACSObjectWrapper('TEST-0012', new OpportunityLineItem(TotalPrice = 170, Quantity = 210.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0012', 'OpportunityId' => 'OPP_TEST-0001'
            }),
            new SSACSObjectWrapper('TEST-0013', new OpportunityLineItem(TotalPrice = 238, Quantity = 186.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0013', 'OpportunityId' => 'OPP_TEST-0001'
            }),
            new SSACSObjectWrapper('TEST-0014', new OpportunityLineItem(TotalPrice = 102, Quantity = 139.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0014', 'OpportunityId' => 'OPP_TEST-0001'
            }),
            new SSACSObjectWrapper('TEST-0015', new OpportunityLineItem(TotalPrice = 612, Quantity = 43.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0015', 'OpportunityId' => 'OPP_TEST-0002'
            }),
            new SSACSObjectWrapper('TEST-0016', new OpportunityLineItem(TotalPrice = 374, Quantity = 117.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0016', 'OpportunityId' => 'OPP_TEST-0002'
            }),
            new SSACSObjectWrapper('TEST-0017', new OpportunityLineItem(TotalPrice = 680, Quantity = 46.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0017', 'OpportunityId' => 'OPP_TEST-0002'
            }),
            new SSACSObjectWrapper('TEST-0018', new OpportunityLineItem(TotalPrice = 408, Quantity = 117.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0018', 'OpportunityId' => 'OPP_TEST-0002'
            }),
            new SSACSObjectWrapper('TEST-0019', new OpportunityLineItem(TotalPrice = 272, Quantity = 193.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0019', 'OpportunityId' => 'OPP_TEST-0002'
            }),
            new SSACSObjectWrapper('TEST-0020', new OpportunityLineItem(TotalPrice = 204, Quantity = 211.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0020', 'OpportunityId' => 'OPP_TEST-0002'
            }),
            new SSACSObjectWrapper('TEST-0021', new OpportunityLineItem(TotalPrice = 646, Quantity = 39.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0021', 'OpportunityId' => 'OPP_TEST-0002'
            }),
            new SSACSObjectWrapper('TEST-0022', new OpportunityLineItem(TotalPrice = 442, Quantity = 156.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0022', 'OpportunityId' => 'OPP_TEST-0003'
            }),
            new SSACSObjectWrapper('TEST-0023', new OpportunityLineItem(TotalPrice = 408, Quantity = 143.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0023', 'OpportunityId' => 'OPP_TEST-0003'
            }),
            new SSACSObjectWrapper('TEST-0024', new OpportunityLineItem(TotalPrice = 510, Quantity = 135.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0024', 'OpportunityId' => 'OPP_TEST-0003'
            }),
            new SSACSObjectWrapper('TEST-0025', new OpportunityLineItem(TotalPrice = 374, Quantity = 102.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0025', 'OpportunityId' => 'OPP_TEST-0003'
            }),
            new SSACSObjectWrapper('TEST-0026', new OpportunityLineItem(TotalPrice = 170, Quantity = 170.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0026', 'OpportunityId' => 'OPP_TEST-0004'
            }),
            new SSACSObjectWrapper('TEST-0027', new OpportunityLineItem(TotalPrice = 204, Quantity = 37.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0027', 'OpportunityId' => 'OPP_TEST-0004'
            }),
            new SSACSObjectWrapper('TEST-0028', new OpportunityLineItem(TotalPrice = 476, Quantity = 51.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0028', 'OpportunityId' => 'OPP_TEST-0004'
            }),
            new SSACSObjectWrapper('TEST-0029', new OpportunityLineItem(TotalPrice = 646, Quantity = 104.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0029', 'OpportunityId' => 'OPP_TEST-0004'
            }),
            new SSACSObjectWrapper('TEST-0030', new OpportunityLineItem(TotalPrice = 136, Quantity = 130.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0030', 'OpportunityId' => 'OPP_TEST-0004'
            }),
            new SSACSObjectWrapper('TEST-0031', new OpportunityLineItem(TotalPrice = 272, Quantity = 112.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0031', 'OpportunityId' => 'OPP_TEST-0004'
            }),
            new SSACSObjectWrapper('TEST-0032', new OpportunityLineItem(TotalPrice = 204, Quantity = 104.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0032', 'OpportunityId' => 'OPP_TEST-0004'
            }),
            new SSACSObjectWrapper('TEST-0033', new OpportunityLineItem(TotalPrice = 272, Quantity = 158.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0033', 'OpportunityId' => 'OPP_TEST-0004'
            }),
            new SSACSObjectWrapper('TEST-0034', new OpportunityLineItem(TotalPrice = 408, Quantity = 76.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0034', 'OpportunityId' => 'OPP_TEST-0004'
            }),
            new SSACSObjectWrapper('TEST-0035', new OpportunityLineItem(TotalPrice = 476, Quantity = 44.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0035', 'OpportunityId' => 'OPP_TEST-0004'
            }),
            new SSACSObjectWrapper('TEST-0036', new OpportunityLineItem(TotalPrice = 34, Quantity = 79.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0036', 'OpportunityId' => 'OPP_TEST-0004'
            }),
            new SSACSObjectWrapper('TEST-0037', new OpportunityLineItem(TotalPrice = 170, Quantity = 176.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0037', 'OpportunityId' => 'OPP_TEST-0005'
            }),
            new SSACSObjectWrapper('TEST-0038', new OpportunityLineItem(TotalPrice = 102, Quantity = 176.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0038', 'OpportunityId' => 'OPP_TEST-0005'
            }),
            new SSACSObjectWrapper('TEST-0039', new OpportunityLineItem(TotalPrice = 408, Quantity = 161.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0039', 'OpportunityId' => 'OPP_TEST-0005'
            }),
            new SSACSObjectWrapper('TEST-0040', new OpportunityLineItem(TotalPrice = 544, Quantity = 49.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0040', 'OpportunityId' => 'OPP_TEST-0005'
            }),
            new SSACSObjectWrapper('TEST-0041', new OpportunityLineItem(TotalPrice = 612, Quantity = 109.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0041', 'OpportunityId' => 'OPP_TEST-0005'
            }),
            new SSACSObjectWrapper('TEST-0042', new OpportunityLineItem(TotalPrice = 510, Quantity = 146.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0042', 'OpportunityId' => 'OPP_TEST-0005'
            }),
            new SSACSObjectWrapper('TEST-0043', new OpportunityLineItem(TotalPrice = 306, Quantity = 74.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0043', 'OpportunityId' => 'OPP_TEST-0005'
            }),
            new SSACSObjectWrapper('TEST-0044', new OpportunityLineItem(TotalPrice = 578, Quantity = 137.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0044', 'OpportunityId' => 'OPP_TEST-0005'
            }),
            new SSACSObjectWrapper('TEST-0045', new OpportunityLineItem(TotalPrice = 170, Quantity = 98.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0045', 'OpportunityId' => 'OPP_TEST-0005'
            }),
            new SSACSObjectWrapper('TEST-0046', new OpportunityLineItem(TotalPrice = 646, Quantity = 118.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0046', 'OpportunityId' => 'OPP_TEST-0006'
            }),
            new SSACSObjectWrapper('TEST-0047', new OpportunityLineItem(TotalPrice = 374, Quantity = 88.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0047', 'OpportunityId' => 'OPP_TEST-0006'
            }),
            new SSACSObjectWrapper('TEST-0048', new OpportunityLineItem(TotalPrice = 102, Quantity = 160.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0048', 'OpportunityId' => 'OPP_TEST-0006'
            }),
            new SSACSObjectWrapper('TEST-0049', new OpportunityLineItem(TotalPrice = 578, Quantity = 88.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0049', 'OpportunityId' => 'OPP_TEST-0006'
            }),
            new SSACSObjectWrapper('TEST-0050', new OpportunityLineItem(TotalPrice = 170, Quantity = 51.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0050', 'OpportunityId' => 'OPP_TEST-0006'
            }),
            new SSACSObjectWrapper('TEST-0051', new OpportunityLineItem(TotalPrice = 442, Quantity = 133.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0051', 'OpportunityId' => 'OPP_TEST-0006'
            }),
            new SSACSObjectWrapper('TEST-0052', new OpportunityLineItem(TotalPrice = 374, Quantity = 178.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0052', 'OpportunityId' => 'OPP_TEST-0006'
            }),
            new SSACSObjectWrapper('TEST-0053', new OpportunityLineItem(TotalPrice = 272, Quantity = 164.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0053', 'OpportunityId' => 'OPP_TEST-0006'
            }),
            new SSACSObjectWrapper('TEST-0054', new OpportunityLineItem(TotalPrice = 510, Quantity = 107.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0054', 'OpportunityId' => 'OPP_TEST-0006'
            }),
            new SSACSObjectWrapper('TEST-0055', new OpportunityLineItem(TotalPrice = 238, Quantity = 140.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0055', 'OpportunityId' => 'OPP_TEST-0006'
            }),
            new SSACSObjectWrapper('TEST-0056', new OpportunityLineItem(TotalPrice = 306, Quantity = 50.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0056', 'OpportunityId' => 'OPP_TEST-0006'
            }),
            new SSACSObjectWrapper('TEST-0057', new OpportunityLineItem(TotalPrice = 578, Quantity = 66.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0057', 'OpportunityId' => 'OPP_TEST-0006'
            }),
            new SSACSObjectWrapper('TEST-0058', new OpportunityLineItem(TotalPrice = 204, Quantity = 127.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0058', 'OpportunityId' => 'OPP_TEST-0006'
            }),
            new SSACSObjectWrapper('TEST-0059', new OpportunityLineItem(TotalPrice = 612, Quantity = 149.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0059', 'OpportunityId' => 'OPP_TEST-0006'
            }),
            new SSACSObjectWrapper('TEST-0060', new OpportunityLineItem(TotalPrice = 170, Quantity = 188.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0060', 'OpportunityId' => 'OPP_TEST-0006'
            }),
            new SSACSObjectWrapper('TEST-0061', new OpportunityLineItem(TotalPrice = 510, Quantity = 77.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0061', 'OpportunityId' => 'OPP_TEST-0006'
            }),
            new SSACSObjectWrapper('TEST-0062', new OpportunityLineItem(TotalPrice = 646, Quantity = 93.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0062', 'OpportunityId' => 'OPP_TEST-0006'
            }),
            new SSACSObjectWrapper('TEST-0063', new OpportunityLineItem(TotalPrice = 340, Quantity = 196.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0063', 'OpportunityId' => 'OPP_TEST-0006'
            }),
            new SSACSObjectWrapper('TEST-0064', new OpportunityLineItem(TotalPrice = 68, Quantity = 69.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0064', 'OpportunityId' => 'OPP_TEST-0006'
            }),
            new SSACSObjectWrapper('TEST-0065', new OpportunityLineItem(TotalPrice = 374, Quantity = 52.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0065', 'OpportunityId' => 'OPP_TEST-0006'
            }),
            new SSACSObjectWrapper('TEST-0066', new OpportunityLineItem(TotalPrice = 272, Quantity = 109.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0066', 'OpportunityId' => 'OPP_TEST-0007'
            }),
            new SSACSObjectWrapper('TEST-0067', new OpportunityLineItem(TotalPrice = 204, Quantity = 98.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0067', 'OpportunityId' => 'OPP_TEST-0007'
            }),
            new SSACSObjectWrapper('TEST-0068', new OpportunityLineItem(TotalPrice = 306, Quantity = 81.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0068', 'OpportunityId' => 'OPP_TEST-0007'
            }),
            new SSACSObjectWrapper('TEST-0069', new OpportunityLineItem(TotalPrice = 204, Quantity = 82.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0069', 'OpportunityId' => 'OPP_TEST-0007'
            }),
            new SSACSObjectWrapper('TEST-0070', new OpportunityLineItem(TotalPrice = 510, Quantity = 70.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0070', 'OpportunityId' => 'OPP_TEST-0007'
            }),
            new SSACSObjectWrapper('TEST-0071', new OpportunityLineItem(TotalPrice = 204, Quantity = 78.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0071', 'OpportunityId' => 'OPP_TEST-0007'
            }),
            new SSACSObjectWrapper('TEST-0072', new OpportunityLineItem(TotalPrice = 408, Quantity = 198.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0072', 'OpportunityId' => 'OPP_TEST-0007'
            }),
            new SSACSObjectWrapper('TEST-0073', new OpportunityLineItem(TotalPrice = 578, Quantity = 77.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0073', 'OpportunityId' => 'OPP_TEST-0007'
            }),
            new SSACSObjectWrapper('TEST-0074', new OpportunityLineItem(TotalPrice = 374, Quantity = 55.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0074', 'OpportunityId' => 'OPP_TEST-0007'
            }),
            new SSACSObjectWrapper('TEST-0075', new OpportunityLineItem(TotalPrice = 238, Quantity = 215.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0075', 'OpportunityId' => 'OPP_TEST-0007'
            }),
            new SSACSObjectWrapper('TEST-0076', new OpportunityLineItem(TotalPrice = 340, Quantity = 222.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0076', 'OpportunityId' => 'OPP_TEST-0007'
            }),
            new SSACSObjectWrapper('TEST-0077', new OpportunityLineItem(TotalPrice = 340, Quantity = 48.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0077', 'OpportunityId' => 'OPP_TEST-0007'
            }),
            new SSACSObjectWrapper('TEST-0078', new OpportunityLineItem(TotalPrice = 578, Quantity = 67.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0078', 'OpportunityId' => 'OPP_TEST-0007'
            }),
            new SSACSObjectWrapper('TEST-0079', new OpportunityLineItem(TotalPrice = 272, Quantity = 37.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0079', 'OpportunityId' => 'OPP_TEST-0007'
            }),
            new SSACSObjectWrapper('TEST-0080', new OpportunityLineItem(TotalPrice = 544, Quantity = 125.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0080', 'OpportunityId' => 'OPP_TEST-0007'
            }),
            new SSACSObjectWrapper('TEST-0081', new OpportunityLineItem(TotalPrice = 306, Quantity = 31.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0081', 'OpportunityId' => 'OPP_TEST-0007'
            }),
            new SSACSObjectWrapper('TEST-0082', new OpportunityLineItem(TotalPrice = 272, Quantity = 73.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0082', 'OpportunityId' => 'OPP_TEST-0008'
            }),
            new SSACSObjectWrapper('TEST-0083', new OpportunityLineItem(TotalPrice = 204, Quantity = 142.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0083', 'OpportunityId' => 'OPP_TEST-0008'
            }),
            new SSACSObjectWrapper('TEST-0084', new OpportunityLineItem(TotalPrice = 102, Quantity = 172.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0084', 'OpportunityId' => 'OPP_TEST-0008'
            }),
            new SSACSObjectWrapper('TEST-0085', new OpportunityLineItem(TotalPrice = 646, Quantity = 42.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0085', 'OpportunityId' => 'OPP_TEST-0008'
            }),
            new SSACSObjectWrapper('TEST-0086', new OpportunityLineItem(TotalPrice = 34, Quantity = 119.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0086', 'OpportunityId' => 'OPP_TEST-0008'
            }),
            new SSACSObjectWrapper('TEST-0087', new OpportunityLineItem(TotalPrice = 0, Quantity = 167.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0087', 'OpportunityId' => 'OPP_TEST-0008'
            }),
            new SSACSObjectWrapper('TEST-0088', new OpportunityLineItem(TotalPrice = 272, Quantity = 144.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0088', 'OpportunityId' => 'OPP_TEST-0008'
            }),
            new SSACSObjectWrapper('TEST-0089', new OpportunityLineItem(TotalPrice = 0, Quantity = 64.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0089', 'OpportunityId' => 'OPP_TEST-0008'
            }),
            new SSACSObjectWrapper('TEST-0090', new OpportunityLineItem(TotalPrice = 306, Quantity = 57.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0090', 'OpportunityId' => 'OPP_TEST-0008'
            }),
            new SSACSObjectWrapper('TEST-0091', new OpportunityLineItem(TotalPrice = 68, Quantity = 43.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0091', 'OpportunityId' => 'OPP_TEST-0008'
            }),
            new SSACSObjectWrapper('TEST-0092', new OpportunityLineItem(TotalPrice = 408, Quantity = 56.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0092', 'OpportunityId' => 'OPP_TEST-0008'
            }),
            new SSACSObjectWrapper('TEST-0093', new OpportunityLineItem(TotalPrice = 204, Quantity = 168.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0093', 'OpportunityId' => 'OPP_TEST-0008'
            }),
            new SSACSObjectWrapper('TEST-0094', new OpportunityLineItem(TotalPrice = 442, Quantity = 73.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0094', 'OpportunityId' => 'OPP_TEST-0008'
            }),
            new SSACSObjectWrapper('TEST-0095', new OpportunityLineItem(TotalPrice = 170, Quantity = 133.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0095', 'OpportunityId' => 'OPP_TEST-0008'
            }),
            new SSACSObjectWrapper('TEST-0096', new OpportunityLineItem(TotalPrice = 238, Quantity = 227.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0096', 'OpportunityId' => 'OPP_TEST-0008'
            }),
            new SSACSObjectWrapper('TEST-0097', new OpportunityLineItem(TotalPrice = 374, Quantity = 132.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0097', 'OpportunityId' => 'OPP_TEST-0008'
            }),
            new SSACSObjectWrapper('TEST-0098', new OpportunityLineItem(TotalPrice = 680, Quantity = 150.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0098', 'OpportunityId' => 'OPP_TEST-0008'
            }),
            new SSACSObjectWrapper('TEST-0099', new OpportunityLineItem(TotalPrice = 102, Quantity = 67.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0099', 'OpportunityId' => 'OPP_TEST-0008'
            }),
            new SSACSObjectWrapper('TEST-0100', new OpportunityLineItem(TotalPrice = 68, Quantity = 36.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0100', 'OpportunityId' => 'OPP_TEST-0008'
            }),
            new SSACSObjectWrapper('TEST-0101', new OpportunityLineItem(TotalPrice = 34, Quantity = 212.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0101', 'OpportunityId' => 'OPP_TEST-0008'
            }),
            new SSACSObjectWrapper('TEST-0102', new OpportunityLineItem(TotalPrice = 408, Quantity = 121.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0102', 'OpportunityId' => 'OPP_TEST-0008'
            }),
            new SSACSObjectWrapper('TEST-0103', new OpportunityLineItem(TotalPrice = 646, Quantity = 143.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0103', 'OpportunityId' => 'OPP_TEST-0008'
            }),
            new SSACSObjectWrapper('TEST-0104', new OpportunityLineItem(TotalPrice = 0, Quantity = 194.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0104', 'OpportunityId' => 'OPP_TEST-0009'
            }),
            new SSACSObjectWrapper('TEST-0105', new OpportunityLineItem(TotalPrice = 578, Quantity = 189.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0105', 'OpportunityId' => 'OPP_TEST-0009'
            }),
            new SSACSObjectWrapper('TEST-0106', new OpportunityLineItem(TotalPrice = 340, Quantity = 230.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0106', 'OpportunityId' => 'OPP_TEST-0009'
            }),
            new SSACSObjectWrapper('TEST-0107', new OpportunityLineItem(TotalPrice = 646, Quantity = 188.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0107', 'OpportunityId' => 'OPP_TEST-0009'
            }),
            new SSACSObjectWrapper('TEST-0108', new OpportunityLineItem(TotalPrice = 306, Quantity = 139.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0108', 'OpportunityId' => 'OPP_TEST-0009'
            }),
            new SSACSObjectWrapper('TEST-0109', new OpportunityLineItem(TotalPrice = 612, Quantity = 106.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0109', 'OpportunityId' => 'OPP_TEST-0009'
            }),
            new SSACSObjectWrapper('TEST-0110', new OpportunityLineItem(TotalPrice = 34, Quantity = 181.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0110', 'OpportunityId' => 'OPP_TEST-0009'
            }),
            new SSACSObjectWrapper('TEST-0111', new OpportunityLineItem(TotalPrice = 340, Quantity = 178.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0111', 'OpportunityId' => 'OPP_TEST-0009'
            }),
            new SSACSObjectWrapper('TEST-0112', new OpportunityLineItem(TotalPrice = 306, Quantity = 184.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0112', 'OpportunityId' => 'OPP_TEST-0009'
            }),
            new SSACSObjectWrapper('TEST-0113', new OpportunityLineItem(TotalPrice = 238, Quantity = 105.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0113', 'OpportunityId' => 'OPP_TEST-0009'
            }),
            new SSACSObjectWrapper('TEST-0114', new OpportunityLineItem(TotalPrice = 272, Quantity = 223.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0114', 'OpportunityId' => 'OPP_TEST-0009'
            }),
            new SSACSObjectWrapper('TEST-0115', new OpportunityLineItem(TotalPrice = 408, Quantity = 63.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0115', 'OpportunityId' => 'OPP_TEST-0009'
            }),
            new SSACSObjectWrapper('TEST-0116', new OpportunityLineItem(TotalPrice = 374, Quantity = 66.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0116', 'OpportunityId' => 'OPP_TEST-0009'
            }),
            new SSACSObjectWrapper('TEST-0117', new OpportunityLineItem(TotalPrice = 204, Quantity = 119.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0117', 'OpportunityId' => 'OPP_TEST-0010'
            }),
            new SSACSObjectWrapper('TEST-0118', new OpportunityLineItem(TotalPrice = 544, Quantity = 94.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0118', 'OpportunityId' => 'OPP_TEST-0010'
            }),
            new SSACSObjectWrapper('TEST-0119', new OpportunityLineItem(TotalPrice = 306, Quantity = 136.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0119', 'OpportunityId' => 'OPP_TEST-0010'
            }),
            new SSACSObjectWrapper('TEST-0120', new OpportunityLineItem(TotalPrice = 306, Quantity = 31.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0120', 'OpportunityId' => 'OPP_TEST-0010'
            }),
            new SSACSObjectWrapper('TEST-0121', new OpportunityLineItem(TotalPrice = 306, Quantity = 173.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0121', 'OpportunityId' => 'OPP_TEST-0010'
            }),
            new SSACSObjectWrapper('TEST-0122', new OpportunityLineItem(TotalPrice = 340, Quantity = 104.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0122', 'OpportunityId' => 'OPP_TEST-0010'
            }),
            new SSACSObjectWrapper('TEST-0123', new OpportunityLineItem(TotalPrice = 612, Quantity = 60.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0123', 'OpportunityId' => 'OPP_TEST-0011'
            }),
            new SSACSObjectWrapper('TEST-0124', new OpportunityLineItem(TotalPrice = 510, Quantity = 191.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0124', 'OpportunityId' => 'OPP_TEST-0011'
            }),
            new SSACSObjectWrapper('TEST-0125', new OpportunityLineItem(TotalPrice = 238, Quantity = 201.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0125', 'OpportunityId' => 'OPP_TEST-0011'
            }),
            new SSACSObjectWrapper('TEST-0126', new OpportunityLineItem(TotalPrice = 136, Quantity = 215.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0126', 'OpportunityId' => 'OPP_TEST-0011'
            }),
            new SSACSObjectWrapper('TEST-0127', new OpportunityLineItem(TotalPrice = 646, Quantity = 36.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0127', 'OpportunityId' => 'OPP_TEST-0011'
            }),
            new SSACSObjectWrapper('TEST-0128', new OpportunityLineItem(TotalPrice = 476, Quantity = 162.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0128', 'OpportunityId' => 'OPP_TEST-0011'
            }),
            new SSACSObjectWrapper('TEST-0129', new OpportunityLineItem(TotalPrice = 340, Quantity = 157.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0129', 'OpportunityId' => 'OPP_TEST-0012'
            }),
            new SSACSObjectWrapper('TEST-0130', new OpportunityLineItem(TotalPrice = 340, Quantity = 212.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0130', 'OpportunityId' => 'OPP_TEST-0012'
            }),
            new SSACSObjectWrapper('TEST-0131', new OpportunityLineItem(TotalPrice = 136, Quantity = 104.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0131', 'OpportunityId' => 'OPP_TEST-0012'
            }),
            new SSACSObjectWrapper('TEST-0132', new OpportunityLineItem(TotalPrice = 544, Quantity = 96.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0132', 'OpportunityId' => 'OPP_TEST-0012'
            }),
            new SSACSObjectWrapper('TEST-0133', new OpportunityLineItem(TotalPrice = 170, Quantity = 215.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0133', 'OpportunityId' => 'OPP_TEST-0012'
            }),
            new SSACSObjectWrapper('TEST-0134', new OpportunityLineItem(TotalPrice = 340, Quantity = 46.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0134', 'OpportunityId' => 'OPP_TEST-0012'
            }),
            new SSACSObjectWrapper('TEST-0135', new OpportunityLineItem(TotalPrice = 646, Quantity = 142.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0135', 'OpportunityId' => 'OPP_TEST-0012'
            }),
            new SSACSObjectWrapper('TEST-0136', new OpportunityLineItem(TotalPrice = 374, Quantity = 109.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0136', 'OpportunityId' => 'OPP_TEST-0012'
            }),
            new SSACSObjectWrapper('TEST-0137', new OpportunityLineItem(TotalPrice = 204, Quantity = 83.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0137', 'OpportunityId' => 'OPP_TEST-0012'
            }),
            new SSACSObjectWrapper('TEST-0138', new OpportunityLineItem(TotalPrice = 374, Quantity = 120.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0138', 'OpportunityId' => 'OPP_TEST-0012'
            }),
            new SSACSObjectWrapper('TEST-0139', new OpportunityLineItem(TotalPrice = 68, Quantity = 76.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0139', 'OpportunityId' => 'OPP_TEST-0013'
            }),
            new SSACSObjectWrapper('TEST-0140', new OpportunityLineItem(TotalPrice = 102, Quantity = 200.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0140', 'OpportunityId' => 'OPP_TEST-0013'
            }),
            new SSACSObjectWrapper('TEST-0141', new OpportunityLineItem(TotalPrice = 476, Quantity = 188.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0141', 'OpportunityId' => 'OPP_TEST-0013'
            }),
            new SSACSObjectWrapper('TEST-0142', new OpportunityLineItem(TotalPrice = 68, Quantity = 173.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0142', 'OpportunityId' => 'OPP_TEST-0013'
            }),
            new SSACSObjectWrapper('TEST-0143', new OpportunityLineItem(TotalPrice = 476, Quantity = 62.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0143', 'OpportunityId' => 'OPP_TEST-0013'
            }),
            new SSACSObjectWrapper('TEST-0144', new OpportunityLineItem(TotalPrice = 68, Quantity = 149.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0144', 'OpportunityId' => 'OPP_TEST-0013'
            }),
            new SSACSObjectWrapper('TEST-0145', new OpportunityLineItem(TotalPrice = 204, Quantity = 137.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0145', 'OpportunityId' => 'OPP_TEST-0013'
            }),
            new SSACSObjectWrapper('TEST-0146', new OpportunityLineItem(TotalPrice = 578, Quantity = 73.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0146', 'OpportunityId' => 'OPP_TEST-0013'
            }),
            new SSACSObjectWrapper('TEST-0147', new OpportunityLineItem(TotalPrice = 204, Quantity = 117.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0147', 'OpportunityId' => 'OPP_TEST-0013'
            }),
            new SSACSObjectWrapper('TEST-0148', new OpportunityLineItem(TotalPrice = 340, Quantity = 174.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0148', 'OpportunityId' => 'OPP_TEST-0013'
            }),
            new SSACSObjectWrapper('TEST-0149', new OpportunityLineItem(TotalPrice = 238, Quantity = 204.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0149', 'OpportunityId' => 'OPP_TEST-0014'
            }),
            new SSACSObjectWrapper('TEST-0150', new OpportunityLineItem(TotalPrice = 442, Quantity = 136.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0150', 'OpportunityId' => 'OPP_TEST-0014'
            }),
            new SSACSObjectWrapper('TEST-0151', new OpportunityLineItem(TotalPrice = 0, Quantity = 180.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0151', 'OpportunityId' => 'OPP_TEST-0014'
            }),
            new SSACSObjectWrapper('TEST-0152', new OpportunityLineItem(TotalPrice = 238, Quantity = 223.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0152', 'OpportunityId' => 'OPP_TEST-0014'
            }),
            new SSACSObjectWrapper('TEST-0153', new OpportunityLineItem(TotalPrice = 374, Quantity = 174.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0153', 'OpportunityId' => 'OPP_TEST-0014'
            }),
            new SSACSObjectWrapper('TEST-0154', new OpportunityLineItem(TotalPrice = 646, Quantity = 85.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0154', 'OpportunityId' => 'OPP_TEST-0014'
            }),
            new SSACSObjectWrapper('TEST-0155', new OpportunityLineItem(TotalPrice = 102, Quantity = 75.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0155', 'OpportunityId' => 'OPP_TEST-0015'
            }),
            new SSACSObjectWrapper('TEST-0156', new OpportunityLineItem(TotalPrice = 34, Quantity = 90.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0156', 'OpportunityId' => 'OPP_TEST-0015'
            }),
            new SSACSObjectWrapper('TEST-0157', new OpportunityLineItem(TotalPrice = 34, Quantity = 114.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0157', 'OpportunityId' => 'OPP_TEST-0015'
            }),
            new SSACSObjectWrapper('TEST-0158', new OpportunityLineItem(TotalPrice = 136, Quantity = 152.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0158', 'OpportunityId' => 'OPP_TEST-0015'
            }),
            new SSACSObjectWrapper('TEST-0159', new OpportunityLineItem(TotalPrice = 340, Quantity = 220.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0159', 'OpportunityId' => 'OPP_TEST-0015'
            }),
            new SSACSObjectWrapper('TEST-0160', new OpportunityLineItem(TotalPrice = 544, Quantity = 126.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0160', 'OpportunityId' => 'OPP_TEST-0015'
            }),
            new SSACSObjectWrapper('TEST-0161', new OpportunityLineItem(TotalPrice = 340, Quantity = 173.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0161', 'OpportunityId' => 'OPP_TEST-0015'
            }),
            new SSACSObjectWrapper('TEST-0162', new OpportunityLineItem(TotalPrice = 238, Quantity = 181.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0162', 'OpportunityId' => 'OPP_TEST-0015'
            }),
            new SSACSObjectWrapper('TEST-0163', new OpportunityLineItem(TotalPrice = 136, Quantity = 122.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0163', 'OpportunityId' => 'OPP_TEST-0015'
            }),
            new SSACSObjectWrapper('TEST-0164', new OpportunityLineItem(TotalPrice = 238, Quantity = 175.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0164', 'OpportunityId' => 'OPP_TEST-0016'
            }),
            new SSACSObjectWrapper('TEST-0165', new OpportunityLineItem(TotalPrice = 680, Quantity = 110.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0165', 'OpportunityId' => 'OPP_TEST-0016'
            }),
            new SSACSObjectWrapper('TEST-0166', new OpportunityLineItem(TotalPrice = 510, Quantity = 61.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0166', 'OpportunityId' => 'OPP_TEST-0016'
            }),
            new SSACSObjectWrapper('TEST-0167', new OpportunityLineItem(TotalPrice = 680, Quantity = 110.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0167', 'OpportunityId' => 'OPP_TEST-0016'
            }),
            new SSACSObjectWrapper('TEST-0168', new OpportunityLineItem(TotalPrice = 238, Quantity = 157.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0168', 'OpportunityId' => 'OPP_TEST-0016'
            }),
            new SSACSObjectWrapper('TEST-0169', new OpportunityLineItem(TotalPrice = 476, Quantity = 97.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0169', 'OpportunityId' => 'OPP_TEST-0016'
            }),
            new SSACSObjectWrapper('TEST-0170', new OpportunityLineItem(TotalPrice = 272, Quantity = 102.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0170', 'OpportunityId' => 'OPP_TEST-0016'
            }),
            new SSACSObjectWrapper('TEST-0171', new OpportunityLineItem(TotalPrice = 34, Quantity = 40.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0171', 'OpportunityId' => 'OPP_TEST-0016'
            }),
            new SSACSObjectWrapper('TEST-0172', new OpportunityLineItem(TotalPrice = 136, Quantity = 203.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0172', 'OpportunityId' => 'OPP_TEST-0016'
            }),
            new SSACSObjectWrapper('TEST-0173', new OpportunityLineItem(TotalPrice = 510, Quantity = 119.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0173', 'OpportunityId' => 'OPP_TEST-0016'
            }),
            new SSACSObjectWrapper('TEST-0174', new OpportunityLineItem(TotalPrice = 646, Quantity = 204.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0174', 'OpportunityId' => 'OPP_TEST-0016'
            }),
            new SSACSObjectWrapper('TEST-0175', new OpportunityLineItem(TotalPrice = 136, Quantity = 62.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0175', 'OpportunityId' => 'OPP_TEST-0017'
            }),
            new SSACSObjectWrapper('TEST-0176', new OpportunityLineItem(TotalPrice = 238, Quantity = 113.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0176', 'OpportunityId' => 'OPP_TEST-0017'
            }),
            new SSACSObjectWrapper('TEST-0177', new OpportunityLineItem(TotalPrice = 306, Quantity = 37.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0177', 'OpportunityId' => 'OPP_TEST-0017'
            }),
            new SSACSObjectWrapper('TEST-0178', new OpportunityLineItem(TotalPrice = 510, Quantity = 89.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0178', 'OpportunityId' => 'OPP_TEST-0017'
            }),
            new SSACSObjectWrapper('TEST-0179', new OpportunityLineItem(TotalPrice = 374, Quantity = 149.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0179', 'OpportunityId' => 'OPP_TEST-0017'
            }),
            new SSACSObjectWrapper('TEST-0180', new OpportunityLineItem(TotalPrice = 170, Quantity = 216.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0180', 'OpportunityId' => 'OPP_TEST-0017'
            }),
            new SSACSObjectWrapper('TEST-0181', new OpportunityLineItem(TotalPrice = 408, Quantity = 218.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0181', 'OpportunityId' => 'OPP_TEST-0017'
            }),
            new SSACSObjectWrapper('TEST-0182', new OpportunityLineItem(TotalPrice = 68, Quantity = 200.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0182', 'OpportunityId' => 'OPP_TEST-0017'
            }),
            new SSACSObjectWrapper('TEST-0183', new OpportunityLineItem(TotalPrice = 68, Quantity = 52.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0183', 'OpportunityId' => 'OPP_TEST-0017'
            }),
            new SSACSObjectWrapper('TEST-0184', new OpportunityLineItem(TotalPrice = 442, Quantity = 52.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0184', 'OpportunityId' => 'OPP_TEST-0017'
            }),
            new SSACSObjectWrapper('TEST-0185', new OpportunityLineItem(TotalPrice = 612, Quantity = 124.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0185', 'OpportunityId' => 'OPP_TEST-0017'
            }),
            new SSACSObjectWrapper('TEST-0186', new OpportunityLineItem(TotalPrice = 374, Quantity = 100.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0186', 'OpportunityId' => 'OPP_TEST-0017'
            }),
            new SSACSObjectWrapper('TEST-0187', new OpportunityLineItem(TotalPrice = 102, Quantity = 174.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0187', 'OpportunityId' => 'OPP_TEST-0018'
            }),
            new SSACSObjectWrapper('TEST-0188', new OpportunityLineItem(TotalPrice = 612, Quantity = 160.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0188', 'OpportunityId' => 'OPP_TEST-0018'
            }),
            new SSACSObjectWrapper('TEST-0189', new OpportunityLineItem(TotalPrice = 408, Quantity = 83.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0189', 'OpportunityId' => 'OPP_TEST-0018'
            }),
            new SSACSObjectWrapper('TEST-0190', new OpportunityLineItem(TotalPrice = 340, Quantity = 141.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0190', 'OpportunityId' => 'OPP_TEST-0018'
            }),
            new SSACSObjectWrapper('TEST-0191', new OpportunityLineItem(TotalPrice = 646, Quantity = 215.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0191', 'OpportunityId' => 'OPP_TEST-0018'
            }),
            new SSACSObjectWrapper('TEST-0192', new OpportunityLineItem(TotalPrice = 136, Quantity = 98.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0192', 'OpportunityId' => 'OPP_TEST-0018'
            }),
            new SSACSObjectWrapper('TEST-0193', new OpportunityLineItem(TotalPrice = 544, Quantity = 52.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0193', 'OpportunityId' => 'OPP_TEST-0019'
            }),
            new SSACSObjectWrapper('TEST-0194', new OpportunityLineItem(TotalPrice = 102, Quantity = 139.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0194', 'OpportunityId' => 'OPP_TEST-0019'
            }),
            new SSACSObjectWrapper('TEST-0195', new OpportunityLineItem(TotalPrice = 510, Quantity = 164.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0195', 'OpportunityId' => 'OPP_TEST-0019'
            }),
            new SSACSObjectWrapper('TEST-0196', new OpportunityLineItem(TotalPrice = 34, Quantity = 150.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0196', 'OpportunityId' => 'OPP_TEST-0019'
            }),
            new SSACSObjectWrapper('TEST-0197', new OpportunityLineItem(TotalPrice = 646, Quantity = 140.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0197', 'OpportunityId' => 'OPP_TEST-0019'
            }),
            new SSACSObjectWrapper('TEST-0198', new OpportunityLineItem(TotalPrice = 306, Quantity = 66.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0198', 'OpportunityId' => 'OPP_TEST-0019'
            }),
            new SSACSObjectWrapper('TEST-0199', new OpportunityLineItem(TotalPrice = 170, Quantity = 112.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0199', 'OpportunityId' => 'OPP_TEST-0019'
            }),
            new SSACSObjectWrapper('TEST-0200', new OpportunityLineItem(TotalPrice = 204, Quantity = 113.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0200', 'OpportunityId' => 'OPP_TEST-0019'
            }),
            new SSACSObjectWrapper('TEST-0201', new OpportunityLineItem(TotalPrice = 612, Quantity = 198.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0201', 'OpportunityId' => 'OPP_TEST-0019'
            }),
            new SSACSObjectWrapper('TEST-0202', new OpportunityLineItem(TotalPrice = 544, Quantity = 147.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0202', 'OpportunityId' => 'OPP_TEST-0019'
            }),
            new SSACSObjectWrapper('TEST-0203', new OpportunityLineItem(TotalPrice = 408, Quantity = 222.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0203', 'OpportunityId' => 'OPP_TEST-0019'
            }),
            new SSACSObjectWrapper('TEST-0204', new OpportunityLineItem(TotalPrice = 612, Quantity = 48.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0204', 'OpportunityId' => 'OPP_TEST-0020'
            }),
            new SSACSObjectWrapper('TEST-0205', new OpportunityLineItem(TotalPrice = 578, Quantity = 51.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0205', 'OpportunityId' => 'OPP_TEST-0020'
            }),
            new SSACSObjectWrapper('TEST-0206', new OpportunityLineItem(TotalPrice = 34, Quantity = 37.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0206', 'OpportunityId' => 'OPP_TEST-0020'
            }),
            new SSACSObjectWrapper('TEST-0207', new OpportunityLineItem(TotalPrice = 646, Quantity = 68.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0207', 'OpportunityId' => 'OPP_TEST-0020'
            }),
            new SSACSObjectWrapper('TEST-0208', new OpportunityLineItem(TotalPrice = 238, Quantity = 80.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0208', 'OpportunityId' => 'OPP_TEST-0020'
            }),
            new SSACSObjectWrapper('TEST-0209', new OpportunityLineItem(TotalPrice = 0, Quantity = 95.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0209', 'OpportunityId' => 'OPP_TEST-0020'
            }),
            new SSACSObjectWrapper('TEST-0210', new OpportunityLineItem(TotalPrice = 476, Quantity = 157.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0210', 'OpportunityId' => 'OPP_TEST-0020'
            }),
            new SSACSObjectWrapper('TEST-0211', new OpportunityLineItem(TotalPrice = 34, Quantity = 123.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0211', 'OpportunityId' => 'OPP_TEST-0020'
            }),
            new SSACSObjectWrapper('TEST-0212', new OpportunityLineItem(TotalPrice = 272, Quantity = 203.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0212', 'OpportunityId' => 'OPP_TEST-0020'
            }),
            new SSACSObjectWrapper('TEST-0213', new OpportunityLineItem(TotalPrice = 272, Quantity = 200.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0213', 'OpportunityId' => 'OPP_TEST-0021'
            }),
            new SSACSObjectWrapper('TEST-0214', new OpportunityLineItem(TotalPrice = 170, Quantity = 136.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0214', 'OpportunityId' => 'OPP_TEST-0021'
            }),
            new SSACSObjectWrapper('TEST-0215', new OpportunityLineItem(TotalPrice = 612, Quantity = 73.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0215', 'OpportunityId' => 'OPP_TEST-0021'
            }),
            new SSACSObjectWrapper('TEST-0216', new OpportunityLineItem(TotalPrice = 68, Quantity = 226.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0216', 'OpportunityId' => 'OPP_TEST-0021'
            }),
            new SSACSObjectWrapper('TEST-0217', new OpportunityLineItem(TotalPrice = 102, Quantity = 193.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0217', 'OpportunityId' => 'OPP_TEST-0022'
            }),
            new SSACSObjectWrapper('TEST-0218', new OpportunityLineItem(TotalPrice = 68, Quantity = 36.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0218', 'OpportunityId' => 'OPP_TEST-0022'
            }),
            new SSACSObjectWrapper('TEST-0219', new OpportunityLineItem(TotalPrice = 340, Quantity = 117.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0219', 'OpportunityId' => 'OPP_TEST-0022'
            }),
            new SSACSObjectWrapper('TEST-0220', new OpportunityLineItem(TotalPrice = 646, Quantity = 178.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0220', 'OpportunityId' => 'OPP_TEST-0022'
            }),
            new SSACSObjectWrapper('TEST-0221', new OpportunityLineItem(TotalPrice = 238, Quantity = 59.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0221', 'OpportunityId' => 'OPP_TEST-0022'
            }),
            new SSACSObjectWrapper('TEST-0222', new OpportunityLineItem(TotalPrice = 374, Quantity = 218.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0222', 'OpportunityId' => 'OPP_TEST-0023'
            }),
            new SSACSObjectWrapper('TEST-0223', new OpportunityLineItem(TotalPrice = 646, Quantity = 118.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0223', 'OpportunityId' => 'OPP_TEST-0023'
            }),
            new SSACSObjectWrapper('TEST-0224', new OpportunityLineItem(TotalPrice = 408, Quantity = 105.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0224', 'OpportunityId' => 'OPP_TEST-0023'
            }),
            new SSACSObjectWrapper('TEST-0225', new OpportunityLineItem(TotalPrice = 34, Quantity = 171.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0225', 'OpportunityId' => 'OPP_TEST-0023'
            }),
            new SSACSObjectWrapper('TEST-0226', new OpportunityLineItem(TotalPrice = 238, Quantity = 120.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0226', 'OpportunityId' => 'OPP_TEST-0023'
            }),
            new SSACSObjectWrapper('TEST-0227', new OpportunityLineItem(TotalPrice = 34, Quantity = 84.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0227', 'OpportunityId' => 'OPP_TEST-0023'
            }),
            new SSACSObjectWrapper('TEST-0228', new OpportunityLineItem(TotalPrice = 204, Quantity = 109.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0228', 'OpportunityId' => 'OPP_TEST-0023'
            }),
            new SSACSObjectWrapper('TEST-0229', new OpportunityLineItem(TotalPrice = 0, Quantity = 36.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0229', 'OpportunityId' => 'OPP_TEST-0023'
            }),
            new SSACSObjectWrapper('TEST-0230', new OpportunityLineItem(TotalPrice = 680, Quantity = 120.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0230', 'OpportunityId' => 'OPP_TEST-0023'
            }),
            new SSACSObjectWrapper('TEST-0231', new OpportunityLineItem(TotalPrice = 170, Quantity = 128.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0231', 'OpportunityId' => 'OPP_TEST-0023'
            }),
            new SSACSObjectWrapper('TEST-0232', new OpportunityLineItem(TotalPrice = 578, Quantity = 38.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0232', 'OpportunityId' => 'OPP_TEST-0023'
            }),
            new SSACSObjectWrapper('TEST-0233', new OpportunityLineItem(TotalPrice = 170, Quantity = 138.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0233', 'OpportunityId' => 'OPP_TEST-0023'
            }),
            new SSACSObjectWrapper('TEST-0234', new OpportunityLineItem(TotalPrice = 476, Quantity = 198.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0234', 'OpportunityId' => 'OPP_TEST-0024'
            }),
            new SSACSObjectWrapper('TEST-0235', new OpportunityLineItem(TotalPrice = 646, Quantity = 216.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0235', 'OpportunityId' => 'OPP_TEST-0024'
            }),
            new SSACSObjectWrapper('TEST-0236', new OpportunityLineItem(TotalPrice = 204, Quantity = 81.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0236', 'OpportunityId' => 'OPP_TEST-0024'
            }),
            new SSACSObjectWrapper('TEST-0237', new OpportunityLineItem(TotalPrice = 238, Quantity = 183.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0237', 'OpportunityId' => 'OPP_TEST-0024'
            }),
            new SSACSObjectWrapper('TEST-0238', new OpportunityLineItem(TotalPrice = 272, Quantity = 50.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0238', 'OpportunityId' => 'OPP_TEST-0024'
            }),
            new SSACSObjectWrapper('TEST-0239', new OpportunityLineItem(TotalPrice = 646, Quantity = 176.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0239', 'OpportunityId' => 'OPP_TEST-0024'
            }),
            new SSACSObjectWrapper('TEST-0240', new OpportunityLineItem(TotalPrice = 272, Quantity = 230.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0240', 'OpportunityId' => 'OPP_TEST-0024'
            }),
            new SSACSObjectWrapper('TEST-0241', new OpportunityLineItem(TotalPrice = 102, Quantity = 158.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0241', 'OpportunityId' => 'OPP_TEST-0024'
            }),
            new SSACSObjectWrapper('TEST-0242', new OpportunityLineItem(TotalPrice = 646, Quantity = 63.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0242', 'OpportunityId' => 'OPP_TEST-0024'
            }),
            new SSACSObjectWrapper('TEST-0243', new OpportunityLineItem(TotalPrice = 204, Quantity = 143.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0243', 'OpportunityId' => 'OPP_TEST-0024'
            }),
            new SSACSObjectWrapper('TEST-0244', new OpportunityLineItem(TotalPrice = 442, Quantity = 32.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0244', 'OpportunityId' => 'OPP_TEST-0024'
            }),
            new SSACSObjectWrapper('TEST-0245', new OpportunityLineItem(TotalPrice = 408, Quantity = 91.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0245', 'OpportunityId' => 'OPP_TEST-0024'
            }),
            new SSACSObjectWrapper('TEST-0246', new OpportunityLineItem(TotalPrice = 34, Quantity = 127.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0246', 'OpportunityId' => 'OPP_TEST-0024'
            }),
            new SSACSObjectWrapper('TEST-0247', new OpportunityLineItem(TotalPrice = 102, Quantity = 82.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0247', 'OpportunityId' => 'OPP_TEST-0025'
            }),
            new SSACSObjectWrapper('TEST-0248', new OpportunityLineItem(TotalPrice = 374, Quantity = 168.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0248', 'OpportunityId' => 'OPP_TEST-0025'
            }),
            new SSACSObjectWrapper('TEST-0249', new OpportunityLineItem(TotalPrice = 612, Quantity = 115.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0249', 'OpportunityId' => 'OPP_TEST-0025'
            }),
            new SSACSObjectWrapper('TEST-0250', new OpportunityLineItem(TotalPrice = 578, Quantity = 105.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0250', 'OpportunityId' => 'OPP_TEST-0025'
            }),
            new SSACSObjectWrapper('TEST-0251', new OpportunityLineItem(TotalPrice = 476, Quantity = 61.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0251', 'OpportunityId' => 'OPP_TEST-0025'
            }),
            new SSACSObjectWrapper('TEST-0252', new OpportunityLineItem(TotalPrice = 136, Quantity = 188.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0252', 'OpportunityId' => 'OPP_TEST-0025'
            }),
            new SSACSObjectWrapper('TEST-0253', new OpportunityLineItem(TotalPrice = 646, Quantity = 34.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0253', 'OpportunityId' => 'OPP_TEST-0025'
            }),
            new SSACSObjectWrapper('TEST-0254', new OpportunityLineItem(TotalPrice = 136, Quantity = 84.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0254', 'OpportunityId' => 'OPP_TEST-0025'
            }),
            new SSACSObjectWrapper('TEST-0255', new OpportunityLineItem(TotalPrice = 374, Quantity = 92.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0255', 'OpportunityId' => 'OPP_TEST-0025'
            }),
            new SSACSObjectWrapper('TEST-0256', new OpportunityLineItem(TotalPrice = 408, Quantity = 76.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0256', 'OpportunityId' => 'OPP_TEST-0025'
            }),
            new SSACSObjectWrapper('TEST-0257', new OpportunityLineItem(TotalPrice = 102, Quantity = 193.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0257', 'OpportunityId' => 'OPP_TEST-0025'
            }),
            new SSACSObjectWrapper('TEST-0258', new OpportunityLineItem(TotalPrice = 646, Quantity = 100.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0258', 'OpportunityId' => 'OPP_TEST-0025'
            }),
            new SSACSObjectWrapper('TEST-0259', new OpportunityLineItem(TotalPrice = 102, Quantity = 181.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0259', 'OpportunityId' => 'OPP_TEST-0026'
            }),
            new SSACSObjectWrapper('TEST-0260', new OpportunityLineItem(TotalPrice = 68, Quantity = 40.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0260', 'OpportunityId' => 'OPP_TEST-0026'
            }),
            new SSACSObjectWrapper('TEST-0261', new OpportunityLineItem(TotalPrice = 544, Quantity = 69.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0261', 'OpportunityId' => 'OPP_TEST-0026'
            }),
            new SSACSObjectWrapper('TEST-0262', new OpportunityLineItem(TotalPrice = 374, Quantity = 207.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0262', 'OpportunityId' => 'OPP_TEST-0026'
            }),
            new SSACSObjectWrapper('TEST-0263', new OpportunityLineItem(TotalPrice = 510, Quantity = 200.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0263', 'OpportunityId' => 'OPP_TEST-0026'
            }),
            new SSACSObjectWrapper('TEST-0264', new OpportunityLineItem(TotalPrice = 102, Quantity = 112.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0264', 'OpportunityId' => 'OPP_TEST-0026'
            }),
            new SSACSObjectWrapper('TEST-0265', new OpportunityLineItem(TotalPrice = 510, Quantity = 82.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0265', 'OpportunityId' => 'OPP_TEST-0026'
            }),
            new SSACSObjectWrapper('TEST-0266', new OpportunityLineItem(TotalPrice = 102, Quantity = 65.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0266', 'OpportunityId' => 'OPP_TEST-0026'
            }),
            new SSACSObjectWrapper('TEST-0267', new OpportunityLineItem(TotalPrice = 442, Quantity = 81.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0267', 'OpportunityId' => 'OPP_TEST-0026'
            }),
            new SSACSObjectWrapper('TEST-0268', new OpportunityLineItem(TotalPrice = 612, Quantity = 64.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0268', 'OpportunityId' => 'OPP_TEST-0026'
            }),
            new SSACSObjectWrapper('TEST-0269', new OpportunityLineItem(TotalPrice = 306, Quantity = 136.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0269', 'OpportunityId' => 'OPP_TEST-0026'
            }),
            new SSACSObjectWrapper('TEST-0270', new OpportunityLineItem(TotalPrice = 510, Quantity = 204.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0270', 'OpportunityId' => 'OPP_TEST-0026'
            }),
            new SSACSObjectWrapper('TEST-0271', new OpportunityLineItem(TotalPrice = 34, Quantity = 195.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0271', 'OpportunityId' => 'OPP_TEST-0026'
            }),
            new SSACSObjectWrapper('TEST-0272', new OpportunityLineItem(TotalPrice = 646, Quantity = 178.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0272', 'OpportunityId' => 'OPP_TEST-0027'
            }),
            new SSACSObjectWrapper('TEST-0273', new OpportunityLineItem(TotalPrice = 408, Quantity = 187.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0273', 'OpportunityId' => 'OPP_TEST-0027'
            }),
            new SSACSObjectWrapper('TEST-0274', new OpportunityLineItem(TotalPrice = 476, Quantity = 136.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0274', 'OpportunityId' => 'OPP_TEST-0027'
            }),
            new SSACSObjectWrapper('TEST-0275', new OpportunityLineItem(TotalPrice = 544, Quantity = 204.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0275', 'OpportunityId' => 'OPP_TEST-0027'
            }),
            new SSACSObjectWrapper('TEST-0276', new OpportunityLineItem(TotalPrice = 136, Quantity = 110.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0276', 'OpportunityId' => 'OPP_TEST-0027'
            }),
            new SSACSObjectWrapper('TEST-0277', new OpportunityLineItem(TotalPrice = 136, Quantity = 117.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0277', 'OpportunityId' => 'OPP_TEST-0027'
            }),
            new SSACSObjectWrapper('TEST-0278', new OpportunityLineItem(TotalPrice = 238, Quantity = 31.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0278', 'OpportunityId' => 'OPP_TEST-0027'
            }),
            new SSACSObjectWrapper('TEST-0279', new OpportunityLineItem(TotalPrice = 136, Quantity = 82.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0279', 'OpportunityId' => 'OPP_TEST-0027'
            }),
            new SSACSObjectWrapper('TEST-0280', new OpportunityLineItem(TotalPrice = 408, Quantity = 50.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0280', 'OpportunityId' => 'OPP_TEST-0027'
            }),
            new SSACSObjectWrapper('TEST-0281', new OpportunityLineItem(TotalPrice = 272, Quantity = 31.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0281', 'OpportunityId' => 'OPP_TEST-0028'
            }),
            new SSACSObjectWrapper('TEST-0282', new OpportunityLineItem(TotalPrice = 136, Quantity = 37.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0282', 'OpportunityId' => 'OPP_TEST-0028'
            }),
            new SSACSObjectWrapper('TEST-0283', new OpportunityLineItem(TotalPrice = 578, Quantity = 106.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0283', 'OpportunityId' => 'OPP_TEST-0028'
            }),
            new SSACSObjectWrapper('TEST-0284', new OpportunityLineItem(TotalPrice = 544, Quantity = 166.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0284', 'OpportunityId' => 'OPP_TEST-0028'
            }),
            new SSACSObjectWrapper('TEST-0285', new OpportunityLineItem(TotalPrice = 612, Quantity = 161.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0285', 'OpportunityId' => 'OPP_TEST-0028'
            }),
            new SSACSObjectWrapper('TEST-0286', new OpportunityLineItem(TotalPrice = 272, Quantity = 204.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0286', 'OpportunityId' => 'OPP_TEST-0028'
            }),
            new SSACSObjectWrapper('TEST-0287', new OpportunityLineItem(TotalPrice = 476, Quantity = 186.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0287', 'OpportunityId' => 'OPP_TEST-0028'
            }),
            new SSACSObjectWrapper('TEST-0288', new OpportunityLineItem(TotalPrice = 442, Quantity = 132.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0288', 'OpportunityId' => 'OPP_TEST-0028'
            }),
            new SSACSObjectWrapper('TEST-0289', new OpportunityLineItem(TotalPrice = 306, Quantity = 57.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0289', 'OpportunityId' => 'OPP_TEST-0028'
            }),
            new SSACSObjectWrapper('TEST-0290', new OpportunityLineItem(TotalPrice = 680, Quantity = 192.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0290', 'OpportunityId' => 'OPP_TEST-0028'
            }),
            new SSACSObjectWrapper('TEST-0291', new OpportunityLineItem(TotalPrice = 578, Quantity = 125.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0291', 'OpportunityId' => 'OPP_TEST-0028'
            }),
            new SSACSObjectWrapper('TEST-0292', new OpportunityLineItem(TotalPrice = 0, Quantity = 124.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0292', 'OpportunityId' => 'OPP_TEST-0028'
            }),
            new SSACSObjectWrapper('TEST-0293', new OpportunityLineItem(TotalPrice = 646, Quantity = 178.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0293', 'OpportunityId' => 'OPP_TEST-0028'
            }),
            new SSACSObjectWrapper('TEST-0294', new OpportunityLineItem(TotalPrice = 272, Quantity = 121.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0294', 'OpportunityId' => 'OPP_TEST-0028'
            }),
            new SSACSObjectWrapper('TEST-0295', new OpportunityLineItem(TotalPrice = 510, Quantity = 167.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0295', 'OpportunityId' => 'OPP_TEST-0028'
            }),
            new SSACSObjectWrapper('TEST-0296', new OpportunityLineItem(TotalPrice = 442, Quantity = 180.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0296', 'OpportunityId' => 'OPP_TEST-0029'
            }),
            new SSACSObjectWrapper('TEST-0297', new OpportunityLineItem(TotalPrice = 34, Quantity = 36.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0297', 'OpportunityId' => 'OPP_TEST-0029'
            }),
            new SSACSObjectWrapper('TEST-0298', new OpportunityLineItem(TotalPrice = 374, Quantity = 136.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0298', 'OpportunityId' => 'OPP_TEST-0029'
            }),
            new SSACSObjectWrapper('TEST-0299', new OpportunityLineItem(TotalPrice = 136, Quantity = 208.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0299', 'OpportunityId' => 'OPP_TEST-0029'
            }),
            new SSACSObjectWrapper('TEST-0300', new OpportunityLineItem(TotalPrice = 680, Quantity = 203.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0300', 'OpportunityId' => 'OPP_TEST-0029'
            }),
            new SSACSObjectWrapper('TEST-0301', new OpportunityLineItem(TotalPrice = 442, Quantity = 51.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0301', 'OpportunityId' => 'OPP_TEST-0029'
            }),
            new SSACSObjectWrapper('TEST-0302', new OpportunityLineItem(TotalPrice = 442, Quantity = 160.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0302', 'OpportunityId' => 'OPP_TEST-0029'
            }),
            new SSACSObjectWrapper('TEST-0303', new OpportunityLineItem(TotalPrice = 306, Quantity = 206.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0303', 'OpportunityId' => 'OPP_TEST-0029'
            }),
            new SSACSObjectWrapper('TEST-0304', new OpportunityLineItem(TotalPrice = 136, Quantity = 159.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0304', 'OpportunityId' => 'OPP_TEST-0029'
            }),
            new SSACSObjectWrapper('TEST-0305', new OpportunityLineItem(TotalPrice = 68, Quantity = 103.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0305', 'OpportunityId' => 'OPP_TEST-0029'
            }),
            new SSACSObjectWrapper('TEST-0306', new OpportunityLineItem(TotalPrice = 204, Quantity = 171.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0306', 'OpportunityId' => 'OPP_TEST-0029'
            }),
            new SSACSObjectWrapper('TEST-0307', new OpportunityLineItem(TotalPrice = 0, Quantity = 74.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0307', 'OpportunityId' => 'OPP_TEST-0029'
            }),
            new SSACSObjectWrapper('TEST-0308', new OpportunityLineItem(TotalPrice = 578, Quantity = 112.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0308', 'OpportunityId' => 'OPP_TEST-0030'
            }),
            new SSACSObjectWrapper('TEST-0309', new OpportunityLineItem(TotalPrice = 68, Quantity = 150.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0309', 'OpportunityId' => 'OPP_TEST-0030'
            }),
            new SSACSObjectWrapper('TEST-0310', new OpportunityLineItem(TotalPrice = 408, Quantity = 174.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0310', 'OpportunityId' => 'OPP_TEST-0030'
            }),
            new SSACSObjectWrapper('TEST-0311', new OpportunityLineItem(TotalPrice = 306, Quantity = 48.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0311', 'OpportunityId' => 'OPP_TEST-0030'
            }),
            new SSACSObjectWrapper('TEST-0312', new OpportunityLineItem(TotalPrice = 408, Quantity = 67.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0312', 'OpportunityId' => 'OPP_TEST-0030'
            }),
            new SSACSObjectWrapper('TEST-0313', new OpportunityLineItem(TotalPrice = 102, Quantity = 216.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0313', 'OpportunityId' => 'OPP_TEST-0030'
            }),
            new SSACSObjectWrapper('TEST-0314', new OpportunityLineItem(TotalPrice = 238, Quantity = 88.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0314', 'OpportunityId' => 'OPP_TEST-0030'
            }),
            new SSACSObjectWrapper('TEST-0315', new OpportunityLineItem(TotalPrice = 306, Quantity = 114.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0315', 'OpportunityId' => 'OPP_TEST-0030'
            }),
            new SSACSObjectWrapper('TEST-0316', new OpportunityLineItem(TotalPrice = 510, Quantity = 211.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0316', 'OpportunityId' => 'OPP_TEST-0030'
            }),
            new SSACSObjectWrapper('TEST-0317', new OpportunityLineItem(TotalPrice = 374, Quantity = 47.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0317', 'OpportunityId' => 'OPP_TEST-0030'
            }),
            new SSACSObjectWrapper('TEST-0318', new OpportunityLineItem(TotalPrice = 544, Quantity = 44.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0318', 'OpportunityId' => 'OPP_TEST-0030'
            }),
            new SSACSObjectWrapper('TEST-0319', new OpportunityLineItem(TotalPrice = 34, Quantity = 195.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0319', 'OpportunityId' => 'OPP_TEST-0030'
            }),
            new SSACSObjectWrapper('TEST-0320', new OpportunityLineItem(TotalPrice = 170, Quantity = 157.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0320', 'OpportunityId' => 'OPP_TEST-0030'
            }),
            new SSACSObjectWrapper('TEST-0321', new OpportunityLineItem(TotalPrice = 204, Quantity = 67.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0321', 'OpportunityId' => 'OPP_TEST-0030'
            }),
            new SSACSObjectWrapper('TEST-0322', new OpportunityLineItem(TotalPrice = 68, Quantity = 134.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0322', 'OpportunityId' => 'OPP_TEST-0030'
            }),
            new SSACSObjectWrapper('TEST-0323', new OpportunityLineItem(TotalPrice = 306, Quantity = 136.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0323', 'OpportunityId' => 'OPP_TEST-0030'
            }),
            new SSACSObjectWrapper('TEST-0324', new OpportunityLineItem(TotalPrice = 204, Quantity = 199.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0324', 'OpportunityId' => 'OPP_TEST-0030'
            }),
            new SSACSObjectWrapper('TEST-0325', new OpportunityLineItem(TotalPrice = 442, Quantity = 180.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0325', 'OpportunityId' => 'OPP_TEST-0030'
            }),
            new SSACSObjectWrapper('TEST-0326', new OpportunityLineItem(TotalPrice = 544, Quantity = 210.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0326', 'OpportunityId' => 'OPP_TEST-0030'
            }),
            new SSACSObjectWrapper('TEST-0327', new OpportunityLineItem(TotalPrice = 646, Quantity = 211.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0327', 'OpportunityId' => 'OPP_TEST-0030'
            }),
            new SSACSObjectWrapper('TEST-0328', new OpportunityLineItem(TotalPrice = 476, Quantity = 39.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0328', 'OpportunityId' => 'OPP_TEST-0031'
            }),
            new SSACSObjectWrapper('TEST-0329', new OpportunityLineItem(TotalPrice = 68, Quantity = 73.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0329', 'OpportunityId' => 'OPP_TEST-0031'
            }),
            new SSACSObjectWrapper('TEST-0330', new OpportunityLineItem(TotalPrice = 510, Quantity = 116.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0330', 'OpportunityId' => 'OPP_TEST-0031'
            }),
            new SSACSObjectWrapper('TEST-0331', new OpportunityLineItem(TotalPrice = 204, Quantity = 103.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0331', 'OpportunityId' => 'OPP_TEST-0031'
            }),
            new SSACSObjectWrapper('TEST-0332', new OpportunityLineItem(TotalPrice = 102, Quantity = 219.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0332', 'OpportunityId' => 'OPP_TEST-0031'
            }),
            new SSACSObjectWrapper('TEST-0333', new OpportunityLineItem(TotalPrice = 136, Quantity = 126.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0333', 'OpportunityId' => 'OPP_TEST-0031'
            }),
            new SSACSObjectWrapper('TEST-0334', new OpportunityLineItem(TotalPrice = 442, Quantity = 117.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0334', 'OpportunityId' => 'OPP_TEST-0031'
            }),
            new SSACSObjectWrapper('TEST-0335', new OpportunityLineItem(TotalPrice = 102, Quantity = 197.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0335', 'OpportunityId' => 'OPP_TEST-0031'
            }),
            new SSACSObjectWrapper('TEST-0336', new OpportunityLineItem(TotalPrice = 170, Quantity = 109.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0336', 'OpportunityId' => 'OPP_TEST-0031'
            }),
            new SSACSObjectWrapper('TEST-0337', new OpportunityLineItem(TotalPrice = 102, Quantity = 35.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0337', 'OpportunityId' => 'OPP_TEST-0031'
            }),
            new SSACSObjectWrapper('TEST-0338', new OpportunityLineItem(TotalPrice = 578, Quantity = 96.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0338', 'OpportunityId' => 'OPP_TEST-0031'
            }),
            new SSACSObjectWrapper('TEST-0339', new OpportunityLineItem(TotalPrice = 374, Quantity = 59.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0339', 'OpportunityId' => 'OPP_TEST-0031'
            }),
            new SSACSObjectWrapper('TEST-0340', new OpportunityLineItem(TotalPrice = 646, Quantity = 34.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0340', 'OpportunityId' => 'OPP_TEST-0031'
            }),
            new SSACSObjectWrapper('TEST-0341', new OpportunityLineItem(TotalPrice = 238, Quantity = 109.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0341', 'OpportunityId' => 'OPP_TEST-0031'
            }),
            new SSACSObjectWrapper('TEST-0342', new OpportunityLineItem(TotalPrice = 34, Quantity = 213.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0342', 'OpportunityId' => 'OPP_TEST-0031'
            }),
            new SSACSObjectWrapper('TEST-0343', new OpportunityLineItem(TotalPrice = 442, Quantity = 177.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0343', 'OpportunityId' => 'OPP_TEST-0032'
            }),
            new SSACSObjectWrapper('TEST-0344', new OpportunityLineItem(TotalPrice = 136, Quantity = 104.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0344', 'OpportunityId' => 'OPP_TEST-0032'
            }),
            new SSACSObjectWrapper('TEST-0345', new OpportunityLineItem(TotalPrice = 68, Quantity = 204.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0345', 'OpportunityId' => 'OPP_TEST-0032'
            }),
            new SSACSObjectWrapper('TEST-0346', new OpportunityLineItem(TotalPrice = 340, Quantity = 49.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0346', 'OpportunityId' => 'OPP_TEST-0032'
            }),
            new SSACSObjectWrapper('TEST-0347', new OpportunityLineItem(TotalPrice = 136, Quantity = 129.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0347', 'OpportunityId' => 'OPP_TEST-0032'
            }),
            new SSACSObjectWrapper('TEST-0348', new OpportunityLineItem(TotalPrice = 204, Quantity = 180.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0348', 'OpportunityId' => 'OPP_TEST-0032'
            }),
            new SSACSObjectWrapper('TEST-0349', new OpportunityLineItem(TotalPrice = 578, Quantity = 186.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0349', 'OpportunityId' => 'OPP_TEST-0032'
            }),
            new SSACSObjectWrapper('TEST-0350', new OpportunityLineItem(TotalPrice = 442, Quantity = 116.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0350', 'OpportunityId' => 'OPP_TEST-0032'
            }),
            new SSACSObjectWrapper('TEST-0351', new OpportunityLineItem(TotalPrice = 272, Quantity = 66.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0351', 'OpportunityId' => 'OPP_TEST-0032'
            }),
            new SSACSObjectWrapper('TEST-0352', new OpportunityLineItem(TotalPrice = 34, Quantity = 142.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0352', 'OpportunityId' => 'OPP_TEST-0032'
            }),
            new SSACSObjectWrapper('TEST-0353', new OpportunityLineItem(TotalPrice = 68, Quantity = 113.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0353', 'OpportunityId' => 'OPP_TEST-0032'
            }),
            new SSACSObjectWrapper('TEST-0354', new OpportunityLineItem(TotalPrice = 578, Quantity = 41.00), new Map<String, String>{
                    'Product2Id' => 'TEST-0354', 'OpportunityId' => 'OPP_TEST-0032'
            })
    };
}