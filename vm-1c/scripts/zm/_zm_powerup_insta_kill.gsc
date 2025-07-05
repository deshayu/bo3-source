#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_pers_upgrades_functions;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_utility;

#namespace zm_powerup_insta_kill;

// Namespace zm_powerup_insta_kill
// Params 0, eflags: 0x2
// Checksum 0xc488e35, Offset: 0x2a0
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_powerup_insta_kill", &__init__, undefined, undefined);
}

// Namespace zm_powerup_insta_kill
// Params 0, eflags: 0x0
// Checksum 0xa5b697f, Offset: 0x2e0
// Size: 0xbc
function __init__() {
    zm_powerups::register_powerup("insta_kill", &grab_insta_kill);
    if (tolower(getdvarstring("g_gametype")) != "zcleansed") {
        zm_powerups::add_zombie_powerup("insta_kill", "p7_zm_power_up_insta_kill", %ZOMBIE_POWERUP_INSTA_KILL, &zm_powerups::func_should_always_drop, 0, 0, 0, undefined, "powerup_instant_kill", "zombie_powerup_insta_kill_time", "zombie_powerup_insta_kill_on");
    }
}

// Namespace zm_powerup_insta_kill
// Params 1, eflags: 0x0
// Checksum 0x9e4ae5c, Offset: 0x3a8
// Size: 0x44
function grab_insta_kill(player) {
    level thread insta_kill_powerup(self, player);
    player thread zm_powerups::powerup_vo("insta_kill");
}

// Namespace zm_powerup_insta_kill
// Params 2, eflags: 0x0
// Checksum 0xc66d2e3e, Offset: 0x3f8
// Size: 0x1c8
function insta_kill_powerup(drop_item, player) {
    level notify("powerup instakill_" + player.team);
    level endon("powerup instakill_" + player.team);
    if (isdefined(level.insta_kill_powerup_override)) {
        level thread [[ level.insta_kill_powerup_override ]](drop_item, player);
        return;
    }
    if (zm_utility::is_classic()) {
        player thread namespace_25f8c2ad::function_a312b387();
    }
    team = player.team;
    level thread zm_powerups::show_on_hud(team, "insta_kill");
    level.zombie_vars[team]["zombie_insta_kill"] = 1;
    n_wait_time = 30;
    if (bgb::is_team_enabled("zm_bgb_temporal_gift")) {
        n_wait_time += 30;
    }
    wait n_wait_time;
    level.zombie_vars[team]["zombie_insta_kill"] = 0;
    players = getplayers(team);
    for (i = 0; i < players.size; i++) {
        if (isdefined(players[i])) {
            players[i] notify(#"insta_kill_over");
        }
    }
}

