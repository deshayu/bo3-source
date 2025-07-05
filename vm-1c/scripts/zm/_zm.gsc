#using scripts/codescripts/struct;
#using scripts/shared/aat_shared;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai_puppeteer_shared;
#using scripts/shared/ai_shared;
#using scripts/shared/archetype_shared/archetype_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/demo_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_bb;
#using scripts/zm/_util;
#using scripts/zm/_zm_attackables;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_bgb_token;
#using scripts/zm/_zm_blockers;
#using scripts/zm/_zm_bot;
#using scripts/zm/_zm_daily_challenges;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_ffotd;
#using scripts/zm/_zm_game_module;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_melee_weapon;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_pers_upgrades;
#using scripts/zm/_zm_pers_upgrades_functions;
#using scripts/zm/_zm_pers_upgrades_system;
#using scripts/zm/_zm_placeable_mine;
#using scripts/zm/_zm_player;
#using scripts/zm/_zm_powerup_bonus_points_player;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_timer;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/aats/_zm_aat_blast_furnace;
#using scripts/zm/aats/_zm_aat_dead_wire;
#using scripts/zm/aats/_zm_aat_fire_works;
#using scripts/zm/aats/_zm_aat_thunder_wall;
#using scripts/zm/aats/_zm_aat_turned;
#using scripts/zm/bgbs/_zm_bgb_aftertaste;
#using scripts/zm/bgbs/_zm_bgb_alchemical_antithesis;
#using scripts/zm/bgbs/_zm_bgb_always_done_swiftly;
#using scripts/zm/bgbs/_zm_bgb_anywhere_but_here;
#using scripts/zm/bgbs/_zm_bgb_armamental_accomplishment;
#using scripts/zm/bgbs/_zm_bgb_arms_grace;
#using scripts/zm/bgbs/_zm_bgb_arsenal_accelerator;
#using scripts/zm/bgbs/_zm_bgb_board_games;
#using scripts/zm/bgbs/_zm_bgb_board_to_death;
#using scripts/zm/bgbs/_zm_bgb_bullet_boost;
#using scripts/zm/bgbs/_zm_bgb_burned_out;
#using scripts/zm/bgbs/_zm_bgb_cache_back;
#using scripts/zm/bgbs/_zm_bgb_coagulant;
#using scripts/zm/bgbs/_zm_bgb_crate_power;
#using scripts/zm/bgbs/_zm_bgb_crawl_space;
#using scripts/zm/bgbs/_zm_bgb_danger_closest;
#using scripts/zm/bgbs/_zm_bgb_dead_of_nuclear_winter;
#using scripts/zm/bgbs/_zm_bgb_disorderly_combat;
#using scripts/zm/bgbs/_zm_bgb_ephemeral_enhancement;
#using scripts/zm/bgbs/_zm_bgb_extra_credit;
#using scripts/zm/bgbs/_zm_bgb_eye_candy;
#using scripts/zm/bgbs/_zm_bgb_fatal_contraption;
#using scripts/zm/bgbs/_zm_bgb_fear_in_headlights;
#using scripts/zm/bgbs/_zm_bgb_firing_on_all_cylinders;
#using scripts/zm/bgbs/_zm_bgb_flavor_hexed;
#using scripts/zm/bgbs/_zm_bgb_head_drama;
#using scripts/zm/bgbs/_zm_bgb_idle_eyes;
#using scripts/zm/bgbs/_zm_bgb_im_feelin_lucky;
#using scripts/zm/bgbs/_zm_bgb_immolation_liquidation;
#using scripts/zm/bgbs/_zm_bgb_impatient;
#using scripts/zm/bgbs/_zm_bgb_in_plain_sight;
#using scripts/zm/bgbs/_zm_bgb_kill_joy;
#using scripts/zm/bgbs/_zm_bgb_killing_time;
#using scripts/zm/bgbs/_zm_bgb_licensed_contractor;
#using scripts/zm/bgbs/_zm_bgb_lucky_crit;
#using scripts/zm/bgbs/_zm_bgb_mind_blown;
#using scripts/zm/bgbs/_zm_bgb_near_death_experience;
#using scripts/zm/bgbs/_zm_bgb_newtonian_negation;
#using scripts/zm/bgbs/_zm_bgb_now_you_see_me;
#using scripts/zm/bgbs/_zm_bgb_on_the_house;
#using scripts/zm/bgbs/_zm_bgb_perkaholic;
#using scripts/zm/bgbs/_zm_bgb_phoenix_up;
#using scripts/zm/bgbs/_zm_bgb_pop_shocks;
#using scripts/zm/bgbs/_zm_bgb_power_vacuum;
#using scripts/zm/bgbs/_zm_bgb_profit_sharing;
#using scripts/zm/bgbs/_zm_bgb_projectile_vomiting;
#using scripts/zm/bgbs/_zm_bgb_reign_drops;
#using scripts/zm/bgbs/_zm_bgb_respin_cycle;
#using scripts/zm/bgbs/_zm_bgb_round_robbin;
#using scripts/zm/bgbs/_zm_bgb_secret_shopper;
#using scripts/zm/bgbs/_zm_bgb_self_medication;
#using scripts/zm/bgbs/_zm_bgb_shopping_free;
#using scripts/zm/bgbs/_zm_bgb_slaughter_slide;
#using scripts/zm/bgbs/_zm_bgb_soda_fountain;
#using scripts/zm/bgbs/_zm_bgb_stock_option;
#using scripts/zm/bgbs/_zm_bgb_sword_flay;
#using scripts/zm/bgbs/_zm_bgb_temporal_gift;
#using scripts/zm/bgbs/_zm_bgb_tone_death;
#using scripts/zm/bgbs/_zm_bgb_unbearable;
#using scripts/zm/bgbs/_zm_bgb_undead_man_walking;
#using scripts/zm/bgbs/_zm_bgb_unquenchable;
#using scripts/zm/bgbs/_zm_bgb_wall_power;
#using scripts/zm/bgbs/_zm_bgb_whos_keeping_score;
#using scripts/zm/craftables/_zm_craftables;
#using scripts/zm/gametypes/_globallogic;
#using scripts/zm/gametypes/_globallogic_player;
#using scripts/zm/gametypes/_globallogic_spawn;
#using scripts/zm/gametypes/_globallogic_vehicle;
#using scripts/zm/gametypes/_weapons;
#using scripts/zm/gametypes/_zm_gametype;

#namespace zm;

// Namespace zm
// Params 0, eflags: 0x2
// Checksum 0x2fbc46f3, Offset: 0x3550
// Size: 0x394
function autoexec ignore_systems() {
    system::ignore("gadget_clone");
    system::ignore("gadget_armor");
    system::ignore("gadget_heat_wave");
    system::ignore("gadget_resurrect");
    system::ignore("gadget_shock_field");
    system::ignore("gadget_active_camo");
    system::ignore("gadget_mrpukey");
    system::ignore("gadget_misdirection");
    system::ignore("gadget_smokescreen");
    system::ignore("gadget_firefly_swarm");
    system::ignore("gadget_immolation");
    system::ignore("gadget_forced_malfunction");
    system::ignore("gadget_sensory_overload");
    system::ignore("gadget_rapid_strike");
    system::ignore("gadget_unstoppable_force");
    system::ignore("gadget_overdrive");
    system::ignore("gadget_concussive_wave");
    system::ignore("gadget_ravage_core");
    system::ignore("gadget_es_strike");
    system::ignore("gadget_cacophany");
    system::ignore("gadget_iff_override");
    system::ignore("gadget_security_breach");
    system::ignore("gadget_surge");
    system::ignore("gadget_exo_breakdown");
    system::ignore("gadget_servo_shortout");
    system::ignore("gadget_system_overload");
    system::ignore("gadget_cleanse");
    system::ignore("gadget_flashback");
    system::ignore("gadget_combat_efficiency");
    system::ignore("gadget_other");
    system::ignore("gadget_camo");
    system::ignore("gadget_vision_pulse");
    system::ignore("gadget_speed_burst");
    system::ignore("gadget_thief");
    system::ignore("replay_gun");
    system::ignore("spike_charge_siegebot");
    system::ignore("siegebot");
    system::ignore("amws");
}

// Namespace zm
// Params 0, eflags: 0x2
// Checksum 0x435733ed, Offset: 0x38f0
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm", &__init__, undefined, undefined);
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x876a6228, Offset: 0x3930
// Size: 0x1c
function __init__() {
    if (!isdefined(level.zombie_vars)) {
        level.zombie_vars = [];
    }
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xd6ff5513, Offset: 0x3958
// Size: 0x8fc
function init() {
    setdvar("doublejump_enabled", 0);
    setdvar("juke_enabled", 0);
    setdvar("playerEnergy_enabled", 0);
    setdvar("wallrun_enabled", 0);
    setdvar("sprintLeap_enabled", 0);
    setdvar("traverse_mode", 2);
    setdvar("weaponrest_enabled", 0);
    setdvar("ui_allowDisplayContinue", 1);
    if (!isdefined(level.killstreakweapons)) {
        level.killstreakweapons = [];
    }
    level.weaponnone = getweapon("none");
    level.weaponnull = getweapon("weapon_null");
    level.weaponbasemelee = getweapon("knife");
    level.weaponbasemeleeheld = getweapon("knife_held");
    level.weaponballisticknife = getweapon("knife_ballistic");
    if (!isdefined(level.weaponriotshield)) {
        level.weaponriotshield = getweapon("riotshield");
    }
    level.weaponrevivetool = getweapon("syrette");
    level.weaponzmdeaththroe = getweapon("death_throe");
    level.weaponzmfists = getweapon("zombie_fists");
    if (!isdefined(level.givecustomloadout)) {
        level.givecustomloadout = &zm_weapons::give_start_weapons;
    }
    level.projectiles_should_ignore_world_pause = 1;
    level.player_out_of_playable_area_monitor = 1;
    level.player_too_many_weapons_monitor = 1;
    level.player_too_many_weapons_monitor_func = &function_67a71cec;
    level.player_too_many_players_check = 1;
    level.player_too_many_players_check_func = &player_too_many_players_check;
    level._use_choke_weapon_hints = 1;
    level._use_choke_blockers = 1;
    level.speed_change_round = 15;
    level.passed_introscreen = 0;
    if (!isdefined(level.custom_ai_type)) {
        level.custom_ai_type = [];
    }
    level.custom_ai_spawn_check_funcs = [];
    level thread zm_ffotd::main_start();
    level.zombiemode = 1;
    level.revivefeature = 0;
    level.swimmingfeature = 0;
    level.calc_closest_player_using_paths = 0;
    level.zombie_melee_in_water = 1;
    level.put_timed_out_zombies_back_in_queue = 1;
    level.use_alternate_poi_positioning = 1;
    level.zmb_laugh_alias = "zmb_laugh_child";
    level.sndannouncerisrich = 1;
    level.scr_zm_ui_gametype = getdvarstring("ui_gametype");
    level.scr_zm_ui_gametype_group = "";
    level.scr_zm_map_start_location = "";
    level.curr_gametype_affects_rank = 0;
    gametype = tolower(getdvarstring("g_gametype"));
    if ("zclassic" == gametype || "zstandard" == gametype) {
        level.curr_gametype_affects_rank = 1;
    }
    level.grenade_multiattack_bookmark_count = 1;
    demo::initactorbookmarkparams(3, 6000, 6000);
    if (!isdefined(level._zombies_round_spawn_failsafe)) {
        level._zombies_round_spawn_failsafe = &zombie_utility::round_spawn_failsafe;
    }
    level.func_get_zombie_spawn_delay = &get_zombie_spawn_delay;
    level.func_get_delay_between_rounds = &get_delay_between_rounds;
    level.zombie_visionset = "zombie_neutral";
    level.wait_and_revive = 0;
    if (getdvarstring("anim_intro") == "1") {
        level.zombie_anim_intro = 1;
    } else {
        level.zombie_anim_intro = 0;
    }
    precache_models();
    precache_zombie_leaderboards();
    level._zombie_gib_piece_index_all = 0;
    level._zombie_gib_piece_index_right_arm = 1;
    level._zombie_gib_piece_index_left_arm = 2;
    level._zombie_gib_piece_index_right_leg = 3;
    level._zombie_gib_piece_index_left_leg = 4;
    level._zombie_gib_piece_index_head = 5;
    level._zombie_gib_piece_index_guts = 6;
    level._zombie_gib_piece_index_hat = 7;
    if (!isdefined(level.zombie_ai_limit)) {
        level.zombie_ai_limit = 24;
    }
    if (!isdefined(level.zombie_actor_limit)) {
        level.zombie_actor_limit = 31;
    }
    init_flags();
    init_dvars();
    init_strings();
    init_levelvars();
    init_sounds();
    init_shellshocks();
    init_client_field_callback_funcs();
    zm_utility::register_offhand_weapons_for_level_defaults();
    level thread function_df2b6b41();
    zm_craftables::init();
    zm_perks::init();
    zm_powerups::init();
    zm_spawner::init();
    zm_weapons::init();
    level.zombie_poi_array = getentarray("zombie_poi", "script_noteworthy");
    init_function_overrides();
    level thread function_e7cfa7b8();
    level thread post_all_players_connected();
    level start_zm_dash_counter_watchers();
    zm_utility::init_utility();
    util::registerclientsys("lsm");
    initializestattracking();
    if (getplayers().size <= 1) {
        incrementcounter("global_solo_games", 1);
    } else if (isdefined(level.systemlink) && level.systemlink) {
        incrementcounter("global_systemlink_games", 1);
    } else if (getdvarint("splitscreen_playerCount") == getplayers().size) {
        incrementcounter("global_splitscreen_games", 1);
    } else {
        incrementcounter("global_coop_games", 1);
    }
    callback::on_connect(&zm_on_player_connect);
    zm_utility::set_demo_intermission_point();
    level thread zm_ffotd::main_end();
    level thread zm_utility::track_players_intersection_tracker();
    level thread onallplayersready();
    level thread function_787fcf1c();
    level thread function_83b0d780();
    callback::on_spawned(&zm_on_player_spawned);
    printhashids();
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x206eee61, Offset: 0x4260
// Size: 0x1c
function post_main() {
    level thread init_custom_ai_type();
}

// Namespace zm
// Params 1, eflags: 0x0
// Checksum 0xd34e2f76, Offset: 0x4288
// Size: 0x56
function cheat_enabled(val) {
    if (getdvarint("zombie_cheat") >= val) {
        /#
            return true;
        #/
        if (isprofilebuild()) {
            return true;
        }
    }
    return false;
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xf6f3a754, Offset: 0x42e8
// Size: 0x17c
function function_83b0d780() {
    level flag::wait_till_any(array("start_zombie_round_logic", "start_encounters_match_logic"));
    while (true) {
        var_82d7c36d = get_round_number();
        level.round_number = undefined;
        var_fa2cbc15 = var_82d7c36d;
        switch (randomint(5)) {
        case 0:
            var_d42a41ac = var_82d7c36d;
        case 1:
            var_ae27c743 = var_82d7c36d;
        case 2:
            var_88254cda = var_82d7c36d;
        case 3:
            var_6222d271 = var_82d7c36d;
        case 4:
            var_3c205808 = var_82d7c36d;
            break;
        }
        level.round_number = var_82d7c36d;
        var_82d7c36d = undefined;
        var_202f367e = undefined;
        var_fa2cbc15 = undefined;
        var_d42a41ac = undefined;
        var_ae27c743 = undefined;
        var_88254cda = undefined;
        var_6222d271 = undefined;
        var_3c205808 = undefined;
        wait 0.05;
    }
}

// Namespace zm
// Params 1, eflags: 0x0
// Checksum 0x93d97c9b, Offset: 0x4470
// Size: 0x38
function set_round_number(new_round) {
    if (new_round > -1) {
        new_round = -1;
    }
    world.roundnumber = new_round ^ 115;
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x70acda70, Offset: 0x44b0
// Size: 0x14
function get_round_number() {
    return world.roundnumber ^ 115;
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x5a4e8d64, Offset: 0x44d0
// Size: 0x4c
function function_787fcf1c() {
    level flag::wait_till_any(array("start_zombie_round_logic", "start_encounters_match_logic"));
    level thread zm_unitrigger::main();
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x8ccec013, Offset: 0x4528
// Size: 0x60
function function_df2b6b41() {
    while (true) {
        level waittill(#"connected", player);
        player demo::reset_actor_bookmark_kill_times();
        player callback::callback(#"hash_eaffea17");
    }
}

// Namespace zm
// Params 3, eflags: 0x0
// Checksum 0xe53aa0c4, Offset: 0x4590
// Size: 0x28c
function fade_out_intro_screen_zm(hold_black_time, fade_out_time, var_47f9982a) {
    lui::screen_fade_out(0, undefined);
    if (isdefined(hold_black_time)) {
        wait hold_black_time;
    } else {
        wait 0.2;
    }
    if (!isdefined(fade_out_time)) {
        fade_out_time = 1.5;
    }
    array::thread_all(getplayers(), &initialblackend);
    level clientfield::set("sndZMBFadeIn", 1);
    lui::screen_fade_in(fade_out_time, undefined);
    wait 1.6;
    level.passed_introscreen = 1;
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (isdefined(level.var_9f508948)) {
            players[i] thread [[ level.var_9f508948 ]]();
        } else {
            players[i] function_4af767f3();
        }
        if (!(isdefined(level.host_ended_game) && level.host_ended_game)) {
            if (isdefined(level.var_7679ccbb)) {
                players[i] freezecontrols(level.var_7679ccbb);
                println("<dev string:x28>");
                continue;
            }
            if (!(isdefined(players[i].hostmigrationcontrolsfrozen) && players[i].hostmigrationcontrolsfrozen)) {
                players[i] freezecontrols(0);
                println("<dev string:x3d>");
            }
        }
    }
    level flag::set("initial_blackscreen_passed");
    level clientfield::set("gameplay_started", 1);
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x67349b3, Offset: 0x4828
// Size: 0x98
function function_4af767f3() {
    self setclientuivisibilityflag("hud_visible", 1);
    self setclientuivisibilityflag("weapon_hud_visible", 1);
    if (!(isdefined(self.seen_promo_anim) && self.seen_promo_anim) && sessionmodeisonlinegame()) {
        self luinotifyevent(%play_promo_anim, 0);
        self.seen_promo_anim = 1;
    }
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xdf67639d, Offset: 0x48c8
// Size: 0x4bc
function onallplayersready() {
    timeout = gettime() + 5000;
    while (getnumexpectedplayers() == 0 && (isloadingcinematicplaying() || gettime() < timeout)) {
        wait 0.1;
    }
    println("<dev string:x52>" + getnumexpectedplayers());
    player_count_actual = 0;
    while (getnumconnectedplayers() < getnumexpectedplayers() || player_count_actual != getnumexpectedplayers()) {
        players = getplayers();
        player_count_actual = 0;
        for (i = 0; i < players.size; i++) {
            players[i] freezecontrols(1);
            if (players[i].sessionstate == "playing") {
                player_count_actual++;
            }
        }
        println("<dev string:x6f>" + getnumconnectedplayers() + "<dev string:x85>" + getnumexpectedplayers());
        wait 0.1;
    }
    setinitialplayersconnected();
    level flag::set("all_players_connected");
    setdvar("all_players_are_connected", "1");
    println("<dev string:x92>");
    if (1 == getnumconnectedplayers() && getdvarint("scr_zm_enable_bots") == 1) {
        level thread add_bots();
        level flag::set("initial_players_connected");
    } else {
        players = getplayers();
        if (players.size == 1) {
            level flag::set("solo_game");
            level.solo_lives_given = 0;
            foreach (player in players) {
                player.lives = 0;
            }
            level function_dd15fb4e(1);
        }
        level flag::set("initial_players_connected");
        array::thread_all(getplayers(), &initialblack);
        while (!aretexturesloaded()) {
            wait 0.05;
        }
        if (isdefined(level.var_639d8432)) {
            wait level.var_639d8432;
        }
        thread function_816dcdcc(3);
    }
    set_intermission_point();
    n_black_screen = 5;
    level thread fade_out_intro_screen_zm(n_black_screen, 1.5, 1);
    wait n_black_screen;
    level.n_gameplay_start_time = gettime();
    clientfield::set("game_start_time", level.n_gameplay_start_time);
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x1f601c99, Offset: 0x4d90
// Size: 0x44
function initialblack() {
    self closemenu("InitialBlack");
    self openmenu("InitialBlack");
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xa8c330cd, Offset: 0x4de0
// Size: 0x24
function initialblackend() {
    self closemenu("InitialBlack");
}

// Namespace zm
// Params 1, eflags: 0x0
// Checksum 0xf0ef5a50, Offset: 0x4e10
// Size: 0x2c
function function_816dcdcc(time_to_wait) {
    wait time_to_wait;
    level flag::set("start_zombie_round_logic");
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x99e476a5, Offset: 0x4e48
// Size: 0xb4
function getallotherplayers() {
    aliveplayers = [];
    for (i = 0; i < level.players.size; i++) {
        if (!isdefined(level.players[i])) {
            continue;
        }
        player = level.players[i];
        if (player.sessionstate != "playing" || player == self) {
            continue;
        }
        aliveplayers[aliveplayers.size] = player;
    }
    return aliveplayers;
}

// Namespace zm
// Params 1, eflags: 0x0
// Checksum 0x53c9ad43, Offset: 0x4f08
// Size: 0xe4
function updateplayernum(player) {
    if (!isdefined(player.playernum)) {
        if (player.team == "allies") {
            player.playernum = zm_utility::get_game_var("_team1_num");
            zm_utility::function_669b4ee("_team1_num", player.playernum + 1);
            return;
        }
        player.playernum = zm_utility::get_game_var("_team2_num");
        zm_utility::function_669b4ee("_team2_num", player.playernum + 1);
    }
}

// Namespace zm
// Params 2, eflags: 0x0
// Checksum 0x360d40c7, Offset: 0x4ff8
// Size: 0x49a
function getfreespawnpoint(spawnpoints, player) {
    if (!isdefined(spawnpoints)) {
        /#
            iprintlnbold("<dev string:xc1>");
        #/
        return undefined;
    }
    if (!isdefined(game["spawns_randomized"])) {
        game["spawns_randomized"] = 1;
        spawnpoints = array::randomize(spawnpoints);
        random_chance = randomint(100);
        if (random_chance > 50) {
            zm_utility::function_669b4ee("side_selection", 1);
        } else {
            zm_utility::function_669b4ee("side_selection", 2);
        }
    }
    side_selection = zm_utility::get_game_var("side_selection");
    if (zm_utility::get_game_var("switchedsides")) {
        if (side_selection == 2) {
            side_selection = 1;
        } else if (side_selection == 1) {
            side_selection = 2;
        }
    }
    if (isdefined(player) && isdefined(player.team)) {
        for (i = 0; isdefined(spawnpoints) && i < spawnpoints.size; i++) {
            if (side_selection == 1) {
                if (isdefined(spawnpoints[i].script_int) && player.team != "allies" && spawnpoints[i].script_int == 1) {
                    arrayremovevalue(spawnpoints, spawnpoints[i]);
                    i = 0;
                } else if (isdefined(spawnpoints[i].script_int) && player.team == "allies" && spawnpoints[i].script_int == 2) {
                    arrayremovevalue(spawnpoints, spawnpoints[i]);
                    i = 0;
                } else {
                    i++;
                }
                continue;
            }
            if (isdefined(spawnpoints[i].script_int) && player.team == "allies" && spawnpoints[i].script_int == 1) {
                arrayremovevalue(spawnpoints, spawnpoints[i]);
                i = 0;
                continue;
            }
            if (isdefined(spawnpoints[i].script_int) && player.team != "allies" && spawnpoints[i].script_int == 2) {
                arrayremovevalue(spawnpoints, spawnpoints[i]);
                i = 0;
                continue;
            }
        }
    }
    updateplayernum(player);
    for (j = 0; j < spawnpoints.size; j++) {
        if (!isdefined(spawnpoints[j].en_num)) {
            for (m = 0; m < spawnpoints.size; m++) {
                spawnpoints[m].en_num = m;
            }
        }
        if (spawnpoints[j].en_num == player.playernum) {
            return spawnpoints[j];
        }
    }
    return spawnpoints[0];
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x59ebb64b, Offset: 0x54a0
// Size: 0x114
function delete_in_createfx() {
    exterior_goals = struct::get_array("exterior_goal", "targetname");
    for (i = 0; i < exterior_goals.size; i++) {
        if (!isdefined(exterior_goals[i].target)) {
            continue;
        }
        targets = getentarray(exterior_goals[i].target, "targetname");
        for (j = 0; j < targets.size; j++) {
            targets[j] zm_utility::self_delete();
        }
    }
    if (isdefined(level.level_createfx_callback_thread)) {
        level thread [[ level.level_createfx_callback_thread ]]();
    }
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xa673fa12, Offset: 0x55c0
// Size: 0x19c
function add_bots() {
    for (host = util::gethostplayer(); !isdefined(host); host = util::gethostplayer()) {
        wait 0.05;
    }
    wait 4;
    function_55942d64();
    setdvar("bot_AllowMovement", "1");
    setdvar("bot_PressAttackBtn", "1");
    setdvar("bot_PressMeleeBtn", "1");
    while (getplayers().size < 2) {
        wait 0.05;
    }
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i] freezecontrols(0);
        println("<dev string:xe3>");
    }
    level.numberbotsadded = 1;
    level flag::set("start_zombie_round_logic");
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x852e6382, Offset: 0x5768
// Size: 0xda
function function_55942d64() {
    player = util::gethostplayer();
    bot = addtestclient();
    if (!isdefined(bot)) {
        println("<dev string:xf8>");
        return;
    }
    spawnpoint = bot zm_gametype::onfindvalidspawnpoint();
    bot.pers["isBot"] = 1;
    bot.equipment_enabled = 0;
    yaw = spawnpoint.angles[1];
    return bot;
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xa7d21f1c, Offset: 0x5850
// Size: 0x164
function post_all_players_connected() {
    level thread end_game();
    level flag::wait_till("start_zombie_round_logic");
    zm_utility::increment_zm_dash_counter("start_per_game", 1);
    zm_utility::increment_zm_dash_counter("start_per_player", level.players.size);
    zm_utility::upload_zm_dash_counters();
    level.var_e656acd7 = level.players.size;
    println("<dev string:x112>", level.script, "<dev string:x125>", getplayers().size);
    level thread round_end_monitor();
    if (!level.zombie_anim_intro) {
        if (isdefined(level._round_start_func)) {
            level thread [[ level._round_start_func ]]();
        }
    }
    level thread players_playing();
    disablegrenadesuicide();
    level.startinvulnerabletime = getdvarint("player_deathInvulnerableTime");
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xf35c678c, Offset: 0x59c0
// Size: 0x34
function start_zm_dash_counter_watchers() {
    level thread first_consumables_used_watcher();
    level thread players_reached_rounds_counter_watcher();
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x54779a9e, Offset: 0x5a00
// Size: 0x74
function first_consumables_used_watcher() {
    level flag::init("first_consumables_used");
    level flag::wait_till("first_consumables_used");
    zm_utility::increment_zm_dash_counter("first_consumables_used", 1);
    zm_utility::upload_zm_dash_counters();
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x5438e105, Offset: 0x5a80
// Size: 0xb2
function players_reached_rounds_counter_watcher() {
    while (true) {
        level waittill(#"start_of_round");
        if (!isdefined(level.dash_counter_round_reached_5) && level.round_number >= 5) {
            level.dash_counter_round_reached_5 = 1;
            zm_utility::increment_zm_dash_counter("reached_5", 1);
        }
        if (!isdefined(level.dash_counter_round_reached_10) && level.round_number >= 10) {
            level.dash_counter_round_reached_10 = 1;
            zm_utility::increment_zm_dash_counter("reached_10", 1);
            return;
        }
    }
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xbf34b5a9, Offset: 0x5b40
// Size: 0x50
function init_custom_ai_type() {
    if (isdefined(level.custom_ai_type)) {
        for (i = 0; i < level.custom_ai_type.size; i++) {
            [[ level.custom_ai_type[i] ]]();
        }
    }
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xa7fa0724, Offset: 0x5b98
// Size: 0x64
function zombiemode_melee_miss() {
    if (isdefined(self.enemy.var_e75c9abb)) {
        self.enemy dodamage(getdvarint("ai_meleeDamage"), self.origin, self, self, "none", "melee");
    }
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xf5ad6cfb, Offset: 0x5c08
// Size: 0x1dc
function player_track_ammo_count() {
    self notify(#"stop_ammo_tracking");
    self endon(#"disconnect");
    self endon(#"stop_ammo_tracking");
    ammolowcount = 0;
    ammooutcount = 0;
    while (true) {
        wait 0.5;
        weapon = self getcurrentweapon();
        if (weapon == level.weaponnone || weapon.skiplowammovox) {
            continue;
        }
        if (weapon.type == "grenade") {
            continue;
        }
        if (self getammocount(weapon) > 5 || self laststand::player_is_in_laststand()) {
            ammooutcount = 0;
            ammolowcount = 0;
            continue;
        }
        if (self getammocount(weapon) > 0) {
            if (ammolowcount < 1) {
                self zm_audio::create_and_play_dialog("general", "ammo_low");
                ammolowcount++;
            }
        } else if (ammooutcount < 1) {
            wait 0.5;
            if (self getcurrentweapon() !== weapon) {
                continue;
            }
            self zm_audio::create_and_play_dialog("general", "ammo_out");
            ammooutcount++;
        }
        wait 20;
    }
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x770b2946, Offset: 0x5df0
// Size: 0x9c
function spawn_vo() {
    wait 1;
    players = getplayers();
    if (players.size > 1) {
        player = array::random(players);
        index = zm_utility::get_player_index(player);
        player thread spawn_vo_player(index, players.size);
    }
}

// Namespace zm
// Params 2, eflags: 0x0
// Checksum 0x220d6778, Offset: 0x5e98
// Size: 0x70
function spawn_vo_player(index, num) {
    sound = "plr_" + index + "_vox_" + num + "play";
    self playsoundwithnotify(sound, "sound_done");
    self waittill(#"sound_done");
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x507b05d6, Offset: 0x5f10
// Size: 0x20
function precache_models() {
    if (isdefined(level.precachecustomcharacters)) {
        self [[ level.precachecustomcharacters ]]();
    }
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x6d14b74e, Offset: 0x5f38
// Size: 0x14
function init_shellshocks() {
    level.player_killed_shellshock = "zombie_death";
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xbaaf43ec, Offset: 0x5f58
// Size: 0x104
function init_strings() {
    zm_utility::add_zombie_hint("undefined", %ZOMBIE_UNDEFINED);
    zm_utility::add_zombie_hint("default_treasure_chest", %ZOMBIE_RANDOM_WEAPON_COST);
    zm_utility::add_zombie_hint("default_buy_barrier_piece_10", %ZOMBIE_BUTTON_BUY_BACK_BARRIER_10);
    zm_utility::add_zombie_hint("default_buy_barrier_piece_20", %ZOMBIE_BUTTON_BUY_BACK_BARRIER_20);
    zm_utility::add_zombie_hint("default_buy_barrier_piece_50", %ZOMBIE_BUTTON_BUY_BACK_BARRIER_50);
    zm_utility::add_zombie_hint("default_buy_barrier_piece_100", %ZOMBIE_BUTTON_BUY_BACK_BARRIER_100);
    zm_utility::add_zombie_hint("default_reward_barrier_piece", %ZOMBIE_BUTTON_REWARD_BARRIER);
    zm_utility::add_zombie_hint("default_buy_area", %ZOMBIE_BUTTON_BUY_OPEN_AREA_COST);
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x43b0ad9c, Offset: 0x6068
// Size: 0x3e4
function init_sounds() {
    zm_utility::add_sound("end_of_round", "mus_zmb_round_over");
    zm_utility::add_sound("end_of_game", "mus_zmb_game_over");
    zm_utility::add_sound("chalk_one_up", "mus_zmb_chalk");
    zm_utility::add_sound("purchase", "zmb_cha_ching");
    zm_utility::add_sound("no_purchase", "zmb_no_cha_ching");
    zm_utility::add_sound("playerzombie_usebutton_sound", "zmb_zombie_vocals_attack");
    zm_utility::add_sound("playerzombie_attackbutton_sound", "zmb_zombie_vocals_attack");
    zm_utility::add_sound("playerzombie_adsbutton_sound", "zmb_zombie_vocals_attack");
    zm_utility::add_sound("zombie_head_gib", "zmb_zombie_head_gib");
    zm_utility::add_sound("rebuild_barrier_piece", "zmb_repair_boards");
    zm_utility::add_sound("rebuild_barrier_metal_piece", "zmb_metal_repair");
    zm_utility::add_sound("rebuild_barrier_hover", "zmb_boards_float");
    zm_utility::add_sound("debris_hover_loop", "zmb_couch_loop");
    zm_utility::add_sound("break_barrier_piece", "zmb_break_boards");
    zm_utility::add_sound("grab_metal_bar", "zmb_bar_pull");
    zm_utility::add_sound("break_metal_bar", "zmb_bar_break");
    zm_utility::add_sound("drop_metal_bar", "zmb_bar_drop");
    zm_utility::add_sound("blocker_end_move", "zmb_board_slam");
    zm_utility::add_sound("barrier_rebuild_slam", "zmb_board_slam");
    zm_utility::add_sound("bar_rebuild_slam", "zmb_bar_repair");
    zm_utility::add_sound("zmb_rock_fix", "zmb_break_rock_barrier_fix");
    zm_utility::add_sound("zmb_vent_fix", "evt_vent_slat_repair");
    zm_utility::add_sound("zmb_barrier_debris_move", "zmb_barrier_debris_move");
    zm_utility::add_sound("door_slide_open", "zmb_door_slide_open");
    zm_utility::add_sound("door_rotate_open", "zmb_door_slide_open");
    zm_utility::add_sound("debris_move", "zmb_weap_wall");
    zm_utility::add_sound("open_chest", "zmb_lid_open");
    zm_utility::add_sound("music_chest", "zmb_music_box");
    zm_utility::add_sound("close_chest", "zmb_lid_close");
    zm_utility::add_sound("weapon_show", "zmb_weap_wall");
    zm_utility::add_sound("break_stone", "evt_break_stone");
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x3878af35, Offset: 0x6458
// Size: 0x9bc
function init_levelvars() {
    level.is_zombie_level = 1;
    level.default_laststandpistol = getweapon("pistol_standard");
    level.default_solo_laststandpistol = getweapon("pistol_standard_upgraded");
    level.super_ee_weapon = getweapon("pistol_burst");
    level.laststandpistol = level.default_laststandpistol;
    level.start_weapon = level.default_laststandpistol;
    level.first_round = 1;
    level.start_round = getgametypesetting("startRound");
    level.round_number = level.start_round;
    level.enable_magic = getgametypesetting("magic");
    level.headshots_only = getgametypesetting("headshotsonly");
    level.player_starting_points = level.round_number * 500;
    level.round_start_time = 0;
    level.pro_tips_start_time = 0;
    level.intermission = 0;
    level.dog_intermission = 0;
    level.zombie_total = 0;
    level.zombie_respawns = 0;
    level.total_zombies_killed = 0;
    level.hudelem_count = 0;
    level.zm_loc_types = [];
    level.zm_loc_types["zombie_location"] = [];
    level.zm_variant_type_max = [];
    level.zm_variant_type_max["walk"] = [];
    level.zm_variant_type_max["run"] = [];
    level.zm_variant_type_max["sprint"] = [];
    level.zm_variant_type_max["super_sprint"] = [];
    level.zm_variant_type_max["walk"]["down"] = 14;
    level.zm_variant_type_max["walk"]["up"] = 16;
    level.zm_variant_type_max["run"]["down"] = 13;
    level.zm_variant_type_max["run"]["up"] = 12;
    level.zm_variant_type_max["sprint"]["down"] = 9;
    level.zm_variant_type_max["sprint"]["up"] = 8;
    level.zm_variant_type_max["super_sprint"]["down"] = 1;
    level.zm_variant_type_max["super_sprint"]["up"] = 1;
    level.zm_variant_type_max["burned"]["down"] = 1;
    level.zm_variant_type_max["burned"]["up"] = 1;
    level.zm_variant_type_max["jump_pad_super_sprint"]["down"] = 1;
    level.zm_variant_type_max["jump_pad_super_sprint"]["up"] = 1;
    level.current_zombie_array = [];
    level.current_zombie_count = 0;
    level.zombie_total_subtract = 0;
    level.destructible_callbacks = [];
    foreach (team in level.teams) {
        if (!isdefined(level.zombie_vars[team])) {
            level.zombie_vars[team] = [];
        }
    }
    difficulty = 1;
    column = int(difficulty) + 1;
    zombie_utility::set_zombie_var("zombie_health_increase", 100, 0, column);
    zombie_utility::set_zombie_var("zombie_health_increase_multiplier", 0.1, 1, column);
    zombie_utility::set_zombie_var("zombie_health_start", -106, 0, column);
    zombie_utility::set_zombie_var("zombie_spawn_delay", 2, 1, column);
    zombie_utility::set_zombie_var("zombie_new_runner_interval", 10, 0, column);
    zombie_utility::set_zombie_var("zombie_move_speed_multiplier", 4, 0, column);
    zombie_utility::set_zombie_var("zombie_move_speed_multiplier_easy", 2, 0, column);
    zombie_utility::set_zombie_var("zombie_max_ai", 24, 0, column);
    zombie_utility::set_zombie_var("zombie_ai_per_player", 6, 0, column);
    zombie_utility::set_zombie_var("below_world_check", -1000);
    zombie_utility::set_zombie_var("spectators_respawn", 1);
    zombie_utility::set_zombie_var("zombie_use_failsafe", 1);
    zombie_utility::set_zombie_var("zombie_between_round_time", 10);
    zombie_utility::set_zombie_var("zombie_intermission_time", 15);
    zombie_utility::set_zombie_var("game_start_delay", 0, 0, column);
    zombie_utility::set_zombie_var("player_base_health", 100);
    zombie_utility::set_zombie_var("penalty_no_revive", 0.1, 1, column);
    zombie_utility::set_zombie_var("penalty_died", 0, 1, column);
    zombie_utility::set_zombie_var("penalty_downed", 0.05, 1, column);
    zombie_utility::set_zombie_var("zombie_score_kill_4player", 50);
    zombie_utility::set_zombie_var("zombie_score_kill_3player", 50);
    zombie_utility::set_zombie_var("zombie_score_kill_2player", 50);
    zombie_utility::set_zombie_var("zombie_score_kill_1player", 50);
    zombie_utility::set_zombie_var("zombie_score_damage_normal", 10);
    zombie_utility::set_zombie_var("zombie_score_damage_light", 10);
    zombie_utility::set_zombie_var("zombie_score_bonus_melee", 80);
    zombie_utility::set_zombie_var("zombie_score_bonus_head", 50);
    zombie_utility::set_zombie_var("zombie_score_bonus_neck", 20);
    zombie_utility::set_zombie_var("zombie_score_bonus_torso", 10);
    zombie_utility::set_zombie_var("zombie_score_bonus_burn", 10);
    zombie_utility::set_zombie_var("zombie_flame_dmg_point_delay", 500);
    zombie_utility::set_zombie_var("zombify_player", 0);
    if (issplitscreen()) {
        zombie_utility::set_zombie_var("zombie_timer_offset", 280);
    }
    level thread init_player_levelvars();
    level.gamedifficulty = getgametypesetting("zmDifficulty");
    if (level.gamedifficulty == 0) {
        level.zombie_move_speed = level.round_number * level.zombie_vars["zombie_move_speed_multiplier_easy"];
    } else {
        level.zombie_move_speed = level.round_number * level.zombie_vars["zombie_move_speed_multiplier"];
    }
    if (level.round_number == 1) {
        level.zombie_move_speed = 1;
    }
    level.speed_change_max = 0;
    level.speed_change_num = 0;
    set_round_number(level.round_number);
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x9547cb0, Offset: 0x6e20
// Size: 0xf2
function init_player_levelvars() {
    level flag::wait_till("start_zombie_round_logic");
    difficulty = 1;
    column = int(difficulty) + 1;
    for (i = 0; i < 8; i++) {
        points = 500;
        if (i > 3) {
            points = 3000;
        }
        points = zombie_utility::set_zombie_var("zombie_score_start_" + i + 1 + "p", points, 0, column);
    }
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xe432219c, Offset: 0x6f20
// Size: 0x19c
function init_dvars() {
    if (getdvarstring("zombie_debug") == "") {
        setdvar("zombie_debug", "0");
    }
    if (getdvarstring("scr_zm_enable_bots") == "") {
        setdvar("scr_zm_enable_bots", "0");
    }
    if (getdvarstring("zombie_cheat") == "") {
        setdvar("zombie_cheat", "0");
    }
    if (getdvarstring("zombiemode_debug_zombie_count") == "") {
        setdvar("zombiemode_debug_zombie_count", "0");
    }
    if (level.script != "zombie_cod5_prototype") {
        setdvar("magic_chest_movable", "1");
    }
    setdvar("revive_trigger_radius", "75");
    setdvar("scr_deleteexplosivesonspawn", "0");
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xd8c2ed9e, Offset: 0x70c8
// Size: 0x1fc
function init_function_overrides() {
    level.callbackplayerdamage = &callback_playerdamage;
    level.overrideplayerdamage = &player_damage_override;
    level.callbackplayerkilled = &player_killed_override;
    level.playerlaststand_func = &player_laststand;
    level.callbackplayerlaststand = &callback_playerlaststand;
    level.prevent_player_damage = &player_prevent_damage;
    level.callbackactorkilled = &actor_killed_override;
    level.callbackactordamage = &actor_damage_override_wrapper;
    level.callbackvehicledamage = &vehicle_damage_override;
    level.callbackvehiclekilled = &globallogic_vehicle::callback_vehiclekilled;
    level.callbackvehicleradiusdamage = &globallogic_vehicle::callback_vehicleradiusdamage;
    level.custom_introscreen = &zombie_intro_screen;
    level.custom_intermission = &player_intermission;
    level.global_damage_func = &zm_spawner::zombie_damage;
    level.global_damage_func_ads = &zm_spawner::zombie_damage_ads;
    level.reset_clientdvars = &onplayerconnect_clientdvars;
    level.zombie_last_stand = &function_a47dc1dc;
    level.zombie_last_stand_pistol_memory = &last_stand_save_pistol_ammo;
    level.zombie_last_stand_ammo_return = &last_stand_restore_pistol_ammo;
    level.player_becomes_zombie = &zombify_player;
    level.validate_enemy_path_length = &zm_utility::default_validate_enemy_path_length;
}

// Namespace zm
// Params 9, eflags: 0x0
// Checksum 0x3d93f68, Offset: 0x72d0
// Size: 0x8c
function callback_playerlaststand(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    self endon(#"disconnect");
    zm_laststand::playerlaststand(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
}

// Namespace zm
// Params 4, eflags: 0x0
// Checksum 0x2d66980b, Offset: 0x7368
// Size: 0x11c
function codecallback_destructibleevent(event, param1, param2, param3) {
    if (event == "broken") {
        notify_type = param1;
        attacker = param2;
        weapon = param3;
        if (isdefined(level.destructible_callbacks[notify_type])) {
            self thread [[ level.destructible_callbacks[notify_type] ]](notify_type, attacker);
        }
        self notify(event, notify_type, attacker);
        return;
    }
    if (event == "breakafter") {
        piece = param1;
        time = param2;
        damage = param3;
        self thread breakafter(time, damage, piece);
    }
}

// Namespace zm
// Params 3, eflags: 0x0
// Checksum 0xf97ad49d, Offset: 0x7490
// Size: 0x64
function breakafter(time, damage, piece) {
    self notify(#"breakafter");
    self endon(#"breakafter");
    wait time;
    self dodamage(damage, self.origin, undefined, undefined);
}

// Namespace zm
// Params 13, eflags: 0x0
// Checksum 0xee7fbd87, Offset: 0x7500
// Size: 0x6ac
function callback_playerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal) {
    startedinlaststand = 0;
    if (isplayer(self)) {
        startedinlaststand = self laststand::player_is_in_laststand();
    }
    println("<dev string:x14c>" + idamage + "<dev string:x165>");
    if (isdefined(eattacker) && isplayer(eattacker) && eattacker.sessionteam == self.sessionteam && !eattacker hasperk("specialty_playeriszombie") && !(isdefined(self.is_zombie) && self.is_zombie)) {
        self process_friendly_fire_callbacks(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex);
        if (self != eattacker) {
            println("<dev string:x167>");
            return;
        } else if (smeansofdeath != "MOD_GRENADE_SPLASH" && smeansofdeath != "MOD_GRENADE" && smeansofdeath != "MOD_EXPLOSIVE" && smeansofdeath != "MOD_PROJECTILE" && smeansofdeath != "MOD_PROJECTILE_SPLASH" && smeansofdeath != "MOD_BURNED" && smeansofdeath != "MOD_SUICIDE") {
            println("<dev string:x190>");
            return;
        }
    }
    if (isdefined(level.pers_upgrade_insta_kill) && level.pers_upgrade_insta_kill) {
        self zm_pers_upgrades_functions::pers_insta_kill_melee_swipe(smeansofdeath, eattacker);
    }
    if (isdefined(self.overrideplayerdamage)) {
        idamage = self [[ self.overrideplayerdamage ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
    } else if (isdefined(level.overrideplayerdamage)) {
        idamage = self [[ level.overrideplayerdamage ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
    }
    assert(isdefined(idamage), "<dev string:x1b1>");
    if (isdefined(self.magic_bullet_shield) && self.magic_bullet_shield) {
        maxhealth = self.maxhealth;
        self.health += idamage;
        self.maxhealth = maxhealth;
    }
    if (isdefined(self.divetoprone) && self.divetoprone == 1) {
        if (smeansofdeath == "MOD_GRENADE_SPLASH") {
            dist = distance2d(vpoint, self.origin);
            if (dist > 32) {
                var_fbd9ba9a = vectordot(anglestoforward(self.angles), vdir);
                if (var_fbd9ba9a > 0) {
                    idamage = int(idamage * 0.5);
                }
            }
        }
    }
    println("<dev string:x1ea>");
    if (isdefined(level.prevent_player_damage)) {
        if (self [[ level.prevent_player_damage ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime)) {
            return;
        }
    }
    idflags |= level.idflags_no_knockback;
    if (idamage > 0 && shitloc == "riotshield") {
        shitloc = "torso_upper";
    }
    println("<dev string:x1f0>");
    wasdowned = 0;
    if (isplayer(self)) {
        wasdowned = !startedinlaststand && self laststand::player_is_in_laststand();
    }
    /#
        if (isdefined(eattacker)) {
            record3dtext("<dev string:x20c>" + idamage + "<dev string:x20f>" + self.health + "<dev string:x214>" + eattacker getentitynumber(), self.origin, (1, 0, 0), "<dev string:x219>", self);
        } else {
            record3dtext("<dev string:x20c>" + idamage + "<dev string:x20f>" + self.health + "<dev string:x220>", self.origin, (1, 0, 0), "<dev string:x219>", self);
        }
    #/
    self finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
    bb::logdamage(eattacker, self, weapon, idamage, smeansofdeath, shitloc, self.health <= 0, wasdowned);
}

// Namespace zm
// Params 13, eflags: 0x0
// Checksum 0x59ce70f, Offset: 0x7bb8
// Size: 0xb4
function finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal) {
    self finishplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
}

// Namespace zm
// Params 1, eflags: 0x0
// Checksum 0x4fbe04b8, Offset: 0x7c78
// Size: 0x3a
function register_player_friendly_fire_callback(callback) {
    if (!isdefined(level.player_friendly_fire_callbacks)) {
        level.player_friendly_fire_callbacks = [];
    }
    level.player_friendly_fire_callbacks[level.player_friendly_fire_callbacks.size] = callback;
}

// Namespace zm
// Params 11, eflags: 0x0
// Checksum 0x6befcff2, Offset: 0x7cc0
// Size: 0x112
function process_friendly_fire_callbacks(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex) {
    if (isdefined(level.player_friendly_fire_callbacks)) {
        foreach (callback in level.player_friendly_fire_callbacks) {
            self [[ callback ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex);
        }
    }
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x9adc2d6e, Offset: 0x7de0
// Size: 0x2da
function init_flags() {
    level flag::init("solo_game");
    level flag::init("start_zombie_round_logic");
    level flag::init("start_encounters_match_logic");
    level flag::init("spawn_point_override");
    level flag::init("crawler_round");
    level flag::init("spawn_zombies", 1);
    level flag::init("special_round");
    level flag::init("dog_round");
    level flag::init("raps_round");
    level flag::init("begin_spawning");
    level flag::init("end_round_wait");
    level flag::init("wait_and_revive");
    level flag::init("instant_revive");
    level flag::init("initial_blackscreen_passed");
    level flag::init("initial_players_connected");
    level flag::init("power_on");
    power_trigs = getentarray("use_elec_switch", "targetname");
    foreach (trig in power_trigs) {
        if (isdefined(trig.script_int)) {
            level flag::init("power_on" + trig.script_int);
        }
    }
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x1e10f555, Offset: 0x80c8
// Size: 0x3bc
function init_client_field_callback_funcs() {
    clientfield::register("actor", "zombie_riser_fx", 1, 1, "int");
    if (isdefined(level.use_water_risers) && level.use_water_risers) {
        clientfield::register("actor", "zombie_riser_fx_water", 1, 1, "int");
    }
    if (isdefined(level.use_foliage_risers) && level.use_foliage_risers) {
        clientfield::register("actor", "zombie_riser_fx_foliage", 1, 1, "int");
    }
    if (isdefined(level.use_low_gravity_risers) && level.use_low_gravity_risers) {
        clientfield::register("actor", "zombie_riser_fx_lowg", 1, 1, "int");
    }
    clientfield::register("actor", "zombie_has_eyes", 1, 1, "int");
    clientfield::register("actor", "zombie_ragdoll_explode", 1, 1, "int");
    clientfield::register("actor", "zombie_gut_explosion", 1, 1, "int");
    clientfield::register("actor", "sndZombieContext", -1, 1, "int");
    clientfield::register("actor", "zombie_keyline_render", 1, 1, "int");
    bits = 4;
    trigs = getentarray("use_elec_switch", "targetname");
    if (isdefined(trigs)) {
        bits = getminbitcountfornum(trigs.size + 1);
    }
    clientfield::register("world", "zombie_power_on", 1, bits, "int");
    clientfield::register("world", "zombie_power_off", 1, bits, "int");
    clientfield::register("world", "round_complete_time", 1, 20, "int");
    clientfield::register("world", "round_complete_num", 1, 8, "int");
    clientfield::register("world", "game_end_time", 1, 20, "int");
    clientfield::register("world", "quest_complete_time", 1, 20, "int");
    clientfield::register("world", "game_start_time", 15001, 20, "int");
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xd66cd9ea, Offset: 0x8490
// Size: 0x332
function init_fx() {
    level.createfx_callback_thread = &delete_in_createfx;
    level._effect["fx_zombie_bar_break"] = "_t6/maps/zombie/fx_zombie_bar_break";
    level._effect["fx_zombie_bar_break_lite"] = "_t6/maps/zombie/fx_zombie_bar_break_lite";
    if (!(isdefined(level.fx_exclude_edge_fog) && level.fx_exclude_edge_fog)) {
        level._effect["edge_fog"] = "_t6/maps/zombie/fx_fog_zombie_amb";
    }
    level._effect["chest_light"] = "zombie/fx_weapon_box_open_glow_zmb";
    level._effect["chest_light_closed"] = "zombie/fx_weapon_box_closed_glow_zmb";
    if (!(isdefined(level.var_63b5ec) && level.var_63b5ec)) {
        level._effect["eye_glow"] = "zombie/fx_glow_eye_orange";
    }
    level._effect["headshot"] = "zombie/fx_bul_flesh_head_fatal_zmb";
    level._effect["headshot_nochunks"] = "zombie/fx_bul_flesh_head_nochunks_zmb";
    level._effect["bloodspurt"] = "zombie/fx_bul_flesh_neck_spurt_zmb";
    if (!(isdefined(level.fx_exclude_tesla_head_light) && level.fx_exclude_tesla_head_light)) {
        level._effect["tesla_head_light"] = "_t6/maps/zombie/fx_zombie_tesla_neck_spurt";
    }
    level._effect["zombie_guts_explosion"] = "zombie/fx_blood_torso_explo_lg_zmb";
    level._effect["rise_burst_water"] = "zombie/fx_spawn_dirt_hand_burst_zmb";
    level._effect["rise_billow_water"] = "zombie/fx_spawn_dirt_body_billowing_zmb";
    level._effect["rise_dust_water"] = "zombie/fx_spawn_dirt_body_dustfalling_zmb";
    level._effect["rise_burst"] = "zombie/fx_spawn_dirt_hand_burst_zmb";
    level._effect["rise_billow"] = "zombie/fx_spawn_dirt_body_billowing_zmb";
    level._effect["rise_dust"] = "zombie/fx_spawn_dirt_body_dustfalling_zmb";
    level._effect["fall_burst"] = "zombie/fx_spawn_dirt_hand_burst_zmb";
    level._effect["fall_billow"] = "zombie/fx_spawn_dirt_body_billowing_zmb";
    level._effect["fall_dust"] = "zombie/fx_spawn_dirt_body_dustfalling_zmb";
    level._effect["character_fire_death_sm"] = "zombie/fx_fire_torso_zmb";
    level._effect["character_fire_death_torso"] = "zombie/fx_fire_torso_zmb";
    if (!(isdefined(level.fx_exclude_default_explosion) && level.fx_exclude_default_explosion)) {
        level._effect["def_explosion"] = "_t6/explosions/fx_default_explosion";
    }
    if (!(isdefined(level.disable_fx_upgrade_aquired) && level.disable_fx_upgrade_aquired)) {
        level._effect["upgrade_aquired"] = "_t6/maps/zombie/fx_zmb_tanzit_upgrade";
    }
}

// Namespace zm
// Params 5, eflags: 0x0
// Checksum 0x477ef2a4, Offset: 0x87d0
// Size: 0x4c
function zombie_intro_screen(string1, string2, string3, string4, string5) {
    level flag::wait_till("start_zombie_round_logic");
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x8453f8cd, Offset: 0x8828
// Size: 0x60
function players_playing() {
    players = getplayers();
    level.players_playing = players.size;
    wait 20;
    players = getplayers();
    level.players_playing = players.size;
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x4d782060, Offset: 0x8890
// Size: 0x10c
function onplayerconnect_clientdvars() {
    self setclientcompass(0);
    self setclientthirdperson(0);
    self resetfov();
    self setclientthirdpersonangle(0);
    self setclientuivisibilityflag("weapon_hud_visible", 1);
    self setclientminiscoreboardhide(1);
    self setclienthudhardcore(0);
    self setclientplayerpushamount(1);
    self setdepthoffield(0, 0, 512, 4000, 4, 0);
    self zm_laststand::function_590a49b2();
}

// Namespace zm
// Params 1, eflags: 0x0
// Checksum 0x2c6fe200, Offset: 0x89a8
// Size: 0xfe
function checkforalldead(excluded_player) {
    players = getplayers();
    count = 0;
    for (i = 0; i < players.size; i++) {
        if (isdefined(excluded_player) && excluded_player == players[i]) {
            continue;
        }
        if (!players[i] laststand::player_is_in_laststand() && !(players[i].sessionstate == "spectator")) {
            count++;
        }
    }
    if (count == 0 && !(isdefined(level.no_end_game_check) && level.no_end_game_check)) {
        level notify(#"end_game");
    }
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x53b3e651, Offset: 0x8ab0
// Size: 0x500
function onplayerspawned() {
    self endon(#"disconnect");
    self notify(#"stop_onplayerspawned");
    self endon(#"stop_onplayerspawned");
    for (;;) {
        self waittill(#"spawned_player");
        if (!(isdefined(level.host_ended_game) && level.host_ended_game)) {
            self freezecontrols(0);
            println("<dev string:x22e>");
        }
        self.hits = 0;
        self zm_utility::init_player_offhand_weapons();
        lethal_grenade = self zm_utility::get_player_lethal_grenade();
        if (!self hasweapon(lethal_grenade)) {
            self giveweapon(lethal_grenade);
            self setweaponammoclip(lethal_grenade, 0);
        }
        self recordplayerrevivezombies(self);
        /#
            if (getdvarint("<dev string:x243>") >= 1 && getdvarint("<dev string:x243>") <= 3) {
                self enableinvulnerability();
            }
        #/
        self setactionslot(3, "altMode");
        self playerknockback(0);
        self setclientthirdperson(0);
        self resetfov();
        self setclientthirdpersonangle(0);
        self setdepthoffield(0, 0, 512, 4000, 4, 0);
        self cameraactivate(0);
        self.num_perks = 0;
        self.on_lander_last_stand = undefined;
        self setblur(0, 0.1);
        self.zmbdialogqueue = [];
        self.zmbdialogactive = 0;
        self.zmbdialoggroups = [];
        self.zmbdialoggroup = "";
        if (isdefined(level.player_out_of_playable_area_monitor) && level.player_out_of_playable_area_monitor) {
            self thread player_out_of_playable_area_monitor();
        }
        if (isdefined(level.player_too_many_weapons_monitor) && level.player_too_many_weapons_monitor) {
            self thread [[ level.player_too_many_weapons_monitor_func ]]();
        }
        if (isdefined(level.player_too_many_players_check) && level.player_too_many_players_check) {
            level thread [[ level.player_too_many_players_check_func ]]();
        }
        self.var_46793f8f = [];
        if (isdefined(self.player_initialized)) {
            if (self.player_initialized == 0) {
                self.player_initialized = 1;
                self giveweapon(self zm_utility::get_player_lethal_grenade());
                self setweaponammoclip(self zm_utility::get_player_lethal_grenade(), 0);
                self setclientuivisibilityflag("weapon_hud_visible", 1);
                self setclientminiscoreboardhide(0);
                self.is_drinking = 0;
                self thread function_39d714b5();
                self thread player_monitor_travel_dist();
                self thread player_monitor_time_played();
                if (isdefined(level.custom_player_track_ammo_count)) {
                    self thread [[ level.custom_player_track_ammo_count ]]();
                } else {
                    self thread player_track_ammo_count();
                }
                self thread zm_utility::shock_onpain();
                self thread player_grenade_watcher();
                self laststand::revive_hud_create();
                if (isdefined(level.zm_gamemodule_spawn_func)) {
                    self thread [[ level.zm_gamemodule_spawn_func ]]();
                }
                self thread player_spawn_protection();
                if (!isdefined(self.lives)) {
                    self.lives = 0;
                }
            }
        }
    }
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xeebacd21, Offset: 0x8fb8
// Size: 0x6c
function player_spawn_protection() {
    self endon(#"disconnect");
    self zm_utility::function_139befeb();
    x = 0;
    while (x < 60) {
        x++;
        wait 0.05;
    }
    self zm_utility::function_36f941b3();
}

// Namespace zm
// Params 3, eflags: 0x0
// Checksum 0x397625d9, Offset: 0x9030
// Size: 0x68
function spawn_life_brush(origin, radius, height) {
    life_brush = spawn("trigger_radius", origin, 0, radius, height);
    life_brush.script_noteworthy = "life_brush";
    return life_brush;
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xeceb9729, Offset: 0x90a0
// Size: 0x90
function in_life_brush() {
    life_brushes = getentarray("life_brush", "script_noteworthy");
    if (!isdefined(life_brushes)) {
        return false;
    }
    for (i = 0; i < life_brushes.size; i++) {
        if (self istouching(life_brushes[i])) {
            return true;
        }
    }
    return false;
}

// Namespace zm
// Params 3, eflags: 0x0
// Checksum 0x72b480b4, Offset: 0x9138
// Size: 0x68
function spawn_kill_brush(origin, radius, height) {
    kill_brush = spawn("trigger_radius", origin, 0, radius, height);
    kill_brush.script_noteworthy = "kill_brush";
    return kill_brush;
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x8da70110, Offset: 0x91a8
// Size: 0xaa
function in_kill_brush() {
    kill_brushes = getentarray("kill_brush", "script_noteworthy");
    self.kill_brush = undefined;
    if (!isdefined(kill_brushes)) {
        return false;
    }
    for (i = 0; i < kill_brushes.size; i++) {
        if (self istouching(kill_brushes[i])) {
            self.kill_brush = kill_brushes[i];
            return true;
        }
    }
    return false;
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x701d04cd, Offset: 0x9260
// Size: 0xc8
function in_enabled_playable_area() {
    zm_zonemgr::wait_zone_flags_updating();
    playable_area = getentarray("player_volume", "script_noteworthy");
    if (!isdefined(playable_area)) {
        return false;
    }
    for (i = 0; i < playable_area.size; i++) {
        if (zm_zonemgr::zone_is_enabled(playable_area[i].targetname) && self istouching(playable_area[i])) {
            return true;
        }
    }
    return false;
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x4318c6c5, Offset: 0x9330
// Size: 0x2c
function get_player_out_of_playable_area_monitor_wait_time() {
    /#
        if (isdefined(level.check_kill_thread_every_frame) && level.check_kill_thread_every_frame) {
            return 0.05;
        }
    #/
    return 3;
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xb222e902, Offset: 0x9368
// Size: 0x380
function player_out_of_playable_area_monitor() {
    self notify(#"stop_player_out_of_playable_area_monitor");
    self endon(#"stop_player_out_of_playable_area_monitor");
    self endon(#"disconnect");
    level endon(#"end_game");
    while (!isdefined(self.characterindex)) {
        wait 0.05;
    }
    wait 0.15 * self.characterindex;
    while (true) {
        if (self.sessionstate == "spectator") {
            wait get_player_out_of_playable_area_monitor_wait_time();
            continue;
        }
        if (isdefined(level.var_c303b23b) && level.var_c303b23b) {
            wait get_player_out_of_playable_area_monitor_wait_time();
            continue;
        }
        if (isdefined(self [[ level.player_out_of_playable_area_override ]]()) && isdefined(level.player_out_of_playable_area_override) && (self in_kill_brush() || !self in_enabled_playable_area() || !self in_life_brush() && self [[ level.player_out_of_playable_area_override ]]())) {
            if (!isdefined(level.player_out_of_playable_area_monitor_callback) || self [[ level.player_out_of_playable_area_monitor_callback ]]()) {
                /#
                    if (isdefined(level.kill_thread_test_mode) && level.kill_thread_test_mode) {
                        printtoprightln("<dev string:x250>" + self.origin);
                        wait get_player_out_of_playable_area_monitor_wait_time();
                        continue;
                    }
                    if (isdefined(level.disable_kill_thread) && (self isinmovemode("<dev string:x267>", "<dev string:x26b>") || level.disable_kill_thread) || getdvarint("<dev string:x243>") > 0) {
                        wait get_player_out_of_playable_area_monitor_wait_time();
                        continue;
                    }
                #/
                self zm_stats::increment_map_cheat_stat("cheat_out_of_playable");
                self zm_stats::increment_client_stat("cheat_out_of_playable", 0);
                self zm_stats::increment_client_stat("cheat_total", 0);
                self playlocalsound(level.zmb_laugh_alias);
                wait 0.5;
                if (isdefined(self.waiting_to_revive) && getplayers().size == 1 && level flag::get("solo_game") && self.waiting_to_revive) {
                    level notify(#"end_game");
                } else {
                    self disableinvulnerability();
                    self.lives = 0;
                    self dodamage(self.health + 1000, self.origin);
                    self.bleedout_time = 0;
                }
            }
        }
        wait get_player_out_of_playable_area_monitor_wait_time();
    }
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xe6985129, Offset: 0x96f0
// Size: 0x8
function function_201bdf19() {
    return 3;
}

// Namespace zm
// Params 1, eflags: 0x0
// Checksum 0x92d6eb5b, Offset: 0x9700
// Size: 0x126
function function_7cbf152c(var_2dbc495) {
    self endon(#"hash_826ea773");
    self util::waittill_any("player_downed", "replace_weapon_powerup");
    for (i = 0; i < var_2dbc495.size; i++) {
        self takeweapon(var_2dbc495[i]);
    }
    self zm_score::player_reduce_points("take_all");
    self zm_utility::give_start_weapon(0);
    if (!self laststand::player_is_in_laststand()) {
        self zm_utility::decrement_is_drinking();
    } else if (level flag::get("solo_game")) {
        self.score_lost_when_downed = 0;
    }
    self notify(#"hash_826ea773");
}

// Namespace zm
// Params 1, eflags: 0x0
// Checksum 0x6c7a6b48, Offset: 0x9830
// Size: 0x1c2
function function_b730d298(var_2dbc495) {
    self thread function_7cbf152c(var_2dbc495);
    self endon(#"player_downed");
    self endon(#"replace_weapon_powerup");
    self zm_utility::increment_is_drinking();
    var_166fb977 = zm_utility::round_up_to_ten(int(self.score / (var_2dbc495.size + 1)));
    for (i = 0; i < var_2dbc495.size; i++) {
        self playlocalsound(level.zmb_laugh_alias);
        self switchtoweapon(var_2dbc495[i]);
        self zm_score::player_reduce_points("take_specified", var_166fb977);
        wait 3;
        self takeweapon(var_2dbc495[i]);
    }
    self playlocalsound(level.zmb_laugh_alias);
    self zm_score::player_reduce_points("take_all");
    wait 1;
    self zm_utility::give_start_weapon(1);
    self zm_utility::decrement_is_drinking();
    self notify(#"hash_826ea773");
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x54aec34e, Offset: 0x9a00
// Size: 0x308
function function_67a71cec() {
    self notify(#"hash_4a2281cb");
    self endon(#"hash_4a2281cb");
    self endon(#"disconnect");
    level endon(#"end_game");
    scalar = self.characterindex;
    if (!isdefined(scalar)) {
        scalar = self getentitynumber();
    }
    wait 0.15 * scalar;
    while (true) {
        if (self zm_utility::has_powerup_weapon() || self laststand::player_is_in_laststand() || self.sessionstate == "spectator" || isdefined(self.laststandpistol)) {
            wait function_201bdf19();
            continue;
        }
        /#
            if (getdvarint("<dev string:x243>") > 0) {
                wait function_201bdf19();
                continue;
            }
        #/
        weapon_limit = zm_utility::get_player_weapon_limit(self);
        primaryweapons = self getweaponslistprimaries();
        if (primaryweapons.size > weapon_limit) {
            self zm_weapons::take_fallback_weapon();
            primaryweapons = self getweaponslistprimaries();
        }
        var_2dbc495 = [];
        for (i = 0; i < primaryweapons.size; i++) {
            if (zm_weapons::is_weapon_included(primaryweapons[i]) || zm_weapons::is_weapon_upgraded(primaryweapons[i])) {
                var_2dbc495[var_2dbc495.size] = primaryweapons[i];
            }
        }
        if (var_2dbc495.size > weapon_limit) {
            if (!isdefined(level.var_9abdcf26) || self [[ level.var_9abdcf26 ]](var_2dbc495)) {
                self zm_stats::increment_map_cheat_stat("cheat_too_many_weapons");
                self zm_stats::increment_client_stat("cheat_too_many_weapons", 0);
                self zm_stats::increment_client_stat("cheat_total", 0);
                self thread function_b730d298(var_2dbc495);
                self waittill(#"hash_826ea773");
            }
        }
        wait function_201bdf19();
    }
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xe6d65d37, Offset: 0x9d10
// Size: 0xa0
function player_monitor_travel_dist() {
    self endon(#"disconnect");
    self notify(#"stop_player_monitor_travel_dist");
    self endon(#"stop_player_monitor_travel_dist");
    for (prevpos = self.origin; true; prevpos = self.origin) {
        wait 0.1;
        self.pers["distance_traveled"] = self.pers["distance_traveled"] + distance(self.origin, prevpos);
    }
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x1468b84d, Offset: 0x9db8
// Size: 0x68
function player_monitor_time_played() {
    self endon(#"disconnect");
    self notify(#"stop_player_monitor_time_played");
    self endon(#"stop_player_monitor_time_played");
    level flag::wait_till("start_zombie_round_logic");
    for (;;) {
        wait 1;
        zm_stats::increment_client_stat("time_played_total");
    }
}

// Namespace zm
// Params 1, eflags: 0x0
// Checksum 0xcdfbf565, Offset: 0x9e28
// Size: 0x2bc
function player_grenade_multiattack_bookmark_watcher(grenade) {
    self endon(#"disconnect");
    waittillframeend();
    if (!isdefined(grenade)) {
        return;
    }
    inflictorentnum = grenade getentitynumber();
    inflictorenttype = grenade getentitytype();
    inflictorbirthtime = 0;
    if (isdefined(grenade.birthtime)) {
        inflictorbirthtime = grenade.birthtime;
    }
    ret_val = grenade util::function_183e3618(15, "explode", "death", self, "disconnect");
    if (isdefined(ret_val) && (!isdefined(self) || "timeout" == ret_val)) {
        return;
    }
    self.grenade_multiattack_count = 0;
    self.grenade_multiattack_ent = undefined;
    self.grenade_multikill_count = 0;
    waittillframeend();
    if (!isdefined(self)) {
        return;
    }
    count = level.grenade_multiattack_bookmark_count;
    if (isdefined(grenade.grenade_multiattack_bookmark_count) && grenade.grenade_multiattack_bookmark_count) {
        count = grenade.grenade_multiattack_bookmark_count;
    }
    var_a6b3f98f = "zm_player_grenade_multiattack";
    if (isdefined(grenade.use_grenade_special_long_bookmark) && grenade.use_grenade_special_long_bookmark) {
        var_a6b3f98f = "zm_player_grenade_special_long";
    } else if (isdefined(grenade.use_grenade_special_bookmark) && grenade.use_grenade_special_bookmark) {
        var_a6b3f98f = "zm_player_grenade_special";
    }
    if (count <= self.grenade_multiattack_count && isdefined(self.grenade_multiattack_ent)) {
        adddemobookmark(var_a6b3f98f, gettime(), self getentitynumber(), -1, 0, inflictorentnum, inflictorenttype, inflictorbirthtime, 0, self.grenade_multiattack_ent getentitynumber());
    }
    if (5 <= self.grenade_multikill_count) {
        self zm_stats::increment_challenge_stat("ZOMBIE_HUNTER_EXPLOSION_MULTIKILL");
    }
    self.grenade_multiattack_count = 0;
    self.grenade_multikill_count = 0;
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xf481ec5a, Offset: 0xa0f0
// Size: 0xe4
function player_grenade_watcher() {
    self endon(#"disconnect");
    self notify(#"stop_player_grenade_watcher");
    self endon(#"stop_player_grenade_watcher");
    self.grenade_multiattack_count = 0;
    self.grenade_multikill_count = 0;
    while (true) {
        self waittill(#"grenade_fire", grenade, weapon);
        if (isdefined(grenade) && isalive(grenade)) {
            grenade.team = self.team;
        }
        self thread player_grenade_multiattack_bookmark_watcher(grenade);
        if (isdefined(level.grenade_watcher)) {
            self [[ level.grenade_watcher ]](grenade, weapon);
        }
    }
}

// Namespace zm
// Params 10, eflags: 0x0
// Checksum 0xa75b1d8a, Offset: 0xa1e0
// Size: 0xf0
function player_prevent_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
    if (!isdefined(einflictor) || !isdefined(eattacker)) {
        return false;
    }
    if (einflictor == self || eattacker == self) {
        return false;
    }
    if (isdefined(einflictor) && isdefined(einflictor.team)) {
        if (!(isdefined(einflictor.damage_own_team) && einflictor.damage_own_team)) {
            if (einflictor.team == self.team) {
                return true;
            }
        }
    }
    return false;
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x78338077, Offset: 0xa2d8
// Size: 0x1d0
function player_revive_monitor() {
    self endon(#"disconnect");
    self notify(#"stop_player_revive_monitor");
    self endon(#"stop_player_revive_monitor");
    while (true) {
        self waittill(#"player_revived", reviver);
        self playsoundtoplayer("zmb_character_revived", self);
        if (isdefined(level.isresetting_grief) && level.isresetting_grief) {
            continue;
        }
        if (isdefined(reviver)) {
            if (reviver != self) {
                if (math::cointoss()) {
                    self zm_audio::create_and_play_dialog("general", "revive_up");
                } else {
                    reviver zm_audio::create_and_play_dialog("general", "revive_support");
                }
            } else {
                self zm_audio::create_and_play_dialog("general", "revive_up");
            }
            points = self.score_lost_when_downed;
            if (!isdefined(points)) {
                points = 0;
            }
            println("<dev string:x272>" + points);
            reviver zm_score::player_add_points("reviver", points);
            self.score_lost_when_downed = 0;
            if (isplayer(reviver) && reviver != self) {
                reviver zm_stats::increment_challenge_stat("SURVIVALIST_REVIVE");
            }
        }
    }
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xac9655e9, Offset: 0xa4b0
// Size: 0xee
function function_7568e30a() {
    if (isdefined(self.var_4ea33925)) {
        var_c685517 = int(-1);
        if (self.var_4ea33925.size > 1) {
            var_c685517 = randomint(self.var_4ea33925.size - 1);
        }
        for (i = 0; i < self.var_4ea33925.size; i++) {
            if (self hasperk(self.var_4ea33925[i])) {
                continue;
            }
            if (i == var_c685517) {
                continue;
            }
            zm_perks::give_perk(self.var_4ea33925[i]);
        }
    }
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x6ccb5985, Offset: 0xa5a8
// Size: 0x8c
function function_4f798a75() {
    self endon(#"death");
    self endon(#"player_revived");
    for (var_c951fac1 = 1; var_c951fac1; var_c951fac1 = 0) {
        self waittill(#"remote_revive", reviver);
        if (reviver.team == self.team) {
        }
    }
    self zm_laststand::remote_revive(reviver);
}

// Namespace zm
// Params 9, eflags: 0x0
// Checksum 0x3149c58f, Offset: 0xa640
// Size: 0x3b4
function player_laststand(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    println("<dev string:x28f>");
    var_54d1a8f4 = 0;
    self allowjump(0);
    currweapon = self getcurrentweapon();
    self addweaponstat(currweapon, "deathsDuringUse", 1);
    if (isdefined(self.var_698f7e["perk_lose"]) && self.var_698f7e["perk_lose"]) {
        self zm_pers_upgrades_functions::function_b725835b();
    }
    players = getplayers();
    if (players.size == 1 && level flag::get("solo_game")) {
        if (self.lives > 0 && self hasperk("specialty_quickrevive")) {
            self thread wait_and_revive();
        }
    }
    self zm_utility::clear_is_drinking();
    self thread function_4f798a75();
    self zm_score::player_downed_penalty();
    self disableoffhandweapons();
    self thread function_43aa4ff0();
    if (smeansofdeath != "MOD_SUICIDE" && smeansofdeath != "MOD_FALLING") {
        if (!(isdefined(self.intermission) && self.intermission)) {
            self zm_audio::create_and_play_dialog("general", "revive_down");
        } else if (isdefined(level.var_204265bc) && !self [[ level.var_204265bc ]]()) {
            self zm_audio::create_and_play_dialog("general", "exert_death");
        }
    }
    if (isdefined(level._zombie_minigun_powerup_last_stand_func)) {
        self thread [[ level._zombie_minigun_powerup_last_stand_func ]]();
    }
    if (isdefined(level._zombie_tesla_powerup_last_stand_func)) {
        self thread [[ level._zombie_tesla_powerup_last_stand_func ]]();
    }
    if (self hasperk("specialty_electriccherry")) {
        var_54d1a8f4 = 1;
        if (isdefined(level.custom_laststand_func)) {
            self thread [[ level.custom_laststand_func ]]();
        }
    }
    if (isdefined(self.intermission) && self.intermission) {
        wait 0.5;
        self stopsounds();
        level waittill(#"forever");
    }
    if (!var_54d1a8f4) {
        visionset_mgr::activate("visionset", "zombie_last_stand", self, 1);
    }
}

// Namespace zm
// Params 1, eflags: 0x0
// Checksum 0x45e47e8, Offset: 0xaa00
// Size: 0x1a4
function function_ec9a829e(excluded_player) {
    for (i = 0; i < 10; i++) {
        wait 0.05;
        players = getplayers();
        foreach (player in players) {
            if (player == excluded_player || !isdefined(player.var_30d551a2) || player zm_laststand::is_reviving_any()) {
                continue;
            }
            /#
                iprintlnbold("<dev string:x2ba>");
            #/
            player zm_laststand::revive_give_back_weapons(level.weaponnone);
            if (isdefined(player.var_30d551a2)) {
                player.var_30d551a2 hud::destroyelem();
            }
            if (isdefined(player.var_fca62492)) {
                player.var_fca62492 destroy();
            }
        }
    }
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x73411f63, Offset: 0xabb0
// Size: 0xa4
function set_intermission_point() {
    points = struct::get_array("intermission", "targetname");
    if (points.size < 1) {
        return;
    }
    points = array::randomize(points);
    point = points[0];
    setdemointermissionpoint(point.origin, point.angles);
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xf72b4289, Offset: 0xac60
// Size: 0x252
function spawnspectator() {
    self endon(#"disconnect");
    self endon(#"spawned_spectator");
    self notify(#"spawned");
    self notify(#"end_respawn");
    if (level.intermission) {
        return;
    }
    if (isdefined(level.no_spectator) && level.no_spectator) {
        wait 3;
        exitlevel();
    }
    self.is_zombie = 1;
    level thread function_ec9a829e(self);
    self notify(#"zombified");
    if (isdefined(self.revivetrigger)) {
        self.revivetrigger delete();
        self.revivetrigger = undefined;
    }
    self.zombification_time = gettime();
    resettimeout();
    self stopshellshock();
    self stoprumble("damage_heavy");
    self.sessionstate = "spectator";
    self.spectatorclient = -1;
    self.maxhealth = self.health;
    self.shellshocked = 0;
    self.inwater = 0;
    self.friendlydamage = undefined;
    self.hasspawned = 1;
    self.spawntime = gettime();
    self.afk = 0;
    println("<dev string:x2e2>");
    self detachall();
    if (isdefined(level.var_586a584f)) {
        self [[ level.var_586a584f ]]();
    } else {
        self setspectatepermissions(1);
    }
    self thread function_128dd783();
    self spawn(self.origin, self.angles);
    self notify(#"spawned_spectator");
}

// Namespace zm
// Params 1, eflags: 0x0
// Checksum 0xea3068a6, Offset: 0xaec0
// Size: 0xbc
function setspectatepermissions(ison) {
    self allowspectateteam("allies", ison && self.team == "allies");
    self allowspectateteam("axis", ison && self.team == "axis");
    self allowspectateteam("freelook", 0);
    self allowspectateteam("none", 0);
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xd54a0040, Offset: 0xaf88
// Size: 0x1a
function function_128dd783() {
    self endon(#"disconnect");
    self endon(#"spawned_player");
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xabfc51af, Offset: 0xafb0
// Size: 0x44
function spectator_toggle_3rd_person() {
    self endon(#"disconnect");
    self endon(#"spawned_player");
    third_person = 1;
    self set_third_person(1);
}

// Namespace zm
// Params 1, eflags: 0x0
// Checksum 0x3809971e, Offset: 0xb000
// Size: 0xe4
function set_third_person(value) {
    if (value) {
        self setclientthirdperson(1);
        self setclientthirdpersonangle(354);
        self setdepthoffield(0, -128, 512, 4000, 6, 1.8);
    } else {
        self setclientthirdperson(0);
        self setclientthirdpersonangle(0);
        self setdepthoffield(0, 0, 512, 4000, 4, 0);
    }
    self resetfov();
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x601de0bf, Offset: 0xb0f0
// Size: 0x16e
function last_stand_revive() {
    level endon(#"between_round_over");
    players = getplayers();
    laststand_count = 0;
    foreach (player in players) {
        if (!zm_utility::is_player_valid(player)) {
            laststand_count++;
        }
    }
    if (laststand_count == players.size) {
        for (i = 0; i < players.size; i++) {
            if (players[i] laststand::player_is_in_laststand() && players[i].revivetrigger.beingrevived == 0) {
                players[i] zm_laststand::auto_revive(players[i]);
            }
        }
    }
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xb5378950, Offset: 0xb268
// Size: 0x1f6
function function_e7cfa7b8() {
    level.pistol_values = [];
    level.pistol_values[level.pistol_values.size] = level.default_laststandpistol;
    level.pistol_values[level.pistol_values.size] = getweapon("pistol_burst");
    level.pistol_values[level.pistol_values.size] = getweapon("pistol_fullauto");
    level.pistol_value_solo_replace_below = level.pistol_values.size - 1;
    level.pistol_values[level.pistol_values.size] = level.default_solo_laststandpistol;
    level.pistol_values[level.pistol_values.size] = getweapon("pistol_burst_upgraded");
    level.pistol_values[level.pistol_values.size] = getweapon("pistol_fullauto_upgraded");
    level.pistol_values[level.pistol_values.size] = getweapon("ray_gun");
    level.pistol_values[level.pistol_values.size] = getweapon("raygun_mark2");
    level.pistol_values[level.pistol_values.size] = getweapon("ray_gun_upgraded");
    level.pistol_values[level.pistol_values.size] = getweapon("raygun_mark2_upgraded");
    level.pistol_values[level.pistol_values.size] = getweapon("raygun_mark3");
    level.pistol_values[level.pistol_values.size] = getweapon("raygun_mark3_upgraded");
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x9bc11305, Offset: 0xb468
// Size: 0x48c
function function_a47dc1dc() {
    if (self zm_utility::has_powerup_weapon()) {
        self.lastactiveweapon = level.weaponnone;
    }
    if (isdefined(self.w_min_last_stand_pistol_override)) {
        self function_89a56458();
    }
    if (!self hasweapon(self.laststandpistol)) {
        self giveweapon(self.laststandpistol);
    }
    ammoclip = self.laststandpistol.clipsize;
    var_2bb48cdc = ammoclip * 2;
    if (self.laststandpistol == level.default_solo_laststandpistol && (isdefined(self.var_c7773c6d) && self.var_c7773c6d || !self.hadpistol)) {
        self.var_c7773c6d = 0;
        self.hadpistol = 0;
        self setweaponammostock(self.laststandpistol, var_2bb48cdc);
    } else if (level flag::get("solo_game") && self.laststandpistol == level.default_solo_laststandpistol) {
        self setweaponammostock(self.laststandpistol, var_2bb48cdc);
    } else if (self.laststandpistol == level.default_laststandpistol) {
        self setweaponammostock(self.laststandpistol, var_2bb48cdc);
    } else if (!isdefined(self.var_a95f4d82) || !isdefined(self.var_a95f4d82[self.laststandpistol])) {
        self setweaponammostock(self.laststandpistol, var_2bb48cdc);
    } else if (self.laststandpistol.name == "ray_gun" || self.laststandpistol.name == "ray_gun_upgraded") {
        if (self.var_a95f4d82[self.laststandpistol].var_c698e6c6 >= ammoclip) {
            self setweaponammoclip(self.laststandpistol, ammoclip);
            self.var_a95f4d82[self.laststandpistol].var_b1264487 = ammoclip;
        } else {
            self setweaponammoclip(self.laststandpistol, self.var_a95f4d82[self.laststandpistol].var_c698e6c6);
            self.var_a95f4d82[self.laststandpistol].var_b1264487 = self.var_a95f4d82[self.laststandpistol].var_c698e6c6;
        }
        self setweaponammostock(self.laststandpistol, 0);
    } else if (self.var_a95f4d82[self.laststandpistol].stock_amt >= var_2bb48cdc) {
        self setweaponammostock(self.laststandpistol, var_2bb48cdc);
        self.var_a95f4d82[self.laststandpistol].var_b1264487 = var_2bb48cdc + self.var_a95f4d82[self.laststandpistol].var_588c8ca8 + self.var_a95f4d82[self.laststandpistol].var_570f77cc;
    } else {
        self setweaponammostock(self.laststandpistol, self.var_a95f4d82[self.laststandpistol].stock_amt);
        self.var_a95f4d82[self.laststandpistol].var_b1264487 = self.var_a95f4d82[self.laststandpistol].var_c698e6c6;
    }
    self switchtoweapon(self.laststandpistol);
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x32ab2b11, Offset: 0xb900
// Size: 0xe4
function function_89a56458() {
    for (i = 0; i < level.pistol_values.size; i++) {
        if (level.pistol_values[i] == self.w_min_last_stand_pistol_override) {
            n_min_last_stand_pistol_value = i;
            break;
        }
    }
    for (k = 0; k < level.pistol_values.size; k++) {
        if (level.pistol_values[k] == self.laststandpistol) {
            n_default_last_stand_pistol_value = k;
            break;
        }
    }
    if (n_min_last_stand_pistol_value > n_default_last_stand_pistol_value) {
        self.hadpistol = 0;
        self.laststandpistol = self.w_min_last_stand_pistol_override;
    }
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xea431232, Offset: 0xb9f0
// Size: 0x294
function function_91d3b895() {
    var_1feb723a = [];
    current_weapons = self getweaponslistprimaries();
    for (i = 0; i < current_weapons.size; i++) {
        var_5ee50b20 = current_weapons[i].weapclass;
        if (current_weapons[i].isballisticknife) {
            var_5ee50b20 = "knife";
        }
        if (var_5ee50b20 == "pistol" || var_5ee50b20 == "pistolspread" || var_5ee50b20 == "pistol spread") {
            if (!level flag::get("solo_game") && (current_weapons[i] != level.default_solo_laststandpistol && !level flag::get("solo_game") || current_weapons[i] != level.default_solo_laststandpistol)) {
                if (current_weapons[i] != self.laststandpistol || self.laststandpistol != level.default_laststandpistol) {
                    if (self getammocount(current_weapons[i]) <= 0) {
                        continue;
                    }
                }
            }
            var_154237ab = var_1feb723a.size;
            var_1feb723a[var_154237ab] = spawnstruct();
            var_1feb723a[var_154237ab].weapon = current_weapons[i];
            var_1feb723a[var_154237ab].value = 0;
            for (j = 0; j < level.pistol_values.size; j++) {
                if (level.pistol_values[j] == current_weapons[i].rootweapon) {
                    var_1feb723a[var_154237ab].value = j;
                    break;
                }
            }
        }
    }
    self.laststandpistol = function_21a82999(var_1feb723a);
}

// Namespace zm
// Params 1, eflags: 0x0
// Checksum 0xe7c679b, Offset: 0xbc90
// Size: 0x224
function function_21a82999(struct_array) {
    if (!isarray(struct_array) || struct_array.size <= 0) {
        self.hadpistol = 0;
        if (isdefined(self.var_a95f4d82)) {
            var_a95f4d82 = getarraykeys(self.var_a95f4d82);
            for (j = 0; j < var_a95f4d82.size; j++) {
                if (var_a95f4d82[j].rootweapon == level.laststandpistol) {
                    self.hadpistol = 1;
                    return var_a95f4d82[j];
                }
            }
        }
        return level.laststandpistol;
    }
    var_17b4ead6 = struct_array[0];
    for (i = 1; i < struct_array.size; i++) {
        if (struct_array[i].value > var_17b4ead6.value) {
            var_17b4ead6 = struct_array[i];
        }
    }
    if (level flag::get("solo_game")) {
        self.var_c7773c6d = 0;
        if (var_17b4ead6.value <= level.pistol_value_solo_replace_below) {
            self.hadpistol = 0;
            self.var_c7773c6d = 1;
            if (isdefined(level.var_1bc2b35c) && level.var_1bc2b35c && !self hasperk("specialty_quickrevive")) {
                return var_17b4ead6.weapon;
            } else {
                return level.laststandpistol;
            }
        } else {
            return var_17b4ead6.weapon;
        }
        return;
    }
    return var_17b4ead6.weapon;
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xf27fd251, Offset: 0xbec0
// Size: 0x26c
function last_stand_save_pistol_ammo() {
    weapon_inventory = self getweaponslist(1);
    self.var_a95f4d82 = [];
    for (i = 0; i < weapon_inventory.size; i++) {
        weapon = weapon_inventory[i];
        var_5ee50b20 = weapon.weapclass;
        if (weapon.isballisticknife) {
            var_5ee50b20 = "knife";
        }
        if (var_5ee50b20 == "pistol" || var_5ee50b20 == "pistolspread" || var_5ee50b20 == "pistol spread") {
            self.var_a95f4d82[weapon] = spawnstruct();
            self.var_a95f4d82[weapon].var_588c8ca8 = self getweaponammoclip(weapon);
            self.var_a95f4d82[weapon].var_570f77cc = 0;
            var_5fa0430a = weapon.dualwieldweapon;
            if (level.weaponnone != var_5fa0430a) {
                self.var_a95f4d82[weapon].var_570f77cc = self getweaponammoclip(var_5fa0430a);
            }
            self.var_a95f4d82[weapon].stock_amt = self getweaponammostock(weapon);
            self.var_a95f4d82[weapon].var_c698e6c6 = self.var_a95f4d82[weapon].var_588c8ca8 + self.var_a95f4d82[weapon].var_570f77cc + self.var_a95f4d82[weapon].stock_amt;
            self.var_a95f4d82[weapon].var_b1264487 = 0;
        }
    }
    self function_91d3b895();
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x43fdcd2c, Offset: 0xc138
// Size: 0x3ec
function last_stand_restore_pistol_ammo() {
    self.var_cd3f6e8f = level.weaponnone;
    if (!isdefined(self.var_a95f4d82)) {
        return;
    }
    weapon_inventory = self getweaponslist(1);
    var_e9e96668 = getarraykeys(self.var_a95f4d82);
    for (i = 0; i < weapon_inventory.size; i++) {
        weapon = weapon_inventory[i];
        if (weapon != self.laststandpistol) {
            continue;
        }
        for (j = 0; j < var_e9e96668.size; j++) {
            if (weapon == var_e9e96668[j]) {
                var_5fa0430a = var_e9e96668[j].dualwieldweapon;
                if (weapon != level.default_laststandpistol) {
                    var_e851a942 = self getweaponammoclip(weapon);
                    var_b856f814 = 0;
                    if (level.weaponnone != var_5fa0430a) {
                        var_b856f814 = self getweaponammoclip(var_5fa0430a);
                    }
                    var_63d31d2a = self getweaponammostock(weapon);
                    var_7a28c85e = var_e851a942 + var_b856f814 + var_63d31d2a;
                    var_4745d55 = self.var_a95f4d82[weapon].var_b1264487 - var_7a28c85e;
                    if (var_4745d55 >= self.var_a95f4d82[weapon].stock_amt) {
                        var_4745d55 -= self.var_a95f4d82[weapon].stock_amt;
                        self.var_a95f4d82[weapon].stock_amt = 0;
                        self.var_a95f4d82[weapon].var_588c8ca8 = self.var_a95f4d82[weapon].var_588c8ca8 - var_4745d55;
                        if (self.var_a95f4d82[weapon].var_588c8ca8 < 0) {
                            self.var_a95f4d82[weapon].var_588c8ca8 = 0;
                        }
                    } else {
                        var_c24fa40d = self.var_a95f4d82[weapon].stock_amt - var_4745d55;
                        if (var_c24fa40d < self.var_a95f4d82[weapon].stock_amt) {
                            self.var_a95f4d82[weapon].stock_amt = var_c24fa40d;
                        }
                    }
                }
                self setweaponammoclip(weapon, self.var_a95f4d82[weapon].var_588c8ca8);
                if (level.weaponnone != var_5fa0430a) {
                    self setweaponammoclip(var_5fa0430a, self.var_a95f4d82[weapon].var_570f77cc);
                }
                self setweaponammostock(weapon, self.var_a95f4d82[weapon].stock_amt);
                break;
            }
        }
    }
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x11fe2523, Offset: 0xc530
// Size: 0x94
function function_ce27fd80() {
    self endon(#"disconnect");
    self endon(#"bled_out");
    self endon(#"player_revived");
    self waittill(#"grenade_fire", grenade, weapon);
    if (isdefined(self.var_9dd17162) && weapon == self.var_9dd17162) {
        self.var_fe8189c--;
    }
    if (isdefined(self.var_9a62d273) && weapon == self.var_9a62d273) {
        self.var_82ee7a0b--;
    }
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xb5f5df54, Offset: 0xc5d0
// Size: 0x2ee
function function_43aa4ff0() {
    if (isdefined(level.isresetting_grief) && level.isresetting_grief) {
        return;
    }
    self endon(#"disconnect");
    self endon(#"bled_out");
    self.var_fe8189c = 0;
    self.var_ea68f26a = 0;
    self.var_82ee7a0b = 0;
    self.var_aa7d5089 = 0;
    self.var_9dd17162 = undefined;
    self.var_9a62d273 = undefined;
    if (self isthrowinggrenade()) {
        self thread function_ce27fd80();
    }
    weapon = self zm_utility::get_player_lethal_grenade();
    if (weapon != level.weaponnone) {
        self.var_ea68f26a = 1;
        self.var_9dd17162 = weapon;
        self.var_fe8189c = self getweaponammoclip(weapon);
        self setweaponammoclip(weapon, 0);
        self takeweapon(weapon);
    }
    weapon = self zm_utility::get_player_tactical_grenade();
    if (weapon != level.weaponnone) {
        self.var_aa7d5089 = 1;
        self.var_9a62d273 = weapon;
        self.var_82ee7a0b = self getweaponammoclip(weapon);
        self setweaponammoclip(weapon, 0);
        self takeweapon(weapon);
    }
    self waittill(#"player_revived");
    if (self.var_ea68f26a) {
        self zm_utility::set_player_lethal_grenade(self.var_9dd17162);
        self giveweapon(self.var_9dd17162);
        self setweaponammoclip(self.var_9dd17162, self.var_fe8189c);
    }
    if (self.var_aa7d5089) {
        self zm_utility::set_player_tactical_grenade(self.var_9a62d273);
        self giveweapon(self.var_9a62d273);
        self setweaponammoclip(self.var_9a62d273, self.var_82ee7a0b);
    }
    self.var_fe8189c = undefined;
    self.var_ea68f26a = undefined;
    self.var_82ee7a0b = undefined;
    self.var_aa7d5089 = undefined;
    self.var_9dd17162 = undefined;
    self.var_9a62d273 = undefined;
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xb96f03a6, Offset: 0xc8c8
// Size: 0xc8
function spectators_respawn() {
    level endon(#"between_round_over");
    if (!isdefined(level.zombie_vars["spectators_respawn"]) || !level.zombie_vars["spectators_respawn"]) {
        return;
    }
    while (true) {
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            e_player = players[i];
            e_player spectator_respawn_player();
        }
        wait 1;
    }
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xaa556a87, Offset: 0xc998
// Size: 0xc8
function spectator_respawn_player() {
    if (self.sessionstate == "spectator" && isdefined(self.spectator_respawn)) {
        if (!isdefined(level.custom_spawnplayer)) {
            level.custom_spawnplayer = &spectator_respawn;
        }
        self [[ level.spawnplayer ]]();
        thread function_785a0ae4();
        if (isdefined(level.script) && level.round_number > 6 && self.score < 1500) {
            self.old_score = self.score;
            if (isdefined(level.var_f30bf142)) {
                self [[ level.var_f30bf142 ]]();
            }
            self.score = 1500;
        }
    }
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xf43261b8, Offset: 0xca68
// Size: 0x300
function spectator_respawn() {
    println("<dev string:x30f>");
    assert(isdefined(self.spectator_respawn));
    origin = self.spectator_respawn.origin;
    angles = self.spectator_respawn.angles;
    self setspectatepermissions(0);
    new_origin = undefined;
    if (isdefined(level.var_75eda423)) {
        new_origin = [[ level.var_75eda423 ]](self);
    }
    if (!isdefined(new_origin)) {
        new_origin = check_for_valid_spawn_near_team(self, 1);
    }
    if (isdefined(new_origin)) {
        if (!isdefined(new_origin.angles)) {
            angles = (0, 0, 0);
        } else {
            angles = new_origin.angles;
        }
        self spawn(new_origin.origin, angles);
    } else {
        self spawn(origin, angles);
    }
    if (isdefined(self zm_utility::get_player_placeable_mine())) {
        self takeweapon(self zm_utility::get_player_placeable_mine());
        self zm_utility::set_player_placeable_mine(level.weaponnone);
    }
    self zm_equipment::take();
    self.is_burning = undefined;
    self.abilities = [];
    self.is_zombie = 0;
    zm_laststand::set_ignoreme(0);
    self clientfield::set("zmbLastStand", 0);
    self reviveplayer();
    self notify(#"spawned_player");
    self callback::callback(#"hash_bc12b61f");
    if (isdefined(level._zombiemode_post_respawn_callback)) {
        self thread [[ level._zombiemode_post_respawn_callback ]]();
    }
    self zm_score::player_reduce_points("died");
    self zm_melee_weapon::spectator_respawn_all();
    self thread function_39d714b5();
    self thread zm_perks::function_36b1754c();
    return true;
}

// Namespace zm
// Params 2, eflags: 0x0
// Checksum 0x5beff19e, Offset: 0xcd70
// Size: 0x326
function check_for_valid_spawn_near_team(revivee, return_struct) {
    if (isdefined(level.check_for_valid_spawn_near_team_callback)) {
        spawn_location = [[ level.check_for_valid_spawn_near_team_callback ]](revivee, return_struct);
        return spawn_location;
    }
    players = getplayers();
    spawn_points = zm_gametype::get_player_spawns_for_gametype();
    closest_group = undefined;
    closest_distance = 100000000;
    backup_group = undefined;
    backup_distance = 100000000;
    if (spawn_points.size == 0) {
        return undefined;
    }
    a_enabled_zone_entities = zm_zonemgr::get_active_zones_entities();
    for (i = 0; i < players.size; i++) {
        if (zm_utility::is_player_valid(players[i], undefined, 1) && players[i] != self) {
            for (j = 0; j < spawn_points.size; j++) {
                if (isdefined(spawn_points[j].script_int)) {
                    ideal_distance = spawn_points[j].script_int;
                } else {
                    ideal_distance = 1000;
                }
                if (zm_utility::check_point_in_enabled_zone(spawn_points[j].origin, 0, a_enabled_zone_entities) == 0) {
                    continue;
                }
                if (spawn_points[j].locked == 0) {
                    plyr_dist = distancesquared(players[i].origin, spawn_points[j].origin);
                    if (plyr_dist < ideal_distance * ideal_distance) {
                        if (plyr_dist < closest_distance) {
                            closest_distance = plyr_dist;
                            closest_group = j;
                        }
                        continue;
                    }
                    if (plyr_dist < backup_distance) {
                        backup_group = j;
                        backup_distance = plyr_dist;
                    }
                }
            }
        }
        if (!isdefined(closest_group)) {
            closest_group = backup_group;
        }
        if (isdefined(closest_group)) {
            spawn_location = get_valid_spawn_location(revivee, spawn_points, closest_group, return_struct);
            if (isdefined(spawn_location)) {
                return spawn_location;
            }
        }
    }
    return undefined;
}

// Namespace zm
// Params 4, eflags: 0x0
// Checksum 0x98e0ce1a, Offset: 0xd0a0
// Size: 0x286
function get_valid_spawn_location(revivee, spawn_points, closest_group, return_struct) {
    spawn_array = struct::get_array(spawn_points[closest_group].target, "targetname");
    spawn_array = array::randomize(spawn_array);
    for (k = 0; k < spawn_array.size; k++) {
        if (isdefined(spawn_array[k].plyr) && spawn_array[k].plyr == revivee getentitynumber()) {
            if (positionwouldtelefrag(spawn_array[k].origin)) {
                spawn_array[k].plyr = undefined;
                break;
            }
            if (isdefined(return_struct) && return_struct) {
                return spawn_array[k];
            }
            return spawn_array[k].origin;
        }
    }
    for (k = 0; k < spawn_array.size; k++) {
        if (positionwouldtelefrag(spawn_array[k].origin)) {
            continue;
        }
        if (!isdefined(spawn_array[k].plyr) || spawn_array[k].plyr == revivee getentitynumber()) {
            spawn_array[k].plyr = revivee getentitynumber();
            if (isdefined(return_struct) && return_struct) {
                return spawn_array[k];
            }
            return spawn_array[k].origin;
        }
    }
    if (isdefined(return_struct) && return_struct) {
        return spawn_array[0];
    }
    return spawn_array[0].origin;
}

// Namespace zm
// Params 3, eflags: 0x0
// Checksum 0x5d1d0130, Offset: 0xd330
// Size: 0x20a
function check_for_valid_spawn_near_position(revivee, v_position, return_struct) {
    spawn_points = zm_gametype::get_player_spawns_for_gametype();
    if (spawn_points.size == 0) {
        return undefined;
    }
    closest_group = undefined;
    closest_distance = 100000000;
    backup_group = undefined;
    backup_distance = 100000000;
    for (i = 0; i < spawn_points.size; i++) {
        if (isdefined(spawn_points[i].script_int)) {
            ideal_distance = spawn_points[i].script_int;
        } else {
            ideal_distance = 1000;
        }
        if (spawn_points[i].locked == 0) {
            dist = distancesquared(v_position, spawn_points[i].origin);
            if (dist < ideal_distance * ideal_distance) {
                if (dist < closest_distance) {
                    closest_distance = dist;
                    closest_group = i;
                }
            } else if (dist < backup_distance) {
                backup_group = i;
                backup_distance = dist;
            }
        }
        if (!isdefined(closest_group)) {
            closest_group = backup_group;
        }
    }
    if (isdefined(closest_group)) {
        spawn_location = get_valid_spawn_location(revivee, spawn_points, closest_group, return_struct);
        if (isdefined(spawn_location)) {
            return spawn_location;
        }
    }
    return undefined;
}

// Namespace zm
// Params 5, eflags: 0x0
// Checksum 0xa7570c86, Offset: 0xd548
// Size: 0x182
function check_for_valid_spawn_within_range(revivee, v_position, return_struct, min_distance, max_distance) {
    spawn_points = zm_gametype::get_player_spawns_for_gametype();
    if (spawn_points.size == 0) {
        return undefined;
    }
    closest_group = undefined;
    closest_distance = 100000000;
    for (i = 0; i < spawn_points.size; i++) {
        if (spawn_points[i].locked == 0) {
            dist = distance(v_position, spawn_points[i].origin);
            if (dist >= min_distance && dist <= max_distance) {
                if (dist < closest_distance) {
                    closest_distance = dist;
                    closest_group = i;
                }
            }
        }
    }
    if (isdefined(closest_group)) {
        spawn_location = get_valid_spawn_location(revivee, spawn_points, closest_group, return_struct);
        if (isdefined(spawn_location)) {
            return spawn_location;
        }
    }
    return undefined;
}

// Namespace zm
// Params 1, eflags: 0x0
// Checksum 0x3d07545a, Offset: 0xd6d8
// Size: 0xcc
function get_players_on_team(exclude) {
    teammates = [];
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (players[i].spawn_side == self.spawn_side && !isdefined(players[i].revivetrigger) && players[i] != exclude) {
            teammates[teammates.size] = players[i];
        }
    }
    return teammates;
}

// Namespace zm
// Params 1, eflags: 0x0
// Checksum 0x4f08d70a, Offset: 0xd7b0
// Size: 0x180
function get_safe_breadcrumb_pos(player) {
    players = getplayers();
    valid_players = [];
    min_dist = 22500;
    for (i = 0; i < players.size; i++) {
        if (!zm_utility::is_player_valid(players[i])) {
            continue;
        }
        valid_players[valid_players.size] = players[i];
    }
    for (i = 0; i < valid_players.size; i++) {
        count = 0;
        for (q = 1; q < player.zombie_breadcrumbs.size; q++) {
            if (distancesquared(player.zombie_breadcrumbs[q], valid_players[i].origin) < min_dist) {
                continue;
            }
            count++;
            if (count == valid_players.size) {
                return player.zombie_breadcrumbs[q];
            }
        }
    }
    return undefined;
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xce206c35, Offset: 0xd938
// Size: 0x538
function round_spawning() {
    level endon(#"intermission");
    level endon(#"end_of_round");
    level endon(#"restart_round");
    /#
        level endon(#"kill_round");
    #/
    if (level.intermission) {
        return;
    }
    if (cheat_enabled(2)) {
        return;
    }
    if (level.zm_loc_types["zombie_location"].size < 1) {
        assertmsg("<dev string:x33d>");
        return;
    }
    zombie_utility::ai_calculate_health(level.round_number);
    count = 0;
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i].zombification_time = 0;
    }
    if (!(isdefined(level.kill_counter_hud) && level.zombie_total > 0)) {
        level.zombie_total = get_zombie_count_for_round(level.round_number, level.players.size);
        level.zombie_respawns = 0;
        level notify(#"zombie_total_set");
    }
    if (isdefined(level.zombie_total_set_func)) {
        level thread [[ level.zombie_total_set_func ]]();
    }
    if (level.round_number < 10 || level.speed_change_max > 0) {
        level thread zombie_utility::function_9d8e8d95();
    }
    old_spawn = undefined;
    while (true) {
        while (zombie_utility::get_current_zombie_count() >= level.zombie_ai_limit || level.zombie_total <= 0) {
            wait 0.1;
        }
        while (zombie_utility::get_current_actor_count() >= level.zombie_actor_limit) {
            zombie_utility::clear_all_corpses();
            wait 0.1;
        }
        if (flag::exists("world_is_paused")) {
            level flag::wait_till_clear("world_is_paused");
        }
        level flag::wait_till("spawn_zombies");
        while (level.zm_loc_types["zombie_location"].size <= 0) {
            wait 0.1;
        }
        run_custom_ai_spawn_checks();
        if (isdefined(level.hostmigrationtimer) && level.hostmigrationtimer) {
            util::wait_network_frame();
            continue;
        }
        if (isdefined(level.fn_custom_round_ai_spawn)) {
            if ([[ level.fn_custom_round_ai_spawn ]]()) {
                util::wait_network_frame();
                continue;
            }
        }
        if (isdefined(level.zombie_spawners)) {
            if (isdefined(level.fn_custom_zombie_spawner_selection)) {
                spawner = [[ level.fn_custom_zombie_spawner_selection ]]();
            } else if (isdefined(level.use_multiple_spawns) && level.use_multiple_spawns) {
                if (isdefined(level.zombie_spawn[level.spawner_int].size) && isdefined(level.spawner_int) && level.zombie_spawn[level.spawner_int].size) {
                    spawner = array::random(level.zombie_spawn[level.spawner_int]);
                } else {
                    spawner = array::random(level.zombie_spawners);
                }
            } else {
                spawner = array::random(level.zombie_spawners);
            }
            ai = zombie_utility::spawn_zombie(spawner, spawner.targetname);
        }
        if (isdefined(ai)) {
            level.zombie_total--;
            if (level.zombie_respawns > 0) {
                level.zombie_respawns--;
            }
            ai thread zombie_utility::round_spawn_failsafe();
            count++;
            if (ai ai::has_behavior_attribute("can_juke")) {
                ai ai::set_behavior_attribute("can_juke", 0);
            }
            if (level.zombie_respawns > 0) {
                wait 0.1;
            } else {
                wait level.zombie_vars["zombie_spawn_delay"];
            }
        }
        util::wait_network_frame();
    }
}

// Namespace zm
// Params 2, eflags: 0x0
// Checksum 0x4bd50353, Offset: 0xde78
// Size: 0x164
function get_zombie_count_for_round(n_round, n_player_count) {
    max = level.zombie_vars["zombie_max_ai"];
    multiplier = n_round / 5;
    if (multiplier < 1) {
        multiplier = 1;
    }
    if (n_round >= 10) {
        multiplier *= n_round * 0.15;
    }
    if (n_player_count == 1) {
        max += int(0.5 * level.zombie_vars["zombie_ai_per_player"] * multiplier);
    } else {
        max += int((n_player_count - 1) * level.zombie_vars["zombie_ai_per_player"] * multiplier);
    }
    if (!isdefined(level.max_zombie_func)) {
        level.max_zombie_func = &zombie_utility::default_max_zombie_func;
    }
    n_zombie_count = [[ level.max_zombie_func ]](max, n_round);
    return n_zombie_count;
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x9c562bcb, Offset: 0xdfe8
// Size: 0x570
function run_custom_ai_spawn_checks() {
    foreach (s in level.custom_ai_spawn_check_funcs) {
        if ([[ s.func_check ]]()) {
            a_spawners = [[ s.func_get_spawners ]]();
            level.zombie_spawners = arraycombine(level.zombie_spawners, a_spawners, 0, 0);
            if (isdefined(level.use_multiple_spawns) && level.use_multiple_spawns) {
                foreach (sp in a_spawners) {
                    if (isdefined(sp.script_int)) {
                        if (!isdefined(level.zombie_spawn[sp.script_int])) {
                            level.zombie_spawn[sp.script_int] = [];
                        }
                        if (!isinarray(level.zombie_spawn[sp.script_int], sp)) {
                            if (!isdefined(level.zombie_spawn[sp.script_int])) {
                                level.zombie_spawn[sp.script_int] = [];
                            } else if (!isarray(level.zombie_spawn[sp.script_int])) {
                                level.zombie_spawn[sp.script_int] = array(level.zombie_spawn[sp.script_int]);
                            }
                            level.zombie_spawn[sp.script_int][level.zombie_spawn[sp.script_int].size] = sp;
                        }
                    }
                }
            }
            if (isdefined(s.func_get_locations)) {
                a_locations = [[ s.func_get_locations ]]();
                level.zm_loc_types["zombie_location"] = arraycombine(level.zm_loc_types["zombie_location"], a_locations, 0, 0);
            }
            continue;
        }
        a_spawners = [[ s.func_get_spawners ]]();
        foreach (sp in a_spawners) {
            arrayremovevalue(level.zombie_spawners, sp);
        }
        if (isdefined(level.use_multiple_spawns) && level.use_multiple_spawns) {
            foreach (sp in a_spawners) {
                if (isdefined(sp.script_int) && isdefined(level.zombie_spawn[sp.script_int])) {
                    arrayremovevalue(level.zombie_spawn[sp.script_int], sp);
                }
            }
        }
        if (isdefined(s.func_get_locations)) {
            a_locations = [[ s.func_get_locations ]]();
            foreach (s_loc in a_locations) {
                arrayremovevalue(level.zm_loc_types["zombie_location"], s_loc);
            }
        }
    }
}

// Namespace zm
// Params 4, eflags: 0x0
// Checksum 0x6aa3ade5, Offset: 0xe560
// Size: 0xb0
function register_custom_ai_spawn_check(str_id, func_check, func_get_spawners, func_get_locations) {
    if (!isdefined(level.custom_ai_spawn_check_funcs[str_id])) {
        level.custom_ai_spawn_check_funcs[str_id] = spawnstruct();
    }
    level.custom_ai_spawn_check_funcs[str_id].func_check = func_check;
    level.custom_ai_spawn_check_funcs[str_id].func_get_spawners = func_get_spawners;
    level.custom_ai_spawn_check_funcs[str_id].func_get_locations = func_get_locations;
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x1ede1beb, Offset: 0xe618
// Size: 0xb0
function round_spawning_test() {
    while (true) {
        spawn_point = array::random(level.zm_loc_types["zombie_location"]);
        spawner = array::random(level.zombie_spawners);
        ai = zombie_utility::spawn_zombie(spawner, spawner.targetname, spawn_point);
        ai waittill(#"death");
        wait 5;
    }
}

// Namespace zm
// Params 1, eflags: 0x0
// Checksum 0x7c534447, Offset: 0xe6d0
// Size: 0x204
function function_6765cd60(delay) {
    if (!isdefined(delay)) {
        delay = 30;
    }
    level.var_e07abad8 = zm_utility::function_e1b7f046();
    level.var_e07abad8 setvalue(delay);
    level.var_e07abad8.color = (1, 1, 1);
    level.var_e07abad8.alpha = 1;
    level.var_e07abad8 fadeovertime(2);
    wait 2;
    level.var_e07abad8.color = (0.21, 0, 0);
    level.var_e07abad8 fadeovertime(3);
    wait 3;
    while (delay >= 1) {
        wait 1;
        delay--;
        level.var_e07abad8 setvalue(delay);
    }
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i] playlocalsound("zmb_perks_packa_ready");
    }
    level.var_e07abad8 fadeovertime(1);
    level.var_e07abad8.color = (1, 1, 1);
    level.var_e07abad8.alpha = 0;
    wait 1;
    level.var_e07abad8 zm_utility::function_ef76706b();
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x822a5a22, Offset: 0xe8e0
// Size: 0x254
function round_start() {
    if (!isdefined(level.zombie_spawners) || level.zombie_spawners.size == 0) {
        println("<dev string:x3a2>");
        level flag::set("begin_spawning");
        return;
    }
    println("<dev string:x3d3>");
    if (isdefined(level.var_e9389b68)) {
        [[ level.var_e9389b68 ]]();
    } else {
        n_delay = 2;
        if (isdefined(level.zombie_round_start_delay)) {
            n_delay = level.zombie_round_start_delay;
        }
        wait n_delay;
    }
    level.zombie_health = level.zombie_vars["zombie_health_start"];
    if (getdvarint("scr_writeconfigstrings") == 1) {
        wait 5;
        exitlevel();
        return;
    }
    if (level.zombie_vars["game_start_delay"] > 0) {
        function_6765cd60(level.zombie_vars["game_start_delay"]);
    }
    level flag::set("begin_spawning");
    if (!isdefined(level.round_spawn_func)) {
        level.round_spawn_func = &round_spawning;
    }
    if (!isdefined(level.move_spawn_func)) {
        level.move_spawn_func = &zm_utility::move_zombie_spawn_location;
    }
    /#
        if (getdvarint("<dev string:x3eb>")) {
            level.round_spawn_func = &round_spawning_test;
        }
    #/
    if (!isdefined(level.round_wait_func)) {
        level.round_wait_func = &round_wait;
    }
    if (!isdefined(level.round_think_func)) {
        level.round_think_func = &round_think;
    }
    level thread [[ level.round_think_func ]]();
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x9b7b9318, Offset: 0xeb40
// Size: 0x17c
function play_door_dialog() {
    self endon(#"warning_dialog");
    timer = 0;
    while (true) {
        wait 0.05;
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            dist = distancesquared(players[i].origin, self.origin);
            if (dist > 4900) {
                timer = 0;
                continue;
            }
            while (dist < 4900 && timer < 3) {
                wait 0.5;
                timer++;
            }
            if (dist > 4900 && timer >= 3) {
                self playsound("door_deny");
                players[i] zm_audio::create_and_play_dialog("general", "outofmoney");
                wait 3;
                self notify(#"warning_dialog");
            }
        }
    }
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x9a4adcc, Offset: 0xecc8
// Size: 0x3c
function wait_until_first_player() {
    players = getplayers();
    if (!isdefined(players[0])) {
        level waittill(#"first_player_ready");
    }
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x4f450ae7, Offset: 0xed10
// Size: 0x1d4
function round_one_up() {
    level endon(#"end_game");
    if (isdefined(level.noroundnumber) && level.noroundnumber == 1) {
        return;
    }
    if (!isdefined(level.doground_nomusic)) {
        level.doground_nomusic = 0;
    }
    if (level.first_round) {
        intro = 1;
        if (isdefined(level._custom_intro_vox)) {
            level thread [[ level._custom_intro_vox ]]();
        } else {
            level thread play_level_start_vox_delayed();
        }
    } else {
        intro = 0;
    }
    if (level.round_number == 5 || level.round_number == 10 || level.round_number == 20 || level.round_number == 35 || level.round_number == 50) {
        players = getplayers();
        rand = randomintrange(0, players.size);
        players[rand] thread zm_audio::create_and_play_dialog("general", "round_" + level.round_number);
    }
    if (intro) {
        if (isdefined(level.host_ended_game) && level.host_ended_game) {
            return;
        }
        wait 6.25;
        level notify(#"intro_hud_done");
        wait 2;
    } else {
        wait 2.5;
    }
    reportmtu(level.round_number);
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x37d6300, Offset: 0xeef0
// Size: 0x1e2
function round_over() {
    if (isdefined(level.noroundnumber) && level.noroundnumber == 1) {
        return;
    }
    time = [[ level.func_get_delay_between_rounds ]]();
    players = getplayers();
    for (player_index = 0; player_index < players.size; player_index++) {
        if (!isdefined(players[player_index].pers["previous_distance_traveled"])) {
            players[player_index].pers["previous_distance_traveled"] = 0;
        }
        distancethisround = int(players[player_index].pers["distance_traveled"] - players[player_index].pers["previous_distance_traveled"]);
        players[player_index].pers["previous_distance_traveled"] = players[player_index].pers["distance_traveled"];
        players[player_index] incrementplayerstat("distance_traveled", distancethisround);
        if (players[player_index].pers["team"] != "spectator") {
            players[player_index] recordroundendstats();
        }
    }
    recordzombieroundend();
    wait time;
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xf601cd1d, Offset: 0xf0e0
// Size: 0x14
function get_delay_between_rounds() {
    return level.zombie_vars["zombie_between_round_time"];
}

// Namespace zm
// Params 2, eflags: 0x0
// Checksum 0x9eb278ed, Offset: 0xf100
// Size: 0x64
function recordplayerroundweapon(weapon, statname) {
    if (isdefined(weapon)) {
        weaponidx = getbaseweaponitemindex(weapon);
        if (isdefined(weaponidx)) {
            self incrementplayerstat(statname, weaponidx);
        }
    }
}

// Namespace zm
// Params 2, eflags: 0x0
// Checksum 0xa5e91415, Offset: 0xf170
// Size: 0x96
function recordprimaryweaponsstats(base_stat_name, max_weapons) {
    current_weapons = self getweaponslistprimaries();
    for (index = 0; index < max_weapons && index < current_weapons.size; index++) {
        recordplayerroundweapon(current_weapons[index], base_stat_name + index);
    }
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x4b1662ea, Offset: 0xf210
// Size: 0xec
function recordroundstartstats() {
    zonename = self zm_utility::get_current_zone();
    if (isdefined(zonename)) {
        self recordzombiezone("startingZone", zonename);
    }
    self incrementplayerstat("score", self.score);
    primaryweapon = self getcurrentweapon();
    self recordprimaryweaponsstats("roundStartPrimaryWeapon", 3);
    self recordmapevent(8, gettime(), self.origin, level.round_number);
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xdd888f64, Offset: 0xf308
// Size: 0x9c
function recordroundendstats() {
    zonename = self zm_utility::get_current_zone();
    if (isdefined(zonename)) {
        self recordzombiezone("endingZone", zonename);
    }
    self recordprimaryweaponsstats("roundEndPrimaryWeapon", 3);
    self recordmapevent(9, gettime(), self.origin, level.round_number);
}

// Namespace zm
// Params 1, eflags: 0x0
// Checksum 0xa451a363, Offset: 0xf3b0
// Size: 0xad8
function round_think(restart) {
    if (!isdefined(restart)) {
        restart = 0;
    }
    println("<dev string:x3fc>");
    level endon(#"end_round_think");
    if (!(isdefined(restart) && restart)) {
        if (isdefined(level.var_b31c6007)) {
            [[ level.var_b31c6007 ]]();
        }
        if (!(isdefined(level.host_ended_game) && level.host_ended_game)) {
            players = getplayers();
            foreach (player in players) {
                if (!(isdefined(player.hostmigrationcontrolsfrozen) && player.hostmigrationcontrolsfrozen)) {
                    player freezecontrols(0);
                    println("<dev string:x414>");
                }
                player zm_stats::set_global_stat("rounds", level.round_number);
            }
        }
    }
    setroundsplayed(level.round_number);
    for (;;) {
        var_40c45d40 = 50 * level.round_number;
        if (var_40c45d40 > 500) {
            var_40c45d40 = 500;
        }
        level.zombie_vars["rebuild_barrier_cap_per_round"] = var_40c45d40;
        level.pro_tips_start_time = gettime();
        level.zombie_last_run_time = gettime();
        if (isdefined(level.var_d58439a1)) {
            [[ level.var_d58439a1 ]]();
        } else {
            if (!(isdefined(level.var_1b7d7bb8) && level.var_1b7d7bb8)) {
                if (isdefined(level.sndgotoroundoccurred) && level.sndgotoroundoccurred) {
                    level.sndgotoroundoccurred = 0;
                } else if (level.round_number == 1) {
                    level thread zm_audio::sndmusicsystem_playstate("round_start_first");
                } else if (level.round_number <= 5) {
                    level thread zm_audio::sndmusicsystem_playstate("round_start");
                } else {
                    level thread zm_audio::sndmusicsystem_playstate("round_start_short");
                }
            }
            round_one_up();
        }
        zm_powerups::powerup_round_start();
        players = getplayers();
        array::thread_all(players, &zm_blockers::rebuild_barrier_reward_reset);
        if (!(isdefined(level.headshots_only) && level.headshots_only) && !restart) {
            level thread award_grenades_for_survivors();
        }
        println("<dev string:x429>" + level.round_number + "<dev string:x443>" + players.size);
        level.round_start_time = gettime();
        while (level.zm_loc_types["zombie_location"].size <= 0) {
            wait 0.1;
        }
        /#
            zkeys = getarraykeys(level.zones);
            for (i = 0; i < zkeys.size; i++) {
                zonename = zkeys[i];
                level.zones[zonename].round_spawn_count = 0;
            }
        #/
        level thread [[ level.round_spawn_func ]]();
        level notify(#"start_of_round");
        recordzombieroundstart();
        bb::logroundevent("start_of_round");
        players = getplayers();
        for (index = 0; index < players.size; index++) {
            players[index] recordroundstartstats();
        }
        if (isdefined(level.round_start_custom_func)) {
            [[ level.round_start_custom_func ]]();
        }
        [[ level.round_wait_func ]]();
        level.first_round = 0;
        level notify(#"end_of_round");
        bb::logroundevent("end_of_round");
        uploadstats();
        if (isdefined(level.round_end_custom_logic)) {
            [[ level.round_end_custom_logic ]]();
        }
        players = getplayers();
        if (isdefined(level.no_end_game_check) && level.no_end_game_check) {
            level thread last_stand_revive();
            level thread spectators_respawn();
        } else if (1 != players.size) {
            level thread spectators_respawn();
        }
        players = getplayers();
        array::thread_all(players, &namespace_d93d7691::round_end);
        if (int(level.round_number / 5) * 5 == level.round_number) {
            level clientfield::set("round_complete_time", int((level.time - level.n_gameplay_start_time + 500) / 1000));
            level clientfield::set("round_complete_num", level.round_number);
        }
        if (level.gamedifficulty == 0) {
            level.zombie_move_speed = level.round_number * level.zombie_vars["zombie_move_speed_multiplier_easy"];
        } else {
            level.zombie_move_speed = level.round_number * level.zombie_vars["zombie_move_speed_multiplier"];
        }
        set_round_number(1 + get_round_number());
        setroundsplayed(get_round_number());
        level.zombie_vars["zombie_spawn_delay"] = [[ level.func_get_zombie_spawn_delay ]](get_round_number());
        matchutctime = getutc();
        players = getplayers();
        foreach (player in players) {
            if (level.curr_gametype_affects_rank && get_round_number() > 3 + level.start_round) {
                player zm_stats::add_client_stat("weighted_rounds_played", get_round_number());
            }
            player zm_stats::set_global_stat("rounds", get_round_number());
            player zm_stats::update_playing_utc_time(matchutctime);
            player zm_perks::function_78f42790("health_reboot", 1, 1);
            for (i = 0; i < 4; i++) {
                player.number_revives_per_round[i] = 0;
            }
            if (isalive(player) && player.sessionstate != "spectator" && !(isdefined(level.skip_alive_at_round_end_xp) && level.skip_alive_at_round_end_xp)) {
                player zm_stats::increment_challenge_stat("SURVIVALIST_SURVIVE_ROUNDS");
                score_number = get_round_number() - 1;
                if (score_number < 1) {
                    score_number = 1;
                } else if (score_number > 20) {
                    score_number = 20;
                }
                scoreevents::processscoreevent("alive_at_round_end_" + score_number, player);
            }
        }
        if (isdefined(level.var_3dbc348c)) {
            [[ level.var_3dbc348c ]]();
        }
        level.round_number = get_round_number();
        level round_over();
        level notify(#"between_round_over");
        level.skip_alive_at_round_end_xp = 0;
        restart = 0;
    }
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x41538396, Offset: 0xfe90
// Size: 0x1fe
function award_grenades_for_survivors() {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (!players[i].is_zombie && !(isdefined(players[i].altbody) && players[i].altbody) && !players[i] laststand::player_is_in_laststand()) {
            lethal_grenade = players[i] zm_utility::get_player_lethal_grenade();
            if (!players[i] hasweapon(lethal_grenade)) {
                players[i] giveweapon(lethal_grenade);
                players[i] setweaponammoclip(lethal_grenade, 0);
            }
            frac = players[i] getfractionmaxammo(lethal_grenade);
            if (frac < 0.25) {
                players[i] setweaponammoclip(lethal_grenade, 2);
                continue;
            }
            if (frac < 0.5) {
                players[i] setweaponammoclip(lethal_grenade, 3);
                continue;
            }
            players[i] setweaponammoclip(lethal_grenade, 4);
        }
    }
}

// Namespace zm
// Params 1, eflags: 0x0
// Checksum 0x9609d0b5, Offset: 0x10098
// Size: 0x116
function get_zombie_spawn_delay(n_round) {
    if (n_round > 60) {
        n_round = 60;
    }
    n_multiplier = 0.95;
    switch (level.players.size) {
    case 1:
        n_delay = 2;
        break;
    case 2:
        n_delay = 1.5;
        break;
    case 3:
        n_delay = 0.89;
        break;
    case 4:
        n_delay = 0.67;
        break;
    }
    for (i = 1; i < n_round; i++) {
        n_delay *= n_multiplier;
        if (n_delay <= 0.1) {
            n_delay = 0.1;
            break;
        }
    }
    return n_delay;
}

/#

    // Namespace zm
    // Params 0, eflags: 0x0
    // Checksum 0x7530b4ad, Offset: 0x101b8
    // Size: 0x88
    function round_spawn_failsafe_debug() {
        level notify(#"failsafe_debug_stop");
        level endon(#"failsafe_debug_stop");
        start = gettime();
        level.chunk_time = 0;
        while (true) {
            level.failsafe_time = gettime() - start;
            if (isdefined(self.lastchunk_destroy_time)) {
                level.chunk_time = gettime() - self.lastchunk_destroy_time;
            }
            util::wait_network_frame();
        }
    }

    // Namespace zm
    // Params 0, eflags: 0x0
    // Checksum 0x5437ea3, Offset: 0x10248
    // Size: 0x15c
    function print_zombie_counts() {
        while (true) {
            if (getdvarint("<dev string:x453>")) {
                if (!isdefined(level.debug_zombie_count_hud)) {
                    level.debug_zombie_count_hud = newdebughudelem();
                    level.debug_zombie_count_hud.alignx = "<dev string:x471>";
                    level.debug_zombie_count_hud.x = 100;
                    level.debug_zombie_count_hud.y = 10;
                    level.debug_zombie_count_hud settext("<dev string:x477>");
                }
                currentcount = zombie_utility::get_current_zombie_count();
                number_to_kill = level.zombie_total;
                level.debug_zombie_count_hud settext("<dev string:x47e>" + currentcount + "<dev string:x485>" + number_to_kill);
            } else if (isdefined(level.debug_zombie_count_hud)) {
                level.debug_zombie_count_hud destroy();
                level.debug_zombie_count_hud = undefined;
            }
            wait 0.1;
        }
    }

#/

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x965d5553, Offset: 0x103b0
// Size: 0x194
function round_wait() {
    level endon(#"restart_round");
    /#
        level endon(#"kill_round");
    #/
    /#
        if (getdvarint("<dev string:x3eb>")) {
            level waittill(#"forever");
        }
    #/
    if (cheat_enabled(2)) {
        level waittill(#"forever");
    }
    /#
        if (getdvarint("<dev string:x48e>") == 0) {
            level waittill(#"forever");
        }
    #/
    wait 1;
    /#
        level thread print_zombie_counts();
        level thread sndmusiconkillround();
    #/
    while (true) {
        should_wait = zombie_utility::get_current_zombie_count() > 0 || level.zombie_total > 0 || level.intermission;
        if (!should_wait) {
            level thread zm_audio::sndmusicsystem_playstate("round_end");
            return;
        }
        if (level flag::get("end_round_wait")) {
            level thread zm_audio::sndmusicsystem_playstate("round_end");
            return;
        }
        wait 1;
    }
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x49389ccc, Offset: 0x10550
// Size: 0x3c
function sndmusiconkillround() {
    level endon(#"end_of_round");
    level waittill(#"kill_round");
    level thread zm_audio::sndmusicsystem_playstate("round_end");
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x6a0ff7d4, Offset: 0x10598
// Size: 0x1fc
function zombify_player() {
    self zm_score::player_died_penalty();
    self recordplayerdeathzombies();
    if (isdefined(level.var_cdf12040)) {
        self [[ level.var_cdf12040 ]]();
    }
    if (isdefined(level.func_clone_plant_respawn) && isdefined(self.s_clone_plant)) {
        self [[ level.func_clone_plant_respawn ]]();
        return;
    }
    if (!isdefined(level.zombie_vars["zombify_player"]) || !level.zombie_vars["zombify_player"]) {
        self thread spawnspectator();
        return;
    }
    self.ignoreme = 1;
    self.is_zombie = 1;
    self.zombification_time = gettime();
    self.team = level.zombie_team;
    self notify(#"zombified");
    if (isdefined(self.revivetrigger)) {
        self.revivetrigger delete();
    }
    self.revivetrigger = undefined;
    self setmovespeedscale(0.3);
    self reviveplayer();
    self takeallweapons();
    self disableweaponcycling();
    self disableoffhandweapons();
    self thread zombie_utility::zombie_eye_glow();
    self thread playerzombie_player_damage();
    self thread playerzombie_soundboard();
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xb09355e9, Offset: 0x107a0
// Size: 0x114
function playerzombie_player_damage() {
    self endon(#"death");
    self endon(#"disconnect");
    self thread playerzombie_infinite_health();
    self.zombiehealth = level.zombie_health;
    while (true) {
        self waittill(#"damage", amount, attacker, directionvec, point, type);
        if (!isdefined(attacker) || !isplayer(attacker)) {
            wait 0.05;
            continue;
        }
        self.zombiehealth -= amount;
        if (self.zombiehealth <= 0) {
            self thread playerzombie_downed_state();
            self waittill(#"playerzombie_downed_state_done");
            self.zombiehealth = level.zombie_health;
        }
    }
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xca827f66, Offset: 0x108c0
// Size: 0x192
function playerzombie_downed_state() {
    self endon(#"death");
    self endon(#"disconnect");
    downtime = 15;
    starttime = gettime();
    endtime = starttime + downtime * 1000;
    self thread playerzombie_downed_hud();
    self.playerzombie_soundboard_disable = 1;
    self thread zombie_utility::zombie_eye_glow_stop();
    self disableweapons();
    self allowstand(0);
    self allowcrouch(0);
    self allowprone(1);
    while (gettime() < endtime) {
        wait 0.05;
    }
    self.playerzombie_soundboard_disable = 0;
    self thread zombie_utility::zombie_eye_glow();
    self enableweapons();
    self allowstand(1);
    self allowcrouch(0);
    self allowprone(0);
    self notify(#"playerzombie_downed_state_done");
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x686e2f68, Offset: 0x10a60
// Size: 0x1ac
function playerzombie_downed_hud() {
    self endon(#"death");
    self endon(#"disconnect");
    text = newclienthudelem(self);
    text.alignx = "center";
    text.aligny = "middle";
    text.horzalign = "user_center";
    text.vertalign = "user_bottom";
    text.foreground = 1;
    text.font = "default";
    text.fontscale = 1.8;
    text.alpha = 0;
    text.color = (1, 1, 1);
    text settext(%ZOMBIE_PLAYERZOMBIE_DOWNED);
    text.y = -113;
    if (self issplitscreen()) {
        text.y = -137;
    }
    text fadeovertime(0.1);
    text.alpha = 1;
    self waittill(#"playerzombie_downed_state_done");
    text fadeovertime(0.1);
    text.alpha = 0;
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xb523a44c, Offset: 0x10c18
// Size: 0x60
function playerzombie_infinite_health() {
    self endon(#"death");
    self endon(#"disconnect");
    bighealth = 100000;
    while (true) {
        if (self.health < bighealth) {
            self.health = bighealth;
        }
        wait 0.1;
    }
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x62a9c26e, Offset: 0x10c80
// Size: 0x294
function playerzombie_soundboard() {
    self endon(#"death");
    self endon(#"disconnect");
    self.playerzombie_soundboard_disable = 0;
    self.buttonpressed_use = 0;
    self.buttonpressed_attack = 0;
    self.buttonpressed_ads = 0;
    self.usesound_waittime = 3000;
    self.usesound_nexttime = gettime();
    usesound = "playerzombie_usebutton_sound";
    self.attacksound_waittime = 3000;
    self.attacksound_nexttime = gettime();
    attacksound = "playerzombie_attackbutton_sound";
    self.adssound_waittime = 3000;
    self.adssound_nexttime = gettime();
    adssound = "playerzombie_adsbutton_sound";
    self.inputsound_nexttime = gettime();
    while (true) {
        if (self.playerzombie_soundboard_disable) {
            wait 0.05;
            continue;
        }
        if (self usebuttonpressed()) {
            if (self can_do_input("use")) {
                self thread playerzombie_play_sound(usesound);
                self thread playerzombie_waitfor_buttonrelease("use");
                self.usesound_nexttime = gettime() + self.usesound_waittime;
            }
        } else if (self attackbuttonpressed()) {
            if (self can_do_input("attack")) {
                self thread playerzombie_play_sound(attacksound);
                self thread playerzombie_waitfor_buttonrelease("attack");
                self.attacksound_nexttime = gettime() + self.attacksound_waittime;
            }
        } else if (self adsbuttonpressed()) {
            if (self can_do_input("ads")) {
                self thread playerzombie_play_sound(adssound);
                self thread playerzombie_waitfor_buttonrelease("ads");
                self.adssound_nexttime = gettime() + self.adssound_waittime;
            }
        }
        wait 0.05;
    }
}

// Namespace zm
// Params 1, eflags: 0x0
// Checksum 0x1fa5b356, Offset: 0x10f20
// Size: 0x102
function can_do_input(inputtype) {
    if (gettime() < self.inputsound_nexttime) {
        return 0;
    }
    cando = 0;
    switch (inputtype) {
    case "use":
        if (gettime() >= self.usesound_nexttime && !self.buttonpressed_use) {
            cando = 1;
        }
        break;
    case "attack":
        if (gettime() >= self.attacksound_nexttime && !self.buttonpressed_attack) {
            cando = 1;
        }
        break;
    case "ads":
        if (gettime() >= self.usesound_nexttime && !self.buttonpressed_ads) {
            cando = 1;
        }
        break;
    default:
        assertmsg("<dev string:x4a1>" + inputtype);
        break;
    }
    return cando;
}

// Namespace zm
// Params 1, eflags: 0x0
// Checksum 0x77173d61, Offset: 0x11030
// Size: 0x24
function playerzombie_play_sound(alias) {
    self zm_utility::play_sound_on_ent(alias);
}

// Namespace zm
// Params 1, eflags: 0x0
// Checksum 0xf3cd3fd, Offset: 0x11060
// Size: 0x188
function playerzombie_waitfor_buttonrelease(inputtype) {
    if (inputtype != "use" && inputtype != "attack" && inputtype != "ads") {
        assertmsg("<dev string:x4d0>" + inputtype + "<dev string:x504>");
        return;
    }
    notifystring = "waitfor_buttonrelease_" + inputtype;
    self notify(notifystring);
    self endon(notifystring);
    if (inputtype == "use") {
        self.buttonpressed_use = 1;
        while (self usebuttonpressed()) {
            wait 0.05;
        }
        self.buttonpressed_use = 0;
        return;
    }
    if (inputtype == "attack") {
        self.buttonpressed_attack = 1;
        while (self attackbuttonpressed()) {
            wait 0.05;
        }
        self.buttonpressed_attack = 0;
        return;
    }
    if (inputtype == "ads") {
        self.buttonpressed_ads = 1;
        while (self adsbuttonpressed()) {
            wait 0.05;
        }
        self.buttonpressed_ads = 0;
    }
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x49f7c45b, Offset: 0x111f0
// Size: 0x5a
function remove_ignore_attacker() {
    self notify(#"new_ignore_attacker");
    self endon(#"new_ignore_attacker");
    self endon(#"disconnect");
    if (!isdefined(level.ignore_enemy_timer)) {
        level.ignore_enemy_timer = 0.4;
    }
    wait level.ignore_enemy_timer;
    self.ignoreattacker = undefined;
}

// Namespace zm
// Params 10, eflags: 0x0
// Checksum 0x94e80145, Offset: 0x11258
// Size: 0x8e
function player_damage_override_cheat(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
    player_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
    return false;
}

// Namespace zm
// Params 10, eflags: 0x0
// Checksum 0xbda597a5, Offset: 0x112f0
// Size: 0x10d6
function player_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
    idamage = self check_player_damage_callbacks(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
    if (self.scene_takedamage === 0) {
        return 0;
    }
    if (isdefined(eattacker.b_aat_fire_works_weapon) && isdefined(eattacker) && eattacker.b_aat_fire_works_weapon) {
        return 0;
    }
    if (isdefined(self.use_adjusted_grenade_damage) && self.use_adjusted_grenade_damage) {
        self.use_adjusted_grenade_damage = undefined;
        if (self.health > idamage) {
            return idamage;
        }
    }
    if (!idamage) {
        return 0;
    }
    if (self laststand::player_is_in_laststand()) {
        return 0;
    }
    if (isdefined(einflictor)) {
        if (isdefined(einflictor.water_damage) && einflictor.water_damage) {
            return 0;
        }
    }
    if (isdefined(eattacker)) {
        if (eattacker.owner === self) {
            return 0;
        }
        if (isdefined(self.ignoreattacker) && self.ignoreattacker == eattacker) {
            return 0;
        }
        if (isdefined(eattacker.is_zombie) && isdefined(self.is_zombie) && self.is_zombie && eattacker.is_zombie) {
            return 0;
        }
        if (isdefined(eattacker.is_zombie) && eattacker.is_zombie) {
            self.ignoreattacker = eattacker;
            self thread remove_ignore_attacker();
            if (isdefined(eattacker.custom_damage_func)) {
                idamage = eattacker [[ eattacker.custom_damage_func ]](self);
            }
        }
        eattacker notify(#"hit_player");
        if (isdefined(eattacker) && isdefined(eattacker.func_mod_damage_override)) {
            smeansofdeath = eattacker [[ eattacker.func_mod_damage_override ]](einflictor, smeansofdeath, weapon);
        }
        if (smeansofdeath != "MOD_FALLING") {
            self thread function_dea8b878(smeansofdeath, eattacker);
            if (isdefined(eattacker.is_zombie) && eattacker.is_zombie || isplayer(eattacker)) {
                self playrumbleonentity("damage_heavy");
            }
            if (isdefined(eattacker.is_zombie) && eattacker.is_zombie) {
                self zm_audio::create_and_play_dialog("general", "attacked");
            }
            var_fa073b05 = 1;
            if (isdefined(level.var_828eb3f1) && level.var_828eb3f1) {
                if (isdefined(self.var_698f7e["flopper"]) && self.var_698f7e["flopper"]) {
                    var_fa073b05 = smeansofdeath != "MOD_PROJECTILE_SPLASH" && smeansofdeath != "MOD_GRENADE" && smeansofdeath != "MOD_GRENADE_SPLASH";
                }
            }
            if (isdefined(var_fa073b05) && var_fa073b05) {
                if (randomintrange(0, 1) == 0) {
                    self thread zm_audio::playerexert("hitmed");
                } else {
                    self thread zm_audio::playerexert("hitlrg");
                }
            }
        }
    }
    if (isdefined(smeansofdeath) && smeansofdeath == "MOD_DROWN") {
        self thread zm_audio::playerexert("drowning", 1);
        self.voxdrowning = 1;
    }
    if (isdefined(level.perk_damage_override)) {
        foreach (func in level.perk_damage_override) {
            n_damage = self [[ func ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
            if (isdefined(n_damage)) {
                idamage = n_damage;
            }
        }
    }
    finaldamage = idamage;
    if (zm_utility::is_placeable_mine(weapon)) {
        return 0;
    }
    if (isdefined(self.player_damage_override)) {
        self thread [[ self.player_damage_override ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
    }
    if (isdefined(einflictor) && isdefined(einflictor.archetype) && einflictor.archetype == "zombie_quad") {
        if (smeansofdeath == "MOD_EXPLOSIVE") {
            if (self.health > 75) {
                return 75;
            }
        }
    }
    if (smeansofdeath == "MOD_SUICIDE" && self bgb::is_enabled("zm_bgb_danger_closest")) {
        return 0;
    }
    if (smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_EXPLOSIVE") {
        if (self bgb::is_enabled("zm_bgb_danger_closest")) {
            return 0;
        }
        if (!(isdefined(self.is_zombie) && self.is_zombie)) {
            if (!(isdefined(eattacker.is_zombie) && eattacker.is_zombie) && (!isdefined(eattacker) || !(isdefined(eattacker.b_override_explosive_damage_cap) && eattacker.b_override_explosive_damage_cap))) {
                if (weapon.name == "ray_gun" || isdefined(weapon.name) && weapon.name == "ray_gun_upgraded") {
                    if (self.health > 25 && idamage > 25) {
                        return 25;
                    }
                } else if (self.health > 75 && idamage > 75) {
                    return 75;
                }
            }
        }
    }
    if (idamage < self.health) {
        if (isdefined(eattacker)) {
            if (isdefined(level.custom_kill_damaged_vo)) {
                eattacker thread [[ level.custom_kill_damaged_vo ]](self);
            } else {
                eattacker.sound_damage_player = self;
            }
            if (isdefined(eattacker.missinglegs) && eattacker.missinglegs) {
                self zm_audio::create_and_play_dialog("general", "crawl_hit");
            }
        }
        return finaldamage;
    }
    if (isdefined(eattacker)) {
        if (isdefined(eattacker.animname) && eattacker.animname == "zombie_dog") {
            self zm_stats::increment_client_stat("killed_by_zdog");
            self zm_stats::increment_player_stat("killed_by_zdog");
        } else if (isdefined(eattacker.var_9051d8cd) && eattacker.var_9051d8cd) {
            self zm_stats::increment_client_stat("killed_by_avogadro", 0);
            self zm_stats::increment_player_stat("killed_by_avogadro");
        }
    }
    self thread clear_path_timers();
    if (level.intermission) {
        level waittill(#"forever");
    }
    if (level.scr_zm_ui_gametype == "zcleansed" && idamage > 0) {
        if (!(isdefined(self.laststand) && self.laststand) && !self laststand::player_is_in_laststand() || isdefined(eattacker) && isplayer(eattacker) && eattacker.team != self.team && !isdefined(self.last_player_attacker)) {
            if (isdefined(eattacker.is_zombie) && isdefined(eattacker.maxhealth) && eattacker.is_zombie) {
                eattacker.health = eattacker.maxhealth;
            }
            if (isdefined(level.player_kills_player)) {
                self thread [[ level.player_kills_player ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
            }
        }
    }
    if (self.lives > 0 && self hasperk("specialty_whoswho")) {
        self.lives--;
        if (isdefined(level.whoswho_laststand_func)) {
            self thread [[ level.whoswho_laststand_func ]]();
            return 0;
        }
    }
    players = getplayers();
    count = 0;
    for (i = 0; i < players.size; i++) {
        if (players[i] == self || players[i].is_zombie || players[i] laststand::player_is_in_laststand() || players[i].sessionstate == "spectator") {
            count++;
        }
    }
    if (isdefined(level.var_d74f517d) && (count < players.size || ![[ level.var_d74f517d ]]())) {
        if (isdefined(level.var_1bc2b35c) && isdefined(self.lives) && self.lives > 0 && level.var_1bc2b35c && self hasperk("specialty_quickrevive")) {
            self thread wait_and_revive();
        }
        return finaldamage;
    }
    if (players.size == 1 && level flag::get("solo_game")) {
        if (isdefined(level.var_4cf8bbbd) && (isdefined(level.no_end_game_check) && level.no_end_game_check || [[ level.var_4cf8bbbd ]]())) {
            return finaldamage;
        } else if (self.lives == 0 || !self hasperk("specialty_quickrevive")) {
            self.intermission = 1;
        }
    }
    var_c47bf847 = self.lives == 0 || players.size == 1 && level flag::get("solo_game") && !self hasperk("specialty_quickrevive");
    var_af50710b = players.size == 1 && (count > 1 || !level flag::get("solo_game"));
    if ((var_c47bf847 || var_af50710b) && !(isdefined(level.no_end_game_check) && level.no_end_game_check)) {
        level notify(#"stop_suicide_trigger");
        self allowprone(1);
        self thread zm_laststand::playerlaststand(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
        if (!isdefined(vdir)) {
            vdir = (1, 0, 0);
        }
        self fakedamagefrom(vdir);
        level notify(#"last_player_died");
        if (isdefined(level.custom_player_fake_death)) {
            self thread [[ level.custom_player_fake_death ]](vdir, smeansofdeath);
        } else {
            self thread player_fake_death();
        }
    }
    if (count == players.size && !(isdefined(level.no_end_game_check) && level.no_end_game_check)) {
        if (players.size == 1 && level flag::get("solo_game")) {
            if (self.lives == 0 || !self hasperk("specialty_quickrevive")) {
                self.lives = 0;
                level notify(#"pre_end_game");
                util::wait_network_frame();
                if (level flag::get("dog_round")) {
                    increment_dog_round_stat("lost");
                }
                level notify(#"end_game");
            } else {
                return finaldamage;
            }
        } else {
            level notify(#"pre_end_game");
            util::wait_network_frame();
            if (level flag::get("dog_round")) {
                increment_dog_round_stat("lost");
            }
            level notify(#"end_game");
        }
        return 0;
    }
    surface = "flesh";
    return finaldamage;
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x258c679e, Offset: 0x123d0
// Size: 0xd2
function clear_path_timers() {
    zombies = getaiteamarray(level.zombie_team);
    foreach (zombie in zombies) {
        if (isdefined(zombie.favoriteenemy) && zombie.favoriteenemy == self) {
            zombie.zombie_path_timer = 0;
        }
    }
}

// Namespace zm
// Params 10, eflags: 0x0
// Checksum 0x5fdbe36c, Offset: 0x124b0
// Size: 0xf8
function check_player_damage_callbacks(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
    if (!isdefined(level.player_damage_callbacks)) {
        return idamage;
    }
    for (i = 0; i < level.player_damage_callbacks.size; i++) {
        newdamage = self [[ level.player_damage_callbacks[i] ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
        if (-1 != newdamage) {
            return newdamage;
        }
    }
    return idamage;
}

// Namespace zm
// Params 1, eflags: 0x0
// Checksum 0x49b15b2a, Offset: 0x125b0
// Size: 0x3a
function register_player_damage_callback(func) {
    if (!isdefined(level.player_damage_callbacks)) {
        level.player_damage_callbacks = [];
    }
    level.player_damage_callbacks[level.player_damage_callbacks.size] = func;
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xecbef3a5, Offset: 0x125f8
// Size: 0x2f4
function wait_and_revive() {
    self endon(#"remote_revive");
    level flag::set("wait_and_revive");
    level.wait_and_revive = 1;
    if (isdefined(self.waiting_to_revive) && self.waiting_to_revive == 1) {
        return;
    }
    if (isdefined(self.var_698f7e["perk_lose"]) && self.var_698f7e["perk_lose"]) {
        self zm_pers_upgrades_functions::function_b725835b();
    }
    self.waiting_to_revive = 1;
    self.lives--;
    if (isdefined(level.exit_level_func)) {
        self thread [[ level.exit_level_func ]]();
    } else if (getplayers().size == 1) {
        player = getplayers()[0];
        level.move_away_points = positionquery_source_navigation(player.origin, 480, 960, 120, 20);
        if (!isdefined(level.move_away_points)) {
            level.move_away_points = positionquery_source_navigation(player.last_valid_position, 480, 960, 120, 20);
        }
    }
    var_2840ac64 = 10;
    name = level.var_b4442f7e[self getentitynumber()];
    self.revive_hud settext(%ZOMBIE_REVIVING_SOLO, name);
    self laststand::revive_hud_show_n_fade(var_2840ac64);
    level flag::wait_till_timeout(var_2840ac64, "instant_revive");
    if (level flag::get("instant_revive")) {
        self laststand::revive_hud_show_n_fade(1);
    }
    level flag::clear("wait_and_revive");
    level.wait_and_revive = 0;
    self zm_laststand::auto_revive(self);
    self.waiting_to_revive = 0;
    if (isdefined(self.var_698f7e["perk_lose"]) && self.var_698f7e["perk_lose"]) {
        self thread zm_pers_upgrades_functions::function_ac62adf2();
    }
}

// Namespace zm
// Params 1, eflags: 0x0
// Checksum 0x59961262, Offset: 0x128f8
// Size: 0x3a
function register_vehicle_damage_callback(func) {
    if (!isdefined(level.vehicle_damage_callbacks)) {
        level.vehicle_damage_callbacks = [];
    }
    level.vehicle_damage_callbacks[level.vehicle_damage_callbacks.size] = func;
}

// Namespace zm
// Params 15, eflags: 0x0
// Checksum 0xaa951640, Offset: 0x12940
// Size: 0x15c
function vehicle_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    if (isdefined(level.vehicle_damage_callbacks)) {
        for (i = 0; i < level.vehicle_damage_callbacks.size; i++) {
            idamage = self [[ level.vehicle_damage_callbacks[i] ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
        }
    }
    self globallogic_vehicle::callback_vehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
}

// Namespace zm
// Params 12, eflags: 0x0
// Checksum 0x53d7bdb8, Offset: 0x12aa8
// Size: 0x88a
function actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    if (!isdefined(self) || !isdefined(attacker)) {
        return damage;
    }
    damage = bgb::actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
    damage = self check_actor_damage_callbacks(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
    self.knuckles_extinguish_flames = weapon.name == "tazer_knuckles";
    if (isdefined(attacker.animname) && attacker.animname == "quad_zombie") {
        if (isdefined(self.animname) && self.animname == "quad_zombie") {
            return 0;
        }
    }
    if (isdefined(self.killby_interdimensional_gun_hole)) {
        return damage;
    } else if (isdefined(self.interdimensional_gun_kill)) {
        if (isdefined(self.var_654f1c0)) {
            self [[ self.var_654f1c0 ]](inflictor, attacker);
            return 0;
        }
    }
    if (isdefined(weapon)) {
        if (!isdefined(meansofdeath) || is_idgun_damage(weapon) && meansofdeath != "MOD_EXPLOSIVE") {
            if (!(self.archetype === "margwa") && !(self.archetype === "mechz")) {
                self.damageorigin = vpoint;
                self.allowdeath = 0;
                self.magic_bullet_shield = 1;
                self.interdimensional_gun_kill = 1;
                self.interdimensional_gun_weapon = weapon;
                self.interdimensional_gun_attacker = attacker;
                if (isdefined(inflictor)) {
                    self.interdimensional_gun_inflictor = inflictor;
                } else {
                    self.interdimensional_gun_inflictor = attacker;
                }
            }
            if (isdefined(self.var_654f1c0)) {
                self [[ self.var_654f1c0 ]](inflictor, attacker);
            }
            return 0;
        }
    }
    attacker thread zm_audio::sndplayerhitalert(self, meansofdeath, inflictor, weapon);
    if (!isplayer(attacker) && isdefined(self.non_attacker_func)) {
        if (isdefined(self.non_attack_func_takes_attacker) && self.non_attack_func_takes_attacker) {
            return self [[ self.non_attacker_func ]](damage, weapon, attacker);
        } else {
            return self [[ self.non_attacker_func ]](damage, weapon);
        }
    }
    if (isdefined(attacker) && isai(attacker)) {
        if (self.team == attacker.team && meansofdeath == "MOD_MELEE") {
            return 0;
        }
    }
    if (attacker.classname == "script_vehicle" && isdefined(attacker.owner)) {
        attacker = attacker.owner;
    }
    if (!isdefined(damage) || !isdefined(meansofdeath)) {
        return damage;
    }
    if (meansofdeath == "") {
        return damage;
    }
    if (isdefined(self.aioverridedamage)) {
        for (index = 0; index < self.aioverridedamage.size; index++) {
            damagecallback = self.aioverridedamage[index];
            damage = self [[ damagecallback ]](inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, undefined);
        }
        if (damage < 1) {
            return 0;
        }
        damage = int(damage + 0.5);
    }
    old_damage = damage;
    final_damage = damage;
    if (isdefined(self.actor_damage_func)) {
        final_damage = [[ self.actor_damage_func ]](inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex);
    }
    /#
        if (getdvarint("<dev string:x518>")) {
            println("<dev string:x526>" + final_damage / old_damage + "<dev string:x53d>" + old_damage + "<dev string:x54d>" + final_damage);
        }
    #/
    if (isdefined(self.in_water) && self.in_water) {
        if (int(final_damage) >= self.health) {
            self.water_damage = 1;
        }
    }
    if (isdefined(inflictor) && isdefined(inflictor.archetype) && inflictor.archetype == "glaive") {
        if (meansofdeath == "MOD_CRUSH") {
            if (isdefined(inflictor._glaive_must_return_to_owner) && (isdefined(inflictor.enemy) && inflictor.enemy != self || inflictor._glaive_must_return_to_owner)) {
                if (isdefined(self.archetype) && self.archetype != "margwa") {
                    final_damage += self.health;
                    if (isactor(self)) {
                        self zombie_utility::gib_random_parts();
                    }
                }
            } else {
                return 0;
            }
        }
    }
    if (isdefined(inflictor) && isplayer(attacker) && attacker == inflictor) {
        if (meansofdeath == "MOD_HEAD_SHOT" || meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_RIFLE_BULLET") {
            attacker.hits++;
        }
    }
    if (isdefined(level.headshots_only) && level.headshots_only && isdefined(attacker) && isplayer(attacker)) {
        if (shitloc == "head" || meansofdeath == "MOD_MELEE" && shitloc == "helmet") {
            return int(final_damage);
        }
        if (zm_utility::is_explosive_damage(meansofdeath)) {
            return int(final_damage);
        } else if (!zm_utility::is_headshot(weapon, shitloc, meansofdeath)) {
            return 0;
        }
    }
    return int(final_damage);
}

// Namespace zm
// Params 12, eflags: 0x0
// Checksum 0xbeb96848, Offset: 0x13340
// Size: 0x110
function check_actor_damage_callbacks(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    if (!isdefined(level.actor_damage_callbacks)) {
        return damage;
    }
    for (i = 0; i < level.actor_damage_callbacks.size; i++) {
        newdamage = self [[ level.actor_damage_callbacks[i] ]](inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
        if (-1 != newdamage) {
            return newdamage;
        }
    }
    return damage;
}

// Namespace zm
// Params 1, eflags: 0x0
// Checksum 0x2bb3c5ff, Offset: 0x13458
// Size: 0x3a
function register_actor_damage_callback(func) {
    if (!isdefined(level.actor_damage_callbacks)) {
        level.actor_damage_callbacks = [];
    }
    level.actor_damage_callbacks[level.actor_damage_callbacks.size] = func;
}

// Namespace zm
// Params 15, eflags: 0x0
// Checksum 0x39d54f98, Offset: 0x134a0
// Size: 0x24c
function actor_damage_override_wrapper(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, modelindex, surfacetype, vsurfacenormal) {
    damage_override = self actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
    willbekilled = self.health - damage_override <= 0;
    if (isdefined(level.zombie_damage_override_callbacks)) {
        foreach (func_override in level.zombie_damage_override_callbacks) {
            self thread [[ func_override ]](willbekilled, inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
        }
    }
    bb::logdamage(attacker, self, weapon, damage_override, meansofdeath, shitloc, willbekilled, willbekilled);
    if (!willbekilled || !(isdefined(self.dont_die_on_me) && self.dont_die_on_me)) {
        self finishactordamage(inflictor, attacker, damage_override, flags, meansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, surfacetype, vsurfacenormal);
    }
}

// Namespace zm
// Params 1, eflags: 0x0
// Checksum 0x2b99d855, Offset: 0x136f8
// Size: 0x92
function register_zombie_damage_override_callback(func) {
    if (!isdefined(level.zombie_damage_override_callbacks)) {
        level.zombie_damage_override_callbacks = [];
    }
    if (!isdefined(level.zombie_damage_override_callbacks)) {
        level.zombie_damage_override_callbacks = [];
    } else if (!isarray(level.zombie_damage_override_callbacks)) {
        level.zombie_damage_override_callbacks = array(level.zombie_damage_override_callbacks);
    }
    level.zombie_damage_override_callbacks[level.zombie_damage_override_callbacks.size] = func;
}

// Namespace zm
// Params 8, eflags: 0x0
// Checksum 0x7b472e42, Offset: 0x13798
// Size: 0x290
function actor_killed_override(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
    if (game["state"] == "postgame") {
        return;
    }
    if (isai(attacker) && isdefined(attacker.script_owner)) {
        if (attacker.script_owner.team != self.team) {
            attacker = attacker.script_owner;
        }
    }
    if (attacker.classname == "script_vehicle" && isdefined(attacker.owner)) {
        attacker = attacker.owner;
    }
    if (isdefined(attacker) && isplayer(attacker)) {
        multiplier = 1;
        if (zm_utility::is_headshot(weapon, shitloc, smeansofdeath)) {
            multiplier = 1.5;
        }
        type = undefined;
        if (isdefined(self.animname)) {
            switch (self.animname) {
            case "quad_zombie":
                type = "quadkill";
                break;
            case "ape_zombie":
                type = "apekill";
                break;
            case "zombie":
                type = "zombiekill";
                break;
            case "zombie_dog":
                type = "dogkill";
                break;
            }
        }
    }
    if (isdefined(self.is_ziplining) && self.is_ziplining) {
        self.deathanim = undefined;
    }
    if (isdefined(self.actor_killed_override)) {
        self [[ self.actor_killed_override ]](einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
    }
    if (isdefined(self.deathfunction)) {
        self [[ self.deathfunction ]](einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
    }
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x2a4656c5, Offset: 0x13a30
// Size: 0x70
function round_end_monitor() {
    while (true) {
        level waittill(#"end_of_round");
        demo::bookmark("zm_round_end", gettime(), undefined, undefined, 1);
        bbpostdemostreamstatsforround(level.round_number);
        zm_utility::upload_zm_dash_counters();
        wait 0.05;
    }
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x21b849e7, Offset: 0x13aa8
// Size: 0x114
function function_c67c5c4a() {
    zm_utility::increment_zm_dash_counter("end_per_game", 1);
    zm_utility::increment_zm_dash_counter("end_per_player", level.players.size);
    if (!(isdefined(level.dash_counter_round_reached_5) && level.dash_counter_round_reached_5)) {
        zm_utility::increment_zm_dash_counter("end_less_5", 1);
    } else if (!(isdefined(level.dash_counter_round_reached_10) && level.dash_counter_round_reached_10)) {
        zm_utility::increment_zm_dash_counter("end_reached_5_less_10", 1);
    } else {
        zm_utility::increment_zm_dash_counter("end_reached_10", 1);
    }
    if (!zm_utility::is_solo_ranked_game()) {
        if (level.var_e656acd7 != level.players.size) {
            zm_utility::increment_zm_dash_counter("end_player_count_diff", 1);
        }
    }
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x93aa97, Offset: 0x13bc8
// Size: 0xf9a
function end_game() {
    level waittill(#"end_game");
    check_end_game_intermission_delay();
    println("<dev string:x55e>");
    setmatchflag("game_ended", 1);
    level clientfield::set("gameplay_started", 0);
    level clientfield::set("game_end_time", int((gettime() - level.n_gameplay_start_time + 500) / 1000));
    util::clientnotify("zesn");
    level thread zm_audio::sndmusicsystem_playstate("game_over");
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i] clientfield::set("zmbLastStand", 0);
    }
    for (i = 0; i < players.size; i++) {
        if (players[i] laststand::player_is_in_laststand()) {
            players[i] recordplayerdeathzombies();
            players[i] zm_stats::increment_player_stat("deaths");
            players[i] zm_stats::increment_client_stat("deaths");
            players[i] zm_pers_upgrades_functions::function_3699cfb6();
        }
        if (isdefined(players[i].var_fca62492)) {
            players[i].var_fca62492 destroy();
        }
    }
    stopallrumbles();
    level.intermission = 1;
    level.zombie_vars["zombie_powerup_insta_kill_time"] = 0;
    level.zombie_vars["zombie_powerup_fire_sale_time"] = 0;
    level.zombie_vars["zombie_powerup_double_points_time"] = 0;
    wait 0.1;
    game_over = [];
    survived = [];
    players = getplayers();
    setmatchflag("disableIngameMenu", 1);
    foreach (player in players) {
        player closeingamemenu();
        player closemenu("StartMenu_Main");
    }
    foreach (player in players) {
        player setdstat("AfterActionReportStats", "lobbyPopup", "summary");
    }
    if (!isdefined(level._supress_survived_screen)) {
        for (i = 0; i < players.size; i++) {
            game_over[i] = newclienthudelem(players[i]);
            survived[i] = newclienthudelem(players[i]);
            if (isdefined(level.var_d3bc0206)) {
                [[ level.var_d3bc0206 ]](players[i], game_over[i], survived[i]);
            } else {
                game_over[i].alignx = "center";
                game_over[i].aligny = "middle";
                game_over[i].horzalign = "center";
                game_over[i].vertalign = "middle";
                game_over[i].y = game_over[i].y - -126;
                game_over[i].foreground = 1;
                game_over[i].fontscale = 3;
                game_over[i].alpha = 0;
                game_over[i].color = (1, 1, 1);
                game_over[i].hidewheninmenu = 1;
                game_over[i] settext(%ZOMBIE_GAME_OVER);
                game_over[i] fadeovertime(1);
                game_over[i].alpha = 1;
                if (players[i] issplitscreen()) {
                    game_over[i].fontscale = 2;
                    game_over[i].y = game_over[i].y + 40;
                }
                survived[i].alignx = "center";
                survived[i].aligny = "middle";
                survived[i].horzalign = "center";
                survived[i].vertalign = "middle";
                survived[i].y = survived[i].y - 100;
                survived[i].foreground = 1;
                survived[i].fontscale = 2;
                survived[i].alpha = 0;
                survived[i].color = (1, 1, 1);
                survived[i].hidewheninmenu = 1;
                if (players[i] issplitscreen()) {
                    survived[i].fontscale = 1.5;
                    survived[i].y = survived[i].y + 40;
                }
            }
            if (level.round_number < 2) {
                if (level.script == "zm_moon") {
                    if (!isdefined(level.var_3d4fdded)) {
                        var_ea3f1473 = level.var_78821af9;
                        var_a97d7ae5 = int(var_ea3f1473 / 1000);
                        var_73d0606f = to_mins(var_a97d7ae5);
                        survived[i] settext(%ZOMBIE_SURVIVED_NOMANS, var_73d0606f);
                    } else if (level.var_3d4fdded == 2) {
                        survived[i] settext(%ZOMBIE_SURVIVED_ROUND);
                    }
                } else {
                    survived[i] settext(%ZOMBIE_SURVIVED_ROUND);
                }
            } else {
                survived[i] settext(%ZOMBIE_SURVIVED_ROUNDS, level.round_number);
            }
            survived[i] fadeovertime(1);
            survived[i].alpha = 1;
        }
    }
    if (isdefined(level.var_dae44d7d)) {
        level [[ level.var_dae44d7d ]]();
    }
    for (i = 0; i < players.size; i++) {
        players[i] setclientuivisibilityflag("weapon_hud_visible", 0);
        players[i] setclientminiscoreboardhide(1);
        players[i] notify(#"report_bgb_consumption");
        players[i] zm_utility::function_49207008();
    }
    uploadstats();
    zm_stats::update_players_stats_at_match_end(players);
    zm_stats::update_global_counters_on_match_end();
    bb::logroundevent("end_game");
    upload_leaderboards();
    recordgameresult("draw");
    globallogic::function_69948487("draw");
    globallogic_player::recordactiveplayersendgamematchrecordstats();
    function_c67c5c4a();
    if (sessionmodeisonlinegame()) {
        level thread zm_utility::function_a6fb8892();
    }
    finalizematchrecord();
    players = getplayers();
    foreach (player in players) {
        if (isdefined(player.sessionstate) && player.sessionstate == "spectator") {
            player.sessionstate = "playing";
            player thread end_game_player_was_spectator();
        }
    }
    wait 0.05;
    /#
        if (!(isdefined(level.host_ended_game) && level.host_ended_game) && getdvarint("<dev string:x572>") > 1) {
            luinotifyevent(%"<dev string:x586>", 0);
            map_restart(1);
            wait 666;
        }
    #/
    players = getplayers();
    luinotifyevent(%force_scoreboard, 1, 1);
    intermission();
    wait level.zombie_vars["zombie_intermission_time"];
    if (!isdefined(level._supress_survived_screen)) {
        for (i = 0; i < players.size; i++) {
            survived[i] destroy();
            game_over[i] destroy();
        }
    } else {
        for (i = 0; i < players.size; i++) {
            if (isdefined(players[i].var_57dee721)) {
                players[i].var_57dee721 destroy();
            }
            if (isdefined(players[i].var_130ce0de)) {
                players[i].var_130ce0de destroy();
            }
        }
    }
    level notify(#"stop_intermission");
    array::thread_all(getplayers(), &player_exit_level);
    wait 1.5;
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i] cameraactivate(0);
    }
    /#
        if (!(isdefined(level.host_ended_game) && level.host_ended_game) && getdvarint("<dev string:x572>")) {
            luinotifyevent(%"<dev string:x586>", 1, 0);
            map_restart(1);
            wait 666;
        }
    #/
    exitlevel(0);
    wait 666;
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xbd8cf547, Offset: 0x14b70
// Size: 0x3c
function end_game_player_was_spectator() {
    wait 0.05;
    self ghost();
    self freezecontrols(1);
}

// Namespace zm
// Params 1, eflags: 0x0
// Checksum 0xfa97e3ff, Offset: 0x14bb8
// Size: 0x26
function disable_end_game_intermission(delay) {
    level.disable_intermission = 1;
    wait delay;
    level.disable_intermission = undefined;
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x6c396d95, Offset: 0x14be8
// Size: 0x34
function check_end_game_intermission_delay() {
    if (isdefined(level.disable_intermission)) {
        while (true) {
            if (!isdefined(level.disable_intermission)) {
                break;
            }
            wait 0.01;
        }
    }
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xbe2284a3, Offset: 0x14c28
// Size: 0x66
function upload_leaderboards() {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i] uploadleaderboards();
    }
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x5b2d48e, Offset: 0x14c98
// Size: 0x64
function initializestattracking() {
    level.global_zombies_killed = 0;
    level.zombies_timeout_spawn = 0;
    level.zombies_timeout_playspace = 0;
    level.zombies_timeout_undamaged = 0;
    level.zombie_player_killed_count = 0;
    level.zombie_trap_killed_count = 0;
    level.zombie_pathing_failed = 0;
    level.zombie_breadcrumb_failed = 0;
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xb6c563ac, Offset: 0x14d08
// Size: 0x64
function uploadglobalstatcounters() {
    incrementcounter("global_zombies_killed", level.global_zombies_killed);
    incrementcounter("global_zombies_killed_by_players", level.zombie_player_killed_count);
    incrementcounter("global_zombies_killed_by_traps", level.zombie_trap_killed_count);
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xf46fb374, Offset: 0x14d78
// Size: 0xbc
function player_fake_death() {
    level notify(#"fake_death");
    self notify(#"fake_death");
    self takeallweapons();
    self allowstand(0);
    self allowcrouch(0);
    self allowprone(1);
    self.ignoreme = 1;
    self enableinvulnerability();
    wait 1;
    self freezecontrols(1);
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x6e971c8a, Offset: 0x14e40
// Size: 0x4c
function player_exit_level() {
    self allowstand(1);
    self allowcrouch(0);
    self allowprone(0);
}

// Namespace zm
// Params 9, eflags: 0x0
// Checksum 0x51304140, Offset: 0x14e98
// Size: 0x58
function player_killed_override(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    level waittill(#"forever");
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x406ba864, Offset: 0x14ef8
// Size: 0x2ce
function function_39d714b5() {
    self notify(#"hash_751883f0");
    self endon(#"hash_751883f0");
    self endon(#"disconnect");
    self endon(#"spawned_spectator");
    level endon(#"intermission");
    self.zombie_breadcrumbs = [];
    self.var_eec471e5 = 576;
    self.var_66fcfa = 3;
    self.var_62e10b27 = 16;
    self function_9ca63ef4(self.origin);
    var_b89c46e9 = self.origin;
    self thread zm_utility::function_fad250ed();
    while (true) {
        wait_time = 0.1;
        if (self.ignoreme) {
            wait wait_time;
            continue;
        }
        var_9ca63ef4 = 1;
        var_53a57667 = 0;
        crumb = self.origin;
        if (!self isonground() && self isinvehicle()) {
            trace = bullettrace(self.origin + (0, 0, 10), self.origin, 0, undefined);
            crumb = trace["position"];
        }
        if (!var_53a57667 && distancesquared(crumb, var_b89c46e9) < self.var_eec471e5) {
            var_9ca63ef4 = 0;
        }
        if (var_53a57667 && self isonground()) {
            var_9ca63ef4 = 1;
            var_53a57667 = 0;
        }
        if (isdefined(level.var_1462edc3)) {
            var_9ca63ef4 = self [[ level.var_1462edc3 ]](var_9ca63ef4);
        }
        if (isdefined(level.var_e8a07eb6)) {
            var_53a57667 = self [[ level.var_e8a07eb6 ]](var_53a57667);
        }
        if (var_9ca63ef4) {
            zm_utility::debug_print("Player is storing breadcrumb " + crumb);
            if (isdefined(self.node)) {
                zm_utility::debug_print("has closest node ");
            }
            var_b89c46e9 = crumb;
            self function_9ca63ef4(crumb);
        }
        wait wait_time;
    }
}

// Namespace zm
// Params 1, eflags: 0x0
// Checksum 0x8790f528, Offset: 0x151d0
// Size: 0x264
function function_9ca63ef4(origin) {
    offsets = [];
    height_offset = 32;
    index = 0;
    for (j = 1; j <= self.var_66fcfa; j++) {
        offset = j * self.var_62e10b27;
        offsets[0] = (origin[0] - offset, origin[1], origin[2]);
        offsets[1] = (origin[0] + offset, origin[1], origin[2]);
        offsets[2] = (origin[0], origin[1] - offset, origin[2]);
        offsets[3] = (origin[0], origin[1] + offset, origin[2]);
        offsets[4] = (origin[0] - offset, origin[1], origin[2] + height_offset);
        offsets[5] = (origin[0] + offset, origin[1], origin[2] + height_offset);
        offsets[6] = (origin[0], origin[1] - offset, origin[2] + height_offset);
        offsets[7] = (origin[0], origin[1] + offset, origin[2] + height_offset);
        for (i = 0; i < offsets.size; i++) {
            self.zombie_breadcrumbs[index] = offsets[i];
            index++;
        }
    }
}

// Namespace zm
// Params 1, eflags: 0x0
// Checksum 0x9be29e6f, Offset: 0x15440
// Size: 0x1c0
function to_mins(seconds) {
    hours = 0;
    minutes = 0;
    if (seconds > 59) {
        minutes = int(seconds / 60);
        seconds = int(seconds * 1000) % 60000;
        seconds *= 0.001;
        if (minutes > 59) {
            hours = int(minutes / 60);
            minutes = int(minutes * 1000) % 60000;
            minutes *= 0.001;
        }
    }
    if (hours < 10) {
        hours = "0" + hours;
    }
    if (minutes < 10) {
        minutes = "0" + minutes;
    }
    seconds = int(seconds);
    if (seconds < 10) {
        seconds = "0" + seconds;
    }
    combined = "" + hours + ":" + minutes + ":" + seconds;
    return combined;
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x46118bb7, Offset: 0x15608
// Size: 0x174
function intermission() {
    level.intermission = 1;
    level notify(#"intermission");
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i] setclientthirdperson(0);
        players[i] resetfov();
        players[i].health = 100;
        players[i] thread [[ level.custom_intermission ]]();
        players[i] stopsounds();
    }
    wait 5.25;
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i] clientfield::set("zmbLastStand", 0);
    }
    level thread zombie_game_over_death();
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x232256fe, Offset: 0x15788
// Size: 0x1ae
function zombie_game_over_death() {
    zombies = getaiteamarray(level.zombie_team);
    for (i = 0; i < zombies.size; i++) {
        if (!isalive(zombies[i])) {
            continue;
        }
        zombies[i] setgoal(zombies[i].origin);
    }
    for (i = 0; i < zombies.size; i++) {
        if (!isalive(zombies[i])) {
            continue;
        }
        if (isdefined(zombies[i].ignore_game_over_death) && zombies[i].ignore_game_over_death) {
            continue;
        }
        wait 0.5 + randomfloat(2);
        if (isdefined(zombies[i])) {
            if (!isvehicle(zombies[i])) {
                zombies[i] zombie_utility::zombie_head_gib();
            }
            zombies[i] kill();
        }
    }
}

// Namespace zm
// Params 3, eflags: 0x0
// Checksum 0x8c04e608, Offset: 0x15940
// Size: 0x4a
function screen_fade_in(n_time, v_color, str_menu_id) {
    lui::screen_fade(n_time, 0, 1, v_color, 0, str_menu_id);
    wait n_time;
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xba715883, Offset: 0x15998
// Size: 0x404
function player_intermission() {
    self closeingamemenu();
    self closemenu("StartMenu_Main");
    self notify(#"player_intermission");
    self endon(#"player_intermission");
    level endon(#"stop_intermission");
    self endon(#"disconnect");
    self endon(#"death");
    self notify(#"_zombie_game_over");
    self.score = self.score_total;
    points = struct::get_array("intermission", "targetname");
    if (!isdefined(points) || points.size == 0) {
        points = getentarray("info_intermission", "classname");
        if (points.size < 1) {
            println("<dev string:x597>");
            return;
        }
    }
    if (isdefined(level.b_show_single_intermission) && level.b_show_single_intermission) {
        a_s_temp_points = array::randomize(points);
        points = [];
        points[0] = array::random(a_s_temp_points);
    } else {
        points = array::randomize(points);
    }
    self zm_utility::create_streamer_hint(points[0].origin, points[0].angles, 0.9);
    wait 5;
    self lui::screen_fade_out(1);
    self.sessionstate = "intermission";
    self.spectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    self.friendlydamage = undefined;
    if (isdefined(level.player_intemission_spawn_callback)) {
        self thread [[ level.player_intemission_spawn_callback ]](points[0].origin, points[0].angles);
    }
    while (true) {
        for (i = 0; i < points.size; i++) {
            point = points[i];
            nextpoint = points[i + 1];
            self setorigin(point.origin);
            self setplayerangles(point.angles);
            wait 0.15;
            self notify(#"player_intermission_spawned");
            if (isdefined(nextpoint)) {
                self zm_utility::create_streamer_hint(nextpoint.origin, nextpoint.angles, 0.9);
                self screen_fade_in(2);
                wait 3;
                self lui::screen_fade_out(2);
                continue;
            }
            self screen_fade_in(2);
            if (points.size == 1) {
                return;
            }
        }
    }
}

// Namespace zm
// Params 1, eflags: 0x0
// Checksum 0x3b366255, Offset: 0x15da8
// Size: 0x30
function fade_up_over_time(t) {
    self fadeovertime(t);
    self.alpha = 1;
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x49741f0a, Offset: 0x15de0
// Size: 0x116
function default_exit_level() {
    zombies = getaiteamarray(level.zombie_team);
    for (i = 0; i < zombies.size; i++) {
        if (isdefined(zombies[i].ignore_solo_last_stand) && zombies[i].ignore_solo_last_stand) {
            continue;
        }
        if (isdefined(zombies[i].find_exit_point)) {
            zombies[i] thread [[ zombies[i].find_exit_point ]]();
            continue;
        }
        if (zombies[i].ignoreme) {
            zombies[i] thread default_delayed_exit();
            continue;
        }
        zombies[i] thread default_find_exit_point();
    }
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x55c4e156, Offset: 0x15f00
// Size: 0x6c
function default_delayed_exit() {
    self endon(#"death");
    while (true) {
        if (!level flag::get("wait_and_revive")) {
            return;
        }
        if (!self.ignoreme) {
            break;
        }
        wait 0.1;
    }
    self thread default_find_exit_point();
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x5a54ad2d, Offset: 0x15f78
// Size: 0x2b8
function default_find_exit_point() {
    self endon(#"death");
    player = getplayers()[0];
    dist_zombie = 0;
    dist_player = 0;
    dest = 0;
    away = vectornormalize(self.origin - player.origin);
    endpos = self.origin + vectorscale(away, 600);
    if (isdefined(level.zm_loc_types["wait_location"]) && level.zm_loc_types["wait_location"].size > 0) {
        locs = array::randomize(level.zm_loc_types["wait_location"]);
    } else {
        locs = array::randomize(level.zm_loc_types["dog_location"]);
    }
    for (i = 0; i < locs.size; i++) {
        dist_zombie = distancesquared(locs[i].origin, endpos);
        dist_player = distancesquared(locs[i].origin, player.origin);
        if (dist_zombie < dist_player) {
            dest = i;
            break;
        }
    }
    self notify(#"stop_find_flesh");
    self notify(#"zombie_acquire_enemy");
    if (isdefined(locs[dest])) {
        self setgoal(locs[dest].origin);
    }
    while (true) {
        var_dd261077 = 1;
        if (isdefined(level.var_f803af94)) {
            var_dd261077 = [[ level.var_f803af94 ]]();
        }
        if (!level flag::get("wait_and_revive") && var_dd261077) {
            break;
        }
        wait 0.1;
    }
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x52365a02, Offset: 0x16238
// Size: 0x7c
function play_level_start_vox_delayed() {
    wait 3;
    players = getplayers();
    num = randomintrange(0, players.size);
    players[num] zm_audio::create_and_play_dialog("general", "intro");
}

// Namespace zm
// Params 2, eflags: 0x0
// Checksum 0x87e96f92, Offset: 0x162c0
// Size: 0x126
function register_sidequest(id, sidequest_stat) {
    if (!isdefined(level.zombie_sidequest_stat)) {
        level.zombie_sidequest_previously_completed = [];
        level.zombie_sidequest_stat = [];
    }
    level.zombie_sidequest_stat[id] = sidequest_stat;
    level flag::wait_till("start_zombie_round_logic");
    level.zombie_sidequest_previously_completed[id] = 0;
    if (!level.onlinegame) {
        return;
    }
    if (isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
        return;
    }
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (players[i] zm_stats::get_global_stat(level.zombie_sidequest_stat[id])) {
            level.zombie_sidequest_previously_completed[id] = 1;
            return;
        }
    }
}

// Namespace zm
// Params 1, eflags: 0x0
// Checksum 0x30cc5fc8, Offset: 0x163f0
// Size: 0x2c
function is_sidequest_previously_completed(id) {
    return isdefined(level.zombie_sidequest_previously_completed[id]) && level.zombie_sidequest_previously_completed[id];
}

// Namespace zm
// Params 1, eflags: 0x0
// Checksum 0x19156669, Offset: 0x16428
// Size: 0xde
function set_sidequest_completed(id) {
    level notify(#"zombie_sidequest_completed", id);
    level.zombie_sidequest_previously_completed[id] = 1;
    if (!level.onlinegame) {
        return;
    }
    if (isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
        return;
    }
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (isdefined(level.zombie_sidequest_stat[id])) {
            players[i] zm_stats::add_global_stat(level.zombie_sidequest_stat[id], 1);
        }
    }
}

// Namespace zm
// Params 2, eflags: 0x0
// Checksum 0xf80ccafa, Offset: 0x16510
// Size: 0x86
function function_dea8b878(mod, attacker) {
    if (isdefined(attacker.archetype) && (isdefined(attacker.is_zombie) && attacker.is_zombie || attacker.archetype == "margwa")) {
        self playsoundtoplayer("evt_player_swiped", self);
        return;
    }
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xd4ab3fc2, Offset: 0x165a0
// Size: 0x1e4
function precache_zombie_leaderboards() {
    if (sessionmodeissystemlink()) {
        return;
    }
    globalleaderboards = "LB_ZM_GB_BULLETS_FIRED_AT ";
    globalleaderboards += "LB_ZM_GB_BULLETS_HIT_AT ";
    globalleaderboards += "LB_ZM_GB_DISTANCE_TRAVELED_AT ";
    globalleaderboards += "LB_ZM_GB_DOORS_PURCHASED_AT ";
    globalleaderboards += "LB_ZM_GB_GRENADE_KILLS_AT ";
    globalleaderboards += "LB_ZM_GB_HEADSHOTS_AT ";
    globalleaderboards += "LB_ZM_GB_KILLS_AT ";
    globalleaderboards += "LB_ZM_GB_PERKS_DRANK_AT ";
    globalleaderboards += "LB_ZM_GB_REVIVES_AT ";
    globalleaderboards += "LB_ZM_GB_KILLSTATS_MR ";
    globalleaderboards += "LB_ZM_GB_GAMESTATS_MR ";
    if (!level.rankedmatch && getdvarint("zm_private_rankedmatch", 0) == 0) {
        precacheleaderboards(globalleaderboards);
        return;
    }
    mapname = getdvarstring("mapname");
    expectedplayernum = getnumexpectedplayers();
    mapleaderboard = "LB_ZM_MAP_" + getsubstr(mapname, 3, mapname.size) + "_" + expectedplayernum + "PLAYER";
    precacheleaderboards(globalleaderboards + mapleaderboard);
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x85d9b28b, Offset: 0x16790
// Size: 0x1c8
function zm_on_player_connect() {
    if (level.passed_introscreen) {
        self setclientuivisibilityflag("hud_visible", 1);
        self setclientuivisibilityflag("weapon_hud_visible", 1);
        zm_utility::increment_zm_dash_counter("hotjoined", 1);
        zm_utility::upload_zm_dash_counters();
    }
    self flag::init("used_consumable");
    self thread zm_utility::function_d6ee2ab();
    self thread zm_utility::function_471c122b();
    thread function_785a0ae4();
    self thread watchdisconnect();
    self.hud_damagefeedback = newdamageindicatorhudelem(self);
    self.hud_damagefeedback.horzalign = "center";
    self.hud_damagefeedback.vertalign = "middle";
    self.hud_damagefeedback.x = -12;
    self.hud_damagefeedback.y = -12;
    self.hud_damagefeedback.alpha = 0;
    self.hud_damagefeedback.archived = 1;
    self.hud_damagefeedback setshader("damage_feedback", 24, 48);
    self.hitsoundtracker = 1;
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x720ee805, Offset: 0x16960
// Size: 0x44
function function_ea9f4cdf() {
    thread function_785a0ae4();
    zm_utility::increment_zm_dash_counter("left_midgame", 1);
    zm_utility::upload_zm_dash_counters();
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x4bdf71f8, Offset: 0x169b0
// Size: 0x3c
function watchdisconnect() {
    self notify(#"watchdisconnect");
    self endon(#"watchdisconnect");
    self waittill(#"disconnect");
    function_ea9f4cdf();
}

// Namespace zm
// Params 1, eflags: 0x0
// Checksum 0xc2dfed38, Offset: 0x169f8
// Size: 0xba
function increment_dog_round_stat(stat) {
    players = getplayers();
    foreach (player in players) {
        player zm_stats::increment_client_stat("zdog_rounds_" + stat);
    }
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x671de82e, Offset: 0x16ac0
// Size: 0x34
function function_e43ad822() {
    level flag::wait_till("start_zombie_round_logic");
    thread function_785a0ae4();
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x3a9f239d, Offset: 0x16b00
// Size: 0x1da
function function_785a0ae4() {
    if (!isdefined(level.var_20955c15)) {
        return;
    }
    players = getplayers();
    foreach (player in players) {
        var_8336cbb5 = 0;
        for (i = 0; i < level.var_20955c15.size; i++) {
            var_d033858 = player zm_stats::get_global_stat(level.var_20955c15[i]);
            if (isdefined(player.var_3d88e938) && player.var_3d88e938 == level.var_20955c15[i]) {
                var_d033858 = 1;
            }
            if (var_d033858) {
                var_8336cbb5 += 1 << i;
            }
        }
        util::wait_network_frame();
        player clientfield::set("navcard_held", 0);
        if (var_8336cbb5 > 0) {
            util::wait_network_frame();
            player clientfield::set("navcard_held", var_8336cbb5);
        }
    }
}

// Namespace zm
// Params 1, eflags: 0x0
// Checksum 0x7926f174, Offset: 0x16ce8
// Size: 0x38
function function_dd15fb4e(var_2d92a626) {
    if (!var_2d92a626) {
        level.laststandpistol = level.default_laststandpistol;
        return;
    }
    level.laststandpistol = level.default_solo_laststandpistol;
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xd91d5804, Offset: 0x16d28
// Size: 0x8a
function player_too_many_players_check() {
    max_players = 4;
    if (level.scr_zm_ui_gametype == "zgrief" || level.scr_zm_ui_gametype == "zmeat") {
        max_players = 8;
    }
    if (getplayers().size > max_players) {
        zm_game_module::function_e3c73203(1);
        level notify(#"end_game");
    }
}

// Namespace zm
// Params 1, eflags: 0x0
// Checksum 0x5ed74505, Offset: 0x16dc0
// Size: 0x3e
function is_idgun_damage(weapon) {
    if (isdefined(level.idgun_weapons)) {
        if (isinarray(level.idgun_weapons, weapon)) {
            return true;
        }
    }
    return false;
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x23a475e2, Offset: 0x16e08
// Size: 0x24
function zm_on_player_spawned() {
    thread update_zone_name();
    thread update_is_player_valid();
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xf93edccd, Offset: 0x16e38
// Size: 0x60
function update_is_player_valid() {
    self endon(#"death");
    self endon(#"hash_3d78f33");
    self.am_i_valid = 1;
    while (isdefined(self)) {
        self.am_i_valid = zm_utility::is_player_valid(self, 1);
        wait 0.05;
    }
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0x59d13817, Offset: 0x16ea0
// Size: 0xb0
function update_zone_name() {
    self endon(#"death");
    self endon(#"hash_3d78f33");
    self.zone_name = zm_utility::get_current_zone();
    if (isdefined(self.zone_name)) {
        self.previous_zone_name = self.zone_name;
    }
    while (isdefined(self)) {
        if (isdefined(self.zone_name)) {
            self.previous_zone_name = self.zone_name;
        }
        self.zone_name = zm_utility::get_current_zone();
        wait randomfloatrange(0.5, 1);
    }
}

// Namespace zm
// Params 0, eflags: 0x0
// Checksum 0xaa3194d6, Offset: 0x16f58
// Size: 0x494
function printhashids() {
    /#
        outputstring = "<dev string:x5ba>";
        outputstring += "<dev string:x601>";
        foreach (var_3111271f in level.var_b09bbe80) {
            outputstring += "<dev string:x613>" + var_3111271f.name + "<dev string:x615>" + var_3111271f.hash_id + "<dev string:x165>";
            if (!isdefined(var_3111271f.var_7a5f63bc)) {
                continue;
            }
            foreach (var_b1028d0b in var_3111271f.var_7a5f63bc) {
                outputstring += var_b1028d0b.piecename + "<dev string:x615>" + var_b1028d0b.hash_id + "<dev string:x165>";
            }
        }
        outputstring += "<dev string:x617>";
        foreach (powerup in level.zombie_powerups) {
            outputstring += powerup.powerup_name + "<dev string:x615>" + powerup.hash_id + "<dev string:x165>";
        }
        outputstring += "<dev string:x627>";
        if (isdefined(level.aat_in_use) && level.aat_in_use) {
            foreach (aat in level.aat) {
                if (!isdefined(aat) || !isdefined(aat.name) || aat.name == "<dev string:x632>") {
                    continue;
                }
                outputstring += aat.name + "<dev string:x615>" + aat.hash_id + "<dev string:x165>";
            }
        }
        outputstring += "<dev string:x637>";
        foreach (perk in level._custom_perks) {
            if (!isdefined(perk) || !isdefined(perk.alias)) {
                continue;
            }
            outputstring += perk.alias + "<dev string:x615>" + perk.hash_id + "<dev string:x165>";
        }
        outputstring += "<dev string:x644>";
        println(outputstring);
    #/
}

