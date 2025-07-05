#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/math_shared;
#using scripts/shared/system_shared;
#using scripts/shared/throttle_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_spawner;

#namespace zm_weap_elemental_bow;

// Namespace zm_weap_elemental_bow
// Params 0, eflags: 0x2
// Checksum 0x3b284ff, Offset: 0x550
// Size: 0x3c
function autoexec __init__sytem__() {
    system::register("_zm_weap_elemental_bow", &__init__, &__main__, undefined);
}

// Namespace zm_weap_elemental_bow
// Params 0, eflags: 0x0
// Checksum 0x87ff24d9, Offset: 0x598
// Size: 0x17c
function __init__() {
    level.w_bow_base = getweapon("elemental_bow");
    level.w_bow_base_charged = getweapon("elemental_bow4");
    clientfield::register("toplayer", "elemental_bow" + "_ambient_bow_fx", 5000, 1, "int");
    clientfield::register("missile", "elemental_bow" + "_arrow_impact_fx", 5000, 1, "int");
    clientfield::register("missile", "elemental_bow4" + "_arrow_impact_fx", 5000, 1, "int");
    callback::on_connect(&function_c45ac6ae);
    setdvar("bg_chargeShotUseOneAmmoForMultipleBullets", 0);
    setdvar("bg_zm_dlc1_chargeShotMultipleBulletsForFullCharge", 2);
    level.var_d6de2706 = new throttle();
    [[ level.var_d6de2706 ]]->initialize(6, 0.1);
}

// Namespace zm_weap_elemental_bow
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x720
// Size: 0x4
function __main__() {
    
}

// Namespace zm_weap_elemental_bow
// Params 0, eflags: 0x0
// Checksum 0xc7508d6e, Offset: 0x730
// Size: 0x7c
function function_c45ac6ae() {
    self thread function_982419bb("elemental_bow");
    self thread function_ececa597("elemental_bow", "elemental_bow4");
    self thread function_7bc6b9d("elemental_bow", "elemental_bow4", &function_65347b70);
}

// Namespace zm_weap_elemental_bow
// Params 5, eflags: 0x0
// Checksum 0xbac48c00, Offset: 0x7b8
// Size: 0x15c
function function_65347b70(weapon, v_position, radius, attacker, normal) {
    var_2679aa6b = function_1796e73(weapon.name);
    if (weapon.name == "elemental_bow4") {
        attacker clientfield::set(var_2679aa6b + "_arrow_impact_fx", 1);
        var_852420bf = array::get_all_closest(v_position, getaiteamarray(level.zombie_team), undefined, undefined, -128);
        var_852420bf = array::filter(var_852420bf, 0, &function_83f44f5, v_position);
        array::thread_all(var_852420bf, &function_7fba300, self, v_position);
        return;
    }
    attacker clientfield::set(var_2679aa6b + "_arrow_impact_fx", 1);
}

// Namespace zm_weap_elemental_bow
// Params 2, eflags: 0x0
// Checksum 0x1ce6489d, Offset: 0x920
// Size: 0x92
function function_83f44f5(ai_enemy, var_289e02fc) {
    return isalive(ai_enemy) && !(isdefined(ai_enemy.var_98056717) && ai_enemy.var_98056717) && bullettracepassed(ai_enemy getcentroid(), var_289e02fc + (0, 0, 48), 0, undefined);
}

// Namespace zm_weap_elemental_bow
// Params 2, eflags: 0x0
// Checksum 0x565deb3c, Offset: 0x9c0
// Size: 0x208
function function_7fba300(e_player, var_289e02fc) {
    self endon(#"death");
    if (self.archetype === "mechz") {
        return;
    }
    self.var_98056717 = 1;
    n_damage = 2233;
    if (self.health > 2233) {
        self thread function_d1e69389(var_289e02fc);
    } else {
        self startragdoll();
        n_dist = distance2d(self.origin, var_289e02fc);
        var_37f1fb21 = (-128 - n_dist) / -128;
        var_9450d281 = vectornormalize(self getcentroid() - var_289e02fc);
        if (var_9450d281[2] < 0.8) {
            var_9450d281 = (var_9450d281[0], var_9450d281[1], 0.8);
        }
        self launchragdoll(var_9450d281 * 96 * var_37f1fb21);
        wait 0.1;
        self zm_spawner::zombie_explodes_intopieces(0);
    }
    if (isdefined(self)) {
        [[ level.var_d6de2706 ]]->waitinqueue(self);
        if (isdefined(self)) {
            self dodamage(n_damage, self.origin, e_player, e_player, undefined, "MOD_PROJECTILE_SPLASH", 0, level.w_bow_base_charged);
            self.var_98056717 = 0;
        }
    }
}

// Namespace zm_weap_elemental_bow
// Params 1, eflags: 0x0
// Checksum 0x66b5a099, Offset: 0xbd0
// Size: 0x210
function function_982419bb(var_6ab83514) {
    self endon(#"death");
    var_e1041201 = getweapon(var_6ab83514);
    while (true) {
        self waittill(#"weapon_change", var_9f85aad5, var_6de65145);
        if (var_9f85aad5 === var_e1041201) {
            if (!(isdefined(self.var_8b65be8c) && self.var_8b65be8c)) {
                if (isdefined(self.hintelem)) {
                    self.hintelem settext("");
                    self.hintelem destroy();
                }
                if (self issplitscreen()) {
                    self thread zm_equipment::show_hint_text(%ZM_CASTLE_BOW_INSTRUCTIONS, 8, 1, -106);
                } else {
                    self thread zm_equipment::show_hint_text(%ZM_CASTLE_BOW_INSTRUCTIONS, 8);
                }
                self.var_8b65be8c = 1;
            }
            if (isdefined(level.var_2edb42da)) {
                self thread [[ level.var_2edb42da ]]();
            }
            self util::waittill_any_timeout(1, "weapon_change_complete", "death");
            self clientfield::set_to_player(var_6ab83514 + "_ambient_bow_fx", 1);
            continue;
        }
        if (var_6de65145 === var_e1041201) {
            self clientfield::set_to_player(var_6ab83514 + "_ambient_bow_fx", 0);
            self stoprumble("bow_draw_loop");
        }
    }
}

// Namespace zm_weap_elemental_bow
// Params 3, eflags: 0x0
// Checksum 0x66d4e32f, Offset: 0xde8
// Size: 0xb0
function function_ececa597(var_6ab83514, var_8f9bdf29, var_5759faa5) {
    if (!isdefined(var_5759faa5)) {
        var_5759faa5 = undefined;
    }
    self endon(#"death");
    if (!isdefined(var_5759faa5)) {
        return;
    }
    while (true) {
        self waittill(#"missile_fire", projectile, weapon);
        if (issubstr(weapon.name, var_6ab83514)) {
            self thread [[ var_5759faa5 ]](projectile, weapon);
        }
    }
}

// Namespace zm_weap_elemental_bow
// Params 1, eflags: 0x0
// Checksum 0xe5ddc2fa, Offset: 0xea0
// Size: 0x1a4
function function_67b18bd9(str_weapon_name) {
    if (!isdefined(str_weapon_name)) {
        return false;
    }
    if (str_weapon_name == "elemental_bow" || str_weapon_name == "elemental_bow2" || str_weapon_name == "elemental_bow3" || str_weapon_name == "elemental_bow4" || str_weapon_name == "elemental_bow_demongate" || str_weapon_name == "elemental_bow_demongate2" || str_weapon_name == "elemental_bow_demongate3" || str_weapon_name == "elemental_bow_demongate4" || str_weapon_name == "elemental_bow_rune_prison" || str_weapon_name == "elemental_bow_rune_prison_ricochet" || str_weapon_name == "elemental_bow_rune_prison2" || str_weapon_name == "elemental_bow_rune_prison3" || str_weapon_name == "elemental_bow_rune_prison4" || str_weapon_name == "elemental_bow_rune_prison4_ricochet" || str_weapon_name == "elemental_bow_storm" || str_weapon_name == "elemental_bow_storm_ricochet" || str_weapon_name == "elemental_bow_storm2" || str_weapon_name == "elemental_bow_storm3" || str_weapon_name == "elemental_bow_storm4" || str_weapon_name == "elemental_bow_storm4_ricochet" || str_weapon_name == "elemental_bow_wolf_howl" || str_weapon_name == "elemental_bow_wolf_howl2" || str_weapon_name == "elemental_bow_wolf_howl3" || str_weapon_name == "elemental_bow_wolf_howl4") {
        return true;
    }
    return false;
}

// Namespace zm_weap_elemental_bow
// Params 1, eflags: 0x0
// Checksum 0x8a308293, Offset: 0x1050
// Size: 0x94
function function_db107e59(str_weapon_name) {
    if (!isdefined(str_weapon_name)) {
        return false;
    }
    if (str_weapon_name == "elemental_bow4" || str_weapon_name == "elemental_bow_demongate4" || str_weapon_name == "elemental_bow_rune_prison4" || str_weapon_name == "elemental_bow_rune_prison4_ricochet" || str_weapon_name == "elemental_bow_storm4" || str_weapon_name == "elemental_bow_storm4_ricochet" || str_weapon_name == "elemental_bow_wolf_howl4") {
        return true;
    }
    return false;
}

// Namespace zm_weap_elemental_bow
// Params 2, eflags: 0x0
// Checksum 0x9bc1b69e, Offset: 0x10f0
// Size: 0x248
function function_b252290e(str_weapon_name, var_93fff756) {
    if (!isdefined(str_weapon_name)) {
        return false;
    }
    switch (var_93fff756) {
    case "elemental_bow":
        if (str_weapon_name == "elemental_bow" || str_weapon_name == "elemental_bow2" || str_weapon_name == "elemental_bow3" || str_weapon_name == "elemental_bow4") {
            return true;
        }
        break;
    case "elemental_bow_demongate":
        if (str_weapon_name == "elemental_bow_demongate" || str_weapon_name == "elemental_bow_demongate2" || str_weapon_name == "elemental_bow_demongate3" || str_weapon_name == "elemental_bow_demongate4") {
            return true;
        }
        break;
    case "elemental_bow_rune_prison":
        if (str_weapon_name == "elemental_bow_rune_prison" || str_weapon_name == "elemental_bow_rune_prison_ricochet" || str_weapon_name == "elemental_bow_rune_prison2" || str_weapon_name == "elemental_bow_rune_prison3" || str_weapon_name == "elemental_bow_rune_prison4" || str_weapon_name == "elemental_bow_rune_prison4_ricochet") {
            return true;
        }
        break;
    case "elemental_bow_storm":
        if (str_weapon_name == "elemental_bow_storm" || str_weapon_name == "elemental_bow_storm_ricochet" || str_weapon_name == "elemental_bow_storm2" || str_weapon_name == "elemental_bow_storm3" || str_weapon_name == "elemental_bow_storm4" || str_weapon_name == "elemental_bow_storm4_ricochet") {
            return true;
        }
        break;
    case "elemental_bow_wolf_howl":
        if (str_weapon_name == "elemental_bow_wolf_howl" || str_weapon_name == "elemental_bow_wolf_howl2" || str_weapon_name == "elemental_bow_wolf_howl3" || str_weapon_name == "elemental_bow_wolf_howl4") {
            return true;
        }
        break;
    default:
        assert(0, "<dev string:x28>");
        break;
    }
    return false;
}

// Namespace zm_weap_elemental_bow
// Params 1, eflags: 0x0
// Checksum 0x23eb5ae4, Offset: 0x1340
// Size: 0x164
function function_ea37b2fe(str_weapon_name) {
    if (!isdefined(str_weapon_name)) {
        return false;
    }
    if (str_weapon_name == "elemental_bow_demongate" || str_weapon_name == "elemental_bow_demongate2" || str_weapon_name == "elemental_bow_demongate3" || str_weapon_name == "elemental_bow_demongate4" || str_weapon_name == "elemental_bow_rune_prison" || str_weapon_name == "elemental_bow_rune_prison_ricochet" || str_weapon_name == "elemental_bow_rune_prison2" || str_weapon_name == "elemental_bow_rune_prison3" || str_weapon_name == "elemental_bow_rune_prison4" || str_weapon_name == "elemental_bow_rune_prison4_ricochet" || str_weapon_name == "elemental_bow_storm" || str_weapon_name == "elemental_bow_storm_ricochet" || str_weapon_name == "elemental_bow_storm2" || str_weapon_name == "elemental_bow_storm3" || str_weapon_name == "elemental_bow_storm4" || str_weapon_name == "elemental_bow_storm4_ricochet" || str_weapon_name == "elemental_bow_wolf_howl" || str_weapon_name == "elemental_bow_wolf_howl2" || str_weapon_name == "elemental_bow_wolf_howl3" || str_weapon_name == "elemental_bow_wolf_howl4") {
        return true;
    }
    return false;
}

// Namespace zm_weap_elemental_bow
// Params 3, eflags: 0x0
// Checksum 0xd10c3dc9, Offset: 0x14b0
// Size: 0x1d0
function function_7bc6b9d(var_6ab83514, var_8f9bdf29, var_332bb697) {
    if (!isdefined(var_332bb697)) {
        var_332bb697 = undefined;
    }
    self endon(#"death");
    while (true) {
        self waittill(#"projectile_impact", weapon, v_position, radius, e_projectile, normal);
        var_48369d98 = function_1796e73(weapon.name);
        if (var_48369d98 == var_6ab83514 || var_48369d98 == var_8f9bdf29) {
            if (var_48369d98 != "elemental_bow" && var_48369d98 != "elemental_bow_wolf_howl4" && isdefined(e_projectile.birthtime)) {
                if (gettime() - e_projectile.birthtime <= -106) {
                    radiusdamage(v_position, 32, level.zombie_health, level.zombie_health, self, "MOD_UNKNOWN", weapon);
                }
            }
            self thread function_d2e32ed2(var_48369d98, v_position);
            if (isdefined(var_332bb697)) {
                self thread [[ var_332bb697 ]](weapon, v_position, radius, e_projectile, normal);
            }
            self thread function_9c5946ba(weapon, v_position);
        }
    }
}

// Namespace zm_weap_elemental_bow
// Params 2, eflags: 0x0
// Checksum 0x41d3eae0, Offset: 0x1688
// Size: 0x6c
function function_d2e32ed2(var_48369d98, v_position) {
    if (var_48369d98 === "elemental_bow_wolf_howl4") {
        return;
    }
    array::thread_all(getaiarchetypearray("mechz"), &function_b78fcfc7, self, var_48369d98, v_position);
}

// Namespace zm_weap_elemental_bow
// Params 3, eflags: 0x0
// Checksum 0xd7b6423a, Offset: 0x1700
// Size: 0x3f4
function function_b78fcfc7(e_player, var_48369d98, v_position) {
    var_2017780d = 0;
    var_c36342f3 = 0;
    var_377b9896 = 0;
    if (!issubstr(var_48369d98, "4")) {
        var_377b9896 = 1;
        var_3fa1565a = 9216;
        var_6594cbc3 = 96;
        var_f419b406 = 0.25;
    } else if (var_48369d98 == "elemental_bow4") {
        var_377b9896 = 1;
        var_3fa1565a = 20736;
        var_6594cbc3 = -112;
        var_f419b406 = 0.1;
    }
    var_7486069a = distancesquared(v_position, self.origin);
    var_7d984cf2 = distancesquared(v_position, self gettagorigin("j_neck"));
    if (var_7486069a < 1600 || var_7d984cf2 < 2304) {
        var_2017780d = 1;
        var_c36342f3 = 1;
    } else if (var_7486069a < var_3fa1565a || var_377b9896 && var_7d984cf2 < var_3fa1565a) {
        var_2017780d = 1;
        var_c36342f3 = 1 - var_f419b406;
        var_c36342f3 *= sqrt(var_7486069a < var_7d984cf2 ? var_7486069a : var_7d984cf2) / var_6594cbc3;
        var_c36342f3 = 1 - var_c36342f3;
    }
    if (var_2017780d) {
        var_3bb42832 = level.var_53cc405d;
        if (isdefined(level.var_f4dc2834)) {
            var_3bb42832 = math::clamp(var_3bb42832, 0, level.var_f4dc2834);
        }
        if (var_48369d98 == "elemental_bow") {
            n_damage_percent = function_dc4f8831(0.15, 0.03);
        } else if (var_48369d98 == "elemental_bow4") {
            n_damage_percent = function_dc4f8831(0.25, 0.12);
        } else if (!issubstr(var_48369d98, "4")) {
            n_damage_percent = 0.1;
        } else {
            n_damage_percent = 0.35;
        }
        var_40955aed = var_3bb42832 * n_damage_percent / 0.2;
        var_40955aed *= var_c36342f3;
        self dodamage(var_40955aed, self.origin, e_player, e_player, undefined, "MOD_PROJECTILE_SPLASH", 0, level.w_bow_base);
    }
}

// Namespace zm_weap_elemental_bow
// Params 2, eflags: 0x0
// Checksum 0x8e4a7efe, Offset: 0x1b00
// Size: 0xbe
function function_dc4f8831(var_eaae98a2, var_c01c8d5c) {
    if (level.var_53cc405d < level.var_c1f907b2) {
        n_damage_percent = var_eaae98a2;
    } else if (level.var_53cc405d > level.var_42fd61f0) {
        n_damage_percent = var_c01c8d5c;
    } else {
        var_d82dde4a = level.var_53cc405d - level.var_c1f907b2;
        var_caabb734 = var_d82dde4a / level.var_42ee1b54;
        n_damage_percent = var_eaae98a2 - (var_eaae98a2 - var_c01c8d5c) * var_caabb734;
    }
    return n_damage_percent;
}

// Namespace zm_weap_elemental_bow
// Params 2, eflags: 0x0
// Checksum 0x6807d103, Offset: 0x1bc8
// Size: 0x4c
function function_9c5946ba(weapon, v_position) {
    util::wait_network_frame();
    radiusdamage(v_position, 24, 1, 1, self, undefined, weapon);
}

// Namespace zm_weap_elemental_bow
// Params 1, eflags: 0x0
// Checksum 0xfb081e1e, Offset: 0x1c20
// Size: 0xd4
function function_5aec3adc(ai_enemy) {
    b_callback_result = 1;
    if (isdefined(level.var_4e84030d)) {
        b_callback_result = [[ level.var_4e84030d ]](ai_enemy);
    }
    return isdefined(ai_enemy) && isalive(ai_enemy) && !ai_enemy isragdoll() && !(isdefined(ai_enemy.var_98056717) && ai_enemy.var_98056717) && !(isdefined(ai_enemy.var_d3c478a0) && ai_enemy.var_d3c478a0) && b_callback_result;
}

// Namespace zm_weap_elemental_bow
// Params 1, eflags: 0x0
// Checksum 0xff0a46ec, Offset: 0x1d00
// Size: 0x2c8
function function_d1e69389(var_63f884ec) {
    self endon(#"death");
    if (!(isdefined(self.knockdown) && self.knockdown) && !(isdefined(self.missinglegs) && self.missinglegs)) {
        self.knockdown = 1;
        self setplayercollision(0);
        var_25cdb267 = var_63f884ec - self.origin;
        var_a87a26a1 = vectornormalize((var_25cdb267[0], var_25cdb267[1], 0));
        var_45ef6cd0 = vectornormalize((anglestoforward(self.angles)[0], anglestoforward(self.angles)[1], 0));
        var_e502452d = vectornormalize((anglestoright(self.angles)[0], anglestoright(self.angles)[1], 0));
        var_8bb8fa69 = vectordot(var_a87a26a1, var_45ef6cd0);
        if (var_8bb8fa69 >= 0.5) {
            self.knockdown_direction = "front";
            self.getup_direction = "getup_back";
        } else if (var_8bb8fa69 < 0.5 && var_8bb8fa69 > -0.5) {
            var_8bb8fa69 = vectordot(var_a87a26a1, var_e502452d);
            if (var_8bb8fa69 > 0) {
                self.knockdown_direction = "right";
                if (math::cointoss()) {
                    self.getup_direction = "getup_back";
                } else {
                    self.getup_direction = "getup_belly";
                }
            } else {
                self.knockdown_direction = "left";
                self.getup_direction = "getup_belly";
            }
        } else {
            self.knockdown_direction = "back";
            self.getup_direction = "getup_belly";
        }
        wait 2.5;
        self setplayercollision(1);
        self.knockdown = 0;
    }
}

// Namespace zm_weap_elemental_bow
// Params 5, eflags: 0x0
// Checksum 0xb12e88ca, Offset: 0x1fd0
// Size: 0x262
function function_866906f(var_7c5a4ee4, str_weapon_name, var_3fee16b8, var_a5018155, var_83c68ee2) {
    if (!isdefined(var_83c68ee2)) {
        var_83c68ee2 = undefined;
    }
    var_980aeb4e = anglestoforward(var_3fee16b8.angles);
    if (var_980aeb4e[2] != -1) {
        var_3e878400 = vectornormalize(var_980aeb4e * -1);
        var_75181c09 = var_7c5a4ee4 + var_3e878400 * var_a5018155;
    } else {
        var_75181c09 = var_7c5a4ee4 + (0, 0, 1);
    }
    var_c6f6381a = bullettrace(var_75181c09, var_75181c09 - (0, 0, 1000), 0, undefined);
    var_58c16abb = var_75181c09[2] - var_c6f6381a["position"][2];
    var_2679aa6b = function_1796e73(str_weapon_name);
    if (!ispointonnavmesh(var_c6f6381a["position"])) {
        var_3fee16b8 clientfield::set(var_2679aa6b + "_arrow_impact_fx", 1);
        return undefined;
    }
    if (var_58c16abb > 72) {
        if (isdefined(var_83c68ee2)) {
            self thread [[ var_83c68ee2 ]](str_weapon_name, var_75181c09, var_c6f6381a["position"]);
        } else {
            self thread function_99de7ff2(str_weapon_name, var_75181c09, var_c6f6381a["position"]);
        }
        return undefined;
    }
    var_3fee16b8 clientfield::set(var_2679aa6b + "_arrow_impact_fx", 1);
    return var_c6f6381a["position"];
}

// Namespace zm_weap_elemental_bow
// Params 3, eflags: 0x0
// Checksum 0x467ba268, Offset: 0x2240
// Size: 0x54
function function_99de7ff2(str_weapon_name, v_source, v_destination) {
    wait 0.1;
    magicbullet(getweapon(str_weapon_name), v_source, v_destination, self);
}

// Namespace zm_weap_elemental_bow
// Params 1, eflags: 0x0
// Checksum 0x78a5427a, Offset: 0x22a0
// Size: 0xfe
function function_1796e73(str_weapon_name) {
    var_48369d98 = str_weapon_name;
    if (issubstr(var_48369d98, "ricochet")) {
        var_ae485cc2 = strtok2(var_48369d98, "_ricochet");
        var_48369d98 = var_ae485cc2[0];
    }
    if (issubstr(var_48369d98, "2")) {
        var_48369d98 = strtok(var_48369d98, "2")[0];
    }
    if (issubstr(var_48369d98, "3")) {
        var_48369d98 = strtok(var_48369d98, "3")[0];
    }
    return var_48369d98;
}

