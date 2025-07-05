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

#namespace zm_stalingrad_timer;

// Namespace zm_stalingrad_timer
// Params 0, eflags: 0x2
// Checksum 0x744b49de, Offset: 0x360
// Size: 0x3c
function autoexec __init__sytem__() {
    system::register("zm_stalingrad_timer", &__init__, &__main__, undefined);
}

// Namespace zm_stalingrad_timer
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x3a8
// Size: 0x4
function __init__() {
    
}

// Namespace zm_stalingrad_timer
// Params 0, eflags: 0x0
// Checksum 0xfec4a344, Offset: 0x3b8
// Size: 0x14c
function __main__() {
    clientfield::register("world", "time_attack_reward", 12000, 3, "int");
    level flag::init("time_attack_weapon_awarded");
    level flag::wait_till("start_zombie_round_logic");
    foreach (s_wallbuy in level._spawned_wallbuys) {
        if (s_wallbuy.zombie_weapon_upgrade == "melee_wrench") {
            level.var_b9f3bf28 = s_wallbuy;
            level.var_b9f3bf28.trigger_stub.prompt_and_visibility_func = &function_6ac3689a;
            break;
        }
    }
    level thread function_86419da();
}

// Namespace zm_stalingrad_timer
// Params 1, eflags: 0x0
// Checksum 0x54e521e1, Offset: 0x510
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

// Namespace zm_stalingrad_timer
// Params 0, eflags: 0x0
// Checksum 0x3be65786, Offset: 0x608
// Size: 0x3bc
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
                var_ec31aba8 = 780;
                break;
            case 2:
                var_ec31aba8 = 720;
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
                var_ec31aba8 = 1440;
                break;
            case 2:
                var_ec31aba8 = 1200;
                break;
            case 3:
                var_ec31aba8 = 1020;
                break;
            case 4:
                var_ec31aba8 = 960;
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
                var_ec31aba8 = 1740;
                break;
            case 4:
                var_ec31aba8 = 1680;
                break;
            }
        LOC_0000023c:
            goto LOC_000002b0;
        case 50:
            switch (level.players.size) {
            case 1:
                var_ec31aba8 = 1920;
                break;
            case 2:
                var_ec31aba8 = 1800;
                break;
            case 3:
                var_ec31aba8 = 1740;
                break;
            case 4:
                var_ec31aba8 = 1680;
                break;
            }
        LOC_000002b0:
            break;
        default:
            break;
        }
        if (var_99870abd % 5 == 0) {
            if (isdefined(var_ec31aba8) && n_current_time < var_ec31aba8) {
                luinotifyevent(%zombie_time_attack_notification, 2, zm::get_round_number() - 1, level.players.size);
                playsoundatposition("zmb_stalingrad_time_trial_complete", (0, 0, 0));
                level thread function_cc8ae246(var_99870abd);
                if (var_99870abd == 20) {
                    level notify(#"hash_399599c1");
                }
            }
        }
    } while (var_99870abd < 50);
}

// Namespace zm_stalingrad_timer
// Params 1, eflags: 0x0
// Checksum 0x6b3e463, Offset: 0x9d0
// Size: 0x26c
function function_cc8ae246(str_reward) {
    switch (str_reward) {
    case 5:
        str_weapon = "melee_wrench";
        var_31fcdfe3 = 1;
        break;
    case 10:
        str_weapon = "melee_dagger";
        var_31fcdfe3 = 2;
        break;
    case 15:
        str_weapon = "melee_fireaxe";
        var_31fcdfe3 = 3;
        break;
    case 20:
        str_weapon = "melee_sword";
        var_31fcdfe3 = 4;
        break;
    case 50:
        str_weapon = "melee_daisho";
        var_31fcdfe3 = 5;
        level.var_b9f3bf28.var_5cf530a8 = %ZM_STALINGRAD_EE_WONDERWEAPON;
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

// Namespace zm_stalingrad_timer
// Params 0, eflags: 0x0
// Checksum 0xd2a28f06, Offset: 0xc48
// Size: 0xe4
function function_3d5b5002() {
    switch (level.players.size) {
    case 1:
        var_ec31aba8 = 6000;
        break;
    case 2:
        var_ec31aba8 = 5340;
        break;
    case 3:
        var_ec31aba8 = 4980;
        break;
    case 4:
        var_ec31aba8 = 4800;
        break;
    }
    if (level.var_2801f599 < var_ec31aba8) {
        level.perk_purchase_limit = level._custom_perks.size;
        callback::on_spawned(&on_player_spawned);
        array::thread_all(level.players, &function_959f59b8);
    }
}

// Namespace zm_stalingrad_timer
// Params 0, eflags: 0x0
// Checksum 0x88ccf2d6, Offset: 0xd38
// Size: 0x1c
function on_player_spawned() {
    self thread function_88b9bf27();
}

// Namespace zm_stalingrad_timer
// Params 0, eflags: 0x0
// Checksum 0x6217008d, Offset: 0xd60
// Size: 0x2c
function function_88b9bf27() {
    if (!isdefined(self.num_perks)) {
        wait 0.1;
    }
    self zm_utility::function_82a5cc4();
}

// Namespace zm_stalingrad_timer
// Params 0, eflags: 0x0
// Checksum 0x75b3ce55, Offset: 0xd98
// Size: 0x60
function function_959f59b8() {
    self endon(#"disconnect");
    while (isdefined(self)) {
        self waittill(#"player_revived");
        var_bfc9d652 = level.players.size == 1;
        self zm_utility::function_82a5cc4(var_bfc9d652);
    }
}

