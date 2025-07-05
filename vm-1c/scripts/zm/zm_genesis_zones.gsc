#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_load;
#using scripts/zm/_zm;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/zm_genesis_ffotd;
#using scripts/zm/zm_genesis_util;

#namespace zm_island_zones;

// Namespace zm_island_zones
// Params 0, eflags: 0x2
// Checksum 0x9d789247, Offset: 0xbc8
// Size: 0x3c
function autoexec __init__sytem__() {
    system::register("zm_genesis_zones", &__init__, &__main__, undefined);
}

// Namespace zm_island_zones
// Params 0, eflags: 0x0
// Checksum 0x8edd9d66, Offset: 0xc10
// Size: 0x44
function __init__() {
    level flag::init("activate_lower_asylum");
    level flag::init("activate_upper_asylum");
}

// Namespace zm_island_zones
// Params 0, eflags: 0x0
// Checksum 0xd4886b20, Offset: 0xc60
// Size: 0x9c
function __main__() {
    level.zones = [];
    level.zone_manager_init_func = &function_19a0be33;
    level.var_4af51a33 = &zm_genesis_ffotd::function_dce2d8a9;
    init_zones[0] = "start_zone";
    level thread zm_zonemgr::manage_zones(init_zones);
    level.player_out_of_playable_area_monitor_callback = &player_out_of_playable_area_override;
    level thread function_6b91d71();
}

// Namespace zm_island_zones
// Params 0, eflags: 0x0
// Checksum 0x578ae467, Offset: 0xd08
// Size: 0x98
function player_out_of_playable_area_override() {
    if (isdefined(self.is_flung) && (isdefined(self.var_5aef0317) && (isdefined(self.b_teleported) && (isdefined(self.b_teleporting) && self.b_teleporting || self.b_teleported) || self.var_5aef0317) || self.is_flung)) {
        return false;
    }
    b_result = zm_genesis_ffotd::function_d51867e();
    if (b_result) {
        return false;
    }
    return true;
}

// Namespace zm_island_zones
// Params 0, eflags: 0x0
// Checksum 0x23dcab82, Offset: 0xda8
// Size: 0xf1c
function function_19a0be33() {
    level flag::init("always_on", 1);
    zm_zonemgr::zone_init("apothicon_interior_zone", 0);
    zm_zonemgr::zone_init("samanthas_room_zone");
    zm_zonemgr::add_adjacent_zone("start_zone", "start_power_zone", "always_on");
    zm_zonemgr::add_adjacent_zone("start_left_path_zone", "start_zone", "connect_start_to_left");
    zm_zonemgr::add_adjacent_zone("start_right_path_zone", "start_zone", "connect_start_to_right");
    level thread zm_genesis_util::function_42108922("start_left_path_zone", "connect_generator_to_trenches");
    level thread zm_genesis_util::function_42108922("start_right_path_zone", "connect_temple_to_temple_stairs");
    zm_zonemgr::add_adjacent_zone("zm_tomb_landing_zone", "zm_tomb_trench_zone", "activate_trenches");
    zm_zonemgr::add_adjacent_zone("zm_tomb_trench_zone", "zm_tomb_trench2_zone", "activate_trenches");
    zm_zonemgr::add_adjacent_zone("zm_tomb_trench2_zone", "zm_tomb_trench_center_zone", "connect_generator_to_trenches");
    zm_zonemgr::add_adjacent_zone("zm_tomb_trench2_zone", "zm_tomb_generator_zone", "connect_generator_to_trenches");
    zm_zonemgr::add_adjacent_zone("zm_tomb_generator_zone", "zm_tomb_trench_center_zone", "activate_ruins");
    zm_zonemgr::add_adjacent_zone("zm_tomb_trench_center_zone", "zm_tomb_footprint_zone", "activate_ruins");
    zm_zonemgr::add_adjacent_zone("zm_tomb_footprint_zone", "zm_tomb_trench_prison_zone", "activate_ruins");
    zm_zonemgr::add_adjacent_zone("zm_tomb_trench_prison_zone", "zm_tomb_ruins2_zone", "activate_ruins");
    zm_zonemgr::add_adjacent_zone("zm_tomb_generator_zone", "zm_tomb_ruins2_zone", "activate_ruins");
    zm_zonemgr::add_adjacent_zone("zm_tomb_ruins2_zone", "zm_tomb_ruins_zone", "activate_ruins");
    zm_zonemgr::add_adjacent_zone("zm_tomb_trench_prison_zone", "zm_prison_zone", "power_on1");
    zm_zonemgr::add_adjacent_zone("zm_prison_zone", "zm_prison_inner2_zone", "activate_cellblock");
    zm_zonemgr::add_adjacent_zone("zm_prison_inner2_zone", "zm_prison_inner_zone", "activate_cellblock");
    zm_zonemgr::add_adjacent_zone("zm_prison_inner_zone", "zm_prison_power_zone", "activate_cellblock");
    zm_zonemgr::add_adjacent_zone("zm_prison_mess_zone", "zm_prison_mess_hall_zone", "activate_cellblock_pad");
    zm_zonemgr::add_adjacent_zone("zm_prison_mess_hall_zone", "zm_prison_inner_zone", "connect_cellblock_to_messhall");
    zm_zonemgr::add_adjacent_zone("zm_tomb_ruins_zone", "zm_tomb_ruins_interior_zone", "connect_ruins_to_inner_ruins");
    zm_zonemgr::add_adjacent_zone("zm_tomb_ruins_interior_zone", "zm_tomb_ruins_tunnel_zone", "activate_cellblock");
    zm_zonemgr::add_adjacent_zone("zm_tomb_ruins_tunnel_zone", "zm_prison_ruins_interior_zone", "activate_cellblock");
    zm_zonemgr::add_adjacent_zone("zm_prison_ruins_interior_zone", "zm_prison_inner2_zone", "activate_ruins_inner");
    zm_zonemgr::add_zone_flags("activate_asylum_kitchen", "activate_cellblock_pad");
    zm_zonemgr::add_zone_flags("connect_cellblock_to_messhall", "activate_cellblock");
    zm_zonemgr::add_zone_flags("connect_ruins_to_inner_ruins", "activate_cellblock");
    zm_zonemgr::add_zone_flags("connect_generator_to_trenches", "activate_ruins");
    zm_zonemgr::add_zone_flags("connect_ruins_to_inner_ruins", "activate_ruins");
    zm_zonemgr::add_zone_flags("power_on1", "activate_ruins");
    zm_zonemgr::add_zone_flags("connect_start_to_left", "activate_trenches");
    zm_zonemgr::add_zone_flags("connect_generator_to_trenches", "activate_trenches");
    zm_zonemgr::add_zone_flags("connect_cellblock_to_messhall", "activate_ruins_inner");
    zm_zonemgr::add_zone_flags("connect_ruins_to_inner_ruins", "activate_ruins_inner");
    level thread zm_genesis_util::function_42108922("zm_prison_mess_zone", "connect_asylum_kitchen_to_upstairs");
    level thread zm_genesis_util::function_42108922("zm_prison_mess_hall_zone", "connect_asylum_kitchen_to_upstairs");
    zm_zonemgr::add_adjacent_zone("zm_temple_zone", "zm_temple2_zone", "activate_temple");
    zm_zonemgr::add_adjacent_zone("zm_temple2_zone", "zm_temple_stairs_zone", "connect_temple_to_temple_stairs");
    zm_zonemgr::add_adjacent_zone("zm_temple_stairs_zone", "zm_temple_interior_zone", "connect_temple_to_temple_stairs");
    zm_zonemgr::add_adjacent_zone("zm_temple_interior_zone", "zm_temple_box_zone", "activate_temple_interior");
    zm_zonemgr::add_adjacent_zone("zm_temple_box_zone", "zm_temple_undercroft_zone", "activate_temple_interior");
    zm_zonemgr::add_adjacent_zone("zm_temple_undercroft_zone", "zm_temple_undercroft2_zone", "activate_temple_interior");
    zm_zonemgr::add_adjacent_zone("zm_temple_undercroft2_zone", "zm_theater_hallway_zone", "activate_temple_interior");
    zm_zonemgr::add_adjacent_zone("zm_temple_undercroft2_zone", "zm_castle_undercroft_hallway_zone", "connect_undercroft_to_temple");
    zm_zonemgr::add_adjacent_zone("zm_temple_undercroft2_zone", "zm_castle_undercroft_hallway2_zone", "connect_undercroft_to_temple");
    zm_zonemgr::add_adjacent_zone("zm_castle_undercroft_hallway_zone", "zm_castle_undercroft_zone", "activate_undercroft");
    zm_zonemgr::add_adjacent_zone("zm_castle_undercroft_hallway2_zone", "zm_castle_undercroft_zone", "activate_undercroft");
    zm_zonemgr::add_adjacent_zone("zm_castle_undercroft_zone", "zm_castle_power_zone", "activate_undercroft");
    zm_zonemgr::add_adjacent_zone("zm_castle_undercroft_zone", "zm_castle_undercroft_airlock_zone", "connect_undercroft_to_theater");
    zm_zonemgr::add_adjacent_zone("zm_castle_undercroft_airlock_zone", "zm_theater_projection_zone", "connect_undercroft_to_theater");
    zm_zonemgr::add_adjacent_zone("zm_theater_hallway_zone", "zm_theater_hallway_airlock_zone", "connect_undercroft_to_foyer");
    zm_zonemgr::add_adjacent_zone("zm_theater_hallway_airlock_zone", "zm_theater_foyer_zone", "connect_undercroft_to_foyer");
    zm_zonemgr::add_adjacent_zone("zm_theater_projection_zone", "zm_theater_balcony_zone", "activate_theater");
    zm_zonemgr::add_adjacent_zone("zm_theater_balcony_zone", "zm_theater_jump_zone", "activate_theater");
    zm_zonemgr::add_adjacent_zone("zm_theater_balcony_zone", "zm_theater_foyer_zone", "activate_theater");
    zm_zonemgr::add_adjacent_zone("zm_theater_foyer_zone", "zm_theater_zone", "activate_theater");
    zm_zonemgr::add_adjacent_zone("zm_theater_zone", "zm_theater_stage_zone", "activate_theater");
    zm_zonemgr::add_zone_flags("connect_start_to_right", "activate_temple");
    zm_zonemgr::add_zone_flags("connect_temple_to_temple_stairs", "activate_temple");
    zm_zonemgr::add_zone_flags("connect_undercroft_to_temple", "activate_undercroft");
    zm_zonemgr::add_zone_flags("connect_undercroft_to_theater", "activate_undercroft");
    zm_zonemgr::add_zone_flags("connect_undercroft_to_foyer", "activate_undercroft");
    zm_zonemgr::add_zone_flags("connect_asylum_downstairs_to_upstairs", "activate_theater");
    zm_zonemgr::add_zone_flags("connect_undercroft_to_theater", "activate_theater");
    zm_zonemgr::add_zone_flags("connect_undercroft_to_foyer", "activate_theater");
    zm_zonemgr::add_zone_flags("connect_undercroft_to_temple", "activate_temple_interior");
    zm_zonemgr::add_zone_flags("connect_temple_to_temple_stairs", "activate_temple_interior");
    zm_zonemgr::add_zone_flags("connect_undercroft_to_foyer", "activate_temple_interior");
    /#
        level thread zm_genesis_util::function_d8db939b("<dev string:x28>");
    #/
    zm_zonemgr::add_adjacent_zone("zm_asylum_kitchen_landing_zone", "zm_asylum_kitchen_zone", "activate_asylum_kitchen");
    zm_zonemgr::add_adjacent_zone("zm_asylum_downstairs_zone", "zm_asylum_downstairs_landing_zone", "activate_lower_asylum");
    zm_zonemgr::add_adjacent_zone("zm_asylum_downstairs_zone", "zm_asylum_courtyard_zone", "connect_asylum_downstairs_to_upstairs");
    zm_zonemgr::add_adjacent_zone("zm_asylum_power_room_zone", "zm_asylum_courtyard_stairs_zone", "activate_asylum");
    zm_zonemgr::add_adjacent_zone("zm_asylum_courtyard_zone", "zm_asylum_courtyard_stairs_zone", "activate_asylum");
    zm_zonemgr::add_adjacent_zone("zm_asylum_courtyard_zone", "zm_asylum_power_zone", "activate_asylum");
    zm_zonemgr::add_adjacent_zone("zm_asylum_kitchen2_zone", "zm_asylum_kitchen_zone", "activate_asylum_kitchen");
    zm_zonemgr::add_adjacent_zone("zm_asylum_kitchen2_zone", "zm_asylum_upstairs_zone", "connect_asylum_kitchen_to_upstairs");
    zm_zonemgr::add_adjacent_zone("zm_asylum_upstairs_zone", "zm_asylum_balcony_zone", "activate_upper_asylum");
    zm_zonemgr::add_adjacent_zone("zm_asylum_upstairs_zone", "zm_asylum_interior_stairs_zone", "connect_asylum_downstairs_to_upstairs");
    zm_zonemgr::add_adjacent_zone("zm_asylum_downstairs_zone", "zm_asylum_interior_stairs_zone", "activate_lower_asylum");
    zm_zonemgr::add_adjacent_zone("zm_asylum_bridge_zone", "zm_asylum_kitchen_zone", "connect_asylum_kitchen_to_upstairs", 1);
    zm_zonemgr::add_adjacent_zone("zm_asylum_bridge_zone", "zm_asylum_power_room_zone", "activate_asylum", 1);
    zm_zonemgr::add_zone_flags("connect_undercroft_to_theater", "activate_asylum");
    zm_zonemgr::add_zone_flags("connect_asylum_kitchen_to_upstairs", array("activate_asylum", "activate_upper_asylum"));
    zm_zonemgr::add_zone_flags("connect_asylum_downstairs_to_upstairs", array("activate_asylum", "activate_lower_asylum", "activate_upper_asylum"));
    zm_zonemgr::add_zone_flags("activate_theater", "activate_lower_asylum");
    zm_zonemgr::add_zone_flags("connect_cellblock_to_messhall", "activate_asylum_kitchen");
    zm_zonemgr::add_zone_flags("connect_asylum_kitchen_to_upstairs", "activate_asylum_kitchen");
    zm_zonemgr::add_adjacent_zone("zm_prototype_apothicon_zone", "zm_prototype_outside_zone", "connect_prototype_upstairs_to_outside");
    zm_zonemgr::add_adjacent_zone("zm_prototype_balcony_zone", "zm_prototype_outside_zone", "connect_prototype_upstairs_to_outside");
    zm_zonemgr::add_adjacent_zone("zm_prototype_balcony_zone", "zm_prototype_start_zone", "connect_prototype_start_to_upstairs");
    zm_zonemgr::add_adjacent_zone("zm_prototype_box_zone", "zm_prototype_upstairs_zone", "connect_prototype_start_to_upstairs");
    zm_zonemgr::add_adjacent_zone("zm_prototype_start_zone", "zm_prototype_box_zone", "open_portals");
    zm_zonemgr::add_adjacent_zone("zm_prototype_start_zone", "zm_prototype_upstairs_zone", "connect_prototype_start_to_upstairs");
    level thread zm_genesis_util::function_42108922("apothicon_interior_zone", "connect_prototype_upstairs_to_outside");
    zm_zonemgr::add_adjacent_zone("dark_arena_zone", "dark_arena2_zone", "test_activate_arena");
    /#
        level thread zm_genesis_util::function_d8db939b("<dev string:x41>");
    #/
    level thread function_fb8b5806();
}

// Namespace zm_island_zones
// Params 0, eflags: 0x0
// Checksum 0x4b0f402, Offset: 0x1cd0
// Size: 0x54
function function_6b91d71() {
    var_25778c2d = getnodearray("blocker_traversal", "script_noteworthy");
    array::thread_all(var_25778c2d, &function_9ce5da3b);
}

// Namespace zm_island_zones
// Params 0, eflags: 0x0
// Checksum 0x29ef9fbb, Offset: 0x1d30
// Size: 0xc4
function function_9ce5da3b() {
    assert(isdefined(self.script_flag), "<dev string:x55>" + self.origin + "<dev string:x6a>");
    if (self.script_string === "start_disabled") {
        unlinktraversal(self);
    }
    level flag::wait_till(self.script_flag);
    if (self.script_string === "start_disabled") {
        linktraversal(self);
        return;
    }
    unlinktraversal(self);
}

// Namespace zm_island_zones
// Params 0, eflags: 0x0
// Checksum 0xa3c85703, Offset: 0x1e00
// Size: 0xb0
function function_fb8b5806() {
    while (true) {
        level flag::wait_till("test_activate_arena");
        zm_genesis_util::function_342295d8("dark_arena2_zone");
        zm_genesis_util::function_342295d8("dark_arena_zone");
        level flag::wait_till_clear("test_activate_arena");
        zm_genesis_util::function_342295d8("dark_arena_zone", 0);
        zm_genesis_util::function_342295d8("dark_arena2_zone", 0);
    }
}

