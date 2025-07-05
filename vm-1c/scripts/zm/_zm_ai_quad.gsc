#using scripts/codescripts/struct;
#using scripts/shared/aat_shared;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/demo_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_zm;
#using scripts/zm/_zm_net;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_utility;

#namespace zm_ai_quad;

// Namespace zm_ai_quad
// Params 0, eflags: 0x2
// Checksum 0x205928dc, Offset: 0x4f0
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_ai_quad", &__init__, undefined, undefined);
}

// Namespace zm_ai_quad
// Params 0, eflags: 0x0
// Checksum 0xf02f5832, Offset: 0x530
// Size: 0xf4
function __init__() {
    function_820fd039();
    if (!isdefined(level.var_b93acc0b) || level.var_b93acc0b) {
        function_1bf67b57();
    }
    animationstatenetwork::registernotetrackhandlerfunction("quad_melee", &function_b783ed6b);
    behaviortreenetworkutility::registerbehaviortreescriptapi("quadDeathAction", &quadDeathAction);
    level thread aat::register_immunity("zm_aat_dead_wire", "zombie_quad", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_turned", "zombie_quad", 1, 1, 1);
}

// Namespace zm_ai_quad
// Params 1, eflags: 0x0
// Checksum 0x3f12100b, Offset: 0x630
// Size: 0x5c
function function_b783ed6b(entity) {
    entity melee();
    /#
        record3dtext("<dev string:x28>", self.origin, (1, 0, 0), "<dev string:x2e>", entity);
    #/
}

// Namespace zm_ai_quad
// Params 1, eflags: 0x0
// Checksum 0x50c719e6, Offset: 0x698
// Size: 0xc4
function quadDeathAction(entity) {
    if (isdefined(entity.var_d98ae1ca)) {
        entity.var_d98ae1ca unlink();
        entity.var_d98ae1ca delete();
    }
    if (entity.can_explode && !(isdefined(entity.guts_explosion) && entity.guts_explosion)) {
        entity thread function_d6bac202();
    }
    entity startragdoll();
}

// Namespace zm_ai_quad
// Params 0, eflags: 0x0
// Checksum 0x9eb496eb, Offset: 0x768
// Size: 0x9c
function function_5af423f4() {
    level.var_889f4094 = getentarray("quad_zombie_spawner", "script_noteworthy");
    array::thread_all(level.var_889f4094, &spawner::add_spawn_function, &function_6109f077);
    zm::register_custom_ai_spawn_check("quads", &function_613fce7d, &function_da243141);
}

// Namespace zm_ai_quad
// Params 0, eflags: 0x0
// Checksum 0x8594b272, Offset: 0x810
// Size: 0x54
function function_1bf67b57() {
    if (!isdefined(level.var_2ac737b1)) {
        level.var_2ac737b1 = 50;
    }
    visionset_mgr::register_info("overlay", "zm_ai_quad_blur", 1, level.var_2ac737b1, 1, 1);
}

// Namespace zm_ai_quad
// Params 0, eflags: 0x0
// Checksum 0x9fb89e92, Offset: 0x870
// Size: 0x32
function function_613fce7d() {
    return isdefined(level.zm_loc_types["quad_location"]) && level.zm_loc_types["quad_location"].size > 0;
}

// Namespace zm_ai_quad
// Params 0, eflags: 0x0
// Checksum 0x8fa3b2d0, Offset: 0x8b0
// Size: 0xa
function function_da243141() {
    return level.var_889f4094;
}

// Namespace zm_ai_quad
// Params 0, eflags: 0x0
// Checksum 0x6057623, Offset: 0x8c8
// Size: 0x260
function function_6109f077() {
    self.animname = "quad_zombie";
    self.no_gib = 1;
    self.no_eye_glow = 1;
    self.var_65eda69a = 1;
    self.canbetargetedbyturnedzombies = 1;
    self.custom_location = &quad_location;
    self zm_spawner::zombie_spawn_init(1);
    self.var_ce31c8e8 = 0;
    self.maxhealth = int(self.maxhealth * 0.75);
    self.health = self.maxhealth;
    self.freezegun_damage = 0;
    self.meleedamage = 45;
    self playsound("zmb_quad_spawn");
    self.var_c8a157ba = 96;
    self.var_6dc8ac4c = 96;
    self.var_3ee1ed0d = 1.05;
    self.var_b46a7728 = 125;
    self.var_8f371b61 = 7;
    if (isdefined(level.var_eb9a1da) && level.var_eb9a1da) {
        self.deathfunction = &function_17d5d016;
        self.actor_killed_override = &function_542e4c77;
    }
    self function_3c1837ec();
    self.thundergun_knockdown_func = &function_962c408a;
    self.var_2177273b = &function_5b8fbcb4;
    self.var_86c23330 = &function_298be061;
    self.can_explode = 0;
    self.exploded = 0;
    self thread quad_trail();
    self allowpitchangle(1);
    self setphysparams(15, 0, 24);
    if (isdefined(level.var_6109f077)) {
        self thread [[ level.var_6109f077 ]]();
    }
}

// Namespace zm_ai_quad
// Params 0, eflags: 0x0
// Checksum 0x74a6fba2, Offset: 0xb30
// Size: 0x3a
function function_820fd039() {
    level._effect["quad_explo_gas"] = "dlc5/zmhd/fx_zombie_quad_gas_nova6";
    level._effect["quad_trail"] = "dlc5/zmhd/fx_zombie_quad_trail";
}

// Namespace zm_ai_quad
// Params 0, eflags: 0x0
// Checksum 0x72bcecd3, Offset: 0xb78
// Size: 0x336
function quad_location() {
    self endon(#"death");
    if (level.zm_loc_types["quad_location"].size <= 0) {
        println("<dev string:x35>" + "<dev string:x5c>");
        self dodamage(self.health * 2, self.origin);
        return;
    }
    spot = array::random(level.zm_loc_types["quad_location"]);
    if (isdefined(spot.target)) {
        self.target = spot.target;
    }
    if (isdefined(spot.zone_name)) {
        self.zone_name = spot.zone_name;
    }
    self.anchor = spawn("script_origin", self.origin);
    self.anchor.angles = self.angles;
    self linkto(self.anchor);
    if (!isdefined(spot.angles)) {
        spot.angles = (0, 0, 0);
    }
    self ghost();
    self.anchor moveto(spot.origin, 0.05);
    self.anchor waittill(#"movedone");
    target_org = zombie_utility::get_desired_origin();
    if (isdefined(target_org)) {
        anim_ang = vectortoangles(target_org - self.origin);
        self.anchor rotateto((0, anim_ang[1], 0), 0.05);
        self.anchor waittill(#"rotatedone");
    }
    if (isdefined(level.zombie_spawn_fx)) {
        playfx(level.zombie_spawn_fx, spot.origin);
    }
    self unlink();
    if (isdefined(self.anchor)) {
        self.anchor delete();
    }
    self show();
    self notify(#"risen", spot.script_string);
}

// Namespace zm_ai_quad
// Params 0, eflags: 0x0
// Checksum 0x1870f7c7, Offset: 0xeb8
// Size: 0x198
function function_65f011b2() {
    self endon(#"death");
    wait 5;
    var_63f5b9d8 = 5;
    while (true) {
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (distancesquared(self.origin, players[i].origin) > 1440000) {
                self playsound("zmb_quad_amb");
                var_63f5b9d8 = 7;
                continue;
            }
            if (distancesquared(self.origin, players[i].origin) > 40000) {
                self playsound("zmb_quad_vox");
                var_63f5b9d8 = 5;
                continue;
            }
            if (distancesquared(self.origin, players[i].origin) < 22500) {
                wait 0.05;
            }
        }
        wait randomfloatrange(1, var_63f5b9d8);
    }
}

// Namespace zm_ai_quad
// Params 0, eflags: 0x0
// Checksum 0x22a5b44e, Offset: 0x1058
// Size: 0x28
function function_3c1837ec() {
    self.goalradius = 16;
    self.maxsightdistsqrd = 16384;
    self.var_b8671742 = 0;
}

// Namespace zm_ai_quad
// Params 2, eflags: 0x0
// Checksum 0x9345c1e6, Offset: 0x1088
// Size: 0x7c
function function_962c408a(player, gib) {
    self endon(#"death");
    damage = int(self.maxhealth * 0.5);
    self dodamage(damage, player.origin, player);
}

// Namespace zm_ai_quad
// Params 0, eflags: 0x0
// Checksum 0x24ad6dc7, Offset: 0x1110
// Size: 0xcc
function function_d6bac202() {
    var_f45a89e6 = [];
    var_f45a89e6["explo_radius_zomb"] = self.var_c8a157ba;
    var_f45a89e6["explo_radius_plr"] = self.var_6dc8ac4c;
    var_f45a89e6["explo_damage_zomb"] = self.var_3ee1ed0d;
    var_f45a89e6["gas_radius"] = self.var_b46a7728;
    var_f45a89e6["gas_time"] = self.var_8f371b61;
    self thread function_30937cb8(self.origin, var_f45a89e6);
    level thread function_8d8e0dae(self.origin, var_f45a89e6);
}

// Namespace zm_ai_quad
// Params 2, eflags: 0x0
// Checksum 0x982dc282, Offset: 0x11e8
// Size: 0x19c
function function_30937cb8(origin, var_f45a89e6) {
    playsoundatposition("zmb_quad_explo", origin);
    players = getplayers();
    zombies = getaiteamarray(level.zombie_team);
    for (i = 0; i < players.size; i++) {
        if (distance(origin, players[i].origin) <= var_f45a89e6["explo_radius_plr"]) {
            var_d9858b13 = 0;
            if (isdefined(level.var_87a7ecf)) {
                var_d9858b13 = players[i] thread [[ level.var_87a7ecf ]]();
            }
            if (!var_d9858b13) {
                players[i] shellshock("explosion", 2.5);
            }
        }
    }
    self.exploded = 1;
    self radiusdamage(origin, var_f45a89e6["explo_radius_zomb"], level.zombie_health, level.zombie_health, self, "MOD_EXPLOSIVE");
}

// Namespace zm_ai_quad
// Params 1, eflags: 0x0
// Checksum 0xb4574222, Offset: 0x1390
// Size: 0x22
function function_dedce615(player) {
    if (self.exploded) {
        return 0;
    }
    return self.meleedamage;
}

// Namespace zm_ai_quad
// Params 2, eflags: 0x0
// Checksum 0xa91f4cd0, Offset: 0x13c0
// Size: 0x244
function function_8d8e0dae(origin, var_f45a89e6) {
    effectarea = spawn("trigger_radius", origin, 0, var_f45a89e6["gas_radius"], 100);
    playfx(level._effect["quad_explo_gas"], origin);
    for (gas_time = 0; gas_time <= var_f45a89e6["gas_time"]; gas_time += 1) {
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            var_d9858b13 = 0;
            if (isdefined(level.var_87a7ecf)) {
                var_d9858b13 = players[i] thread [[ level.var_87a7ecf ]]();
            }
            if (players[i] istouching(effectarea) && !var_d9858b13) {
                visionset_mgr::activate("overlay", "zm_ai_quad_blur", players[i]);
                continue;
            }
            visionset_mgr::deactivate("overlay", "zm_ai_quad_blur", players[i]);
        }
        wait 1;
    }
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        visionset_mgr::deactivate("overlay", "zm_ai_quad_blur", players[i]);
    }
    effectarea delete();
}

// Namespace zm_ai_quad
// Params 0, eflags: 0x0
// Checksum 0xd4e2880d, Offset: 0x1610
// Size: 0xfc
function quad_trail() {
    self endon(#"death");
    self.var_d98ae1ca = spawn("script_model", self gettagorigin("tag_origin"));
    self.var_d98ae1ca.angles = self gettagangles("tag_origin");
    self.var_d98ae1ca setmodel("tag_origin");
    self.var_d98ae1ca linkto(self, "tag_origin");
    zm_net::network_safe_play_fx_on_tag("quad_fx", 2, level._effect["quad_trail"], self.var_d98ae1ca, "tag_origin");
}

// Namespace zm_ai_quad
// Params 8, eflags: 0x0
// Checksum 0x91c5bf65, Offset: 0x1718
// Size: 0x5e
function function_17d5d016(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
    self zm_spawner::zombie_death_animscript();
    return false;
}

// Namespace zm_ai_quad
// Params 8, eflags: 0x0
// Checksum 0xc71ab8ad, Offset: 0x1780
// Size: 0xd8
function function_542e4c77(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
    if (smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET") {
        self.can_explode = 1;
    } else {
        self.can_explode = 0;
        if (isdefined(self.var_d98ae1ca)) {
            self.var_d98ae1ca unlink();
            self.var_d98ae1ca delete();
        }
    }
    if (isdefined(level.var_552a9606)) {
        [[ level.var_552a9606 ]](self);
    }
}

// Namespace zm_ai_quad
// Params 0, eflags: 0x0
// Checksum 0x38eeb5ef, Offset: 0x1860
// Size: 0x4c
function function_5b8fbcb4() {
    if (isdefined(self.var_d98ae1ca)) {
        self.var_d98ae1ca unlink();
        self.var_d98ae1ca delete();
        wait 0.1;
    }
}

// Namespace zm_ai_quad
// Params 0, eflags: 0x0
// Checksum 0xbf235bea, Offset: 0x18b8
// Size: 0x144
function function_298be061() {
    if (isdefined(self.var_d98ae1ca)) {
        self.var_d98ae1ca unlink();
        self.var_d98ae1ca delete();
    }
    if (self.health > 0) {
        self.var_d98ae1ca = spawn("script_model", self gettagorigin("tag_origin"));
        self.var_d98ae1ca.angles = self gettagangles("tag_origin");
        self.var_d98ae1ca setmodel("tag_origin");
        self.var_d98ae1ca linkto(self, "tag_origin");
        zm_net::network_safe_play_fx_on_tag("quad_fx", 2, level._effect["quad_trail"], self.var_d98ae1ca, "tag_origin");
    }
}

