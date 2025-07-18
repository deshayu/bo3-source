#using scripts/codescripts/struct;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_daily_challenges;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_utility;

#namespace zm_powerup_nuke;

// Namespace zm_powerup_nuke
// Params 0, eflags: 0x2
// Checksum 0x82427fd2, Offset: 0x2e0
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_powerup_nuke", &__init__, undefined, undefined);
}

// Namespace zm_powerup_nuke
// Params 0, eflags: 0x0
// Checksum 0xd92d5b9c, Offset: 0x320
// Size: 0xd4
function __init__() {
    zm_powerups::register_powerup("nuke", &grab_nuke);
    clientfield::register("actor", "zm_nuked", 1000, 1, "counter");
    clientfield::register("vehicle", "zm_nuked", 1000, 1, "counter");
    zm_powerups::add_zombie_powerup("nuke", "p7_zm_power_up_nuke", %ZOMBIE_POWERUP_NUKE, &zm_powerups::func_should_always_drop, 0, 0, 0, "zombie/fx_powerup_nuke_zmb");
}

// Namespace zm_powerup_nuke
// Params 1, eflags: 0x0
// Checksum 0x5c85f5ea, Offset: 0x400
// Size: 0xa8
function grab_nuke(player) {
    level thread nuke_powerup(self, player.team);
    player thread zm_powerups::powerup_vo("nuke");
    zombies = getaiteamarray(level.zombie_team);
    player.zombie_nuked = arraysort(zombies, self.origin);
    player notify(#"nuke_triggered");
}

// Namespace zm_powerup_nuke
// Params 2, eflags: 0x0
// Checksum 0x412b3b31, Offset: 0x4b0
// Size: 0x49e
function nuke_powerup(drop_item, player_team) {
    level thread nuke_delay_spawning(3);
    location = drop_item.origin;
    if (isdefined(drop_item.fx)) {
        playfx(drop_item.fx, location);
    }
    level thread nuke_flash(player_team);
    wait 0.5;
    zombies = getaiteamarray(level.zombie_team);
    zombies = arraysort(zombies, location);
    zombies_nuked = [];
    for (i = 0; i < zombies.size; i++) {
        if (isdefined(zombies[i].ignore_nuke) && zombies[i].ignore_nuke) {
            continue;
        }
        if (isdefined(zombies[i].marked_for_death) && zombies[i].marked_for_death) {
            continue;
        }
        if (isdefined(zombies[i].nuke_damage_func)) {
            zombies[i] thread [[ zombies[i].nuke_damage_func ]]();
            continue;
        }
        if (zm_utility::is_magic_bullet_shield_enabled(zombies[i])) {
            continue;
        }
        zombies[i].marked_for_death = 1;
        if (!(isdefined(zombies[i].nuked) && zombies[i].nuked) && !zm_utility::is_magic_bullet_shield_enabled(zombies[i])) {
            zombies[i].nuked = 1;
            zombies_nuked[zombies_nuked.size] = zombies[i];
            zombies[i] clientfield::increment("zm_nuked");
        }
    }
    for (i = 0; i < zombies_nuked.size; i++) {
        wait randomfloatrange(0.1, 0.7);
        if (!isdefined(zombies_nuked[i])) {
            continue;
        }
        if (zm_utility::is_magic_bullet_shield_enabled(zombies_nuked[i])) {
            continue;
        }
        if (!(isdefined(zombies_nuked[i].isdog) && zombies_nuked[i].isdog)) {
            if (!(isdefined(zombies_nuked[i].no_gib) && zombies_nuked[i].no_gib)) {
                zombies_nuked[i] zombie_utility::zombie_head_gib();
            }
            zombies_nuked[i] playsound("evt_nuked");
        }
        zombies_nuked[i] dodamage(zombies_nuked[i].health + 666, zombies_nuked[i].origin);
        level thread zm_daily_challenges::increment_nuked_zombie();
    }
    level notify(#"nuke_complete");
    players = getplayers(player_team);
    for (i = 0; i < players.size; i++) {
        players[i] zm_score::player_add_points("nuke_powerup", 400);
    }
}

// Namespace zm_powerup_nuke
// Params 1, eflags: 0x0
// Checksum 0x7682e4e6, Offset: 0x958
// Size: 0xac
function nuke_flash(team) {
    if (isdefined(team)) {
        getplayers()[0] playsoundtoteam("evt_nuke_flash", team);
    } else {
        getplayers()[0] playsound("evt_nuke_flash");
    }
    lui::screen_flash(0.2, 0.5, 1, 0.8, "white");
}

// Namespace zm_powerup_nuke
// Params 1, eflags: 0x0
// Checksum 0xafff8d61, Offset: 0xa10
// Size: 0xc4
function nuke_delay_spawning(n_spawn_delay) {
    level endon(#"disable_nuke_delay_spawning");
    if (isdefined(level.disable_nuke_delay_spawning) && level.disable_nuke_delay_spawning) {
        return;
    }
    b_spawn_zombies_before_nuke = level flag::get("spawn_zombies");
    level flag::clear("spawn_zombies");
    level waittill(#"nuke_complete");
    if (isdefined(level.disable_nuke_delay_spawning) && level.disable_nuke_delay_spawning) {
        return;
    }
    wait n_spawn_delay;
    if (b_spawn_zombies_before_nuke) {
        level flag::set("spawn_zombies");
    }
}

