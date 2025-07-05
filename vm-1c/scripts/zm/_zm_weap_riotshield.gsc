#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_weaponobjects;
#using scripts/zm/_util;
#using scripts/zm/_zm;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;

#namespace riotshield;

// Namespace riotshield
// Params 0, eflags: 0x2
// Checksum 0x781be6ac, Offset: 0x570
// Size: 0x3c
function autoexec __init__sytem__() {
    system::register("zm_equip_riotshield", &__init__, &__main__, undefined);
}

// Namespace riotshield
// Params 0, eflags: 0x0
// Checksum 0xbcbaeae6, Offset: 0x5b8
// Size: 0x30c
function __init__() {
    if (!isdefined(level.weaponriotshield)) {
        level.weaponriotshield = getweapon("riotshield");
    }
    clientfield::register("clientuimodel", "zmInventory.shield_health", 11000, 4, "float");
    zombie_utility::set_zombie_var("riotshield_cylinder_radius", 360);
    zombie_utility::set_zombie_var("riotshield_fling_range", 90);
    zombie_utility::set_zombie_var("riotshield_gib_range", 90);
    zombie_utility::set_zombie_var("riotshield_gib_damage", 75);
    zombie_utility::set_zombie_var("riotshield_knockdown_range", 90);
    zombie_utility::set_zombie_var("riotshield_knockdown_damage", 15);
    zombie_utility::set_zombie_var("riotshield_fling_force_melee", 100);
    zombie_utility::set_zombie_var("riotshield_hit_points", 1850);
    zombie_utility::set_zombie_var("riotshield_fling_damage_shield", 100);
    zombie_utility::set_zombie_var("riotshield_knockdown_damage_shield", 15);
    zombie_utility::set_zombie_var("riotshield_juke_damage_shield", 100);
    zombie_utility::set_zombie_var("riotshield_stowed_block_fraction", 1);
    level.var_75bba292 = 0;
    level.riotshield_gib_refs = [];
    level.riotshield_gib_refs[level.riotshield_gib_refs.size] = "guts";
    level.riotshield_gib_refs[level.riotshield_gib_refs.size] = "right_arm";
    level.riotshield_gib_refs[level.riotshield_gib_refs.size] = "left_arm";
    zm::register_player_damage_callback(&player_damage_override_callback);
    if (!isdefined(level.riotshield_melee)) {
        level.riotshield_melee = &riotshield_melee;
    }
    if (!isdefined(level.riotshield_melee_power)) {
        level.riotshield_melee_power = &riotshield_melee;
    }
    if (!isdefined(level.riotshield_damage_callback)) {
        level.riotshield_damage_callback = &player_damage_shield;
    }
    if (!isdefined(level.should_shield_absorb_damage)) {
        level.should_shield_absorb_damage = &should_shield_absorb_damage;
    }
    callback::on_connect(&on_player_connect);
}

// Namespace riotshield
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x8d0
// Size: 0x4
function __main__() {
    
}

// Namespace riotshield
// Params 0, eflags: 0x0
// Checksum 0xdbf9fdcc, Offset: 0x8e0
// Size: 0x84
function on_player_connect() {
    self.player_shield_reset_health = &player_init_shield_health;
    if (!isdefined(self.player_shield_apply_damage)) {
        self.player_shield_apply_damage = &player_damage_shield;
    }
    self thread player_watch_weapon_change();
    self thread player_watch_shield_melee();
    self thread player_watch_shield_melee_power();
}

// Namespace riotshield
// Params 0, eflags: 0x0
// Checksum 0x1e1bb714, Offset: 0x970
// Size: 0x48
function player_init_shield_health() {
    self updateriotshieldmodel();
    self clientfield::set_player_uimodel("zmInventory.shield_health", 1);
    return true;
}

// Namespace riotshield
// Params 2, eflags: 0x0
// Checksum 0x53d1d836, Offset: 0x9c0
// Size: 0x54
function player_set_shield_health(damage, max_damage) {
    self updateriotshieldmodel();
    self clientfield::set_player_uimodel("zmInventory.shield_health", damage / max_damage);
}

// Namespace riotshield
// Params 4, eflags: 0x0
// Checksum 0x2a6b4477, Offset: 0xa20
// Size: 0x24
function player_shield_absorb_damage(eattacker, idamage, shitloc, smeansofdeath) {
    
}

// Namespace riotshield
// Params 2, eflags: 0x0
// Checksum 0x285f0562, Offset: 0xa50
// Size: 0x132
function player_shield_facing_attacker(vdir, limit) {
    orientation = self getplayerangles();
    forwardvec = anglestoforward(orientation);
    forwardvec2d = (forwardvec[0], forwardvec[1], 0);
    unitforwardvec2d = vectornormalize(forwardvec2d);
    tofaceevec = vdir * -1;
    tofaceevec2d = (tofaceevec[0], tofaceevec[1], 0);
    unittofaceevec2d = vectornormalize(tofaceevec2d);
    dotproduct = vectordot(unitforwardvec2d, unittofaceevec2d);
    return dotproduct > limit;
}

// Namespace riotshield
// Params 10, eflags: 0x0
// Checksum 0x4a7ad5ad, Offset: 0xb90
// Size: 0x17a
function should_shield_absorb_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
    if (isdefined(self.hasriotshield) && self.hasriotshield && isdefined(vdir)) {
        if (isdefined(eattacker.is_zombie) && eattacker.is_zombie || isdefined(eattacker) && isplayer(eattacker)) {
            if (isdefined(self.hasriotshieldequipped) && self.hasriotshieldequipped) {
                if (self player_shield_facing_attacker(vdir, 0.2)) {
                    return 1;
                }
            } else if (!isdefined(self.riotshieldentity)) {
                if (!self player_shield_facing_attacker(vdir, -0.2)) {
                    return level.zombie_vars["riotshield_stowed_block_fraction"];
                }
            } else {
                assert(!isdefined(self.riotshieldentity), "<dev string:x28>");
            }
        }
    }
    return 0;
}

// Namespace riotshield
// Params 10, eflags: 0x0
// Checksum 0x3f6b8d20, Offset: 0xd18
// Size: 0x1b2
function player_damage_override_callback(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
    friendly_fire = isdefined(eattacker) && eattacker.team === self.team;
    if (isdefined(self.hasriotshield) && self.hasriotshield && !friendly_fire) {
        fblockfraction = self [[ level.should_shield_absorb_damage ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
        if (fblockfraction > 0 && isdefined(self.player_shield_apply_damage)) {
            iblocked = int(fblockfraction * idamage);
            iunblocked = idamage - iblocked;
            if (isdefined(self.player_shield_apply_damage)) {
                self [[ self.player_shield_apply_damage ]](iblocked, 0, shitloc == "riotshield", smeansofdeath);
                if (isdefined(self.riotshield_damage_absorb_callback)) {
                    self [[ self.riotshield_damage_absorb_callback ]](eattacker, iblocked, shitloc, smeansofdeath);
                }
            }
            return iunblocked;
        }
    }
    return -1;
}

// Namespace riotshield
// Params 4, eflags: 0x0
// Checksum 0x7bc25a7f, Offset: 0xed8
// Size: 0x21c
function player_damage_shield(idamage, bheld, fromcode, smod) {
    if (!isdefined(fromcode)) {
        fromcode = 0;
    }
    if (!isdefined(smod)) {
        smod = "MOD_UNKNOWN";
    }
    damagemax = level.weaponriotshield.weaponstarthitpoints;
    if (isdefined(self.weaponriotshield)) {
        damagemax = self.weaponriotshield.weaponstarthitpoints;
    }
    shieldhealth = damagemax;
    shielddamage = idamage;
    rumbled = 0;
    if (fromcode) {
        shielddamage = 0;
    }
    shieldhealth = self damageriotshield(shielddamage);
    if (shieldhealth <= 0) {
        if (!rumbled) {
            self playrumbleonentity("damage_heavy");
            earthquake(1, 0.75, self.origin, 100);
        }
        self thread player_take_riotshield();
    } else {
        if (!rumbled) {
            self playrumbleonentity("damage_light");
            earthquake(0.5, 0.5, self.origin, 100);
        }
        self playsound("fly_riotshield_zm_impact_zombies");
    }
    self updateriotshieldmodel();
    self clientfield::set_player_uimodel("zmInventory.shield_health", shieldhealth / damagemax);
}

// Namespace riotshield
// Params 0, eflags: 0x0
// Checksum 0xddf5b406, Offset: 0x1100
// Size: 0x38
function player_watch_weapon_change() {
    for (;;) {
        self waittill(#"weapon_change", weapon);
        self updateriotshieldmodel();
    }
}

// Namespace riotshield
// Params 0, eflags: 0x0
// Checksum 0xc49c04ea, Offset: 0x1140
// Size: 0x48
function player_watch_shield_melee() {
    for (;;) {
        self waittill(#"weapon_melee", weapon);
        if (weapon.isriotshield) {
            self [[ level.riotshield_melee ]](weapon);
        }
    }
}

// Namespace riotshield
// Params 0, eflags: 0x0
// Checksum 0xcd295d56, Offset: 0x1190
// Size: 0x48
function player_watch_shield_melee_power() {
    for (;;) {
        self waittill(#"weapon_melee_power", weapon);
        if (weapon.isriotshield) {
            self [[ level.riotshield_melee_power ]](weapon);
        }
    }
}

// Namespace riotshield
// Params 3, eflags: 0x0
// Checksum 0x5aba3ab2, Offset: 0x11e0
// Size: 0x11c
function riotshield_fling_zombie(player, fling_vec, index) {
    if (!isdefined(self) || !isalive(self)) {
        return;
    }
    if (isdefined(self.ignore_riotshield) && self.ignore_riotshield) {
        return;
    }
    if (isdefined(self.var_7430d3e0)) {
        self [[ self.var_7430d3e0 ]](player);
        return;
    }
    damage = 2500;
    self dodamage(damage, player.origin, player, player, "", "MOD_IMPACT");
    if (self.health < 1) {
        self.riotshield_death = 1;
        self startragdoll(1);
        self launchragdoll(fling_vec);
    }
}

// Namespace riotshield
// Params 2, eflags: 0x0
// Checksum 0xe4efc0b4, Offset: 0x1308
// Size: 0xcc
function zombie_knockdown(player, gib) {
    damage = level.zombie_vars["riotshield_knockdown_damage"];
    if (isdefined(level.var_86db50c0)) {
        self [[ level.var_86db50c0 ]](player, gib);
        return;
    }
    if (gib) {
        self.a.gib_ref = array::random(level.riotshield_gib_refs);
        self thread zombie_death::do_gib();
    }
    self dodamage(damage, player.origin, player);
}

// Namespace riotshield
// Params 2, eflags: 0x0
// Checksum 0x63acafa, Offset: 0x13e0
// Size: 0x124
function riotshield_knockdown_zombie(player, gib) {
    self endon(#"death");
    playsoundatposition("vox_riotshield_forcehit", self.origin);
    playsoundatposition("wpn_riotshield_proj_impact", self.origin);
    if (!isdefined(self) || !isalive(self)) {
        return;
    }
    if (isdefined(self.riotshield_knockdown_func)) {
        self [[ self.riotshield_knockdown_func ]](player, gib);
    } else {
        self zombie_knockdown(player, gib);
    }
    self dodamage(level.zombie_vars["riotshield_knockdown_damage"], player.origin, player);
    self playsound("fly_riotshield_forcehit");
}

// Namespace riotshield
// Params 0, eflags: 0x0
// Checksum 0xecb1ca2f, Offset: 0x1510
// Size: 0x5a8
function riotshield_get_enemies_in_range() {
    view_pos = self geteye();
    zombies = array::get_all_closest(view_pos, getaiteamarray(level.zombie_team), undefined, undefined, 2 * level.zombie_vars["riotshield_knockdown_range"]);
    if (!isdefined(zombies)) {
        return;
    }
    knockdown_range_squared = level.zombie_vars["riotshield_knockdown_range"] * level.zombie_vars["riotshield_knockdown_range"];
    gib_range_squared = level.zombie_vars["riotshield_gib_range"] * level.zombie_vars["riotshield_gib_range"];
    fling_range_squared = level.zombie_vars["riotshield_fling_range"] * level.zombie_vars["riotshield_fling_range"];
    cylinder_radius_squared = level.zombie_vars["riotshield_cylinder_radius"] * level.zombie_vars["riotshield_cylinder_radius"];
    fling_force = level.zombie_vars["riotshield_fling_force_melee"];
    fling_force_v = 0.5;
    forward_view_angles = self getweaponforwarddir();
    end_pos = view_pos + vectorscale(forward_view_angles, level.zombie_vars["riotshield_knockdown_range"]);
    /#
        if (2 == getdvarint("<dev string:x50>")) {
            near_circle_pos = view_pos + vectorscale(forward_view_angles, 2);
            circle(near_circle_pos, level.zombie_vars["<dev string:x65>"], (1, 0, 0), 0, 0, 100);
            line(near_circle_pos, end_pos, (0, 0, 1), 1, 0, 100);
            circle(end_pos, level.zombie_vars["<dev string:x65>"], (1, 0, 0), 0, 0, 100);
        }
    #/
    for (i = 0; i < zombies.size; i++) {
        if (!isdefined(zombies[i]) || !isalive(zombies[i])) {
            continue;
        }
        if (zombies[i].archetype == "margwa") {
            continue;
        }
        test_origin = zombies[i] getcentroid();
        test_range_squared = distancesquared(view_pos, test_origin);
        if (test_range_squared > knockdown_range_squared) {
            return;
        }
        normal = vectornormalize(test_origin - view_pos);
        dot = vectordot(forward_view_angles, normal);
        if (0 > dot) {
            continue;
        }
        radial_origin = pointonsegmentnearesttopoint(view_pos, end_pos, test_origin);
        if (distancesquared(test_origin, radial_origin) > cylinder_radius_squared) {
            continue;
        }
        if (0 == zombies[i] damageconetrace(view_pos, self)) {
            continue;
        }
        if (test_range_squared < fling_range_squared) {
            level.riotshield_fling_enemies[level.riotshield_fling_enemies.size] = zombies[i];
            dist_mult = (fling_range_squared - test_range_squared) / fling_range_squared;
            fling_vec = vectornormalize(test_origin - view_pos);
            if (5000 < test_range_squared) {
                fling_vec += vectornormalize(test_origin - radial_origin);
            }
            fling_vec = (fling_vec[0], fling_vec[1], fling_force_v * abs(fling_vec[2]));
            fling_vec = vectorscale(fling_vec, fling_force + fling_force * dist_mult);
            level.riotshield_fling_vecs[level.riotshield_fling_vecs.size] = fling_vec;
            continue;
        }
        level.riotshield_knockdown_enemies[level.riotshield_knockdown_enemies.size] = zombies[i];
        level.riotshield_knockdown_gib[level.riotshield_knockdown_gib.size] = 0;
    }
}

// Namespace riotshield
// Params 0, eflags: 0x0
// Checksum 0x11e1ecd0, Offset: 0x1ac0
// Size: 0x4c
function function_cea518ee() {
    level.var_75bba292++;
    if (!(level.var_75bba292 % 10)) {
        util::wait_network_frame();
        util::wait_network_frame();
        util::wait_network_frame();
    }
}

// Namespace riotshield
// Params 1, eflags: 0x0
// Checksum 0xfb64c8b3, Offset: 0x1b18
// Size: 0x1f4
function riotshield_melee(weapon) {
    if (!isdefined(level.riotshield_knockdown_enemies)) {
        level.riotshield_knockdown_enemies = [];
        level.riotshield_knockdown_gib = [];
        level.riotshield_fling_enemies = [];
        level.riotshield_fling_vecs = [];
    }
    self riotshield_get_enemies_in_range();
    shield_damage = 0;
    level.var_75bba292 = 0;
    for (i = 0; i < level.riotshield_fling_enemies.size; i++) {
        function_cea518ee();
        if (isdefined(level.riotshield_fling_enemies[i])) {
            level.riotshield_fling_enemies[i] thread riotshield_fling_zombie(self, level.riotshield_fling_vecs[i], i);
            shield_damage += level.zombie_vars["riotshield_fling_damage_shield"];
        }
    }
    for (i = 0; i < level.riotshield_knockdown_enemies.size; i++) {
        function_cea518ee();
        level.riotshield_knockdown_enemies[i] thread riotshield_knockdown_zombie(self, level.riotshield_knockdown_gib[i]);
        shield_damage += level.zombie_vars["riotshield_knockdown_damage_shield"];
    }
    level.riotshield_knockdown_enemies = [];
    level.riotshield_knockdown_gib = [];
    level.riotshield_fling_enemies = [];
    level.riotshield_fling_vecs = [];
    if (shield_damage) {
        self player_damage_shield(shield_damage, 0);
    }
}

// Namespace riotshield
// Params 0, eflags: 0x0
// Checksum 0x6783bb79, Offset: 0x1d18
// Size: 0x1d4
function updateriotshieldmodel() {
    wait 0.05;
    self.hasriotshield = 0;
    self.weaponriotshield = level.weaponnone;
    foreach (weapon in self getweaponslist(1)) {
        if (weapon.isriotshield) {
            self.hasriotshield = 1;
            self.weaponriotshield = weapon;
        }
    }
    current = self getcurrentweapon();
    self.hasriotshieldequipped = current.isriotshield;
    if (self.hasriotshield) {
        self clientfield::set_player_uimodel("hudItems.showDpadDown", 1);
        if (self.hasriotshieldequipped) {
            self zm_weapons::clear_stowed_weapon();
        } else {
            self zm_weapons::set_stowed_weapon(self.weaponriotshield);
        }
    } else {
        self clientfield::set_player_uimodel("hudItems.showDpadDown", 0);
        self setstowedweapon(level.weaponnone);
    }
    self refreshshieldattachment();
}

// Namespace riotshield
// Params 0, eflags: 0x0
// Checksum 0xb2c72fb4, Offset: 0x1ef8
// Size: 0x204
function player_take_riotshield() {
    self notify(#"destroy_riotshield");
    current = self getcurrentweapon();
    if (current.isriotshield) {
        if (!self laststand::player_is_in_laststand()) {
            new_primary = level.weaponnone;
            primaryweapons = self getweaponslistprimaries();
            for (i = 0; i < primaryweapons.size; i++) {
                if (!primaryweapons[i].isriotshield) {
                    new_primary = primaryweapons[i];
                    break;
                }
            }
            if (new_primary == level.weaponnone) {
                self zm_weapons::give_fallback_weapon();
                self switchtoweaponimmediate();
                self playsound("wpn_riotshield_zm_destroy");
            } else {
                self switchtoweaponimmediate();
                self playsound("wpn_riotshield_zm_destroy");
                self waittill(#"weapon_change");
            }
        }
    }
    self playsound("zmb_rocketshield_break");
    if (isdefined(self.weaponriotshield)) {
        self zm_equipment::take(self.weaponriotshield);
    } else {
        self zm_equipment::take(level.weaponriotshield);
    }
    self.hasriotshield = 0;
    self.hasriotshieldequipped = 0;
}

