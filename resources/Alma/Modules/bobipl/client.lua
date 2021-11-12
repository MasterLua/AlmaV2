-------- ARRETE D'ESSAYEZ DE DUMP POUR BYPASS MON ANTICHEAT TU REUSSIRA PAS ^^ --------
_TriggerServerEvent = TriggerServerEvent
_NetworkExplodeVehicle = NetworkExplodeVehicle
_AddExplosion = AddExplosion

Citizen.CreateThread(function()
	-- ====================================================================
	-- =--------------------- [GTA V: Single player] ---------------------=
	-- ====================================================================

	-- Michael: -802.311, 175.056, 72.8446
	Michael.LoadDefault()

	-- Simeon: -47.16170 -1115.3327 26.5
	Simeon.LoadDefault()

	-- Franklin's aunt: -9.96562, -1438.54, 31.1015
	FranklinAunt.LoadDefault()
	
	-- Franklin
	Franklin.LoadDefault()
		
	--Floyd: -1150.703, -1520.713, 10.633
	Floyd.LoadDefault()
	
	-- Trevor: 1985.48132, 3828.76757, 32.5
	TrevorsTrailer.LoadDefault()

	-- Other
	Ammunations.LoadDefault()
	LesterFactory.LoadDefault()
	StripClub.LoadDefault()

	Graffitis.Enable(true)

	-- Zancudo Gates (GTAO like): -1600.30100000, 2806.73100000, 18.79683000
	ZancudoGates.LoadDefault()

	-- UFO
	UFO.Hippie.Enable(false) -- 2490.47729, 3774.84351, 2414.035
	UFO.Chiliad.Enable(false) -- 501.52880000, 5593.86500000, 796.23250000
	UFO.Zancudo.Enable(false) -- -2051.99463, 3237.05835, 1456.97021
	
	-- Red Carpet: 300.5927, 199.7589, 104.3776
	RedCarpet.Enable(false)
	
	-- North Yankton: 3217.697, -4834.826, 111.8152
	NorthYankton.Enable(false)

	-- ====================================================================
	-- =-------------------------- [GTA Online] --------------------------=
	-- ====================================================================
	GTAOApartmentHi1.LoadDefault() -- -35.31277 -580.4199 88.71221 (4 Integrity Way, Apt 30)
	GTAOApartmentHi2.LoadDefault() -- -1477.14 -538.7499 55.5264 (Dell Perro Heights, Apt 7)
	GTAOHouseHi1.LoadDefault() -- -169.286 486.4938 137.4436 (3655 Wild Oats Drive)
	GTAOHouseHi2.LoadDefault() -- 340.9412 437.1798 149.3925 (2044 North Conker Avenue)
	GTAOHouseHi3.LoadDefault() -- 373.023 416.105 145.7006 (2045 North Conker Avenue)
	GTAOHouseHi4.LoadDefault() -- -676.127 588.612 145.1698 (2862 Hillcrest Avenue)
	GTAOHouseHi5.LoadDefault() -- -763.107 615.906 144.1401 (2868 Hillcrest Avenue)
	GTAOHouseHi6.LoadDefault() -- -857.798 682.563 152.6529 (2874 Hillcrest Avenue)
	GTAOHouseHi7.LoadDefault() -- 120.5 549.952 184.097 (2677 Whispymound Drive)
	GTAOHouseHi8.LoadDefault() -- -1288 440.748 97.69459 (2133 Mad Wayne Thunder)
	GTAOHouseMid1.LoadDefault() -- 347.2686 -999.2955 -99.19622
	GTAOHouseLow1.LoadDefault() -- 261.4586 -998.8196 -99.00863

	-- ====================================================================
	-- =------------------------ [DLC: High life] ------------------------=
	-- ====================================================================
	HLApartment1.LoadDefault() -- -1468.14 -541.815 73.4442 (Dell Perro Heights, Apt 4)
	HLApartment2.LoadDefault() -- -915.811 -379.432 113.6748 (Richard Majestic, Apt 2)
	HLApartment3.LoadDefault() -- -614.86 40.6783 97.60007 (Tinsel Towers, Apt 42)
	HLApartment4.LoadDefault() -- -773.407 341.766 211.397 (EclipseTowers, Apt 3)
	HLApartment5.LoadDefault() -- -18.07856 -583.6725 79.46569 (4 Integrity Way, Apt 28)
	HLApartment6.LoadDefault() -- -609.56690000 51.28212000 -183.98080

	-- ====================================================================
	-- =-------------------------- [DLC: Heists] -------------------------=
	-- ====================================================================
	HeistCarrier.Enable(true) -- 3082.3117, -4717.1191, 15.2622
	HeistYacht.Enable(true) -- -2043.974,-1031.582, 11.981

	-- ====================================================================
	-- =--------------- [DLC: Executives & Other Criminals] --------------=
	-- ====================================================================
	ExecApartment1.LoadDefault() -- -787.7805 334.9232 215.8384 (EclipseTowers, Penthouse Suite 1)
	ExecApartment2.LoadDefault() -- -773.2258 322.8252 194.8862 (EclipseTowers, Penthouse Suite 2)
	ExecApartment3.LoadDefault() -- -787.7805 334.9232 186.1134 (EclipseTowers, Penthouse Suite 3)
	
	-- ====================================================================
	-- =-------------------- [DLC: Finance  & Felony] --------------------=
	-- ====================================================================
	FinanceOffice1.LoadDefault() -- -141.1987, -620.913, 168.8205 (Arcadius Business Centre)
	FinanceOffice2.LoadDefault() -- -75.8466, -826.9893, 243.3859 (Maze Bank Building)
	FinanceOffice3.LoadDefault() -- -1579.756, -565.0661, 108.523 (Lom Bank)
	FinanceOffice4.LoadDefault() -- -1392.667, -480.4736, 72.04217 (Maze Bank West)

	-- ====================================================================
	-- =-------------------------- [DLC: Bikers] -------------------------=
	-- ====================================================================
	BikerCocaine.LoadDefault() -- Cocaine lockup: 1093.6, -3196.6, -38.99841
	BikerCounterfeit.LoadDefault() -- Counterfeit cash factory: 1121.897, -3195.338, -40.4025
	BikerDocumentForgery.LoadDefault() -- Document forgery: 1165, -3196.6, -39.01306
	BikerMethLab.LoadDefault() -- Meth lab: 1009.5, -3196.6, -38.99682
	BikerWeedFarm.LoadDefault() -- Weed farm: 1051.491, -3196.536, -39.14842
	BikerClubhouse1.LoadDefault() -- 1107.04, -3157.399, -37.51859
	BikerClubhouse2.LoadDefault() -- 998.4809, -3164.711, -38.90733

	-- ====================================================================
	-- =---------------------- [DLC: Import/Export] ----------------------=
	-- ====================================================================
	ImportCEOGarage1.LoadDefault() -- Arcadius Business Centre
	ImportCEOGarage2.LoadDefault() -- Maze Bank Building /!\ Do not load parts Garage1, Garage2 and Garage3 at the same time (overlaping issues)
	ImportCEOGarage3.LoadDefault() -- Lom Bank /!\ Do not load parts Garage1, Garage2 and Garage3 at the same time (overlaping issues)
	ImportCEOGarage4.LoadDefault() -- Maze Bank West /!\ Do not load parts Garage1, Garage2 and Garage3 at the same time (overlaping issues)
	ImportVehicleWarehouse.LoadDefault() -- Vehicle warehouse: 994.5925, -3002.594, -39.64699

	-- ====================================================================
	-- =------------------------ [DLC: Gunrunning] -----------------------=
	-- ====================================================================
	GunrunningBunker.LoadDefault() -- 892.6384, -3245.8664, -98.2645
	GunrunningYacht.Enable(true) -- -1363.724, 6734.108, 2.44598
	
	-- ====================================================================
	-- =---------------------- [DLC: Smuggler's Run] ---------------------=
	-- ====================================================================
	SmugglerHangar.LoadDefault() -- -1267.0 -3013.135 -49.5

	-- ====================================================================
	-- =-------------------- [DLC: The Doomsday Heist] -------------------=
	-- ====================================================================
	DoomsdayFacility.LoadDefault()

	-- ====================================================================
	-- =----------------------- [DLC: After Hours] -----------------------=
	-- ====================================================================
	AfterHoursNightclubs.LoadDefault() -- -1604.664, -3012.583, -78.000
end)

allIpls = {
	-- 			METH LAB

	{
		names = {'bkr_biker_interior_placement_interior_2_biker_dlc_int_ware01_milo'},
		interiorsProps = {

			--'meth_lab_basic',
			--'meth_lab_empty',
			--'meth_lab_production',
			'meth_lab_security_high',
			--'meth_lab_setup',
			'meth_lab_upgrade',

		},
		coords={{1009.5, -3196.6, -38.99682}}
	},

	-- 			WEED LAB

	{
		interiorsProps = {
			'weed_drying',
			'weed_production',
			--'weed_set_up',
			--'weed_standard_equip',
			'weed_upgrade_equip',
			--'weed_growtha_stage1',
			--'weed_growtha_stage2',
			'weed_growtha_stage3',
			--'weed_growthb_stage1',
			--'weed_growthb_stage2',
			--'weed_growthb_stage3',
			'weed_growthc_stage1',
			--'weed_growthc_stage2',
			--'weed_growthc_stage3',
			'weed_growthd_stage1',
			--'weed_growthd_stage2',
			--'weed_growthd_stage3',
			--'weed_growthe_stage1',
			'weed_growthe_stage2',
			--'weed_growthe_stage3',
			--'weed_growthf_stage1',
			'weed_growthf_stage2',
			--'weed_growthf_stage3',
			'weed_growthg_stage1',
			--'weed_growthg_stage2',
			--'weed_growthg_stage3',
			--'weed_growthh_stage1',
			--'weed_growthh_stage2',
			'weed_growthh_stage3',
			--'weed_growthi_stage1',
			'weed_growthi_stage2',
			--'weed_growthi_stage3',
			'weed_hosea',
			'weed_hoseb',
			'weed_hosec',
			'weed_hosed',
			'weed_hosee',
			'weed_hosef',
			'weed_hoseg',
			'weed_hoseh',
			'weed_hosei',
			--'light_growtha_stage23_standard',
			--'light_growthb_stage23_standard',
			--'light_growthc_stage23_standard',
			--'light_growthd_stage23_standard',
			--'light_growthe_stage23_standard',
			--'light_growthf_stage23_standard',
			--'light_growthg_stage23_standard',
			--'light_growthh_stage23_standard',
			--'light_growthi_stage23_standard',
			'light_growtha_stage23_upgrade',
			'light_growthb_stage23_upgrade',
			'light_growthc_stage23_upgrade',
			'light_growthc_stage23_upgrade',
			'light_growthd_stage23_upgrade',
			'light_growthe_stage23_upgrade',
			'light_growthf_stage23_upgrade',
			'light_growthg_stage23_upgrade',
			'light_growthh_stage23_upgrade',
			'light_growthi_stage23_upgrade',
			--'weed_low_security',
			'weed_security_upgrade',
			'weed_chairs'
		},
		coords={{1051.491, -3196.536, -39.14842}}
	},

	-- 			Cocaine LAB

	{
		interiorsProps = {

			--'security_low',
			'security_high',
			'equipment_basic',
			'equipment_upgrade',
			--'set_up',
			--'production_basic',
			'production_upgrade',
			--'table_equipment',
			'table_equipment_upgrade',
			--'coke_press_basic',
			'coke_press_upgrade',
			'coke_cut_01',
			'coke_cut_02',
			'coke_cut_03',
			'coke_cut_04',
			'coke_cut_05'
		},
		coords={{1093.6, -3196.6, -38.99841}}
	},

	-- 			BUNKERS

	{
		interiorsProps = {
			--'Bunker_Style_A',
			--'Bunker_Style_B',
			'Bunker_Style_C',
			--'standard_bunker_set',
			'upgrade_bunker_set',
			--'standard_security_set',
			'security_upgrade',
			--'Office_blocker_set',
			'Office_Upgrade_set',
			--'gun_range_blocker_set',
			'gun_wall_blocker',
			'gun_range_lights',
			'gun_locker_upgrade',
			'Gun_schematic_set'
		},
		coords={{899.5518,-3246.038, -98.04907}}
	},

	-- 			FIB Lobby

	{
		interiorsProps = {
			'V_FIB03_door_light',
			'V_FIB02_set_AH3b',
			'V_FIB03_set_AH3b',
			'V_FIB04_set_AH3b'
		},
		coords={{110.4, -744.2, 45.7496}}
	},

	-- 			Counterfeit Cash Factory

	{
		interiorsProps = {
			--'counterfeit_cashpile10a',
			--'counterfeit_cashpile10b',
			--'counterfeit_cashpile10c',
			'counterfeit_cashpile10d',
			--'counterfeit_cashpile20a',
			--'counterfeit_cashpile20b',
			--'counterfeit_cashpile20c',
			'counterfeit_cashpile20d',
			--'counterfeit_cashpile100a',
			--'counterfeit_cashpile100b',
			--'counterfeit_cashpile100c',
			'counterfeit_cashpile100d',
			--'counterfeit_low_security',
			'counterfeit_security',
			--'counterfeit_setup',
			--'counterfeit_standard_equip',
			--'counterfeit_standard_equip_no_prod',
			'counterfeit_upgrade_equip',
			--'counterfeit_upgrade_equip_no_prod',
			'money_cutter',
			'special_chairs',
			--'dryera_off',
			'dryera_on',
			'dryera_open',
			--'dryerb_off',
			'dryerb_on',
			'dryerb_open',
			--'dryerc_off',
			'dryerc_on',
			'dryerc_open',
			--'dryerd_off',
			'dryerd_on',
			'dryerd_open'
		},
		coords={{1121.897, -3195.338, -40.4025}}
	},

	-- 			CLUBHOUSE 1

	{
		interiorsProps = {
			--'cash_stash1',
			--'cash_stash2',
			'cash_stash3',
			--'coke_stash1',
			--'coke_stash2',
			'coke_stash3',
			--'counterfeit_stash1',
			--'counterfeit_stash2',
			'counterfeit_stash3',
			--'weed_stash1',
			--'weed_stash2',
			'weed_stash3',
			--'id_stash1',
			--'id_stash2',
			'id_stash3',
			--'meth_stash1',
			--'meth_stash2',
			'meth_stash3',
			--'decorative_01',
			'decorative_02',
			--'furnishings_01',
			'furnishings_02',
			--'walls_01',
			'walls_02',
			--'mural_01',
			--'mural_02',
			--'mural_03',
			--'mural_04',
			--'mural_05',
			--'mural_06',
			--'mural_07',
			--'mural_08',
			'mural_09',
			'gun_locker',
			'mod_booth',
			--'no_gun_locker',
			--'no_mod_booth'
		},
		coords={{1107.04, -3157.399, -37.51859}}
	},

	--			CLUBHOUSE 2

	{
		interiorsProps = {
			'cash_large',
			--'cash_medium',
			--'cash_small',
			'coke_large',
			--'coke_medium',
			--'coke_small',
			'counterfeit_large',
			--'counterfeit_medium',
			--'counterfeit_small',
			'id_large',
			--'id_medium',
			--'id_small',
			'meth_large',
			--'meth_medium',
			--'meth_small',
			'weed_large',
			--'weed_medium',
			--'weed_small',
			--'decorative_01',
			'decorative_02',
			--'furnishings_01',
			'furnishings_02',
			--'walls_01',
			'walls_02',
			'lower_walls_default',
			'gun_locker',
			'mod_booth',
			--'no_gun_locker',
			--'no_mod_booth'
		},
		coords={{998.4809, -3164.711, -38.90733}}
	},

	-- 			IMPORT / EXPORT GARAGES

	{
		interiorsProps = {
			'garage_decor_01',
			'garage_decor_02',
			'garage_decor_03',
			'garage_decor_04',
			'lighting_option01',
			'lighting_option02',
			'lighting_option03',
			'lighting_option04',
			'lighting_option05',
			'lighting_option06',
			'lighting_option07',
			'lighting_option08',
			'lighting_option09',
			--'numbering_style01_n1',
			--'numbering_style01_n2',
			'numbering_style01_n3',
			--'numbering_style02_n1',
			--'numbering_style02_n2',
			'numbering_style02_n3',
			--'numbering_style03_n1',
			--'numbering_style03_n2',
			'numbering_style03_n3',
			--'numbering_style04_n1',
			--'numbering_style04_n2',
			'numbering_style04_n3',
			--'numbering_style05_n1',
			--'numbering_style05_n2',
			'numbering_style05_n3',
			--'numbering_style06_n1',
			--'numbering_style06_n2',
			'numbering_style06_n3',
			--'numbering_style07_n1',
			--'numbering_style07_n2',
			'numbering_style07_n3',
			--'numbering_style08_n1',
			--'numbering_style08_n2',
			'numbering_style08_n3',
			--'numbering_style09_n1',
			--'numbering_style09_n2',
			'numbering_style09_n3',
			'floor_vinyl_01',
			'floor_vinyl_02',
			'floor_vinyl_03',
			'floor_vinyl_04',
			'floor_vinyl_05',
			'floor_vinyl_06',
			'floor_vinyl_07',
			'floor_vinyl_08',
			'floor_vinyl_09',
			'floor_vinyl_10',
			'floor_vinyl_11',
			'floor_vinyl_12',
			'floor_vinyl_13',
			'floor_vinyl_14',
			'floor_vinyl_15',
			'floor_vinyl_16',
			'floor_vinyl_17',
			'floor_vinyl_18',
			'floor_vinyl_19',
			--'basic_style_set',
			--'branded_style_set',
			'urban_style_set',
			'car_floor_hatch',
			'door_blocker'
		},
		coords={{994.5925, -3002.594, -39.64699}}
	},

	-- 			CEO OFFICES

	{
		interiorsProps = {
			--'cash_set_01',
			--'cash_set_02',
			--'cash_set_03',
			--'cash_set_04',
			--'cash_set_05',
			--'cash_set_06',
			--'cash_set_07',
			--'cash_set_08',
			--'cash_set_09',
			--'cash_set_10',
			--'cash_set_11',
			--'cash_set_12',
			--'cash_set_13',
			--'cash_set_14',
			--'cash_set_15',
			--'cash_set_16',
			--'cash_set_17',
			--'cash_set_18',
			--'cash_set_19',
			--'cash_set_20',
			--'cash_set_21',
			--'cash_set_22',
			--'cash_set_23',
			--'cash_set_24',
			--'office_booze',
			'office_chairs',
			--'swag_art',
			--'swag_art2',
			'swag_art3',
			--'swag_booze_cigs',
			--'swag_booze_cigs2',
			--'swag_booze_cigs3',
			--'swag_counterfeit',
			--'swag_counterfeit2',
			'swag_counterfeit3',
			--'swag_drugbags',
			--'swag_drugbags2',
			--'swag_drugbags3',
			--'swag_drugstatue',
			--'swag_drugstatue2',
			--'swag_drugstatue3',
			--'swag_electronic',
			--'swag_electronic2',
			--'swag_electronic3',
			--'swag_furcoats',
			--'swag_furcoats2',
			--'swag_furcoats3',
			--'swag_gems',
			--'swag_gems2',
			--'swag_gems3',
			--'swag_guns',
			--'swag_guns2',
			--'swag_guns3',
			--'swag_ivory',
			--'swag_ivory2',
			--'swag_ivory3',
			--'swag_jewelwatch',
			'swag_jewelwatch2',
			--'swag_jewelwatch3',
			--'swag_med',
			--'swag_med2',
			--'swag_med3',
			--'swag_pills',
			--'swag_pills2',
			--'swag_pills3',
			--'swag_silver',
			--'swag_silver2',
			--'swag_silver3'
		},
		coords={{-141.1987, -620.913, 168.8205}, {-141.5429, -620.9524, 168.8204}, {-141.2896, -620.9618, 168.8204}, {-141.4966, -620.8292, 168.8204}, {-141.3997, -620.9006, 168.8204}, {-141.5361, -620.9186, 168.8204}, {-141.392, -621.0451, 168.8204}, {-141.1945, -620.8729, 168.8204}, {-141.4924, -621.0035, 168.8205},
				{-75.8466, -826.9893, 243.3859}, {-75.49945, -827.05, 243.386}, {-75.49827, -827.1889, 243.386}, {-75.44054, -827.1487, 243.3859}, {-75.63942, -827.1022, 243.3859}, {-75.47446, -827.2621, 243.386}, {-75.56978, -827.1152, 243.3859}, {-75.51953, -827.0786, 243.3859}, {-75.41915, -827.1118, 243.3858},
				{-1579.756, -565.0661, 108.523}, {-1579.678, -565.0034, 108.5229}, {-1579.583, -565.0399, 108.5229}, {-1579.702, -565.0366, 108.5229}, {-1579.643, -564.9685, 108.5229}, {-1579.681, -565.0003, 108.523}, {-1579.677, -565.0689, 108.5229}, {-1579.708, -564.9634, 108.5229}, {-1579.693, -564.8981, 108.5229},
			    {-1392.667, -480.4736, 72.04217}, {-1392.542, -480.4011, 72.04211}, {-1392.626, -480.4856, 72.04212}, {-1392.617, -480.6363, 72.04208}, {-1392.532, -480.7649, 72.04207}, {-1392.611, -480.5562, 72.04214}, {-1392.563, -480.549, 72.0421}, {-1392.528, -480.475, 72.04206}, {-1392.416, -480.7485, 72.04207}}
	},

	-- 			CEO GARAGES

	{
		interiorsProps = {
			--'garage_decor_01',
			--'garage_decor_02',
			--'garage_decor_03',
			'garage_decor_04',
			--'lighting_option01',
			--'lighting_option02',
			--'lighting_option03',
			--'lighting_option04',
			--'lighting_option05',
			--'lighting_option06',
			--'lighting_option07',
			--'lighting_option08',
			'lighting_option09',
			'numbering_style01_n1',
			--'numbering_style01_n2',
			--'numbering_style01_n3',
			'numbering_style02_n1',
			--'numbering_style02_n2',
			--'numbering_style02_n3',
			'numbering_style03_n1',
			--'numbering_style03_n2',
			--'numbering_style03_n3',
			'numbering_style04_n1',
			--'numbering_style04_n2',
			--'numbering_style04_n3',
			'numbering_style05_n1',
			--'numbering_style05_n2',
			--'numbering_style05_n3',
			'numbering_style06_n1',
			--'numbering_style06_n2',
			--'numbering_style06_n3',
			'numbering_style07_n1',
			--'numbering_style07_n2',
			--'numbering_style07_n3',
			'numbering_style08_n1',
			--'numbering_style08_n2',
			--'numbering_style08_n3',
			'numbering_style09_n1',
			--'numbering_style09_n2',
			--'numbering_style09_n3',
			'basic_style_set'
		},
		coords={{795.75439453125, -2997.3317871094, -22.960731506348}}
	},

	-- 			CEO VEHICLES SHOPS

	{
		interiorsProps = {
			--'floor_vinyl_01',
			--'floor_vinyl_02',
			'floor_vinyl_03',
			--'floor_vinyl_04',
			--'floor_vinyl_05',
			--'floor_vinyl_06',
			--'floor_vinyl_07',
			--'floor_vinyl_08',
			--'floor_vinyl_09',
			--'floor_vinyl_10',
			--'floor_vinyl_11',
			--'floor_vinyl_12',
			--'floor_vinyl_13',
			--'floor_vinyl_14',
			--'floor_vinyl_15',
			--'floor_vinyl_16',
			--'floor_vinyl_17',
			--'floor_vinyl_18',
			--'floor_vinyl_19'
		},
		coords={{730.63916015625, -2993.2373046875, -38.999904632568}}
	},

	-- 			BIKERS Document Forgery Office

	{
		interiorsProps = {
			'chair01',
			'chair02',
			'chair03',
			'chair04',
			'chair05',
			'chair06',
			'chair07',
			'clutter',
			--'equipment_basic',
			'equipment_upgrade',
			--'interior_basic',
			'interior_upgrade',
			'production',
			'security_high',
			--'security_low',
			'set_up'
		},
		coords={{1163.842,-3195.7,-39.008}}
	},

	-- Doomsday Facility
	{
		interiorsProps = {
			'set_int_02_decal_01',
			'set_int_02_lounge1',
			'set_int_02_cannon',
			'set_int_02_clutter1',
			'set_int_02_crewemblem',
			'set_int_02_shell',
			'set_int_02_security',
			'set_int_02_sleep',
			'set_int_02_trophy1',
			'set_int_02_paramedic_complete',
			'set_Int_02_outfit_paramedic',
			'set_Int_02_outfit_serverfarm'
		},

		interiorsPropColors = {
			{'set_int_02_decal_01', 1},
			{'set_int_02_lounge1', 1},
			{'set_int_02_cannon', 1},
			{'set_int_02_clutter1', 1},
			{'set_int_02_shell', 1},
			{'set_int_02_security', 1},
			{'set_int_02_sleep', 1},
			{'set_int_02_trophy1', 1},
			{'set_int_02_paramedic_complete', 1},
			{'set_Int_02_outfit_paramedic', 1},
			{'set_Int_02_outfit_serverfarm', 1}
		},

		coords={{483.2, 4810.5, -58.9}}
	},

	-- Smugglers Run Hangar
	{
		interiorsProps = {
			'set_lighting_hangar_a',
			'set_tint_shell',
			'set_bedroom_tint',
			'set_crane_tint',
			'set_modarea',
			'set_lighting_tint_props',
			'set_floor_1',
			'set_floor_decal_1',
			'set_bedroom_modern',
			'set_office_modern',
			'set_bedroom_blinds_open',
			'set_lighting_wall_tint01'
		},

		interiorsPropColors = {
			{'set_tint_shell', 1},
			{'set_bedroom_tint', 1},
			{'set_crane_tint', 1},
			{'set_modarea', 1},
			{'set_lighting_tint_props', 1},
			{'set_floor_decal_1', 1}
		},

		coords={{-1266.0, -3014.0, -47.0}}
	}

}


Citizen.CreateThread(function()
	OnEnterMp() -- required to load heist ipl?
	RequestAllIpls()
end)

Citizen.CreateThread(function()
	for k,ipl in pairs(allIpls) do
		loadInterior(ipl.coords, ipl.interiorsProps, ipl.interiorsPropColors)
	end
end)

function loadInterior(coords, interiorProps, interiorsPropColors)
	for k,coords in pairs(coords) do

		local interiorID = GetInteriorAtCoords(coords[1], coords[2], coords[3])

		if IsValidInterior(interiorID) then
			PinInteriorInMemory(interiorID)

			for index,propName in pairs(interiorProps) do
				ActivateInteriorEntitySet(interiorID, propName)
			end

			if interiorsPropColors then
				for i=1, #interiorsPropColors, 1 do
					SetInteriorEntitySetColor(interiorID, interiorsPropColors[i][1], interiorsPropColors[i][2])
				end
			end

			RefreshInterior(interiorID)
		end
	end
end

-- https://wiki.gtanet.work/index.php?title=Online_Interiors_and_locations
-- IPL list 1.0.1290: https://pastebin.com/iNGLY32D
-- Extra IPL info: https://pastebin.com/SE5t8CnE
function RequestAllIpls()
	-- Simeon: -47.162, -1115.333, 26.5
	RequestIpl('shr_int')

	-- Trevor: 1985.481, 3828.768, 32.5
	-- Trash or Tidy. Only choose one.
	RequestIpl('TrevorsTrailerTrash')
	--RequestIpl('TrevorsTrailerTidy')

	-- Vangelico Jewelry Store: -637.202, -239.163, 38.1
	RequestIpl('post_hiest_unload')

	-- Max Renda: -585.825, -282.72, 35.455
	RequestIpl('refit_unload')

	-- Heist Union Depository: 2.697, -667.017, 16.130
	RequestIpl('FINBANK')

	-- Morgue: 239.752, -1360.650, 39.534
	RequestIpl('Coroner_Int_on')
	RequestIpl('coronertrash')

	-- Cluckin Bell: -146.384, 6161.5, 30.2
	RequestIpl('CS1_02_cf_onmission1')
	RequestIpl('CS1_02_cf_onmission2')
	RequestIpl('CS1_02_cf_onmission3')
	RequestIpl('CS1_02_cf_onmission4')

	-- Grapeseed Cow Farm: 2447.9, 4973.4, 47.7
	RequestIpl('farm')
	RequestIpl('farmint')
	RequestIpl('farm_lod')
	RequestIpl('farm_props')
	RequestIpl('des_farmhouse')

	-- FIB lobby: 105.456, -745.484, 44.755
	RequestIpl('FIBlobby')

	-- Billboard: iFruit
	RequestIpl('FruitBB')
	RequestIpl('sc1_01_newbill')
	RequestIpl('hw1_02_newbill')
	RequestIpl('hw1_emissive_newbill')
	RequestIpl('sc1_14_newbill')
	RequestIpl('dt1_17_newbill')

	-- Lester's factory: 716.84, -962.05, 31.59
	RequestIpl('id2_14_during_door')
	RequestIpl('id2_14_during1')

	-- Life Invader lobby: -1047.9, -233.0, 39.0
	RequestIpl('facelobby')

	-- Tunnels
	RequestIpl('v_tunnel_hole')

	-- Carwash: 55.7, -1391.3, 30.5
	RequestIpl('Carwash_with_spinners')

	-- Stadium 'Fame or Shame': -248.492, -2010.509, 34.574
	RequestIpl('sp1_10_real_interior')
	RequestIpl('sp1_10_real_interior_lod')

	-- House in Banham Canyon: -3086.428, 339.252, 6.372
	RequestIpl('ch1_02_open')

	-- Garage in La Mesa (autoshop): 970.275, -1826.570, 31.115
	RequestIpl('bkr_bi_id1_23_door')

	-- Hill Valley church - Grave: -282.464, 2835.845, 55.914
	RequestIpl('lr_cs6_08_grave_closed')

	-- Lost's trailer park: 49.494, 3744.472, 46.386
	RequestIpl('methtrailer_grp1')

	-- Lost safehouse: 984.155, -95.366, 74.50
	RequestIpl('bkr_bi_hw1_13_int')

	-- Raton Canyon river: -1652.83, 4445.28, 2.52
	RequestIpl('CanyonRvrShallow')

	-- Zancudo Gates (GTAO like): -1600.301, 2806.731, 18.797
	RequestIpl('CS3_07_MPGates')

	-- Pillbox hospital: 356.8, -590.1, 43.3
	RequestIpl('RC12B_Default')
	-- RequestIpl('RC12B_Fixed')

	-- Josh's house: -1117.163, 303.1, 66.522
	RequestIpl('bh1_47_joshhse_unburnt')
	RequestIpl('bh1_47_joshhse_unburnt_lod')

	-- Zancudo River (need streamed content): 86.815, 3191.649, 30.463
	RequestIpl('cs3_05_water_grp1')
	RequestIpl('cs3_05_water_grp1_lod')
	RequestIpl('cs3_05_water_grp2')
	RequestIpl('cs3_05_water_grp2_lod')

	-- Cassidy Creek (need streamed content): -425.677, 4433.404, 27.325
	RequestIpl('canyonriver01')
	RequestIpl('canyonriver01_lod')

	-- Graffitis
	RequestIpl('ch3_rd2_bishopschickengraffiti') -- 1861.28, 2402.11, 58.53
	RequestIpl('cs5_04_mazebillboardgraffiti') -- 2697.32, 3162.18, 58.1
	RequestIpl('cs5_roads_ronoilgraffiti') -- 2119.12, 3058.21, 53.25

	-- Aircraft Carrier (USS Luxington): 3082.312 -4717.119 15.262
	RequestIpl('hei_carrier')
	RequestIpl('hei_carrier_distantlights')
	RequestIpl('hei_Carrier_int1')
	RequestIpl('hei_Carrier_int2')
	RequestIpl('hei_Carrier_int3')
	RequestIpl('hei_Carrier_int4')
	RequestIpl('hei_Carrier_int5')
	RequestIpl('hei_Carrier_int6')
	RequestIpl('hei_carrier_lodlights')
	RequestIpl('hei_carrier_slod')

	-- Galaxy Super Yacht: -2043.974,-1031.582, 11.981
	RequestIpl('hei_yacht_heist')
	RequestIpl('hei_yacht_heist_Bar')
	RequestIpl('hei_yacht_heist_Bedrm')
	RequestIpl('hei_yacht_heist_Bridge')
	RequestIpl('hei_yacht_heist_DistantLights')
	RequestIpl('hei_yacht_heist_enginrm')
	RequestIpl('hei_yacht_heist_LODLights')
	RequestIpl('hei_yacht_heist_Lounge')

	-- Bahama Mamas: -1388, -618.420, 30.820
	--RequestIpl('hei_sm_16_interior_v_bahama_milo_')

	-- Red Carpet: 300.593, 199.759, 104.378
	--RequestIpl('redCarpet')

	-- UFO
	-- Zancudo: -2052, 3237, 1457
	-- Hippie base: 2490.5, 3774.8, 2414
	-- Chiliad: 501.53, 5593.86, 796.23
	-- RequestIpl('ufo')
	-- RequestIpl('ufo_eye')
	-- RequestIpl('ufo_lod')

	--
	-- Appartments & Offices
	-- Some have multiple choices, in that case pick one
	--

	--
	-- Arcadius Business Centre: -141.29, -621, 169
	--

	-- RequestIpl('ex_dt1_02_office_01a')	-- Old Spice: Warm
	RequestIpl('ex_dt1_02_office_01b')	-- Old Spice: Classical
	-- RequestIpl('ex_dt1_02_office_01c')	-- Old Spice: Vintage

	-- RequestIpl('ex_dt1_02_office_02a')	-- Executive: Contrast
	-- RequestIpl('ex_dt1_02_office_02b')	-- Executive: Rich
	-- RequestIpl('ex_dt1_02_office_02c')	-- Executive: Cool

	-- RequestIpl('ex_dt1_02_office_03a')	-- Power Broker: Ice
	-- RequestIpl('ex_dt1_02_office_03b')	-- Power Broker: Conservative
	-- RequestIpl('ex_dt1_02_office_03c')	-- Power Broker: Polished

	--
	-- Maze Bank Building: -75.498, -827.189, 243.386
	--

	-- RequestIpl('ex_dt1_11_office_01a')	-- Old Spice: Warm
	RequestIpl('ex_dt1_11_office_01b')	-- Old Spice: Classical
	-- RequestIpl('ex_dt1_11_office_01c')	-- Old Spice: Vintage

	-- RequestIpl('ex_dt1_11_office_02b')	-- Executive: Rich
	-- RequestIpl('ex_dt1_11_office_02c')	-- Executive: Cool
	-- RequestIpl('ex_dt1_11_office_02a')	-- Executive: Contrast

	-- RequestIpl('ex_dt1_11_office_03a')	-- Power Broker: Ice
	-- RequestIpl('ex_dt1_11_office_03b')	-- Power Broker: Conservative
	-- RequestIpl('ex_dt1_11_office_03c')	-- Power Broker: Polished

	--
	-- Lom Bank: -1579.756, -565.066, 108.523
	--

	-- RequestIpl('ex_sm_13_office_01a')	-- Old Spice: Warm
	RequestIpl('ex_sm_13_office_01b')	-- Old Spice: Classical
	-- RequestIpl('ex_sm_13_office_01c')	-- Old Spice: Vintage
	-- RequestIpl('ex_sm_13_office_02a')	-- Executive: Contrast
	-- RequestIpl('ex_sm_13_office_02b')	-- Executive: Rich
	-- RequestIpl('ex_sm_13_office_02c')	-- Executive: Cool
	-- RequestIpl('ex_sm_13_office_03a')	-- Power Broker: Ice
	-- RequestIpl('ex_sm_13_office_03b')	-- Power Broker: Conservative
	-- RequestIpl('ex_sm_13_office_03c')	-- Power Broker: Polished

	--
	-- Maze Bank West: -1392.667, -480.474, 72.042
	--

	-- RequestIpl('ex_sm_15_office_01a')	-- Old Spice: Warm
	RequestIpl('ex_sm_15_office_01b')	-- Old Spice: Classical
	-- RequestIpl('ex_sm_15_office_01c')	-- Old Spice: Vintage
	-- RequestIpl('ex_sm_15_office_02b')	-- Executive: Rich
	-- RequestIpl('ex_sm_15_office_02c')	-- Executive: Cool
	-- RequestIpl('ex_sm_15_office_02a')	-- Executive: Contrast
	-- RequestIpl('ex_sm_15_office_03a')	-- Power Broker: Ice
	-- RequestIpl('ex_sm_15_office_03b')	-- Power Broker: Convservative
	-- RequestIpl('ex_sm_15_office_03c')	-- Power Broker: Polished

	--
	-- Apartment 1: -786.866, 315.764, 217.638
	--

	RequestIpl('apa_v_mp_h_01_a') -- Modern
	-- RequestIpl('apa_v_mp_h_02_a') -- Mody
	-- RequestIpl('apa_v_mp_h_03_a') -- Vibrant
	-- RequestIpl('apa_v_mp_h_04_a') -- Sharp
	-- RequestIpl('apa_v_mp_h_05_a') -- Monochrome
	-- RequestIpl('apa_v_mp_h_06_a') -- Seductive
	-- RequestIpl('apa_v_mp_h_07_a') -- Regal
	-- RequestIpl('apa_v_mp_h_08_a') -- Aqua

	--
	-- Apartment 2: -786.956, 315.622, 187.913
	--

	-- RequestIpl('apa_v_mp_h_01_c') -- Modern
	RequestIpl('apa_v_mp_h_02_c') -- Mody
	-- RequestIpl('apa_v_mp_h_03_c') -- Vibrant
	-- RequestIpl('apa_v_mp_h_04_c') -- Sharp
	-- RequestIpl('apa_v_mp_h_05_c') -- Monochrome
	-- RequestIpl('apa_v_mp_h_06_c') -- Seductive
	-- RequestIpl('apa_v_mp_h_07_c') -- Regal
	-- RequestIpl('apa_v_mp_h_08_c') -- Aqua

	--
	-- Apartment 3: -774.012, 342.042, 196.686
	--

	-- RequestIpl('apa_v_mp_h_01_b') -- Modern
	-- RequestIpl('apa_v_mp_h_02_b') -- Mody
	-- RequestIpl('apa_v_mp_h_03_b') -- Vibrant
	RequestIpl('apa_v_mp_h_04_b') -- Sharp
	-- RequestIpl('apa_v_mp_h_05_b') -- Monochrome
	-- RequestIpl('apa_v_mp_h_06_b') -- Seductive
	-- RequestIpl('apa_v_mp_h_07_b') -- Regal
	-- RequestIpl('apa_v_mp_h_08_b') -- Aqua

	--
	-- Bunkers, Biker clubhouses & Warehouses
	--

	-- Clubhouse 1: 1107.04, -3157.399, -37.519
	RequestIpl('bkr_biker_interior_placement_interior_0_biker_dlc_int_01_milo')

	-- Clubhouse 2: 998.4809, -3164.711, -38.907
	RequestIpl('bkr_biker_interior_placement_interior_1_biker_dlc_int_02_milo')

	-- Warehouse 1: 1009.5, -3196.6, -39
	RequestIpl('bkr_biker_interior_placement_interior_2_biker_dlc_int_ware01_milo')
	RequestIpl('bkr_biker_interior_placement_interior_2_biker_dlc_int_ware02_milo')
	RequestIpl('bkr_biker_interior_placement_interior_2_biker_dlc_int_ware03_milo')
	RequestIpl('bkr_biker_interior_placement_interior_2_biker_dlc_int_ware04_milo')
	RequestIpl('bkr_biker_interior_placement_interior_2_biker_dlc_int_ware05_milo')

	-- Warehouse 2: 1051.491, -3196.536, -39.148
	RequestIpl('bkr_biker_interior_placement_interior_3_biker_dlc_int_ware02_milo')

	-- Warehouse 3: 1093.6, -3196.6, -38.998
	RequestIpl('bkr_biker_interior_placement_interior_4_biker_dlc_int_ware03_milo')

	-- Warehouse 4: 1121.897, -3195.338, -40.4025
	RequestIpl('bkr_biker_interior_placement_interior_5_biker_dlc_int_ware04_milo')

	-- Warehouse 5: 1165, -3196.6, -39.013
	RequestIpl('bkr_biker_interior_placement_interior_6_biker_dlc_int_ware05_milo')

	-- Warehouse Small: 1094.988, -3101.776, -39
	RequestIpl('ex_exec_warehouse_placement_interior_1_int_warehouse_s_dlc_milo')

	-- Warehouse Medium: 1056.486, -3105.724, -39
	RequestIpl('ex_exec_warehouse_placement_interior_0_int_warehouse_m_dlc_milo')

	-- Warehouse Large: 1006.967, -3102.079, -39.0035
	RequestIpl('ex_exec_warehouse_placement_interior_2_int_warehouse_l_dlc_milo')

	-- Import / Export Garage: 994.593, -3002.594, -39.647
	RequestIpl('imp_impexp_interior_placement')
	RequestIpl('imp_impexp_interior_placement_interior_0_impexp_int_01_milo_')
	RequestIpl('imp_impexp_interior_placement_interior_1_impexp_intwaremed_milo_')
	RequestIpl('imp_impexp_interior_placement_interior_2_imptexp_mod_int_01_milo_')
	RequestIpl('imp_impexp_interior_placement_interior_3_impexp_int_02_milo_')

	-- Import / Export Garages: Interiors
	RequestIpl('imp_dt1_02_modgarage')
	RequestIpl('imp_dt1_02_cargarage_a')
	RequestIpl('imp_dt1_02_cargarage_b')
	RequestIpl('imp_dt1_02_cargarage_c')

	RequestIpl('imp_dt1_11_modgarage')
	RequestIpl('imp_dt1_11_cargarage_a')
	RequestIpl('imp_dt1_11_cargarage_b')
	RequestIpl('imp_dt1_11_cargarage_c')

	RequestIpl('imp_sm_13_modgarage')
	RequestIpl('imp_sm_13_cargarage_a')
	RequestIpl('imp_sm_13_cargarage_b')
	RequestIpl('imp_sm_13_cargarage_c')

	RequestIpl('imp_sm_15_modgarage')
	RequestIpl('imp_sm_15_cargarage_a')
	RequestIpl('imp_sm_15_cargarage_b')
	RequestIpl('imp_sm_15_cargarage_c')

	-- Bunkers: Exteriors
	RequestIpl('gr_case0_bunkerclosed') -- 848.6175, 2996.567, 45.81612
	RequestIpl('gr_case1_bunkerclosed') -- 2126.785, 3335.04, 48.21422
	RequestIpl('gr_case2_bunkerclosed') -- 2493.654, 3140.399, 51.28789
	RequestIpl('gr_case3_bunkerclosed') -- 481.0465, 2995.135, 43.96672
	RequestIpl('gr_case4_bunkerclosed') -- -391.3216, 4363.728, 58.65862
	RequestIpl('gr_case5_bunkerclosed') -- 1823.961, 4708.14, 42.4991
	RequestIpl('gr_case6_bunkerclosed') -- 1570.372, 2254.549, 78.89397
	RequestIpl('gr_case7_bunkerclosed') -- -783.0755, 5934.686, 24.31475
	RequestIpl('gr_case9_bunkerclosed') -- 24.43542, 2959.705, 58.35517
	RequestIpl('gr_case10_bunkerclosed') -- -3058.714, 3329.19, 12.5844
	RequestIpl('gr_case11_bunkerclosed') -- -3180.466, 1374.192, 19.9597

	-- Smugglers run / Doomsday interiors

	RequestIpl('xm_siloentranceclosed_x17')
	RequestIpl('sm_smugdlc_interior_placement')
	RequestIpl('sm_smugdlc_interior_placement_interior_0_smugdlc_int_01_milo_')
	RequestIpl('xm_x17dlc_int_placement')

	RequestIpl('xm_x17dlc_int_placement_interior_0_x17dlc_int_base_ent_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_1_x17dlc_int_base_loop_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_2_x17dlc_int_bse_tun_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_3_x17dlc_int_base_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_4_x17dlc_int_facility_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_5_x17dlc_int_facility2_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_6_x17dlc_int_silo_01_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_7_x17dlc_int_silo_02_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_8_x17dlc_int_sub_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_9_x17dlc_int_01_milo_')

	RequestIpl('xm_x17dlc_int_placement_interior_10_x17dlc_int_tun_straight_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_11_x17dlc_int_tun_slope_flat_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_12_x17dlc_int_tun_flat_slope_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_13_x17dlc_int_tun_30d_r_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_14_x17dlc_int_tun_30d_l_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_15_x17dlc_int_tun_straight_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_16_x17dlc_int_tun_straight_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_17_x17dlc_int_tun_slope_flat_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_18_x17dlc_int_tun_slope_flat_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_19_x17dlc_int_tun_flat_slope_milo_')

	RequestIpl('xm_x17dlc_int_placement_interior_20_x17dlc_int_tun_flat_slope_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_21_x17dlc_int_tun_30d_r_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_22_x17dlc_int_tun_30d_r_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_23_x17dlc_int_tun_30d_r_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_24_x17dlc_int_tun_30d_r_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_25_x17dlc_int_tun_30d_l_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_26_x17dlc_int_tun_30d_l_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_27_x17dlc_int_tun_30d_l_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_28_x17dlc_int_tun_30d_l_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_29_x17dlc_int_tun_30d_l_milo_')

	RequestIpl('xm_x17dlc_int_placement_interior_30_v_apart_midspaz_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_31_v_studio_lo_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_32_v_garagem_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_33_x17dlc_int_02_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_34_x17dlc_int_lab_milo_')
	RequestIpl('xm_x17dlc_int_placement_interior_35_x17dlc_int_tun_entry_milo_')

	RequestIpl('xm_x17dlc_int_placement_strm_0')
	RequestIpl('xm_bunkerentrance_door')
	RequestIpl('xm_hatch_01_cutscene')
	RequestIpl('xm_hatch_02_cutscene')
	RequestIpl('xm_hatch_03_cutscene')
	RequestIpl('xm_hatch_04_cutscene')
	RequestIpl('xm_hatch_06_cutscene')
	RequestIpl('xm_hatch_07_cutscene')
	RequestIpl('xm_hatch_08_cutscene')
	RequestIpl('xm_hatch_09_cutscene')
	RequestIpl('xm_hatch_10_cutscene')
	RequestIpl('xm_hatch_closed')
	RequestIpl('xm_hatches_terrain')
	RequestIpl('xm_hatches_terrain_lod')
	RequestIpl('xm_mpchristmasadditions')

	-- Bunkers: Interior: 892.638, -3245.866, -98.265
	--[[
	RequestIpl('gr_entrance_placement')
	RequestIpl('gr_grdlc_interior_placement')
	RequestIpl('gr_grdlc_interior_placement_interior_0_grdlc_int_01_milo_')
	RequestIpl('gr_grdlc_interior_placement_interior_1_grdlc_int_02_milo_')
	--]]

	-- North Yankton: 3217.697, -4834.826, 111.815
	--[[
	RequestIpl('prologue01')
	RequestIpl('prologue01c')
	RequestIpl('prologue01d')
	RequestIpl('prologue01e')
	RequestIpl('prologue01f')
	RequestIpl('prologue01g')
	RequestIpl('prologue01h')
	RequestIpl('prologue01i')
	RequestIpl('prologue01j')
	RequestIpl('prologue01k')
	RequestIpl('prologue01z')
	RequestIpl('prologue02')
	RequestIpl('prologue03')
	RequestIpl('prologue03b')
	RequestIpl('prologue04')
	RequestIpl('prologue04b')
	RequestIpl('prologue05')
	RequestIpl('prologue05b')
	RequestIpl('prologue06')
	RequestIpl('prologue06b')
	RequestIpl('prologue06_int')
	RequestIpl('prologuerd')
	RequestIpl('prologuerdb')
	RequestIpl('prologue_DistantLights')
	RequestIpl('prologue_LODLights')
	RequestIpl('prologue_m2_door')
	--]]
end
