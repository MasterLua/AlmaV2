local Animations = {
	moodIndex = 1,
	gaitIndex = 1,
	mood = {
		"mood_normal_1",
		"mood_angry_1",
		"mood_drunk_1",
		"pose_injured_1",
		"electrocuted_1",
		"effort_1",
		"mood_drivefast_1",
		"pose_angry_1",
		"mood_happy_1",
		"mood_injured_1",
		"mood_dancing_low_1",
		"smoking_hold_1",
		"pose_normal_1",
		"pose_aiming_1",
		"shocked_1",
		"shocked_2",
		"mood_sleeping_1",
		"dead_1",
		"dead_2",
		"mood_smug_1",
		"mood_aiming_1",
		"mood_stressed_1",
		"mood_sulk_1",
		"effort_2",
		"effort_3",
	},
	gait = {
		"move_m@business@c",
		"move_m@alien",
		"anim_group_move_ballistic",
		"move_f@arrogant@a",
		"move_m@brave",
		"move_m@casual@a",
		"move_m@casual@b",
		"move_m@casual@c",
		"move_m@casual@d",
		"move_m@casual@e",
		"move_m@casual@f",
		"move_f@chichi",
		"move_m@confident",
		"move_m@business@a",
		"move_m@business@b",
		"move_m@drunk@a",
		"move_m@drunk@slightlydrunk",
		"move_m@buzzed",
		"move_m@drunk@verydrunk",
		"move_f@femme@",
		"move_characters@franklin@fire",
		"move_characters@michael@fire",
		"move_m@fire",
		"move_f@flee@a",
		"move_p_m_one",
		"move_m@gangster@generic",
		"move_m@gangster@ng",
		"move_m@gangster@var_e",
		"move_m@gangster@var_f",
		"move_m@gangster@var_i",
		"anim@move_m@grooving@",
		"move_f@heels@c",
		"move_f@heels@d",
		"move_m@hipster@a",
		"move_m@hobo@a",
		"move_f@hurry@a",
		"move_p_m_zero_janitor",
		"move_p_m_zero_slow",
		"move_m@jog@",
		"anim_group_move_lemar_alley",
		"move_heist_lester",
		"move_lester_caneup",
		"move_f@maneater",
		"move_ped_bucket",
		"move_m@money",
		"move_m@posh@",
		"move_f@posh@",
		"move_m@quick",
		"female_fast_runner",
		"move_m@sad@a",
		"move_m@sassy",
		"move_f@sassy",
		"move_f@scared",
		"move_f@sexy@a",
		"move_m@shadyped@a",
		"move_characters@jimmy@slow@",
		"move_m@swagger",
		"move_m@tough_guy@",
		"move_f@tough_guy@",
		"clipset@move@trash_fast_turn",
		"missfbi4prepp1_garbageman",
		"move_p_m_two",
		"move_m@bag"
	},
	Types = { index = 1 },
	Danse = {
		{ name = "Danser", anim = { "misschinese2_crystalmazemcs1_cs", "dance_loop_tao" } },
		{ name = 'Dance 5', anim = { 'anim@amb@casino@mini@dance@dance_solo@female@var_a@', 'med_center' } },
		{ name = 'Dance', anim = { 'anim@amb@nightclub@dancers@podium_dancers@', 'hi_dance_facedj_17_v2_male^5' } },
		{ name = 'Dance F5', anim = { 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 'hi_dance_facedj_09_v2_female^3' } },
		{ name = 'Dance Silly 7', anim = { 'anim@amb@casino@mini@dance@dance_solo@female@var_b@', 'high_center' } },
		{ name = 'Dance Slow', anim = { 'anim@amb@nightclub@mini@dance@dance_solo@male@var_b@', 'low_center' } },
		{ name = 'Dance 4', anim = { 'anim@amb@nightclub@mini@dance@dance_solo@male@var_b@', 'high_center_up' } },
		{ name = 'Dance Shy 2', anim = { 'anim@amb@nightclub@mini@dance@dance_solo@female@var_b@', 'low_center_down' } },
		{ name = 'Dance F2', anim = { 'anim@amb@nightclub@mini@dance@dance_solo@female@var_a@', 'high_center' } },
		{ name = 'Dance Silly 9', anim = { 'rcmnigel1bnmt_1b', 'dance_loop_tyler' } },
		{ name = 'Dance Silly 8', anim = { 'anim@mp_player_intcelebrationfemale@the_woogie', 'the_woogie' } },
		{ name = 'Dance 8', anim = { 'missfbi3_sniping', 'dance_m_default' } },
		{ name = 'Dance 2', anim = { 'anim@amb@nightclub@mini@dance@dance_solo@male@var_b@', 'high_center_down' } },
		{ name = 'Dance Shy', anim = { 'anim@amb@nightclub@mini@dance@dance_solo@male@var_a@', 'low_center' } },
		{ name = 'Dance F4', anim = { 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 'hi_dance_facedj_09_v2_female^1' } },
		{ name = 'Dance Silly 6', anim = { 'timetable@tracy@ig_8@idle_b', 'idle_d' } },
		{ name = 'Dance F3', anim = { 'anim@amb@nightclub@mini@dance@dance_solo@female@var_a@', 'high_center_up' } },
		{ name = 'Dance Silly 5', anim = { 'timetable@tracy@ig_5@idle_a', 'idle_a' } },
		{ name = 'Dance Silly 4', anim = { 'anim@amb@nightclub@lazlow@hi_podium@', 'danceidle_hi_11_buttwiggle_b_laz' } },
		{ name = 'Dance Silly 2', anim = { 'move_clown@p_m_zero_idles@', 'fidget_short_dance' } },
		{ name = 'Dance Silly 3', anim = { 'move_clown@p_m_two_idles@', 'fidget_short_dance' } },
		{ name = 'Dance Silly', anim = { 'special_ped@mountain_dancer@monologue_3@monologue_3a', 'mnt_dnc_buttwag' } },
		{ name = 'Dance 9', anim = { 'anim@amb@nightclub@mini@dance@dance_solo@female@var_a@', 'med_center_up' } },
		{ name = 'Dance 6', anim = { 'misschinese2_crystalmazemcs1_cs', 'dance_loop_tao' } },
		{ name = 'Dance 7', anim = { 'misschinese2_crystalmazemcs1_ig', 'dance_loop_tao' } },
		{ name = 'Dance 3', anim = { 'anim@amb@nightclub@mini@dance@dance_solo@male@var_a@', 'high_center' } },
		{ name = 'Dance F', anim = { 'anim@amb@nightclub@dancers@solomun_entourage@', 'mi_dance_facedj_17_v1_female^1' } },
		{ name = 'Dance Upper', anim = { 'anim@amb@nightclub@mini@dance@dance_solo@female@var_b@', 'high_center' } },
		{ name = 'Dance F6', anim = { 'anim@amb@nightclub@mini@dance@dance_solo@female@var_a@', 'high_center_up' } },
		{ name = 'Dance Upper 2', anim = { 'anim@amb@nightclub@mini@dance@dance_solo@female@var_b@', 'high_center_up' } },
		{ name = 'Dance Slow 4', anim = { 'anim@amb@nightclub@mini@dance@dance_solo@female@var_b@', 'low_center' } },
		{ name = 'Dance Slow 3', anim = { 'anim@amb@nightclub@mini@dance@dance_solo@female@var_a@', 'low_center_down' } },
		{ name = 'Dance Slow 2', anim = { 'anim@amb@nightclub@mini@dance@dance_solo@female@var_a@', 'low_center' } },

		{ name = "Ambiance - 1", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_06_base_male^4" } },
		{ name = "Ambiance - 2", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_12_v1_female_heel^1" } },
		{ name = "Ambiance - 3", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_06_base_male^6" } },
		{ name = "Ambiance - 4", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_06_base_male^5" } },
		{ name = "Ambiance - 5", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_06_base_male^3" } },
		{ name = "Ambiance - 6", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_06_base_male^2" } },
		{ name = "Ambiance - 7", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_06_base_male^1" } },
		{ name = "Ambiance - 8", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_12_v1_female_heel^6" } },
		{ name = "Ambiance - 9", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_12_v1_female_heel^5" } },
		{ name = "Ambiance - 10", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_12_v1_female_heel^4" } },
		{ name = "Ambiance - 11", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_12_v1_female_heel^3" } },
		{ name = "Ambiance - 12", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_12_v1_female_heel^2" } },
		{ name = "Ambiance - 13", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_13_v1_male^6" } },
		{ name = "Ambiance - 14", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_13_v1_male^5" } },
		{ name = "Ambiance - 15", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_13_v1_male^4" } },
		{ name = "Ambiance - 16", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_13_v1_male^3" } },
		{ name = "Ambiance - 17", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_13_v1_male^2" } },
		{ name = "Ambiance - 18", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_13_v1_male^1" } },
		{ name = "Ambiance - 19", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_10_v1_female^5" } },
		{ name = "Ambiance - 20", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_10_v1_female^4" } },
		{ name = "Ambiance - 21", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_10_v1_female^1" } },
		{ name = "Ambiance - 22", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_13_v1_female^6" } },
		{ name = "Ambiance - 23", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_13_v1_female^5" } },
		{ name = "Ambiance - 24", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_13_v1_female^4" } },
		{ name = "Ambiance - 25", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_13_v1_female^2" } },
		{ name = "Ambiance - 26", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_06_base_female_heel^6" } },
		{ name = "Ambiance - 27", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_06_base_female_heel^5" } },
		{ name = "Ambiance - 28", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_06_base_female_heel^4" } },
		{ name = "Ambiance - 29", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_06_base_female_heel^1" } },
		{ name = "Ambiance - 30", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_06_base_female_heel^3" } },
		{ name = "Ambiance - 31", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_06_base_female_heel^2" } },
		{ name = "Ambiance - 32", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_13_v1_female^3" } },
		{ name = "Ambiance - 33", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_13_v1_female^1" } },
		{ name = "Ambiance - 34", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_10_v1_female^3" } },
		{ name = "Ambiance - 35", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_10_v1_female^2" } },
		{ name = "Ambiance - 36", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_10_v1_female^6" } },
		{ name = "Ambiance - 37", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_11_v1_male^2" } },
		{ name = "Ambiance - 38", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_11_v1_male^1" } },
		{ name = "Ambiance - 39", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_13_v1_male^6" } },
		{ name = "Ambiance - 40", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_13_v1_male^5" } },
		{ name = "Ambiance - 41", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_13_v1_male^4" } },
		{ name = "Ambiance - 42", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_13_v1_male^3" } },
		{ name = "Ambiance - 43", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_13_v1_male^2" } },
		{ name = "Ambiance - 44", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_13_v1_male^1" } },
		{ name = "Ambiance - 45", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_09_v1_male^6" } },
		{ name = "Ambiance - 46", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_09_v1_male^5" } },
		{ name = "Ambiance - 47", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_09_v1_male^4" } },
		{ name = "Ambiance - 48", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_09_v1_male^3" } },
		{ name = "Ambiance - 49", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_09_v1_male^2" } },
		{ name = "Ambiance - 50", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_09_v1_male^1" } },
		{ name = "Ambiance - 51", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_11_v1_male^6" } },
		{ name = "Ambiance - 52", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_11_v1_male^5" } },
		{ name = "Ambiance - 53", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_11_v1_male^4" } },
		{ name = "Ambiance - 54", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_11_v1_male^3" } },
		{ name = "Ambiance - 55", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_12_v1_female_heel^6" } },
		{ name = "Ambiance - 56", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_12_v1_female_heel^5" } },
		{ name = "Ambiance - 57", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_12_v1_female_heel^4" } },
		{ name = "Ambiance - 58", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_12_v1_female_heel^3" } },
		{ name = "Ambiance - 59", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_06_base_female^6" } },
		{ name = "Ambiance - 60", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_06_base_female^5" } },
		{ name = "Ambiance - 61", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_06_base_female^4" } },
		{ name = "Ambiance - 62", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_06_base_female^3" } },
		{ name = "Ambiance - 63", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_06_base_female^2" } },
		{ name = "Ambiance - 64", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_12_v1_female_heel^1" } },
		{ name = "Ambiance - 65", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_06_base_male^6" } },
		{ name = "Ambiance - 66", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_06_base_male^5" } },
		{ name = "Ambiance - 67", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_06_base_male^4" } },
		{ name = "Ambiance - 68", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_13_v1_female_heel^6" } },
		{ name = "Ambiance - 69", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_12_v1_female_heel^2" } },
		{ name = "Ambiance - 70", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_06_base_male^3" } },
		{ name = "Ambiance - 71", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_06_base_male^2" } },
		{ name = "Ambiance - 72", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_06_base_male^1" } },
		{ name = "Ambiance - 73", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_10_v1_female_heel^3" } },
		{ name = "Ambiance - 74", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_10_v1_female_heel^2" } },
		{ name = "Ambiance - 75", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_10_v1_female_heel^1" } },
		{ name = "Ambiance - 76", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_13_v1_female_heel^5" } },
		{ name = "Ambiance - 77", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_13_v1_female_heel^4" } },
		{ name = "Ambiance - 78", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_13_v1_female_heel^3" } },
		{ name = "Ambiance - 79", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_13_v1_female_heel^2" } },
		{ name = "Ambiance - 80", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_13_v1_female_heel^1" } },
		{ name = "Ambiance - 81", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_11_v1_female^6" } },
		{ name = "Ambiance - 82", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_11_v1_female^5" } },
		{ name = "Ambiance - 83", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_11_v1_female^4" } },
		{ name = "Ambiance - 84", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_11_v1_female^3" } },
		{ name = "Ambiance - 85", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_11_v1_female^2" } },
		{ name = "Ambiance - 86", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_11_v1_female^1" } },
		{ name = "Ambiance - 87", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_10_v1_female_heel^6" } },
		{ name = "Ambiance - 88", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_10_v1_female_heel^5" } },
		{ name = "Ambiance - 89", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_10_v1_female_heel^4" } },
		{ name = "Ambiance - 90", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_09_v1_female^6" } },
		{ name = "Ambiance - 91", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_09_v1_female^5" } },
		{ name = "Ambiance - 92", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_11_v1_female_heel^2" } },
		{ name = "Ambiance - 93", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_11_v1_female_heel^1" } },
		{ name = "Ambiance - 94", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_11_v1_female_heel^4" } },
		{ name = "Ambiance - 95", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_12_v1_female^4" } },
		{ name = "Ambiance - 96", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_12_v1_female^3" } },
		{ name = "Ambiance - 97", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_12_v1_female^2" } },
		{ name = "Ambiance - 98", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_12_v1_female^1" } },
		{ name = "Ambiance - 99", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_09_v1_female^4" } },
		{ name = "Ambiance - 100", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_09_v1_female^3" } },
		{ name = "Ambiance - 101", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_09_v1_female^2" } },
		{ name = "Ambiance - 102", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_09_v1_female^1" } },
		{ name = "Ambiance - 103", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_11_v1_female_heel^6" } },
		{ name = "Ambiance - 104", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_11_v1_female_heel^5" } },
		{ name = "Ambiance - 105", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_12_v1_female^6" } },
		{ name = "Ambiance - 106", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_12_v1_female^5" } },
		{ name = "Ambiance - 107", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_11_v1_female_heel^3" } },
		{ name = "Ambiance - 108", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_10_v1_female^6" } },
		{ name = "Ambiance - 109", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_10_v1_female^5" } },
		{ name = "Ambiance - 110", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_10_v1_female^4" } },
		{ name = "Ambiance - 111", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_10_v1_female^3" } },
		{ name = "Ambiance - 112", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_10_v1_female^2" } },
		{ name = "Ambiance - 113", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_10_v1_female^1" } },
		{ name = "Ambiance - 114", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_06_base_female^1" } },
		{ name = "Ambiance - 115", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_12_v1_male^1" } },
		{ name = "Ambiance - 116", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_09_v1_female_heel^6" } },
		{ name = "Ambiance - 117", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_09_v1_female_heel^5" } },
		{ name = "Ambiance - 118", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_09_v1_female_heel^4" } },
		{ name = "Ambiance - 119", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_09_v1_female_heel^3" } },
		{ name = "Ambiance - 120", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_09_v1_female_heel^2" } },
		{ name = "Ambiance - 121", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_09_v1_female_heel^1" } },
		{ name = "Ambiance - 122", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_12_v1_male^6" } },
		{ name = "Ambiance - 123", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_12_v1_male^5" } },
		{ name = "Ambiance - 124", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_12_v1_male^4" } },
		{ name = "Ambiance - 125", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_12_v1_male^3" } },
		{ name = "Ambiance - 126", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_12_v1_male^2" } },
		{ name = "Ambiance - 127", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_12_v1_female^2" } },
		{ name = "Ambiance - 128", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_12_v1_female^1" } },
		{ name = "Ambiance - 129", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_06_base_female_heel^6" } },
		{ name = "Ambiance - 130", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_06_base_female_heel^5" } },
		{ name = "Ambiance - 131", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_06_base_female_heel^4" } },
		{ name = "Ambiance - 132", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_13_v1_female^6" } },
		{ name = "Ambiance - 133", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_12_v1_female^3" } },
		{ name = "Ambiance - 134", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_06_base_female_heel^3" } },
		{ name = "Ambiance - 135", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_06_base_female_heel^2" } },
		{ name = "Ambiance - 136", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_06_base_female_heel^1" } },
		{ name = "Ambiance - 137", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_13_v1_female^1" } },
		{ name = "Ambiance - 138", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_10_v1_female_heel^6" } },
		{ name = "Ambiance - 139", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_10_v1_female_heel^1" } },
		{ name = "Ambiance - 140", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_12_v1_female^6" } },
		{ name = "Ambiance - 141", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_12_v1_female^5" } },
		{ name = "Ambiance - 142", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_12_v1_female^4" } },
		{ name = "Ambiance - 143", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_13_v1_female^5" } },
		{ name = "Ambiance - 144", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_13_v1_female^4" } },
		{ name = "Ambiance - 145", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_13_v1_female^3" } },
		{ name = "Ambiance - 146", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_13_v1_female^2" } },
		{ name = "Ambiance - 147", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_10_v1_female_heel^5" } },
		{ name = "Ambiance - 148", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_10_v1_female_heel^4" } },
		{ name = "Ambiance - 149", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_10_v1_female_heel^3" } },
		{ name = "Ambiance - 150", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_10_v1_female_heel^2" } },
		{ name = "Ambiance - 151", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_13_v1_female_heel^6" } },
		{ name = "Ambiance - 152", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_13_v1_female_heel^5" } },
		{ name = "Ambiance - 153", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "trans_li-mi_to_mi-hi_09_v1_female_heel^6" } },
		{ name = "Ambiance - 154", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "trans_li-mi_to_mi-hi_09_v1_female_heel^5" } },
		{ name = "Ambiance - 155", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "trans_li-mi_to_mi-hi_09_v1_female_heel^4" } },
		{ name = "Ambiance - 156", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "trans_li-mi_to_mi-hi_09_v1_female_heel^3" } },
		{ name = "Ambiance - 157", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "trans_li-mi_to_mi-hi_09_v1_female_heel^2" } },
		{ name = "Ambiance - 158", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "trans_li-mi_to_mi-hi_09_v1_female_heel^1" } },
		{ name = "Ambiance - 159", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_10_v1_male^6" } },
		{ name = "Ambiance - 160", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_10_v1_male^2" } },
		{ name = "Ambiance - 161", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_10_v1_male^5" } },
		{ name = "Ambiance - 162", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_10_v1_male^4" } },
		{ name = "Ambiance - 163", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_10_v1_male^3" } },
		{ name = "Ambiance - 164", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_10_v1_male^1" } },
		{ name = "Ambiance - 165", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "trans_li-mi_to_mi-hi_09_v1_female^6" } },
		{ name = "Ambiance - 166", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "trans_li-mi_to_mi-hi_09_v1_female^5" } },
		{ name = "Ambiance - 167", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_09_v1_female_heel^2" } },
		{ name = "Ambiance - 168", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_09_v1_female_heel^6" } },
		{ name = "Ambiance - 169", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_09_v1_female_heel^5" } },
		{ name = "Ambiance - 170", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_09_v1_female_heel^4" } },
		{ name = "Ambiance - 171", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_09_v1_female_heel^3" } },
		{ name = "Ambiance - 172", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_09_v1_female_heel^1" } },
		{ name = "Ambiance - 173", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_12_v1_male^4" } },
		{ name = "Ambiance - 174", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_12_v1_male^3" } },
		{ name = "Ambiance - 175", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_12_v1_male^1" } },
		{ name = "Ambiance - 176", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "trans_mi-hi_to_li-mi_09_v1_male^6" } },
		{ name = "Ambiance - 177", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "trans_mi-hi_to_li-mi_09_v1_male^5" } },
		{ name = "Ambiance - 178", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "trans_mi-hi_to_li-mi_09_v1_male^4" } },
		{ name = "Ambiance - 179", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "trans_mi-hi_to_li-mi_09_v1_male^3" } },
		{ name = "Ambiance - 180", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "trans_mi-hi_to_li-mi_09_v1_male^2" } },
		{ name = "Ambiance - 181", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "trans_mi-hi_to_li-mi_09_v1_male^1" } },
		{ name = "Ambiance - 182", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "trans_mi-hi_to_li-mi_09_v1_female_heel^3" } },
		{ name = "Ambiance - 183", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "trans_mi-hi_to_li-mi_09_v1_female_heel^2" } },
		{ name = "Ambiance - 184", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "trans_mi-hi_to_li-mi_09_v1_female_heel^1" } },
		{ name = "Ambiance - 185", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_12_v1_male^6" } },
		{ name = "Ambiance - 186", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_12_v1_male^5" } },
		{ name = "Ambiance - 187", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_12_v1_male^2" } },
		{ name = "Ambiance - 188", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "trans_mi-hi_to_li-mi_09_v1_female_heel^6" } },
		{ name = "Ambiance - 189", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "trans_mi-hi_to_li-mi_09_v1_female_heel^5" } },
		{ name = "Ambiance - 190", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "trans_mi-hi_to_li-mi_09_v1_female_heel^4" } },
		{ name = "Ambiance - 191", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "trans_mi-hi_to_li-mi_09_v1_female^4" } },
		{ name = "Ambiance - 192", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "trans_mi-hi_to_li-mi_09_v1_female^3" } },
		{ name = "Ambiance - 193", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "trans_mi-hi_to_li-mi_09_v1_female^2" } },
		{ name = "Ambiance - 194", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "trans_mi-hi_to_li-mi_09_v1_female^1" } },
		{ name = "Ambiance - 195", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_11_v1_male^2" } },
		{ name = "Ambiance - 196", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_11_v1_male^1" } },
		{ name = "Ambiance - 197", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_11_v1_male^5" } },
		{ name = "Ambiance - 198", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_11_v1_male^4" } },
		{ name = "Ambiance - 199", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_11_v1_male^3" } },
		{ name = "Ambiance - 200", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_11_v1_male^6" } },
		{ name = "Ambiance - 201", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_10_v1_male^6" } },
		{ name = "Ambiance - 202", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_10_v1_male^5" } },
		{ name = "Ambiance - 203", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_10_v1_male^3" } },
		{ name = "Ambiance - 204", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_10_v1_male^4" } },
		{ name = "Ambiance - 205", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_10_v1_male^2" } },
		{ name = "Ambiance - 206", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_10_v1_male^1" } },
		{ name = "Ambiance - 207", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_11_v1_female^6" } },
		{ name = "Ambiance - 208", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_11_v1_female^5" } },
		{ name = "Ambiance - 209", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_11_v1_female^4" } },
		{ name = "Ambiance - 210", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_11_v1_female^3" } },
		{ name = "Ambiance - 211", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_11_v1_female^2" } },
		{ name = "Ambiance - 212", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_11_v1_female^1" } },
		{ name = "Ambiance - 213", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_11_v1_female_heel^6" } },
		{ name = "Ambiance - 214", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_11_v1_female_heel^5" } },
		{ name = "Ambiance - 215", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_11_v1_female_heel^4" } },
		{ name = "Ambiance - 216", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_11_v1_female_heel^3" } },
		{ name = "Ambiance - 217", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_11_v1_female_heel^2" } },
		{ name = "Ambiance - 218", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_11_v1_female_heel^1" } },
		{ name = "Ambiance - 219", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_13_v1_female_heel^4" } },
		{ name = "Ambiance - 220", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_13_v1_female_heel^2" } },
		{ name = "Ambiance - 221", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_13_v1_female_heel^1" } },
		{ name = "Ambiance - 222", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_09_v1_male^3" } },
		{ name = "Ambiance - 223", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_09_v1_male^2" } },
		{ name = "Ambiance - 224", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_09_v1_male^1" } },
		{ name = "Ambiance - 225", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_13_v1_female_heel^3" } },
		{ name = "Ambiance - 226", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "trans_li-mi_to_mi-hi_09_v1_female^2" } },
		{ name = "Ambiance - 227", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "trans_li-mi_to_mi-hi_09_v1_female^1" } },
		{ name = "Ambiance - 228", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_09_v1_female^6" } },
		{ name = "Ambiance - 229", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_09_v1_female^5" } },
		{ name = "Ambiance - 230", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_09_v1_female^4" } },
		{ name = "Ambiance - 231", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "trans_li-mi_to_mi-hi_09_v1_male^5" } },
		{ name = "Ambiance - 232", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "trans_li-mi_to_mi-hi_09_v1_male^4" } },
		{ name = "Ambiance - 233", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "trans_li-mi_to_mi-hi_09_v1_male^3" } },
		{ name = "Ambiance - 234", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "trans_li-mi_to_mi-hi_09_v1_male^2" } },
		{ name = "Ambiance - 235", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "trans_li-mi_to_mi-hi_09_v1_male^1" } },
		{ name = "Ambiance - 236", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "trans_li-mi_to_mi-hi_09_v1_female^4" } },
		{ name = "Ambiance - 237", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "trans_li-mi_to_mi-hi_09_v1_female^3" } },
		{ name = "Ambiance - 238", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_06_base_female^6" } },
		{ name = "Ambiance - 239", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_06_base_female^5" } },
		{ name = "Ambiance - 240", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_06_base_female^4" } },
		{ name = "Ambiance - 241", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_06_base_female^3" } },
		{ name = "Ambiance - 242", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_06_base_female^2" } },
		{ name = "Ambiance - 243", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_06_base_female^1" } },
		{ name = "Ambiance - 244", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_09_v1_female^3" } },
		{ name = "Ambiance - 245", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_09_v1_female^2" } },
		{ name = "Ambiance - 246", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "mi-hi_amb_club_09_v1_female^1" } },
		{ name = "Ambiance - 247", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_09_v1_male^6" } },
		{ name = "Ambiance - 248", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_09_v1_male^5" } },
		{ name = "Ambiance - 249", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "li-mi_amb_club_09_v1_male^4" } },
		{ name = "Ambiance - 250", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "trans_li-mi_to_mi-hi_09_v1_male^6" } },
		{ name = "Ambiance - 251", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "trans_mi-hi_to_li-mi_09_v1_female^6" } },
		{ name = "Ambiance - 252", anim = { "anim@amb@nightclub_island@dancers@club_ambientpeds@", "trans_mi-hi_to_li-mi_09_v1_female^5" } },

		{ name = "Bapho-Casino - 1", anim = { "anim@amb@nightclub_island@dancers@club@", "ti_idle_c_f03" } },
		{ name = "Bapho-Casino - 2", anim = { "anim@amb@nightclub_island@dancers@club@", "ti_idle_c_f02" } },
		{ name = "Bapho-Casino - 3", anim = { "anim@amb@nightclub_island@dancers@club@", "ti_idle_c_f01" } },
		{ name = "Bapho-Casino - 4", anim = { "anim@amb@nightclub_island@dancers@club@", "ti_to_hi_f02" } },
		{ name = "Bapho-Casino - 5", anim = { "anim@amb@nightclub_island@dancers@club@", "ti_to_hi_f01" } },
		{ name = "Bapho-Casino - 6", anim = { "anim@amb@nightclub_island@dancers@club@", "li_idle_a_f03" } },
		{ name = "Bapho-Casino - 7", anim = { "anim@amb@nightclub_island@dancers@club@", "li_idle_a_f02" } },
		{ name = "Bapho-Casino - 8", anim = { "anim@amb@nightclub_island@dancers@club@", "li_idle_a_f01" } },
		{ name = "Bapho-Casino - 9", anim = { "anim@amb@nightclub_island@dancers@club@", "ti_to_hi_f03" } },
		{ name = "Bapho-Casino - 10", anim = { "anim@amb@nightclub_island@dancers@club@", "li_idle_f_f02" } },
		{ name = "Bapho-Casino - 11", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_to_li_m03" } },
		{ name = "Bapho-Casino - 12", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_to_li_m02" } },
		{ name = "Bapho-Casino - 13", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_idle_c_m01" } },
		{ name = "Bapho-Casino - 14", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_idle_d_m03" } },
		{ name = "Bapho-Casino - 15", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_idle_d_m02" } },
		{ name = "Bapho-Casino - 16", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_idle_d_m01" } },
		{ name = "Bapho-Casino - 17", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_idle_c_m03" } },
		{ name = "Bapho-Casino - 18", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_idle_c_m02" } },
		{ name = "Bapho-Casino - 19", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_idle_c_m03" } },
		{ name = "Bapho-Casino - 20", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_idle_c_m02" } },
		{ name = "Bapho-Casino - 21", anim = { "anim@amb@nightclub_island@dancers@club@", "li_to_mi_m03" } },
		{ name = "Bapho-Casino - 22", anim = { "anim@amb@nightclub_island@dancers@club@", "li_to_mi_m02" } },
		{ name = "Bapho-Casino - 23", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_to_li_m01" } },
		{ name = "Bapho-Casino - 24", anim = { "anim@amb@nightclub_island@dancers@club@", "li_idle_a_f04" } },
		{ name = "Bapho-Casino - 25", anim = { "anim@amb@nightclub_island@dancers@club@", "li_to_mi_m01" } },
		{ name = "Bapho-Casino - 26", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_idle_e_f02" } },
		{ name = "Bapho-Casino - 27", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_idle_c_m01" } },
		{ name = "Bapho-Casino - 28", anim = { "anim@amb@nightclub_island@dancers@club@", "ti_idle_a_m02" } },
		{ name = "Bapho-Casino - 29", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_loop_m02" } },
		{ name = "Bapho-Casino - 30", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_loop_m01" } },
		{ name = "Bapho-Casino - 31", anim = { "anim@amb@nightclub_island@dancers@club@", "ti_idle_a_m03" } },
		{ name = "Bapho-Casino - 32", anim = { "anim@amb@nightclub_island@dancers@club@", "ti_idle_a_m01" } },
		{ name = "Bapho-Casino - 33", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_loop_m03" } },
		{ name = "Bapho-Casino - 34", anim = { "anim@amb@nightclub_island@dancers@club@", "ti_loop_m03" } },
		{ name = "Bapho-Casino - 35", anim = { "anim@amb@nightclub_island@dancers@club@", "ti_loop_m02" } },
		{ name = "Bapho-Casino - 36", anim = { "anim@amb@nightclub_island@dancers@club@", "ti_loop_m01" } },
		{ name = "Bapho-Casino - 37", anim = { "anim@amb@nightclub_island@dancers@club@", "ti_idle_b_m03" } },
		{ name = "Bapho-Casino - 38", anim = { "anim@amb@nightclub_island@dancers@club@", "ti_idle_b_m02" } },
		{ name = "Bapho-Casino - 39", anim = { "anim@amb@nightclub_island@dancers@club@", "ti_idle_b_m01" } },
		{ name = "Bapho-Casino - 40", anim = { "anim@amb@nightclub_island@dancers@club@", "ti_to_li_m03" } },
		{ name = "Bapho-Casino - 41", anim = { "anim@amb@nightclub_island@dancers@club@", "ti_to_li_m02" } },
		{ name = "Bapho-Casino - 42", anim = { "anim@amb@nightclub_island@dancers@club@", "ti_to_li_m01" } },
		{ name = "Bapho-Casino - 43", anim = { "anim@amb@nightclub_island@dancers@club@", "li_to_ti_f03" } },
		{ name = "Bapho-Casino - 44", anim = { "anim@amb@nightclub_island@dancers@club@", "li_to_ti_f02" } },
		{ name = "Bapho-Casino - 45", anim = { "anim@amb@nightclub_island@dancers@club@", "li_to_ti_f01" } },
		{ name = "Bapho-Casino - 46", anim = { "anim@amb@nightclub_island@dancers@club@", "li_idle_e_f02" } },
		{ name = "Bapho-Casino - 47", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_idle_a_f01" } },
		{ name = "Bapho-Casino - 48", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_idle_b_m03" } },
		{ name = "Bapho-Casino - 49", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_idle_b_m02" } },
		{ name = "Bapho-Casino - 50", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_idle_b_m01" } },
		{ name = "Bapho-Casino - 51", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_idle_a_f04" } },
		{ name = "Bapho-Casino - 52", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_idle_a_f03" } },
		{ name = "Bapho-Casino - 53", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_idle_a_f02" } },
		{ name = "Bapho-Casino - 54", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_loop_m03" } },
		{ name = "Bapho-Casino - 55", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_to_hi_f03" } },
		{ name = "Bapho-Casino - 56", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_to_hi_f02" } },
		{ name = "Bapho-Casino - 57", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_to_hi_f01" } },
		{ name = "Bapho-Casino - 58", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_loop_m02" } },
		{ name = "Bapho-Casino - 59", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_loop_m01" } },
		{ name = "Bapho-Casino - 60", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_to_ti_m02" } },
		{ name = "Bapho-Casino - 61", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_to_ti_m01" } },
		{ name = "Bapho-Casino - 62", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_idle_d_f02" } },
		{ name = "Bapho-Casino - 63", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_idle_b_f04" } },
		{ name = "Bapho-Casino - 64", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_idle_b_f03" } },
		{ name = "Bapho-Casino - 65", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_idle_b_f02" } },
		{ name = "Bapho-Casino - 66", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_idle_b_f01" } },
		{ name = "Bapho-Casino - 67", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_to_ti_m03" } },
		{ name = "Bapho-Casino - 68", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_idle_d_f03" } },
		{ name = "Bapho-Casino - 69", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_idle_d_f01" } },
		{ name = "Bapho-Casino - 70", anim = { "anim@amb@nightclub_island@dancers@club@", "li_idle_b_f04" } },
		{ name = "Bapho-Casino - 71", anim = { "anim@amb@nightclub_island@dancers@club@", "li_idle_b_f03" } },
		{ name = "Bapho-Casino - 72", anim = { "anim@amb@nightclub_island@dancers@club@", "li_idle_b_f02" } },
		{ name = "Bapho-Casino - 73", anim = { "anim@amb@nightclub_island@dancers@club@", "li_idle_b_f01" } },
		{ name = "Bapho-Casino - 74", anim = { "anim@amb@nightclub_island@dancers@club@", "li_idle_c_f01" } },
		{ name = "Bapho-Casino - 75", anim = { "anim@amb@nightclub_island@dancers@club@", "ti_idle_b_f02" } },
		{ name = "Bapho-Casino - 76", anim = { "anim@amb@nightclub_island@dancers@club@", "ti_idle_b_f01" } },
		{ name = "Bapho-Casino - 77", anim = { "anim@amb@nightclub_island@dancers@club@", "li_idle_c_f04" } },
		{ name = "Bapho-Casino - 78", anim = { "anim@amb@nightclub_island@dancers@club@", "ti_idle_b_f03" } },
		{ name = "Bapho-Casino - 79", anim = { "anim@amb@nightclub_island@dancers@club@", "li_idle_c_f03" } },
		{ name = "Bapho-Casino - 80", anim = { "anim@amb@nightclub_island@dancers@club@", "li_idle_c_f02" } },
		{ name = "Bapho-Casino - 81", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_idle_d_f04" } },
		{ name = "Bapho-Casino - 82", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_idle_d_f02" } },
		{ name = "Bapho-Casino - 83", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_loop_f03" } },
		{ name = "Bapho-Casino - 84", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_loop_f02" } },
		{ name = "Bapho-Casino - 85", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_loop_f01" } },
		{ name = "Bapho-Casino - 86", anim = { "anim@amb@nightclub_island@dancers@club@", "ti_to_mi_f01" } },
		{ name = "Bapho-Casino - 87", anim = { "anim@amb@nightclub_island@dancers@club@", "ti_to_mi_f03" } },
		{ name = "Bapho-Casino - 88", anim = { "anim@amb@nightclub_island@dancers@club@", "ti_to_mi_f02" } },
		{ name = "Bapho-Casino - 89", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_idle_b_m01" } },
		{ name = "Bapho-Casino - 90", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_to_ti_f03" } },
		{ name = "Bapho-Casino - 91", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_to_ti_f01" } },
		{ name = "Bapho-Casino - 92", anim = { "anim@amb@nightclub_island@dancers@club@", "li_loop_m03" } },
		{ name = "Bapho-Casino - 93", anim = { "anim@amb@nightclub_island@dancers@club@", "li_loop_m02" } },
		{ name = "Bapho-Casino - 94", anim = { "anim@amb@nightclub_island@dancers@club@", "li_loop_m01" } },
		{ name = "Bapho-Casino - 95", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_to_ti_f02" } },
		{ name = "Bapho-Casino - 96", anim = { "anim@amb@nightclub_island@dancers@club@", "li_loop_f04" } },
		{ name = "Bapho-Casino - 97", anim = { "anim@amb@nightclub_island@dancers@club@", "li_loop_f03" } },
		{ name = "Bapho-Casino - 98", anim = { "anim@amb@nightclub_island@dancers@club@", "li_loop_f02" } },
		{ name = "Bapho-Casino - 99", anim = { "anim@amb@nightclub_island@dancers@club@", "li_loop_f01" } },
		{ name = "Bapho-Casino - 100", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_to_li_f03" } },
		{ name = "Bapho-Casino - 101", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_to_li_f02" } },
		{ name = "Bapho-Casino - 102", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_to_li_f01" } },
		{ name = "Bapho-Casino - 103", anim = { "anim@amb@nightclub_island@dancers@club@", "ti_to_li_f03" } },
		{ name = "Bapho-Casino - 104", anim = { "anim@amb@nightclub_island@dancers@club@", "ti_to_li_f02" } },
		{ name = "Bapho-Casino - 105", anim = { "anim@amb@nightclub_island@dancers@club@", "ti_to_li_f01" } },
		{ name = "Bapho-Casino - 106", anim = { "anim@amb@nightclub_island@dancers@club@", "li_idle_d_f02" } },
		{ name = "Bapho-Casino - 107", anim = { "anim@amb@nightclub_island@dancers@club@", "ti_to_hi_m03" } },
		{ name = "Bapho-Casino - 108", anim = { "anim@amb@nightclub_island@dancers@club@", "ti_to_hi_m02" } },
		{ name = "Bapho-Casino - 109", anim = { "anim@amb@nightclub_island@dancers@club@", "ti_to_hi_m01" } },
		{ name = "Bapho-Casino - 110", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_idle_b_m03" } },
		{ name = "Bapho-Casino - 111", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_idle_b_m02" } },
		{ name = "Bapho-Casino - 112", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_to_hi_m02" } },
		{ name = "Bapho-Casino - 113", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_to_hi_m01" } },
		{ name = "Bapho-Casino - 114", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_idle_b_f03" } },
		{ name = "Bapho-Casino - 115", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_to_hi_m03" } },
		{ name = "Bapho-Casino - 116", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_idle_b_f02" } },
		{ name = "Bapho-Casino - 117", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_idle_b_f01" } },
		{ name = "Bapho-Casino - 118", anim = { "anim@amb@nightclub_island@dancers@club@", "li_to_hi_m03" } },
		{ name = "Bapho-Casino - 119", anim = { "anim@amb@nightclub_island@dancers@club@", "li_to_hi_m02" } },
		{ name = "Bapho-Casino - 120", anim = { "anim@amb@nightclub_island@dancers@club@", "li_to_hi_m01" } },
		{ name = "Bapho-Casino - 121", anim = { "anim@amb@nightclub_island@dancers@club@", "li_to_mi_f04" } },
		{ name = "Bapho-Casino - 122", anim = { "anim@amb@nightclub_island@dancers@club@", "li_to_mi_f03" } },
		{ name = "Bapho-Casino - 123", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_to_mi_f02" } },
		{ name = "Bapho-Casino - 124", anim = { "anim@amb@nightclub_island@dancers@club@", "ti_idle_d_f02" } },
		{ name = "Bapho-Casino - 125", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_idle_f_f02" } },
		{ name = "Bapho-Casino - 126", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_to_mi_f03" } },
		{ name = "Bapho-Casino - 127", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_to_mi_f01" } },
		{ name = "Bapho-Casino - 128", anim = { "anim@amb@nightclub_island@dancers@club@", "li_to_mi_f02" } },
		{ name = "Bapho-Casino - 129", anim = { "anim@amb@nightclub_island@dancers@club@", "li_to_mi_f01" } },
		{ name = "Bapho-Casino - 130", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_idle_a_m03" } },
		{ name = "Bapho-Casino - 131", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_idle_a_m02" } },
		{ name = "Bapho-Casino - 132", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_idle_a_m03" } },
		{ name = "Bapho-Casino - 133", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_idle_a_m02" } },
		{ name = "Bapho-Casino - 134", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_idle_a_m01" } },
		{ name = "Bapho-Casino - 135", anim = { "anim@amb@nightclub_island@dancers@club@", "li_to_ti_m02" } },
		{ name = "Bapho-Casino - 136", anim = { "anim@amb@nightclub_island@dancers@club@", "li_to_ti_m01" } },
		{ name = "Bapho-Casino - 137", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_idle_c_f04" } },
		{ name = "Bapho-Casino - 138", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_idle_c_f03" } },
		{ name = "Bapho-Casino - 139", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_idle_c_f02" } },
		{ name = "Bapho-Casino - 140", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_idle_c_f01" } },
		{ name = "Bapho-Casino - 141", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_to_mi_m01" } },
		{ name = "Bapho-Casino - 142", anim = { "anim@amb@nightclub_island@dancers@club@", "li_idle_c_m02" } },
		{ name = "Bapho-Casino - 143", anim = { "anim@amb@nightclub_island@dancers@club@", "li_idle_c_m01" } },
		{ name = "Bapho-Casino - 144", anim = { "anim@amb@nightclub_island@dancers@club@", "li_idle_d_f03" } },
		{ name = "Bapho-Casino - 145", anim = { "anim@amb@nightclub_island@dancers@club@", "li_to_ti_m03" } },
		{ name = "Bapho-Casino - 146", anim = { "anim@amb@nightclub_island@dancers@club@", "li_idle_a_m03" } },
		{ name = "Bapho-Casino - 147", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_to_mi_m03" } },
		{ name = "Bapho-Casino - 148", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_to_mi_m02" } },
		{ name = "Bapho-Casino - 149", anim = { "anim@amb@nightclub_island@dancers@club@", "li_idle_c_m03" } },
		{ name = "Bapho-Casino - 150", anim = { "anim@amb@nightclub_island@dancers@club@", "li_idle_a_m02" } },
		{ name = "Bapho-Casino - 151", anim = { "anim@amb@nightclub_island@dancers@club@", "li_idle_a_m01" } },
		{ name = "Bapho-Casino - 152", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_to_li_m03" } },
		{ name = "Bapho-Casino - 153", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_to_li_m02" } },
		{ name = "Bapho-Casino - 154", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_to_li_m01" } },
		{ name = "Bapho-Casino - 155", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_idle_a_f03" } },
		{ name = "Bapho-Casino - 156", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_idle_a_f02" } },
		{ name = "Bapho-Casino - 157", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_idle_a_f01" } },
		{ name = "Bapho-Casino - 158", anim = { "anim@amb@nightclub_island@dancers@club@", "ti_to_mi_m03" } },
		{ name = "Bapho-Casino - 159", anim = { "anim@amb@nightclub_island@dancers@club@", "ti_to_mi_m02" } },
		{ name = "Bapho-Casino - 160", anim = { "anim@amb@nightclub_island@dancers@club@", "ti_to_mi_m01" } },
		{ name = "Bapho-Casino - 161", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_to_si_f01" } },
		{ name = "Bapho-Casino - 162", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_idle_e_f02" } },
		{ name = "Bapho-Casino - 163", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_to_ti_m03" } },
		{ name = "Bapho-Casino - 164", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_to_ti_m02" } },
		{ name = "Bapho-Casino - 165", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_to_ti_m01" } },
		{ name = "Bapho-Casino - 166", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_to_li_f04" } },
		{ name = "Bapho-Casino - 167", anim = { "anim@amb@nightclub_island@dancers@club@", "ti_idle_c_m03" } },
		{ name = "Bapho-Casino - 168", anim = { "anim@amb@nightclub_island@dancers@club@", "ti_idle_c_m02" } },
		{ name = "Bapho-Casino - 169", anim = { "anim@amb@nightclub_island@dancers@club@", "ti_idle_c_m01" } },
		{ name = "Bapho-Casino - 170", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_to_li_f03" } },
		{ name = "Bapho-Casino - 171", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_to_li_f02" } },
		{ name = "Bapho-Casino - 172", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_idle_f_f02" } },
		{ name = "Bapho-Casino - 173", anim = { "anim@amb@nightclub_island@dancers@club@", "li_idle_b_m03" } },
		{ name = "Bapho-Casino - 174", anim = { "anim@amb@nightclub_island@dancers@club@", "li_idle_b_m02" } },
		{ name = "Bapho-Casino - 175", anim = { "anim@amb@nightclub_island@dancers@club@", "li_idle_b_m01" } },
		{ name = "Bapho-Casino - 176", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_to_li_f01" } },
		{ name = "Bapho-Casino - 177", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_idle_c_f03" } },
		{ name = "Bapho-Casino - 178", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_idle_c_f02" } },
		{ name = "Bapho-Casino - 179", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_idle_c_f01" } },
		{ name = "Bapho-Casino - 180", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_to_ti_f03" } },
		{ name = "Bapho-Casino - 181", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_to_ti_f02" } },
		{ name = "Bapho-Casino - 182", anim = { "anim@amb@nightclub_island@dancers@club@", "ti_loop_f02" } },
		{ name = "Bapho-Casino - 183", anim = { "anim@amb@nightclub_island@dancers@club@", "ti_loop_f01" } },
		{ name = "Bapho-Casino - 184", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_to_ti_f01" } },
		{ name = "Bapho-Casino - 185", anim = { "anim@amb@nightclub_island@dancers@club@", "ti_loop_f03" } },
		{ name = "Bapho-Casino - 186", anim = { "anim@amb@nightclub_island@dancers@club@", "li_to_hi_f01" } },
		{ name = "Bapho-Casino - 187", anim = { "anim@amb@nightclub_island@dancers@club@", "li_to_hi_f03" } },
		{ name = "Bapho-Casino - 188", anim = { "anim@amb@nightclub_island@dancers@club@", "li_to_hi_f02" } },
		{ name = "Bapho-Casino - 189", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_loop_f04" } },
		{ name = "Bapho-Casino - 190", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_loop_f03" } },
		{ name = "Bapho-Casino - 191", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_loop_f02" } },
		{ name = "Bapho-Casino - 192", anim = { "anim@amb@nightclub_island@dancers@club@", "mi_loop_f01" } },
		{ name = "Bapho-Casino - 193", anim = { "anim@amb@nightclub_island@dancers@club@", "ti_idle_e_f02" } },
		{ name = "Bapho-Casino - 194", anim = { "anim@amb@nightclub_island@dancers@club@", "hi_idle_a_m01" } },
		{ name = "Bapho-Casino - 195", anim = { "anim@amb@nightclub_island@dancers@club@", "ti_idle_a_f03" } },
		{ name = "Bapho-Casino - 196", anim = { "anim@amb@nightclub_island@dancers@club@", "ti_idle_a_f02" } },
		{ name = "Bapho-Casino - 197", anim = { "anim@amb@nightclub_island@dancers@club@", "ti_idle_a_f01" } },

		{ name = "Danser stylé", anim = { "missfbi3_sniping", "dance_m_default" } },
		{ name = "Danse banale", anim = { "rcmnigel1bnmt_1b", "dance_loop_tyler" } },
		{ name = "Danse spéciale 01", anim = { "timetable@tracy@ig_5@idle_a", "idle_a" } },
		{ name = "Danse spéciale 02", anim = { "timetable@tracy@ig_5@idle_a", "idle_b" } },
		{ name = "Danse spéciale 03", anim = { "timetable@tracy@ig_5@idle_b", "idle_e" } },
		{ name = "Danse spéciale 04", anim = { "timetable@tracy@ig_5@idle_b", "idle_d" } },
		{ name = "Danse de pecno ", anim = { "special_ped@mountain_dancer@monologue_3@monologue_3a", "mnt_dnc_buttwag" } },
		{ name = "Danse basique", anim = { "anim@amb@nightclub@lazlow@hi_podium@", "danceidle_hi_06_base_laz" } },
		{ name = "Danse turnaround", anim = { "anim@amb@nightclub@lazlow@hi_podium@", "danceidle_hi_11_turnaround_laz" } },
		{ name = "Danse crotchgrab", anim = { "anim@amb@nightclub@lazlow@hi_podium@", "danceidle_hi_13_crotchgrab_laz" } },
		{ name = "Danse flying", anim = { "anim@amb@nightclub@lazlow@hi_podium@", "danceidle_hi_13_flyingv_laz" } },
		{ name = "Danse robot", anim = { "anim@amb@nightclub@lazlow@hi_podium@", "danceidle_mi_15_robot_laz" } },
		{ name = "Danse shimmy", anim = { "anim@amb@nightclub@lazlow@hi_podium@", "danceidle_mi_15_shimmy_laz" } },
		{ name = "Danse crazyrobot", anim = { "anim@amb@nightclub@lazlow@hi_podium@", "danceidle_hi_15_crazyrobot_laz" }, },
		{ name = "Danse smack", anim = { "anim@amb@nightclub@lazlow@hi_podium@", "danceidle_hi_17_smackthat_laz" } },
		{ name = "Danse spider", anim = { "anim@amb@nightclub@lazlow@hi_podium@", "danceidle_hi_17_spiderman_laz" } },
		{ name = "Danse hipswivel", anim = { "anim@amb@nightclub@lazlow@hi_podium@", "danceidle_li_13_hipswivel_laz" } },
		{ name = "Danse Grind", anim = { "anim@amb@nightclub@lazlow@hi_podium@", "danceidle_li_15_sexygrind_laz" } },
		{ name = "Danse point", anim = { "anim@amb@nightclub@lazlow@hi_podium@", "danceidle_mi_11_pointthrust_laz" } },
		{ name = "Danse miturn", anim = { "anim@amb@nightclub@lazlow@hi_podium@", "danceidle_mi_13_turnaround_laz" } },
		{ name = "Danse du ventre", anim = { "mini@strip_club@private_dance@idle", "priv_dance_idle" } },
		{ name = "Dance Salsa Roll", anim = { "anim@mp_player_intcelebrationmale@salsa_roll", "salsa_roll" } },
		{ name = "Danse de soirée 1", anim = { "anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v1_male^4" } },
		{ name = "Danse de soirée 2", anim = { "anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v2_female^1" } },
		{ name = "Danse de soirée 3", anim = { "anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v2_female^2" } },
		{ name = "Danse de soirée 4", anim = { "anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v2_male^2" } },
		{ name = "Danse de soirée 5", anim = { "anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v2_male^2" } },
		{ name = "Danse de soirée 6", anim = { "anim@amb@nightclub@dancers@crowddance_groups@", "hi_dance_crowd_09_v1_female^1" } },
		{ name = "Danse de soirée 7", anim = { "anim@amb@nightclub@dancers@crowddance_groups@", "hi_dance_crowd_09_v1_female^3" } },
		{ name = "Danse de soirée 8", anim = { "anim@amb@nightclub@djs@black_madonna@", "dance_b_idle_a_blamadon" } },
		{ name = "Danse de soirée 9", anim = { "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center" } },
		{ name = "Danse de soirée 10", anim = { "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "med_center" } },
		{ name = "Danse de soirée 11", anim = { "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "high_center_up" } },
		{ name = "Dance Disco", anim = { "anim@mp_player_intcelebrationmale@uncle_disco", "uncle_disco" } }
	},
	Expressions = {
		{ name = "Loose Thumbs 1", anim = { "anim@arena@celeb@flat@solo@no_props@", "thumbs_down_a_player_a" } },
		{ name = "Mort de rire", anim = { "anim@arena@celeb@flat@solo@no_props@", "taunt_d_player_b" } },
		{ name = "Badmood 1", anim = { "amb@world_human_stupor@male@base", "base" } },
		{ name = "Badmood 2", anim = { "amb@world_human_stupor@male_looking_left@base", "base" } },
		{ name = "Bisou", anim = { "mp_ped_interaction", "kisses_guy_a" } },
		{ name = "Stressé", anim = { "rcmme_tracey1", "nervous_loop" } },
		{ name = "Peace", anim = { "anim@mp_player_intcelebrationmale@peace", "peace" } },
		{ name = "Clown teubé", anim = { "move_clown@p_m_two_idles@", "fidget_short_dance" } },
		{ name = "Face Palm", anim = { "anim@mp_player_intcelebrationmale@face_palm", "face_palm" } },
		{ name = "Patience", anim = { "special_ped@impotent_rage@base", "base" } },
		{ name = "Respect", anim = { "mp_player_int_upperbro_love", "mp_player_int_bro_love_fp" } },
		{ name = "Inspecter ses lunettes", anim = { "clothingspecs", "try_glasses_positive_a" } },
		{ name = "Réflexion", anim = { "misscarsteal4@aliens", "rehearsal_base_idle_director" } },
		{ name = "Check mon flow", anim = { "clothingshirt", "try_shirt_positive_d" } },
		{ name = "VICTOIRE", anim = { "mini@tennisexit@", "tennis_outro_win_01_female" } },
		{ name = "Le plus fort", anim = { "rcmbarry", "base" } },
		{ name = "Ta géré!", anim = { "anim@mp_player_intcelebrationmale@thumbs_up", "thumbs_up" } },
		{ name = "Mal de tête", anim = { "misscarsteal4@actor", "stumble" } },
		{ name = "Bro love", anim = { "anim@mp_player_intcelebrationmale@bro_love", "bro_love" } },
		{ name = "Craquer les poignets", anim = { "anim@mp_player_intcelebrationmale@knuckle_crunch", "knuckle_crunch" } },
		{ name = "Salut militaire", anim = { "anim@mp_player_intuppersalute", "idle_a" } },
		{ name = "Signe GSF", anim = { "amb@code_human_in_car_mp_actions@gang_sign_b@low@ps@base", "idle_a" } },
		{ name = "Signe Vagos", anim = { "amb@code_human_in_car_mp_actions@v_sign@std@rds@base", "idle_a" } },
		{ name = "Signe Ballas", anim = { "mp_player_int_uppergang_sign_b", "mp_player_int_gang_sign_b" } },
		{ name = "Signe Locura", anim = { "mp_player_int_uppergang_sign_a", "mp_player_int_gang_sign_a" } },
		{ name = "Check moi ça !", anim = { "mp_ped_interaction", "handshake_guy_a" } },
		{ name = "Check moi ça 2", anim = { "mp_ped_interaction", "hugs_guy_a" } },
		{ name = "A vos marque ! Partez !", anim = { "random@street_race", "grid_girl_race_start" } },
		{ name = "Il a gagné !", anim = { "random@street_race", "_streetracer_accepted" } },
		{ name = "Ceinturons", anim = { "amb@code_human_wander_idles_cop@male@static", "static" } },
		{ name = "On arrête tous !", anim = { "anim@heists@ornate_bank@chat_manager", "fail" } }
	},
	Poses = {
		{ name = "Faire du stop", anim = { "random@hitch_lift", "idle_f" } },
		{
			name = "Se rendre, à genoux",
			anims = {
				enter = {
					{ anim = { "random@arrests@busted", "enter" }, flag = 0 },
					{ anim = { "random@arrests@busted", "idle_a" }, flag = 1 }
				},
				exit = { { anim = { "random@arrests@busted", "exit" }, flag = 0 } }
			}
		},
		{ name = "Dormir sur place", anim = { "mp_sleep", "sleep_loop" }, flag = 49 },
		{ name = "PLS", anim = { "timetable@tracy@sleep@", "idle_c" } },
		{ name = "Roule au sol", anim = { "missfinale_a_ig_2", "trevor_death_reaction_pt" } },
		{ name = "Blessé au sol", anim = { "combat@damage@rb_writhe", "rb_writhe_loop" } },
		{ name = "Désespéré", anim = { "rcmnigel1c", "idle_d" } },
		{ name = "Essouffler", anim = { "re@construction", "out_of_breath" } },
		{ name = "Faire la statue", anim = "WORLD_HUMAN_HUMAN_STATUE" },
		{ name = "Montrer ses muscles", anim = "WORLD_HUMAN_MUSCLE_FLEX" },
		{ name = "Zombie", anim = { "special_ped@zombie@monologue_1@monologue_1c", "iamundead_2" } },
		{ name = "Pose garde", anim = { "amb@world_human_stand_guard@male@base", "base" } },
		{ name = "Bras croisé lourd", anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" } },
		{ name = "Faire le maik", anim = { "anim@heists@heist_corona@single_team", "single_team_intro_two" } },
		{ name = "Bras croisé", anim = { "random@street_race", "_car_b_lookout" } },
		{ name = "Holster", anim = { "reaction@intimidation@cop@unarmed", "intro" } },
		{ name = "Patauge", anim = { "move_m@wading", "walk" } }
	},
	Actions = {
		{ name = "Slide", anim = { "anim@arena@celeb@flat@solo@no_props@", "slide_a_player_a" } },
		{ name = "Reverence ", anim = { "anim@arena@celeb@podium@no_prop@", "regal_c_1st" } },
		{ name = "Pleure a genoux", anim = { "mp_bank_heist_1", "f_cower_01" } },
		--{ name = "Sortir son carnet", anim = "CODE_HUMAN_MEDIC_TIME_OF_DEATH" },
		--{ name = "Noter des informations", anim = "WORLD_HUMAN_CLIPBOARD" },
		{ name = "Siffler", anim = { "rcmnigel1c", "hailing_whistle_waive_a" } },
		{ name = "Faire des pompes", anim = "WORLD_HUMAN_PUSH_UPS" },
		{ name = "Je me sens pas bien", anim = { "missfam5_blackout", "pass_out" } },
		{ name = "Locoooo", anim = { "anim@mp_player_intcelebrationmale@you_loco", "you_loco" } },
		{ name = "Wank", anim = { "anim@mp_player_intcelebrationmale@wank", "wank" } },
		{ name = "Laché moi", anim = { "anim@mp_player_intcelebrationmale@freakout", "freakout" } },
		{ name = "Mendier", anim = "WORLD_HUMAN_BUM_FREEWAY" },
		{ name = "Applaudir", anim = "WORLD_HUMAN_CHEERING" },
		{ name = "Slow Clap", anim = { "anim@mp_player_intcelebrationmale@slow_clap", "slow_clap" } },
		{ name = "Appel téléphonique", anim = { "cellphone@", "cellphone_call_listen_base" } },
		{ name = "Encouragement", anim = { "mini@triathlon", "male_one_handed_a" } },
		{ name = "Prendre une photo", anim = "WORLD_HUMAN_MOBILE_FILM_SHOCKING" },
		{ name = "Bras tendu", anim = { "nm@hands", "flail" } },
		{ name = "Yoga", anim = { "amb@world_human_yoga@male@base", "base_a" } },
		{ name = "Mîme", anim = { "special_ped@mime@monologue_5@monologue_5a", "10_ig_1_wa_0" } },
		{ name = "Faire des abdos", anim = "WORLD_HUMAN_SIT_UPS" },
		{ name = "Sortir votre carte", anim = "WORLD_HUMAN_TOURIST_MAP" },
		{ name = "Acrobatie 1", anim = { "anim@arena@celeb@flat@solo@no_props@", "cap_a_player_a" } },
		{ name = "Acrobatie 2", anim = { "anim@arena@celeb@flat@solo@no_props@", "flip_a_player_a" } },
		{ name = "Acrobatie 3", anim = { "anim@arena@celeb@flat@solo@no_props@", "pageant_a_player_a" } },
		{ name = "Radio", anim = { "random@arrests", "generic_radio_chatter" } }
	},
	Festive = {
		{ name = "Suspens", anim = { "anim@amb@nightclub@dancers@black_madonna_entourage@", "li_dance_facedj_11_v1_male^1" } },
		{ name = "Coincé", anim = { "anim@amb@nightclub@dancers@black_madonna_entourage@", "li_dance_facedj_15_v2_male^2" } },
		{ name = "Enchainé", anim = { "anim@amb@nightclub@dancers@black_madonna_entourage@", "hi_dance_facedj_09_v2_male^5" } },
		{ name = "Hey man", anim = { "anim@amb@nightclub@dancers@club_ambientpeds@", "mi-hi_amb_club_09_v1_male^1" } },
		{ name = "Move 01", anim = { "anim@mp_player_intupperuncle_disco", "idle_a" } },
		{ name = "Move 02", anim = { "anim@mp_player_intuppersalsa_roll", "idle_a" } },
		{ name = "Move 03", anim = { "anim@mp_player_intupperraise_the_roof", "idle_a" } },
		{ name = "Move 04", anim = { "anim@mp_player_intupperoh_snap", "idle_a" } },
		{ name = "Move 05", anim = { "anim@mp_player_intupperheart_pumping", "idle_a" } },
		{ name = "Move 06", anim = { "anim@mp_player_intupperfind_the_fish", "idle_a" } },
		{ name = "Move 07", anim = { "anim@mp_player_intuppercats_cradle", "idle_a" } },
		{ name = "Move 08", anim = { "anim@mp_player_intupperbanging_tunes", "idle_a" } },
		{ name = "Move 09", anim = { "anim@mp_player_intupperbanging_tunes_right", "idle_a" } },
		{ name = "Move 10", anim = { "anim@mp_player_intupperbanging_tunes_left", "idle_a" } },
		{ name = "DJ", anim = { "anim@mp_player_intcelebrationmale@dj", "dj" } },
		{ name = "Fausse guitare", anim = { "anim@mp_player_intcelebrationmale@air_guitar", "air_guitar" } },
		{ name = "Mains Jazz", anim = { "anim@mp_player_intcelebrationfemale@jazz_hands", "jazz_hands" } },
		{ name = "Rock'n roll", anim = { "anim@mp_player_intcelebrationmale@rock", "rock" } }
	},
	Insolent = {
		{ name = "MDR", anim = { "anim@arena@celeb@flat@solo@no_props@", "giggle_a_player_a" } },
		{ name = "Se curer le nez", anim = { "anim@mp_player_intcelebrationmale@nose_pick", "nose_pick" } },
		{ name = "Bouffe mon doigt", anim = { "anim@mp_player_intcelebrationmale@finger", "finger" } },
		{ name = "Prend mon fuck", anim = { "random@shop_gunstore", "_negative_goodbye" } },
		{ name = "Nananère", anim = { "anim@mp_player_intcelebrationmale@thumb_on_ears", "thumb_on_ears" } },
		{ name = "DTC", anim = { "anim@mp_player_intcelebrationmale@dock", "dock" } },
		{ name = "Chuuuuute", anim = { "anim@mp_player_intcelebrationmale@shush", "shush" } },
		{ name = "Poule Mouillé", anim = { "anim@mp_player_intcelebrationmale@chicken_taunt", "chicken_taunt" } },
		{
			name = "Doigt solo",
			anims = {
				enter = {
					{ anim = { "anim@mp_player_intselfiethe_bird", "enter" } },
					{ anim = { "anim@mp_player_intselfiethe_bird", "idle_a" } }
				},
				exit = {
					{ anim = { "anim@mp_player_intselfiethe_bird", "idle_a" } },
					{ anim = { "anim@mp_player_intselfiethe_bird", "exit" } }
				}
			}
		},
		{ name = "Doigt d'honneur", anim = { "mp_player_int_upperfinger", "mp_player_int_finger_01" } },
		{ name = "Uriner", anim = { "misscarsteal2peeing", "peeing_intro" } },
		{ name = "Se gratter le cul", anim = { "mp_player_int_upperarse_pick", "mp_player_int_arse_pick" } },
		{
			name = "Se gratter les couilles",
			anim = { "mp_player_int_uppergrab_crotch", "mp_player_int_grab_crotch" }
		},
		{ name = "Pluie de fric", anim = { "anim@arena@celeb@flat@solo@props@", "make_it_rain_b_player_b" } },
		{ name = "Pluie de fric 2", anim = { "anim@mp_player_intcelebrationmale@raining_cash", "raining_cash" } }
	},
	Sex = {
		{ name = "Fellation", anim = { "misscarsteal2pimpsex", "pimpsex_hooker" } },
		{ name = "Se faire sucer 01", anim = { "misscarsteal2pimpsex", "pimpsex_pimp" } },
		{ name = "Se faire sucer 02", anim = { "misscarsteal2pimpsex", "pimpsex_punter" } },
		{ name = "Danse sexy", anim = { "mp_safehouse", "lap_dance_girl" } },
		{ name = "Danse Twerk", anim = { "mini@strip_club@private_dance@part3", "priv_dance_p3" } },
		{ name = "Montrer sa poitrine", anim = { "mini@strip_club@backroom@", "stripper_b_backroom_idle_b" } },
		{ name = "Montrer ses fesses", anim = { "switch@trevor@mocks_lapdance", "001443_01_trvs_28_idle_stripper" } },
		{ name = "Se faire su*** en voiture", anim = { "oddjobs@towing", "m_blow_job_loop" } },
		{ name = "Faire une gaterie en voiture", anim = { "oddjobs@towing", "f_blow_job_loop" } },
		{ name = "***** en voiture", anim = { "mini@prostitutes@sexlow_veh", "low_car_sex_loop_player" } },
		{ name = "Se ***** en voiture", anim = { "mini@prostitutes@sexlow_veh", "low_car_sex_loop_female" } },
		{ name = "Mon coeur", anim = { "mini@hookers_spvanilla", "idle_a" } }
	},
	Weapon = {
		{ name = "Animation execution", anim = { "oddjobs@suicide", "bystander_pointinto" } },
		{ name = "Animation suicide", anim = { "mp_suicide", "pistol" } },
		{ name = "Check arme", anim = { "mp_corona@single_team", "single_team_intro_one" } },
		{ name = "Arme pointé", anim = { "random@arrests", "cop_gunaimed_door_open_idle" } },
		{ name = "Melée 1", anim = { "anim@deathmatch_intros@melee@2h", "intro_male_melee_2h_b" } },
		{ name = "Melée 2", anim = { "anim@deathmatch_intros@melee@1h", "intro_male_melee_1h_b" } },
		{ name = "Melée 3", anim = { "anim@deathmatch_intros@melee@1h", "intro_male_melee_1h_c" } },
		{ name = "Melée 4", anim = { "mp_deathmatch_intros@melee@2h", "intro_male_melee_2h_d" } },
		{ name = "Melée 5", anim = { "mp_deathmatch_intros@melee@2h", "intro_male_melee_2h_a_gclub" } },
		{ name = "Melée 6", anim = { "mp_deathmatch_intros@melee@1h", "intro_male_melee_1h_b" } },
		{ name = "Fight 1", anim = { "anim@deathmatch_intros@unarmed", "intro_male_unarmed_e" } },
		{ name = "Fight 2", anim = { "anim@deathmatch_intros@unarmed", "intro_male_unarmed_d" } },
		{ name = "Fight 3", anim = { "anim@deathmatch_intros@unarmed", "intro_male_unarmed_b" } } }
}

local category = {
	"Actions", "Danses", "Poses", "Expressions", "Festives", "Insolentes", "Armes"
}

local NameToTable = {
	["Actions"] = Animations.Actions,
	["Danses"] = Animations.Danse,
	["Poses"] = Animations.Poses,
	["Expressions"] = Animations.Expressions,
	["Festives"] = Animations.Festive,
	["Insolentes"] = Animations.Insolent,
	--["Adulte"] = Animations.Sex,
	["Armes"] = Animations.Weapon,
}

local selected = {};
local selectedName = nil;

local function PlayAnim(animDict, animName, timewait1, timewait2, flag, duration)
	Citizen.CreateThread(function()
		local dur = -1
		if duration ~= nil then
			dur = duration
		end
		if timewait2 >= 0 then
			Citizen.Wait(timewait2)
		end
		RequestAnimDict(animDict)
		while not HasAnimDictLoaded(animDict) do
			Citizen.Wait(1)
		end
		FreezeEntityPosition(PlayerPedId(), false)
		TaskPlayAnim(PlayerPedId(), animDict, animName, 8.0, -8.0, dur, flag, 1, 0, 0, 0)
		Citizen.Wait(timewait1)
		if animDict ~= nil then
			RemoveAnimDict(animDict)
		end
	end)
end

local ActionByName = {
	["Actions"] = function(v)
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped, false) then
			if v.anim[2] ~= nil then
				if IsEntityPlayingAnim(ped, v.anim[1], v.anim[2], 3) then
					ClearPedTasksImmediately(ped)
				else
					PlayAnim(v.anim[1], v.anim[2], 0, 0, 0, -1)
				end
			else
				if IsPedUsingAnyScenario(ped) then
					ClearPedTasksImmediately(ped)
				else
					TaskStartScenarioInPlace(ped, v.anim, -1, 1)
				end
			end
		end
	end,
	["Danses"] = function(v)
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped, false) then
			if IsEntityPlayingAnim(PlayerPedId(), v.anim[1], v.anim[2], 3) then
				ClearPedTasksImmediately(PlayerPedId())
			else
				PlayAnim(v.anim[1], v.anim[2], 0, 0, 1, -1)
			end
		end
	end,
	["Poses"] = function(v)
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped, false) then
			if v.anims ~= nil and v.anims.enter ~= nil then
				if IsEntityPlayingAnim(PlayerPedId(), v.anims.enter[2].anim[1], v.anims.enter[2].anim[2], 3) then
					PlayAnim(v.anims.exit[1].anim[1], v.anims.exit[1].anim[2], 0, 0, 0, -1)
				else
					PlayAnim(v.anims.enter[1].anim[1], v.anims.enter[1].anim[2], 0, 0, 0, -1)
					PlayAnim(v.anims.enter[1].anim[1], v.anims.enter[2].anim[2], 0, 1500, 1, -1)
				end
			else
				if v.anim[2] ~= nil then
					if IsEntityPlayingAnim(PlayerPedId(), v.anim[1], v.anim[2], 3) then
						ClearPedTasksImmediately(PlayerPedId())
					else
						PlayAnim(v.anim[1], v.anim[2], 0, 0, v.flag or 1, -1)
					end
				else
					if IsPedUsingAnyScenario(ped) then
						ClearPedTasksImmediately(ped)
					else
						TaskStartScenarioInPlace(ped, v.anim, -1, 1)
					end
				end
			end
		end
	end,
	["Expressions"] = function(v)
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped, false) then
			if IsEntityPlayingAnim(PlayerPedId(), v.anim[1], v.anim[2], 3) then
				ClearPedTasksImmediately(PlayerPedId())
			else
				PlayAnim(v.anim[1], v.anim[2], 0, 0, 0, -1)
			end
		end
	end,
	["Festives"] = function(v)
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped, false) then
			if IsEntityPlayingAnim(PlayerPedId(), v.anim[1], v.anim[2], 3) then
				ClearPedTasksImmediately(PlayerPedId())
			else
				PlayAnim(v.anim[1], v.anim[2], 0, 0, 0, -1)
			end
		end
	end,
	["Insolentes"] = function(v)
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped, false) then
			if v.anims ~= nil and v.anims.enter ~= nil then
				if IsEntityPlayingAnim(PlayerPedId(), v.anims.enter[2].anim[1], v.anims.enter[2].anim[2], 3) then
					PlayAnim(v.anims.exit[1].anim[1], v.anims.exit[1].anim[2], 0, 0, 0, -1)
				else
					PlayAnim(v.anims.enter[1].anim[1], v.anims.enter[1].anim[2], 0, 0, 0, -1)
					PlayAnim(v.anims.enter[1].anim[1], v.anims.enter[2].anim[2], 0, 500, 2, -1)
				end
			else
				if v.anim[2] ~= nil then
					if IsEntityPlayingAnim(PlayerPedId(), v.anim[1], v.anim[2], 3) then
						ClearPedTasksImmediately(PlayerPedId())
					else
						PlayAnim(v.anim[1], v.anim[2], 0, 0, v.flag or 0, -1)
					end
				else
					if IsPedUsingAnyScenario(ped) then
						ClearPedTasksImmediately(ped)
					else
						TaskStartScenarioInPlace(ped, v.anim, -1, 1)
					end
				end
			end
		end
	end,
	["Adulte"] = function(v)
		if IsEntityPlayingAnim(PlayerPedId(), v.anim[1], v.anim[2], 3) then
			ClearPedTasksImmediately(PlayerPedId())
		else
			PlayAnim(v.anim[1], v.anim[2], 0, 0, 0, -1)
		end
	end,
	["Armes"] = function(v)
		if IsEntityPlayingAnim(PlayerPedId(), v.anim[1], v.anim[2], 3) then
			ClearPedTasksImmediately(PlayerPedId())
		else
			PlayAnim(v.anim[1], v.anim[2], 0, 0, 2, -1)
		end
	end,
}

RegisterCommand("animmenu", function(source, args, rawCommand)
    AnimMenu()
end, false)

RegisterKeyMapping('animmenu', 'Menu Animation', 'keyboard', 'k')

function AnimMenu()
	local animation = RageUI.CreateMenu("Animations", "QUE VOULEZ VOUS FAIRE?")
	local subMenu = RageUI.CreateSubMenu(animation, "Animations", "SubMenu")

	RageUI.Visible(animation, not RageUI.Visible(animation))

	while animation do
		Citizen.Wait(0)
		RageUI.IsVisible(animation, function()
			DisablePlayerFiring(PlayerPedId(), true)
			for i = 1, #category do
				RageUI.Button(category[i], nil, {}, true, {
					onHovered = function()

					end,
					onSelected = function()
						selected = NameToTable[category[i]]
						selectedName = category[i]
						subMenu:SetSubtitle(category[i])
					end,
				}, subMenu);
			end
		end)
		RageUI.IsVisible(subMenu, function()
			DisablePlayerFiring(PlayerPedId(), true)
			for i, v in pairs(selected) do
				RageUI.Button(v.name, nil, {}, true, {
					onHovered = function()
						Visual.Subtitle("onHovered", 100)
					end,
					onSelected = function()
						if (ActionByName[selectedName] ~= nil) then
							ActionByName[selectedName](v);
						else
							Visual.Subtitle("Fatal errors occurred", 5000)
						end
					end,
				});
			end
		end)
		if not RageUI.Visible(animation) and not RageUI.Visible(subMenu) then
			animation = RMenu:DeleteType("animation", true)
			subMenu = RMenu:DeleteType("subMenu", true)
		end
	end
end

RegisterCommand("demarche", function(source, args, rawCommand)
    DemarcheMenu()
end, false)

function DemarcheMenu()
	local demarche = RageUI.CreateMenu("Démarche", "QUE VOULEZ VOUS FAIRE?")

	RageUI.Visible(demarche, not RageUI.Visible(demarche))

	while demarche do
		Citizen.Wait(0)
	    RageUI.IsVisible(demarche, function()
	    	RageUI.List("Humeur", { "Normal", "Fâché", "Ivre", "Stupide", "Électrocuté", "Grincheux", "Grincheux 2", "Grincheux 3", "Heureux", "Blessé", "Joyeux", "Excité", "Ne cligne jamais", "Un oeil", "Sous le choc", "Sous le choc 2", "Epuisé", "Epuisé 2", "Epuisé 3", "Suffisant", "Spéculatif", "Stressé", "Bouder", "Bizarre", "Bizarre 2" }, Animations.moodIndex or 1, nil, {}, true, {
	    		onListChange = function(Index, Items)
	    			Animations.moodIndex = Index
	    			SetFacialIdleAnimOverride(PlayerPedId(), Animations.mood[Animations.moodIndex])
	    		end,
	    	})
	    	RageUI.List("Démarche", { "Normal", "Alien", "Balloner", "Arrogant", "Décontracté", "Décontracté 2", "Décontracté 3", "Décontracté 4", "Décontracté 5", "Décontracté 6", "Chichi", "Sur de soi", "Flic", "Flic 2", "Flic 3", "Ivre ", "Ivre 2", "Ivre 3", "Ivre 4", "Femme", "En feu", "En feu 2", "En feu 3", "Efféminé", "Franklin", "Gangster", "Gangster 2", "Gangster 3", "Gangster 4", "Gangster 5", "Grooving", "Talons", "Talons 2", "Hipster", "Clochard", "Se dépêcher", "Concierge", "Concierge 2", "Jogging", "Lemar", "Lester", "Lester 2", "Maneater", "Michael", "Argent", "Chic", "chic 2", "Rapide", "Coureur", "Triste", "Impertinent", "Impertinent 2", "Effrayé", "Sexy", "Ombragé", "Lent", "Swagger", "Dure", "Dure 2", "Poubelle", "Poubelle 2", "Trevor", "Wide" }, Animations.gaitIndex or 1, nil, {}, true, {
	    		onListChange = function(Index, Items)
	    			Animations.gaitIndex = Index
	    			RequestAnimSet(Animations.gait[Animations.gaitIndex])
	    			while not HasAnimSetLoaded(Animations.gait[Animations.gaitIndex]) do
	    				Citizen.Wait(1)
	    			end
	    			SetPedMovementClipset(PlayerPedId(), Animations.gait[Animations.gaitIndex], 0.2)
	    		end,
	    	})
	    end)
		if not RageUI.Visible(demarche) then
			demarche = RMenu:DeleteType("demarche", true)
		end
	end
end