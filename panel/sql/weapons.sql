SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

CREATE TABLE IF NOT EXISTS `weapons` (
`id` int(11) NOT NULL,
  `index` int(6) DEFAULT NULL,
  `name` varchar(150) DEFAULT NULL,
  `weapon` varchar(150) DEFAULT NULL,
  `slot` varchar(12) DEFAULT NULL,
  `class` varchar(70) DEFAULT NULL,
  `image` varchar(150) DEFAULT NULL
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=212 ;

INSERT INTO `weapons` (`id`, `index`, `name`, `weapon`, `slot`, `class`, `image`) VALUES
(1, 2, 'Fire Axe', 'fireaxe', 'Melee', 'Pyro', 'images/weaponicons/Killicon_fireaxe.png'),
(2, 8, 'Bonesaw ', 'bonesaw', 'Melee', 'Medic', 'images/weaponicons/Killicon_bonesaw.png'),
(3, 0, 'Bat', 'bat', 'Melee', 'Scout', 'images/weaponicons/Killicon_bat.png'),
(4, 1, 'Bottle', 'bottle', 'Melee', 'Demoman', 'images/weaponicons/Killicon_bottle.png'),
(5, 15, 'Minigun', 'minigun', 'Primary', 'Heavy', 'images/weaponicons/Killicon_minigun.png'),
(6, 5, 'Fists', 'fists', 'Melee', 'Heavy', 'images/weaponicons/Killicon_fists.png'),
(7, 21, 'Flamethrower', 'flamethrower', 'Primary', 'Pyro', 'images/weaponicons/Killicon_flamethrower.png'),
(8, 19, 'Grenade Launcher', 'tf_projectile_pipe', 'Primary', 'Demoman', 'images/weaponicons/Killicon_grenade_launcher.png'),
(9, 4, 'Knife', 'knife', 'Melee', 'Spy', 'images/weaponicons/Killicon_knife.png'),
(10, 3, 'Kukri', 'club', 'Melee', 'Sniper', 'images/weaponicons/Killicon_kukri.png'),
(11, 24, 'Revolver', 'revolver', 'Secondary', 'Spy', 'images/weaponicons/Killicon_revolver.png'),
(12, 17, 'Syringe Gun', 'syringegun_medic', 'Primary', 'Medic', 'images/weaponicons/Killicon_syringegun.png'),
(13, 22, 'Engineer''s Pistol', 'pistol', 'Secondary', 'Engineer', 'images/weaponicons/Killicon_pistol.png'),
(14, 18, 'Rocket Launcher', 'tf_projectile_rocket', 'Primary', 'Soldier', 'images/weaponicons/Killicon_rocketlauncher.png'),
(15, 13, 'Scattergun', 'scattergun', 'Primary', 'Scout', 'images/weaponicons/Killicon_scattergun.png'),
(16, 20, 'Stickybomb Launcher', 'tf_projectile_pipe_remote', 'Secondary', 'Demoman', 'images/weaponicons/Killicon_stickybomb_launcher.png'),
(17, 16, 'SMG', 'smg', 'Secondary', 'Sniper', 'images/weaponicons/Killicon_smg.png'),
(18, 14, 'Sniper Rifle', 'sniperrifle', 'Primary', 'Sniper', 'images/weaponicons/Killicon_sniperrifle.png'),
(201, 10, 'Soldier''s Shotgun', 'shotgun_soldier', 'Secondary', 'Soldier', 'images/weaponicons/Killicon_shotgun.png'),
(20, 7, 'Wrench', 'wrench', 'Melee', 'Engineer', 'images/weaponicons/Killicon_wrench.png'),
(200, 9, 'Engineer''s Shotgun', 'shotgun_primary', 'Secondary', 'Engineer', 'images/weaponicons/Killicon_shotgun.png'),
(22, 6, 'Shovel', 'shovel', 'Melee', 'Soldier', 'images/weaponicons/Killicon_shovel.png'),
(23, NULL, 'Hadouken', 'taunt_pyro', 'Taunt', 'Pyro', 'images/weaponicons/Killicon_hadouken.png'),
(24, 38, 'Axtinguisher', 'axtinguisher', 'Melee', 'Pyro', 'images/weaponicons/Killicon_axtinguisher.png'),
(25, 39, 'Flare Gun', 'flaregun', 'Secondary', 'Pyro', 'images/weaponicons/Killicon_flare_gun.png'),
(26, 40, 'Backburner', 'backburner', 'Primary', 'Pyro', 'images/weaponicons/Killicon_backburner.png'),
(27, 41, 'Natascha', 'natascha', 'Primary', 'Heavy', 'images/weaponicons/Killicon_natascha.png'),
(28, 36, 'Blutsauger', 'blutsauger', 'Primary', 'Medic', 'images/weaponicons/Killicon_blutsauger.png'),
(29, 43, 'Killing Gloves Of Boxing', 'gloves', 'Melee', 'Heavy', 'images/weaponicons/Killicon_kgb.png'),
(30, NULL, 'Showdown', 'taunt_heavy', 'Taunt', 'Heavy', 'images/weaponicons/Killicon_showdown.png'),
(31, 37, 'Ubersaw', 'ubersaw', 'Melee', 'Medic', 'images/weaponicons/Killicon_ubersaw.png'),
(32, 56, 'Huntsman', 'tf_projectile_arrow', 'Primary', 'Sniper', 'images/weaponicons/Killicon_huntsman.png'),
(33, 61, 'Ambassador', 'ambassador', 'Secondary', 'Spy', 'images/weaponicons/Killicon_ambassador.png'),
(34, 44, 'Sandman', 'sandman', 'Melee', 'Scout', 'images/weaponicons/Killicon_sandman.png'),
(35, NULL, 'Huntsman Fire Arrow', 'compound_bow', 'Primary', 'Sniper', 'images/weaponicons/Killicon_flaming_huntsman.png'),
(36, NULL, 'Home Run', 'taunt_scout', 'Taunt', 'Scout', 'images/weaponicons/Killicon_home_run.png'),
(37, 45, 'Force-A-Nature', 'force_a_nature', 'Primary', 'Scout', 'images/weaponicons/Killicon_force_a_nature.png'),
(39, 128, 'Equalizer', 'unique_pickaxe', 'Melee', 'Soldier', 'images/weaponicons/Killicon_equalizer.png'),
(40, 127, 'Direct Hit', 'rocketlauncher_directhit', 'Primary', 'Soldier', 'images/weaponicons/Killicon_direct_hit.png'),
(41, NULL, 'Telefrag', 'telefrag', 'Other', 'Scout, Sniper, Soldier, Demoman, Medic, Heavy, Pyro, Spy, Engineer', 'images/weaponicons/Killicon_telefrag.png'),
(42, NULL, 'Kamikaze', 'taunt_soldier', 'Taunt', 'Soldier', 'images/weaponicons/Killicon_kamikaze.png'),
(43, 131, 'Chargin'' Targe', 'demoshield', 'Secondary', 'Demoman', 'images/weaponicons/Killicon_chargin_targe.png'),
(44, 132, 'Eyelander', 'sword', 'Melee', 'Demoman', 'images/weaponicons/Killicon_eyelander.png'),
(45, NULL, 'Decapitation', 'taunt_demoman', 'Taunt', 'Demoman', 'images/weaponicons/Killicon_decapitation.png'),
(46, 130, 'Scottish Resistance', 'sticky_resistance', 'Secondary', 'Demoman', 'images/weaponicons/Killicon_scottish_resistance.png'),
(47, 171, 'Tribalman''s Shiv', 'tribalkukri', 'Melee', 'Sniper', 'images/weaponicons/Killicon_tribalman''s_shiv.png'),
(48, 172, 'Scotsman''s Skullcutter', 'battleaxe', 'Melee', 'Demoman', 'images/weaponicons/Killicon_scotsman''s_skullcutter.png'),
(49, NULL, 'Ball', 'ball', 'Melee', 'Scout', 'images/weaponicons/Killicon_sandman_ball.png'),
(50, 154, 'Pain Train', 'paintrain', 'Melee', 'Soldier, Demoman', 'images/weaponicons/Killicon_pain_train.png'),
(51, 153, 'Homewrecker', 'sledgehammer', 'Melee', 'Pyro', 'images/weaponicons/Killicon_homewrecker.png'),
(52, NULL, 'Pumpkin Bomb', 'tf_pumpkin_bomb', 'Other', 'Scout, Sniper, Soldier, Demoman, Medic, Heavy, Pyro, Spy, Engineer', 'images/weaponicons/Killicon_pumpkin.png'),
(53, NULL, 'Goomba Stomp', 'goomba', 'Other', 'Scout, Sniper, Soldier, Demoman, Medic, Heavy, Pyro, Spy, Engineer', 'images/weaponicons/Killicon_home_run.png'),
(54, NULL, 'Sentry Lvl1', 'obj_sentrygun', 'PDA', 'Engineer', 'images/weaponicons/Killicon_sentry1.png'),
(55, NULL, 'Sentry Lvl2', 'obj_sentrygun2', 'PDA', 'Engineer', 'images/weaponicons/Killicon_sentry2.png'),
(56, NULL, 'Sentry Lvl3', 'obj_sentrygun3', 'PDA', 'Engineer', 'images/weaponicons/Killicon_sentry3.png'),
(57, 141, 'Frontier Justice', 'frontier_justice', 'Primary', 'Engineer', 'images/weaponicons/Killicon_frontier_justice.png'),
(58, 140, 'Wrangler', 'wrangler_kill', 'Secondary', 'Engineer', 'images/weaponicons/Killicon_wrangler.png'),
(59, 142, 'Gunslinger', 'robot_arm', 'Melee', 'Engineer', 'images/weaponicons/Killicon_gunslinger.png'),
(60, 294, 'Lugermorph', 'maxgun', 'Secondary', 'Scout, Engineer', 'images/weaponicons/Killicon_maxgun.png'),
(61, 155, 'Southern Hospitality', 'southern_hospitality', 'Melee', 'Engineer', 'images/weaponicons/Killicon_southern_hospitality.png'),
(62, NULL, 'Bleed', 'bleed_kill', 'Melee', 'Scout, Sniper, Engineer', 'images/weaponicons/Killicon_bleed.png'),
(63, NULL, 'Organ Grinder', 'robot_arm_blender_kill', 'Taunt', 'Engineer', 'images/weaponicons/Killicon_organ_grinder.png'),
(64, NULL, 'Dischord', 'taunt_guitar_kill', 'Taunt', 'Engineer', 'images/weaponicons/Killicon_dischord.png'),
(65, 161, 'Big Kill', 'samrevolver', 'Secondary', 'Spy', 'images/weaponicons/Killicon_samgun.png'),
(66, 220, 'Shortstop', 'short_stop', 'Primary', 'Scout', 'images/weaponicons/Killicon_shortstop.png'),
(67, 221, 'Holy Mackerel', 'holy_mackerel', 'Melee', 'Scout', 'images/weaponicons/Killicon_holy_mackerel.png'),
(68, 214, 'Powerjack', 'powerjack', 'Melee', 'Pyro', 'images/weaponicons/Killicon_powerjack.png'),
(69, 215, 'Degreaser', 'degreaser', 'Primary', 'Pyro', 'images/weaponicons/Killicon_degreaser.png'),
(70, 173, 'Vita-Saw', 'battleneedle', 'Melee', 'Medic', 'images/weaponicons/Killicon_vita-saw.png'),
(71, 225, 'Your Eternal Reward', 'eternal_reward', 'Melee', 'Spy', 'images/weaponicons/Killicon_your_eternal_reward.png'),
(72, 224, 'L''Etranger', 'letranger', 'Secondary', 'Spy', 'images/weaponicons/Killicon_l''etranger.png'),
(73, 232, 'Bushwacka', 'bushwacka', 'Melee', 'Sniper', 'images/weaponicons/Killicon_bushwacka.png'),
(74, 239, 'Gloves of Running Urgently', 'gloves_running_urgently', 'Melee', 'Heavy', 'images/weaponicons/Killicon_gru.png'),
(75, 230, 'Sydney Sleeper', 'sydney_sleeper', 'Primary', 'Sniper', 'images/weaponicons/Killicon_sydney_sleeper.png'),
(76, 228, 'Black Box', 'blackbox', 'Primary', 'Soldier', 'images/weaponicons/Killicon_black_box.png'),
(77, 142, 'Gunslinger (Triple Punch)', 'robot_arm_combo_kill', 'Melee', 'Engineer', 'images/weaponicons/Killicon_gunslinger_triple_punch.png'),
(78, 264, 'Frying Pan', 'fryingpan', 'Melee', 'Scout, Sniper, Soldier, Demoman, Medic, Heavy, Pyro', 'images/weaponicons/Killicon_frying_pan.png'),
(79, 266, 'Horseless Headless Horsemann''s Headtaker', 'headtaker', 'Melee', 'Demoman', 'images/weaponicons/Killicon_horseless_headless_horsemann''s_headtaker.png'),
(80, 298, 'Iron Curtain', 'iron_curtain', 'Primary', 'Heavy', 'images/weaponicons/Killicon_iron_curtain.png'),
(81, 317, 'Candy Cane', 'candy_cane', 'Melee', 'Scout', 'images/weaponicons/Killicon_candy_cane.png'),
(82, 325, 'Boston Basher', 'boston_basher', 'Melee', 'Scout', 'images/weaponicons/Killicon_boston_basher.png'),
(83, 326, 'Back Scratcher', 'back_scratcher', 'Melee', 'Pyro', 'images/weaponicons/Killicon_back_scratcher.png'),
(84, 307, 'Ullapool Caber', 'ullapool_caber', 'Melee', 'Demoman', 'images/weaponicons/Killicon_ullapool_caber.png'),
(85, 308, 'Loch-n-Load', 'loch_n_load', 'Primary', 'Demoman', 'images/weaponicons/Killicon_loch-n-load.png'),
(86, 327, 'Claidheamh Mòr', 'claidheamohmor', 'Melee', 'Demoman', 'images/weaponicons/Killicon_claidheamh_mor.png'),
(87, 312, 'Brass Beast', 'brass_beast', 'Primary', 'Heavy', 'images/weaponicons/Killicon_brass_beast.png'),
(88, 310, 'Warrior''s Spirit', 'warrior_spirit', 'Melee', 'Heavy', 'images/weaponicons/Killicon_warrior''s_spirit.png'),
(89, 331, 'Fists of Steel', 'steel_fists', 'Melee', 'Heavy', 'images/weaponicons/Killicon_fists_of_steel.png'),
(90, 329, 'Jag', 'wrench_jag', 'Melee', 'Engineer', 'images/weaponicons/Killicon_jag.png'),
(91, 304, 'Amputator', 'amputator', 'Melee', 'Medic', 'images/weaponicons/Killicon_amputator.png'),
(92, 305, 'Crusader''s Crossbow', 'crusaders_crossbow', 'Primary', 'Medic', 'images/weaponicons/Killicon_crusader''s_crossbow.png'),
(93, NULL, 'Mini-Sentry', 'obj_minisentry', 'PDA', 'Scout', 'images/weaponicons/Killicon_minisentry.png'),
(94, 307, 'Ullapool Caber Explosion', 'ullapool_caber_explosion', 'Melee', 'Demoman', 'images/weaponicons/Killicon_ullapool_caber_explode.png'),
(95, NULL, 'Worm''s Grenade', 'taunt_soldier_lumbricus', 'Taunt', 'Soldier', 'images/weaponicons/Killicon_hhg.png'),
(96, 348, 'Sharpened Volcano Fragment', 'lava_axe', 'Melee', 'Pyro', 'images/weaponicons/Killicon_sharpened_volcano_fragment.png'),
(97, 349, 'Sun-on-a-Stick', 'lava_bat', 'Melee', 'Scout', 'images/weaponicons/Killicon_sun-on-a-stick.png'),
(98, 355, 'Fan O''War', 'warfan', 'Melee', 'Scout', 'images/weaponicons/Killicon_fan_owar.png'),
(99, 356, 'Conniver''s Kunai', 'kunai', 'Melee', 'Spy', 'images/weaponicons/Killicon_connivers_kunai.png'),
(100, 357, 'Half-Zatoichi', 'demokatana', 'Melee', 'Soldier, Demoman', 'images/weaponicons/Killicon_half-zatoichi.png'),
(101, 452, 'Three-Rune Blade', 'scout_sword', 'Melee', 'Scout', 'images/weaponicons/Killicon_three-rune_blade.png'),
(102, 466, 'Maul', 'the_maul', 'Melee', 'Pyro', 'images/weaponicons/Killicon_maul.png'),
(103, 448, 'Soda Popper', 'soda_popper', 'Primary', 'Scout', 'images/weaponicons/Killicon_soda_popper.png'),
(104, 449, 'Winger', 'the_winger', 'Secondary', 'Scout', 'images/weaponicons/Killicon_winger.png'),
(105, 450, 'Atomizer', 'atomizer', 'Melee', 'Scout', 'images/weaponicons/Killicon_atomizer.png'),
(106, 414, 'Liberty Launcher', 'liberty_launcher', 'Primary', 'Soldier', 'images/weaponicons/Killicon_liberty_launcher.png'),
(107, 415, 'Reserve Shooter', 'reserve_shooter', 'Secondary', 'Soldier, Pyro', 'images/weaponicons/Killicon_reserve_shooter.png'),
(108, 447, 'Disciplinary Action', 'disciplinary_action', 'Melee', 'Soldier', 'images/weaponicons/Killicon_disciplinary_action.png'),
(109, 416, 'Market Gardener', 'market_gardener', 'Melee', 'Soldier', 'images/weaponicons/Killicon_market_gardener.png'),
(110, 444, 'Mantreads', 'mantreads', 'Secondary', 'Soldier', 'images/weaponicons/Killicon_mantreads.png'),
(111, 351, 'Detonator', 'detonator', 'Secondary', 'Pyro', 'images/weaponicons/Killicon_detonator.png'),
(112, 404, 'Persian Persuader', 'persian_persuader', 'Melee', 'Demoman', 'images/weaponicons/Killicon_persian_persuader.png'),
(113, 406, 'Splendid Screen', 'splendid_screen', 'Secondary', 'Demoman', 'images/weaponicons/Killicon_splendid_screen.png'),
(114, 424, 'Tomislav', 'tomislav', 'Primary', 'Heavy', 'images/weaponicons/Killicon_tomislav.png'),
(115, 425, 'Family Business', 'family_business', 'Secondary', 'Heavy', 'images/weaponicons/Killicon_family_business.png'),
(116, 426, 'Eviction Notice', 'eviction_notice', 'Melee', 'Heavy', 'images/weaponicons/Killicon_eviction_notice.png'),
(117, 412, 'Overdose', 'proto_syringe', 'Primary', 'Medic', 'images/weaponicons/Killicon_overdose.png'),
(118, 413, 'Solemn Vow', 'solemn_vow', 'Melee', 'Medic', 'images/weaponicons/Killicon_solemn_vow.png'),
(119, 402, 'Bazaar Bargain', 'bazaar_bargain', 'Primary', 'Sniper', 'images/weaponicons/Killicon_bazaar_bargain.png'),
(120, 401, 'Shahanshah', 'shahanshah', 'Melee', 'Sniper', 'images/weaponicons/Killicon_shahanshah.png'),
(121, 460, 'Enforcer', 'enforcer', 'Secondary', 'Spy', 'images/weaponicons/Killicon_enforcer.png'),
(122, 461, 'Big Earner', 'big_earner', 'Melee', 'Spy', 'images/weaponicons/Killicon_big_earner.png'),
(123, 457, 'Postal Pummeler', 'mailbox', 'Melee', 'Pyro', 'images/weaponicons/Killicon_postal_pummeler.png'),
(124, 482, 'Nessie''s Nine Iron', 'nessieclub', 'Melee', 'Demoman', 'images/weaponicons/Killicon_nessie''s_nine_iron.png'),
(125, 441, 'Cow Mangler 5000', 'cow_mangler', 'Primary', 'Soldier', 'images/weaponicons/Killicon_cow_mangler_5000.png'),
(126, 442, 'Righteous Bison', 'righteous_bison', 'Secondary', 'Soldier', 'images/weaponicons/Killicon_righteous_bison.png'),
(127, 513, 'Original', 'quake_rl', 'Primary', 'Soldier', 'images/weaponicons/Killicon_original.png'),
(128, 441, 'Cow Mangler 5000', 'cow_mangler', 'Primary', 'Soldier', 'images/weaponicons/Killicon_fire.png'),
(129, 527, 'Widowmaker', 'widowmaker', 'Primary', 'Engineer', 'images/weaponicons/Killicon_widowmaker.png'),
(130, 528, 'Short Circuit', 'short_circuit', 'Secondary', 'Engineer', 'images/weaponicons/Killicon_short_circuit.png'),
(131, 526, 'Machina', 'machina', 'Primary', 'Sniper', 'images/weaponicons/Killicon_machina.png'),
(132, 526, 'Machina Double Kill', 'player_penetration', 'Primary', 'Sniper', 'images/weaponicons/Killicon_machina_penetrate.png'),
(133, 525, 'Diamondback', 'diamondback', 'Secondary', 'Spy', 'images/weaponicons/Killicon_diamondback.png'),
(134, 572, 'Unarmed Combat', 'unarmed_combat', 'Melee', 'Scout', 'images/weaponicons/Killicon_unarmed_combat.png'),
(135, 574, 'Wanga Prick', 'voodoo_pin', 'Melee', 'Spy', 'images/weaponicons/Killicon_wanga_prick.png'),
(136, 609, 'Scottish Handshake', 'scotland_shard', 'Melee', 'Demoman', 'images/weaponicons/Killicon_scottish_handshake.png'),
(137, 474, 'Conscientious Objector', 'nonnonviolent_protest', 'Melee', 'Scout, Sniper, Soldier, Demoman, Medic, Heavy, Pyro', 'images/weaponicons/Killicon_conscientious_objector.png'),
(138, 423, 'Saxxy', 'saxxy', 'Melee', 'Soldier', 'images/weaponicons/Killicon_saxxy.png'),
(139, NULL, 'Eyeball Rocket', 'eyeball_rocket', 'Primary', 'Pyro', 'images/weaponicons/Killicon_monoculus.png'),
(202, 11, 'Heavy''s Shotgun', 'shotgun_hwg', 'Secondary', 'Heavy', 'images/weaponicons/Killicon_shotgun.png'),
(203, 12, 'Pyro''s Shotgun', 'shotgun_pyro', 'Secondary', 'Pyro', 'images/weaponicons/Killicon_shotgun.png'),
(141, 594, 'Phlogistinator', 'phlogistinator', 'Primary', 'Pyro', 'images/weaponicons/Killicon_phlogistinator.png'),
(142, 595, 'Manmelter', 'manmelter', 'Secondary', 'Pyro', 'images/weaponicons/Killicon_manmelter.png'),
(143, 593, 'Third Degree', 'thirddegree', 'Melee', 'Pyro', 'images/weaponicons/Killicon_third_degree.png'),
(144, 656, 'Holiday Punch', 'holiday_punch', 'Melee', 'Heavy', 'images/weaponicons/Killicon_holiday_punch.png'),
(145, 588, 'Pomson 6000', 'pomson', 'Primary', 'Engineer', 'images/weaponicons/Killicon_pomson_6000.png'),
(146, 589, 'Eureka Effect', 'eureka_effect', 'Melee', 'Engineer', 'images/weaponicons/Killicon_eureka_effect.png'),
(147, 638, 'Sharp Dresser', 'sharp_dresser', 'Melee', 'Spy', 'images/weaponicons/Killicon_sharp_dresser.png'),
(148, 649, 'Spy-cicle', 'spy_cicle', 'Melee', 'Spy', 'images/weaponicons/Killicon_spy-cicle.png'),
(149, 811, 'Huo-Long Heater', 'long_heatmaker', 'Primary', 'Heavy', 'images/weaponicons/Killicon_huo-long_heater.png'),
(150, 813, 'Neon Annihilator', 'annihilator', 'Melee', 'Pyro', 'images/weaponicons/Killicon_neon_annihilator.png'),
(151, 812, 'Flying Guillotine', 'guillotine', 'Secondary', 'Scout', 'images/weaponicons/Killicon_flying_guillotine.png'),
(152, 1013, 'Ham Shank', 'ham_shank', 'Melee', 'Scout, Sniper, Soldier, Demoman, Medic, Heavy, Pyro', 'images/weaponicons/Killicon_ham_shank.png'),
(153, 851, 'AWPer Hand', 'awper_hand', 'Primary', 'Sniper', 'images/weaponicons/Killicon_awperhand.png'),
(154, 996, 'Loose Cannon Impact', 'loose_cannon_impact', 'Primary', 'Demoman', 'images/weaponicons/Killicon_loose_cannon_pushed.png'),
(155, 939, 'Bat Outta Hell', 'skullbat', 'Melee', 'Scout, Sniper, Soldier, Demoman, Medic, Heavy, Pyro', 'images/weaponicons/Killicon_bat_outta_hell.png'),
(156, 880, 'Freedom Staff', 'freedom_staff', 'Melee', 'Scout, Sniper, Soldier, Demoman, Medic, Heavy, Pyro', 'images/weaponicons/Killicon_freedom_staff.png'),
(157, 997, 'Rescue Ranger', 'the_rescue_ranger', 'Primary', 'Engineer', 'images/weaponicons/Killicon_rescue_ranger.png'),
(158, 772, 'Baby Face''s Blaster', 'pep_brawlerblaster', 'Primary', 'Scout', 'images/weaponicons/Killicon_baby_face''s_blaster.png'),
(159, 773, 'Pretty Boy''s Pocket Pistol', 'pep_pistol', 'Secondary', 'Scout, Engineer', 'images/weaponicons/Killicon_pretty_boy''s_pocket_pistol.png'),
(160, 730, 'Beggar''s Bazooka', 'dumpster_device', 'Primary', 'Soldier', 'images/weaponicons/Killicon_beggar''s_bazooka.png'),
(161, 775, 'Escape Plan', 'unique_pickaxe_escape', 'Melee', 'Soldier', 'images/weaponicons/Killicon_escape_plan.png'),
(162, 741, 'Rainblower', 'rainblower', 'Primary', 'Pyro', 'images/weaponicons/Killicon_rainblower.png'),
(163, 740, 'Scorch Shot', 'scorchshot', 'Secondary', 'Pyro', 'images/weaponicons/Killicon_scorch_shot.png'),
(164, 739, 'Lollichop', 'lollichop', 'Melee', 'Pyro', 'images/weaponicons/Killicon_lollichop.png'),
(165, NULL, 'Armageddon', 'armageddon', 'Taunt', 'Pyro', 'images/weaponicons/Killicon_armageddon.png'),
(166, 752, 'Hitman''s Heatmaker', 'pro_rifle', 'Primary', 'Sniper', 'images/weaponicons/Killicon_hitman''s_heatmaker.png'),
(167, 751, 'Cleaner''s Carbine', 'pro_smg', 'Secondary', 'Sniper', 'images/weaponicons/Killicon_cleaner''s_carbine.png'),
(168, NULL, 'Skewer', 'taunt_sniper', 'Taunt', 'Sniper', 'images/weaponicons/Killicon_skewer.png'),
(169, NULL, 'Fencing', 'taunt_spy', 'Taunt', 'Spy', 'images/weaponicons/Killicon_fencing.png'),
(170, 727, 'Black Rose', 'black_rose', 'Melee', 'Spy', 'images/weaponicons/Killicon_black_rose.png'),
(171, 587, 'Apoco-Fists', 'apocofists', 'Melee', 'Heavy', 'images/weaponicons/Killicon_apoco-fists.png'),
(172, 648, 'Wrap Assassin', 'wrap_assassin', 'Melee', 'Scout', 'images/weaponicons/Killicon_wrap_assassin.png'),
(173, 996, 'Loose Cannon', 'loose_cannon', 'Primary', 'Demoman', 'images/weaponicons/Killicon_loose_cannon.png'),
(174, NULL, 'Toxic', 'rtd_toxic', 'Other', 'Scout, Sniper, Soldier, Demoman, Medic, Heavy, Pyro, Spy, Engineer', 'images/weaponicons/Killicon_fire.png'),
(175, NULL, 'Timebomb', 'rtd_timebomb', 'Other', 'Scout, Sniper, Soldier, Demoman, Medic, Heavy, Pyro, Spy, Engineer', 'images/weaponicons/Killicon_explosion.png'),
(176, NULL, 'Instant Kills', 'rtd_instant_kills', 'Other', 'Scout, Sniper, Soldier, Demoman, Medic, Heavy, Pyro, Spy, Engineer', 'images/weaponicons/Killicon_underworld.png'),
(177, NULL, 'Deflected Arrow', 'deflect_arrow', 'Primary', 'Pyro', 'images/weaponicons/Killicon_deflect_arrow.png'),
(178, NULL, 'Deflected Sticky', 'deflect_sticky', 'Primary', 'Pyro', 'images/weaponicons/Killicon_deflect_sticky.png'),
(179, 954, 'Memory Maker', 'memory_maker', 'Melee', 'Scout, Sniper, Soldier, Demoman, Medic, Heavy, Pyro', 'images/weaponicons/Killicon_memory_maker.png'),
(180, NULL, 'Deflected Rocket', 'deflect_rocket', 'Primary', 'Pyro', 'images/weaponicons/Killicon_deflect_rocket.png'),
(181, NULL, 'Deflected Flare', 'deflect_flare', 'Primary', 'Pyro', 'images/weaponicons/Killicon_deflect_flare.png'),
(182, NULL, 'Deflected Grenade', 'deflect_promode', 'Primary', 'Pyro', 'images/weaponicons/Killicon_deflect_grenade.png'),
(183, 1071, 'Golden Frying Pan', 'golden_fryingpan', 'Melee', 'Scout, Sniper, Soldier, Demoman, Medic, Heavy, Pyro, Spy, Engineer', 'images/weaponicons/Killicon_golden_frying_pan.png'),
(184, NULL, 'Fireball', 'spellbook_fireball', 'Other', 'Scout, Sniper, Soldier, Demoman, Medic, Heavy, Pyro, Spy, Engineer', 'images/weaponicons/Killicon_fireball.png'),
(185, NULL, 'Teleport', 'spellbook_teleport', 'Other', 'Scout, Sniper, Soldier, Demoman, Medic, Heavy, Pyro, Spy, Engineer', 'images/weaponicons/Killicon_teleport.png'),
(186, NULL, 'Superjump', 'spellbook_blastjump', 'Other', 'Scout, Sniper, Soldier, Demoman, Medic, Heavy, Pyro, Spy, Engineer', 'images/weaponicons/Killicon_superjump.png'),
(187, NULL, 'Ball O'' Bats', 'spellbook_bats', 'Other', 'Scout, Sniper, Soldier, Demoman, Medic, Heavy, Pyro, Spy, Engineer', 'images/weaponicons/Killicon_batball.png'),
(188, NULL, 'Pumpkin MIRV', 'spellbook_mirv', 'Other', 'Scout, Sniper, Soldier, Demoman, Medic, Heavy, Pyro, Spy, Engineer', 'images/weaponicons/Killicon_pumpkin_mirv.png'),
(189, NULL, 'MONOCULUS', 'spellbook_boss', 'Other', 'Scout, Sniper, Soldier, Demoman, Medic, Heavy, Pyro, Spy, Engineer', 'images/weaponicons/Killicon_monoculus_spell.png'),
(190, NULL, 'Skeletons', 'spellbook_skeleton', 'Other', 'Scout, Sniper, Soldier, Demoman, Medic, Heavy, Pyro, Spy, Engineer', 'images/weaponicons/Killicon_skeletons.png'),
(191, NULL, 'Tesla Bolt', 'spellbook_lightning', 'Other', 'Scout, Sniper, Soldier, Demoman, Medic, Heavy, Pyro, Spy, Engineer', 'images/weaponicons/Killicon_tesla_bolt.png'),
(192, NULL, 'Meteor Shower', 'spellbook_meteor', 'Other', 'Scout, Sniper, Soldier, Demoman, Medic, Heavy, Pyro, Spy, Engineer', 'images/weaponicons/Killicon_meteor_shower.png'),
(193, NULL, 'Minify', 'spellbook_athletic', 'Other', 'Scout, Sniper, Soldier, Demoman, Medic, Heavy, Pyro, Spy, Engineer', 'images/weaponicons/Killicon_minify.png'),
(194, 1098, 'Classic', 'the_classic', 'Primary', 'Sniper', 'images/weaponicons/Killicon_classic.png'),
(195, 1099, 'Tide Turner', 'tide_turner', 'Secondary', 'Demoman', 'images/weaponicons/Killicon_tide_turner.png'),
(196, 1100, 'Bread Bite', 'bread_bite', 'Melee', 'Heavy', 'images/weaponicons/Killicon_bread_bite.png'),
(197, 1103, 'Back Scatter', 'back_scatter', 'Primary', 'Scout', 'images/weaponicons/Killicon_back_scatter.png'),
(198, 1104, 'Air Strike', 'airstrike', 'Primary', 'Soldier', 'images/weaponicons/Killicon_air_strike.png'),
(204, 169, 'Golden Wrench', 'wrench_golden', 'Melee', 'Engineer', 'images/weaponicons/Killicon_golden_wrench.png'),
(205, 23, 'Scout''s Pistol', 'pistol_scout', 'Secondary', 'Scout', 'images/weaponicons/Killicon_pistol.png'),
(206, NULL, 'Spinal Tap', 'taunt_medic', 'Taunt', 'Medic', 'images/weaponicons/Killicon_spinal_tap.png'),
(207, NULL, 'Environment', 'world', NULL, 'Scout, Sniper, Soldier, Demoman, Medic, Heavy, Pyro, Spy, Engineer', 'images/weaponicons/Killicon_skull.png'),
(208, NULL, 'Deflected Cow Mangler 5000', 'tf_projectile_energy_ball', 'Primary', 'Pyro', 'images/weaponicons/Killicon_skull.png'),
(209, NULL, 'Suicide', 'player', NULL, 'Scout, Sniper, Soldier, Demoman, Medic, Heavy, Pyro, Spy, Engineer', 'images/weaponicons/Killicon_skull.png'),
(210, NULL, 'Deflected Repair Claws', 'rescue_ranger_reflect', 'Primary', 'Pyro', 'images/weaponicons/Killicon_deflect_repair_claws.png'),
(211, NULL, 'Deflected Cannonballs', 'loose_cannon_reflect', 'Primary', 'Pyro', 'images/weaponicons/Killicon_deflect_cannonballs.png');


ALTER TABLE `weapons`
 ADD PRIMARY KEY (`id`);


ALTER TABLE `weapons`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=212;