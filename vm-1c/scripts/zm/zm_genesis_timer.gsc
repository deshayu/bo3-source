#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_util;
#using scripts/zm/_zm;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_magicbox;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_zonemgr;

#namespace zm_genesis_timer;

// Namespace zm_genesis_timer
// Params 0, eflags: 0x2
// Checksum 0xbf77c7fd, Offset: 0x348
// Size: 0x3c
function autoexec __init__sytem__() {
    system::register("zm_genesis_timer", &__init__, &__main__, undefined);
}

// Namespace zm_genesis_timer
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x390
// Size: 0x4
function __init__() {
    
}

// Namespace zm_genesis_timer
// Params 0, eflags: 0x0
// Checksum 0x3da6be8d, Offset: 0x3a0
// Size: 0x14c
function __main__() {
    clientfield::register("world", "time_attack_reward", 15000, 3, "int");
    level flag::init("time_attack_weapon_awarded");
    level flag::wait_till("start_zombie_round_logic");
    foreach (s_wallbuy in level._spawned_wallbuys) {
        if (s_wallbuy.zombie_weapon_upgrade == "melee_nunchuks") {
            level.var_b9f3bf28 = s_wallbuy;
            level.var_b9f3bf28.trigger_stub.prompt_and_visibility_func = &function_6ac3689a;
            break;
        }
    }
    level thread function_86419da();
}

// Namespace zm_genesis_timer
// Params 1, eflags: 0x0
// Checksum 0x12384f36, Offset: 0x4f8
// Size: 0xf0
function function_6ac3689a(player) {
    if (player zm_magicbox::can_buy_weapon() && !player bgb::is_enabled("zm_bgb_disorderly_combat") && level flag::get("time_attack_weapon_awarded")) {
        self setvisibletoplayer(player);
        self.stub.hint_string = zm_weapons::get_weapon_hint(self.weapon);
        self sethintstring(self.stub.hint_string);
        return 1;
    }
    self setinvisibletoplayer(player);
    return 0;
}

// Namespace zm_genesis_timer
// Params 0, eflags: 0x0
// Checksum 0x6883f9dc, Offset: 0x5f0
// Size: 0x322
function function_86419da() {
    do {
        level waittill(#"end_of_round");
        n_current_time = (gettime() - level.n_gameplay_start_time) / 1000;
        var_99870abd = zm::get_round_number() - 1;
        var_ec31aba8 = undefined;
        switch (var_99870abd) {
        case 5:
            switch (level.players.size) {
            case 1:
                var_ec31aba8 = 300;
                break;
            case 2:
                var_ec31aba8 = 270;
                break;
            case 3:
                var_ec31aba8 = -6;
                break;
            case 4:
                var_ec31aba8 = -16;
                break;
            }
            goto LOC_00000154;
        case 10:
            switch (level.players.size) {
            case 1:
                var_ec31aba8 = 720;
                break;
            case 2:
                var_ec31aba8 = 690;
                break;
            case 3:
                var_ec31aba8 = 670;
                break;
            case 4:
                var_ec31aba8 = 660;
                break;
            }
        LOC_00000154:
            goto LOC_000001c8;
        case 15:
            switch (level.players.size) {
            case 1:
                var_ec31aba8 = 1140;
                break;
            case 2:
                var_ec31aba8 = 1170;
                break;
            case 3:
                var_ec31aba8 = 1020;
                break;
            case 4:
                var_ec31aba8 = 945;
                break;
            }
        LOC_000001c8:
            goto LOC_0000023c;
        case 20:
            switch (level.players.size) {
            case 1:
                var_ec31aba8 = 1920;
                break;
            case 2:
                var_ec31aba8 = 1800;
                break;
            case 3:
                var_ec31aba8 = 1720;
                break;
            case 4:
                var_ec31aba8 = 1680;
                break;
            }
        LOC_0000023c:
            break;
        default:
            break;
        }
        if (var_99870abd % 5 == 0) {
            if (isdefined(var_ec31aba8) && n_current_time < var_ec31aba8) {
                luinotifyevent(%zombie_time_attack_notification, 2, zm::get_round_number() - 1, level.players.size);
                playsoundatposition("zmb_genesis_timetrial_complete", (0, 0, 0));
                level thread function_cc8ae246(var_99870abd);
            }
        }
    } while (var_99870abd < 50);
}

// Namespace zm_genesis_timer
// Params 1, eflags: 0x0
// Checksum 0xda77ac43, Offset: 0x920
// Size: 0x27c
function function_cc8ae246(n_reward) {
    if (n_reward != -56 && level flag::get("hope_done")) {
        return;
    }
    switch (n_reward) {
    case 200:
        str_weapon = "melee_katana";
        var_31fcdfe3 = 5;
        break;
    case 5:
        str_weapon = "melee_nunchuks";
        var_31fcdfe3 = 1;
        break;
    case 10:
        str_weapon = "melee_mace";
        var_31fcdfe3 = 2;
        break;
    case 15:
        str_weapon = "melee_improvise";
        var_31fcdfe3 = 3;
        break;
    case 20:
        str_weapon = "melee_boneglass";
        var_31fcdfe3 = 4;
        break;
    }
    weapon = getweapon(str_weapon);
    level.var_b9f3bf28.zombie_weapon_upgrade = str_weapon;
    level.var_b9f3bf28.weapon = weapon;
    level.var_b9f3bf28.trigger_stub.weapon = weapon;
    level.var_b9f3bf28.trigger_stub.cursor_hint_weapon = weapon;
    clientfield::set(level.var_b9f3bf28.trigger_stub.clientfieldname, 0);
    level clientfield::set("time_attack_reward", var_31fcdfe3);
    util::wait_network_frame();
    clientfield::set(level.var_b9f3bf28.trigger_stub.clientfieldname, 2);
    util::wait_network_frame();
    clientfield::set(level.var_b9f3bf28.trigger_stub.clientfieldname, 1);
    level flag::set("time_attack_weapon_awarded");
}

