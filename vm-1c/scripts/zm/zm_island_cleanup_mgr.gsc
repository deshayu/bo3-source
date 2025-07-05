#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/zm_island;

#namespace zm_island_cleanup;

// Namespace zm_island_cleanup
// Params 0, eflags: 0x2
// Checksum 0xacc26b74, Offset: 0x240
// Size: 0x3c
function autoexec __init__sytem__() {
    system::register("zm_island_cleanup", &__init__, &__main__, undefined);
}

// Namespace zm_island_cleanup
// Params 0, eflags: 0x0
// Checksum 0x4d917da7, Offset: 0x288
// Size: 0x10
function __init__() {
    level.n_cleanups_processed_this_frame = 0;
}

// Namespace zm_island_cleanup
// Params 0, eflags: 0x0
// Checksum 0x2d0edf1f, Offset: 0x2a0
// Size: 0x1c
function __main__() {
    level thread cleanup_main();
}

// Namespace zm_island_cleanup
// Params 0, eflags: 0x4
// Checksum 0x13db4dcd, Offset: 0x2c8
// Size: 0x29e
function private cleanup_main() {
    n_next_eval = 0;
    while (true) {
        util::wait_network_frame();
        n_time = gettime();
        if (n_time < n_next_eval) {
            continue;
        }
        if (isdefined(level.n_cleanup_manager_restart_time)) {
            n_current_time = gettime() / 1000;
            n_delta_time = n_current_time - level.n_cleanup_manager_restart_time;
            if (n_delta_time < 0) {
                continue;
            }
            level.n_cleanup_manager_restart_time = undefined;
        }
        n_round_time = (n_time - level.round_start_time) / 1000;
        if (level.round_number <= 2 && n_round_time < 15) {
            continue;
        } else if (level.round_number > 2 && level.round_number <= 5 && n_round_time < 30) {
            continue;
        } else if (level.round_number > 5 && n_round_time < 20) {
            continue;
        }
        if (isdefined(level.bzm_worldpaused) && level.bzm_worldpaused) {
            continue;
        }
        n_override_cleanup_dist_sq = undefined;
        if (level.zombie_total == 0 && zombie_utility::get_current_zombie_count() < 3) {
            n_override_cleanup_dist_sq = 4000000;
        }
        n_next_eval += 3000;
        a_ai_enemies = getaiteamarray("axis");
        foreach (ai_enemy in a_ai_enemies) {
            if (level.n_cleanups_processed_this_frame >= 1) {
                level.n_cleanups_processed_this_frame = 0;
                util::wait_network_frame();
            }
            ai_enemy do_cleanup_check(n_override_cleanup_dist_sq);
        }
    }
}

// Namespace zm_island_cleanup
// Params 1, eflags: 0x0
// Checksum 0x755c15a5, Offset: 0x570
// Size: 0x2e4
function do_cleanup_check(n_override_cleanup_dist) {
    if (!isalive(self)) {
        return;
    }
    if (self.b_ignore_cleanup === 1) {
        return;
    }
    if (self.var_20b8c74a === 1 || self.var_3f6ea790 === 1 || self.var_9b59d7f8 === 1) {
        return;
    }
    n_time_alive = gettime() - self.spawn_time;
    if (n_time_alive < 5000) {
        return;
    }
    if (self.archetype === "zombie") {
        if (n_time_alive < 45000 && self.script_string !== "find_flesh" && self.completed_emerging_into_playable_area !== 1) {
            return;
        }
    }
    if (self zm_zonemgr::entity_in_zone("zone_start_water")) {
        n_override_cleanup_dist = 4000000;
    }
    b_in_active_zone = self zm_zonemgr::entity_in_active_zone();
    level.n_cleanups_processed_this_frame++;
    if (isdefined(self.var_b1b7c1b7) && self.var_b1b7c1b7) {
        self thread function_cc0c7e36();
    }
    if (!b_in_active_zone) {
        n_dist_sq_min = 10000000;
        e_closest_player = level.activeplayers[0];
        foreach (player in level.activeplayers) {
            n_dist_sq = distancesquared(self.origin, player.origin);
            if (n_dist_sq < n_dist_sq_min) {
                n_dist_sq_min = n_dist_sq;
                e_closest_player = player;
            }
        }
        if (isdefined(n_override_cleanup_dist)) {
            n_cleanup_dist_sq = n_override_cleanup_dist;
        } else if (isdefined(e_closest_player) && player_ahead_of_me(e_closest_player)) {
            n_cleanup_dist_sq = 189225;
        } else {
            n_cleanup_dist_sq = 250000;
        }
        if (n_dist_sq_min >= n_cleanup_dist_sq) {
            self thread delete_zombie_noone_looking();
        }
    }
}

// Namespace zm_island_cleanup
// Params 0, eflags: 0x4
// Checksum 0x531ff317, Offset: 0x860
// Size: 0xdc
function private delete_zombie_noone_looking() {
    if (isdefined(self.in_the_ground) && self.in_the_ground) {
        return;
    }
    foreach (player in level.players) {
        if (player.sessionstate == "spectator") {
            continue;
        }
        if (self player_can_see_me(player)) {
            return;
        }
    }
    self function_e89cc6dd();
}

// Namespace zm_island_cleanup
// Params 0, eflags: 0x4
// Checksum 0xbccc6d01, Offset: 0x948
// Size: 0x24
function private function_cc0c7e36() {
    self endon(#"death");
    self thread delete_zombie_noone_looking();
}

// Namespace zm_island_cleanup
// Params 0, eflags: 0x4
// Checksum 0x6f52d7f2, Offset: 0x978
// Size: 0x1ec
function private function_e89cc6dd() {
    if (!(isdefined(self.exclude_cleanup_adding_to_total) && self.exclude_cleanup_adding_to_total)) {
        level.zombie_total++;
        level.zombie_respawns++;
        if (self.health < self.maxhealth) {
            if (!isdefined(level.var_5a487977[self.archetype])) {
                level.var_5a487977[self.archetype] = [];
            }
            if (!isdefined(level.var_5a487977[self.archetype])) {
                level.var_5a487977[self.archetype] = [];
            } else if (!isarray(level.var_5a487977[self.archetype])) {
                level.var_5a487977[self.archetype] = array(level.var_5a487977[self.archetype]);
            }
            level.var_5a487977[self.archetype][level.var_5a487977[self.archetype].size] = self.health;
        }
    }
    self notify(#"enemy_cleaned_up");
    util::wait_network_frame();
    if (isalive(self)) {
        /#
            debugstar(self.origin, 1000, (1, 1, 1));
        #/
        self zombie_utility::reset_attack_spot();
        self util::stop_magic_bullet_shield();
        self kill();
        self delete();
    }
}

// Namespace zm_island_cleanup
// Params 1, eflags: 0x4
// Checksum 0xa6d8dcaa, Offset: 0xb70
// Size: 0xd8
function private player_can_see_me(player) {
    v_player_angles = player getplayerangles();
    v_player_forward = anglestoforward(v_player_angles);
    var_47fa366e = self.origin - player getorigin();
    var_47fa366e = vectornormalize(var_47fa366e);
    n_dot = vectordot(v_player_forward, var_47fa366e);
    if (n_dot < 0.766) {
        return false;
    }
    return true;
}

// Namespace zm_island_cleanup
// Params 1, eflags: 0x4
// Checksum 0x2689ee81, Offset: 0xc50
// Size: 0xb4
function private player_ahead_of_me(player) {
    v_player_angles = player getplayerangles();
    v_player_forward = anglestoforward(v_player_angles);
    v_dir = player getorigin() - self.origin;
    n_dot = vectordot(v_player_forward, v_dir);
    if (n_dot < 0) {
        return false;
    }
    return true;
}

// Namespace zm_island_cleanup
// Params 0, eflags: 0x0
// Checksum 0x1a2f9b8b, Offset: 0xd10
// Size: 0xcc
function get_escape_position() {
    self endon(#"death");
    str_zone = zm_zonemgr::get_zone_from_position(self.origin, 1);
    if (!isdefined(str_zone)) {
        str_zone = self.zone_name;
    }
    if (isdefined(str_zone)) {
        a_zones = get_adjacencies_to_zone(str_zone);
        a_wait_locations = get_wait_locations_in_zones(a_zones);
        s_farthest = self get_farthest_wait_location(a_wait_locations);
    }
    return s_farthest;
}

// Namespace zm_island_cleanup
// Params 1, eflags: 0x0
// Checksum 0xfc31ea47, Offset: 0xde8
// Size: 0x11e
function get_adjacencies_to_zone(str_zone) {
    a_adjacencies = [];
    a_adjacencies[0] = str_zone;
    a_adjacent_zones = getarraykeys(level.zones[str_zone].adjacent_zones);
    for (i = 0; i < a_adjacent_zones.size; i++) {
        if (level.zones[str_zone].adjacent_zones[a_adjacent_zones[i]].is_connected) {
            if (!isdefined(a_adjacencies)) {
                a_adjacencies = [];
            } else if (!isarray(a_adjacencies)) {
                a_adjacencies = array(a_adjacencies);
            }
            a_adjacencies[a_adjacencies.size] = a_adjacent_zones[i];
        }
    }
    return a_adjacencies;
}

// Namespace zm_island_cleanup
// Params 1, eflags: 0x4
// Checksum 0x1c186094, Offset: 0xf10
// Size: 0xd2
function private get_wait_locations_in_zones(a_zones) {
    a_wait_locations = [];
    foreach (zone in a_zones) {
        a_wait_locations = arraycombine(a_wait_locations, level.zones[zone].a_loc_types["wait_location"], 0, 0);
    }
    return a_wait_locations;
}

// Namespace zm_island_cleanup
// Params 1, eflags: 0x4
// Checksum 0x45b9f0ec, Offset: 0xff0
// Size: 0xd6
function private get_farthest_wait_location(a_wait_locations) {
    if (!isdefined(a_wait_locations) || a_wait_locations.size == 0) {
        return undefined;
    }
    var_61c71098 = 0;
    var_1bfac935 = 0;
    for (i = 0; i < a_wait_locations.size; i++) {
        n_distance_sq = distancesquared(self.origin, a_wait_locations[i].origin);
        if (n_distance_sq > var_1bfac935) {
            var_1bfac935 = n_distance_sq;
            var_61c71098 = i;
        }
    }
    return a_wait_locations[var_61c71098];
}

// Namespace zm_island_cleanup
// Params 1, eflags: 0x4
// Checksum 0x4cb39629, Offset: 0x10d0
// Size: 0x88
function private get_wait_locations_in_zone(zone) {
    if (isdefined(level.zones[zone].a_loc_types["wait_location"])) {
        a_wait_locations = [];
        a_wait_locations = arraycombine(a_wait_locations, level.zones[zone].a_loc_types["wait_location"], 0, 0);
        return a_wait_locations;
    }
    return undefined;
}

// Namespace zm_island_cleanup
// Params 0, eflags: 0x0
// Checksum 0xf32084ac, Offset: 0x1160
// Size: 0xb4
function get_escape_position_in_current_zone() {
    self endon(#"death");
    str_zone = zm_zonemgr::get_zone_from_position(self.origin, 1);
    if (!isdefined(str_zone)) {
        str_zone = self.zone_name;
    }
    if (isdefined(str_zone)) {
        a_wait_locations = get_wait_locations_in_zone(str_zone);
        if (isdefined(a_wait_locations)) {
            s_farthest = self get_farthest_wait_location(a_wait_locations);
        }
    }
    return s_farthest;
}

