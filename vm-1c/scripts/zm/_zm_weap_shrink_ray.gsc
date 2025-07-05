#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/math_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_utility;

#namespace zm_weap_shrink_ray;

// Namespace zm_weap_shrink_ray
// Params 0, eflags: 0x2
// Checksum 0x12975d65, Offset: 0x478
// Size: 0x3c
function autoexec __init__sytem__() {
    system::register("zm_weap_shrink_ray", &__init__, &__main__, undefined);
}

// Namespace zm_weap_shrink_ray
// Params 0, eflags: 0x0
// Checksum 0x3fc39ebe, Offset: 0x4c0
// Size: 0x174
function __init__() {
    clientfield::register("actor", "fun_size", 5000, 1, "int");
    level.var_ac0866f = [];
    zombie_utility::set_zombie_var("shrink_ray_fling_range", 480);
    level._effect["shrink_ray_stepped_on"] = "dlc5/temple/fx_ztem_zombie_mini_squish";
    level._effect["shrink_ray_stepped_on_in_water"] = "dlc5/temple/fx_ztem_zombie_mini_drown";
    level._effect["shrink_ray_stepped_on_no_gore"] = "dlc5/temple/fx_ztem_monkey_shrink";
    level._effect["shrink"] = "dlc5/zmb_weapon/fx_shrink_ray_zombie_shrink";
    level._effect["unshrink"] = "dlc5/zmb_weapon/fx_shrink_ray_zombie_unshrink";
    callback::on_spawned(&function_37ce705e);
    level.var_c50bd012 = [];
    level.var_f812085 = getweapon("shrink_ray");
    level.var_953f69a0 = getweapon("shrink_ray_upgraded");
    zm::register_player_damage_callback(&function_19171a77);
}

// Namespace zm_weap_shrink_ray
// Params 0, eflags: 0x0
// Checksum 0x8b11a348, Offset: 0x640
// Size: 0x20
function __main__() {
    if (isdefined(level.var_cc49958b)) {
        [[ level.var_cc49958b ]]();
    }
}

// Namespace zm_weap_shrink_ray
// Params 1, eflags: 0x0
// Checksum 0x7d6a5113, Offset: 0x668
// Size: 0x2c
function function_80738220(ent) {
    array::add(level.var_c50bd012, ent, 0);
}

// Namespace zm_weap_shrink_ray
// Params 1, eflags: 0x0
// Checksum 0x32eb8f72, Offset: 0x6a0
// Size: 0x2c
function function_d705d94f(ent) {
    arrayremovevalue(level.var_c50bd012, ent);
}

// Namespace zm_weap_shrink_ray
// Params 0, eflags: 0x0
// Checksum 0x5eda1459, Offset: 0x6d8
// Size: 0x30
function function_ebf92008() {
    while (true) {
        level.var_1b24c8b0 = 0;
        util::wait_network_frame();
    }
}

// Namespace zm_weap_shrink_ray
// Params 0, eflags: 0x0
// Checksum 0xfe8f8cf3, Offset: 0x710
// Size: 0x88
function function_37ce705e() {
    self endon(#"disconnect");
    for (;;) {
        self waittill(#"weapon_fired");
        currentweapon = self getcurrentweapon();
        if (currentweapon == level.var_f812085 || currentweapon == level.var_953f69a0) {
            self thread function_fe7a4182(currentweapon == level.var_953f69a0);
        }
    }
}

// Namespace zm_weap_shrink_ray
// Params 13, eflags: 0x0
// Checksum 0x1837c087, Offset: 0x7a0
// Size: 0xa4
function function_19171a77(e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, w_weapon, v_point, v_dir, str_hit_loc, psoffsettime, var_3bc96147, var_269779a, var_829b9480) {
    if (isdefined(e_inflictor)) {
        if (isdefined(e_inflictor.shrinked) && e_inflictor.shrinked) {
            return 5;
        }
    }
    return n_damage;
}

// Namespace zm_weap_shrink_ray
// Params 1, eflags: 0x0
// Checksum 0x66095d4b, Offset: 0x850
// Size: 0x12c
function function_fe7a4182(upgraded) {
    zombies = function_66ab6f95(upgraded, 0);
    objects = function_66ab6f95(upgraded, 1);
    zombies = arraycombine(zombies, objects, 1, 0);
    var_744b41f1 = 1000;
    for (i = 0; i < zombies.size && i < var_744b41f1; i++) {
        if (isai(zombies[i])) {
            zombies[i] thread shrink_zombie(upgraded, self);
            continue;
        }
        zombies[i] notify(#"shrunk", upgraded);
    }
}

// Namespace zm_weap_shrink_ray
// Params 2, eflags: 0x0
// Checksum 0xe66b2c8a, Offset: 0x988
// Size: 0x7c
function function_20c24bab(upgraded, player) {
    damage = 10;
    self dodamage(damage, player.origin, player, undefined, "projectile");
    self function_9ae4cf1b(damage, (0, 1, 0));
}

// Namespace zm_weap_shrink_ray
// Params 2, eflags: 0x0
// Checksum 0x94f50335, Offset: 0xa10
// Size: 0x14c
function function_9af5d92d(upgraded, attacker) {
    if (isdefined(self.shrinked) && self.shrinked) {
        return;
    }
    self.shrinked = 1;
    var_36333499 = self getattachsize();
    for (i = var_36333499 - 1; i >= 0; i--) {
        model = self getattachmodelname(i);
        self detach(model);
        attachmodel = level.var_ac0866f[model];
        if (isdefined(attachmodel)) {
            self attach(attachmodel);
        }
    }
    var_87aa5c26 = level.var_ac0866f[self.model];
    if (isdefined(var_87aa5c26)) {
        self setmodel(var_87aa5c26);
    }
}

// Namespace zm_weap_shrink_ray
// Params 2, eflags: 0x0
// Checksum 0xd22e8e38, Offset: 0xb68
// Size: 0xace
function shrink_zombie(upgraded, attacker) {
    self endon(#"death");
    if (isdefined(self.shrinked) && self.shrinked) {
        return;
    }
    if (!isdefined(self.var_bb09c29a)) {
        self.var_bb09c29a = 0;
    }
    var_50d1f39 = 2.5;
    if (self.animname == "sonic_zombie") {
        if (self.var_bb09c29a == 0) {
            var_50d1f39 = 0.75;
        } else if (self.var_bb09c29a == 1) {
            var_50d1f39 = 1.5;
        } else {
            var_50d1f39 = 2.5;
        }
    } else if (self.animname == "napalm_zombie") {
        if (self.var_bb09c29a == 0) {
            var_50d1f39 = 0.75;
        } else if (self.var_bb09c29a == 1) {
            var_50d1f39 = 1.5;
        } else {
            var_50d1f39 = 2.5;
        }
    } else {
        var_50d1f39 = 2.5;
        var_50d1f39 += randomfloatrange(0, 0.5);
    }
    if (upgraded) {
        var_50d1f39 *= 2;
    }
    self.var_bb09c29a++;
    var_f1754347 = 0;
    if (isactor(self)) {
        self clientfield::set("fun_size", 1);
    }
    self notify(#"shrink");
    self.shrinked = 1;
    self.var_2209ea1b = attacker;
    self.kill_on_wine_coccon = 1;
    if (!isdefined(attacker.var_e5e4e1e5)) {
        attacker.var_e5e4e1e5 = [];
    }
    if (!isdefined(attacker.var_e5e4e1e5[self.animname])) {
        attacker.var_e5e4e1e5[self.animname] = 0;
    }
    attacker.var_e5e4e1e5[self.animname]++;
    var_cd13f0ff = self.model;
    health = self.health;
    if (isdefined(self.animname) && self.animname == "monkey_zombie") {
        if (isdefined(self.var_7711e778)) {
            self [[ self.var_7711e778 ]](attacker);
        } else {
            fling_range_squared = level.zombie_vars["shrink_ray_fling_range"] * level.zombie_vars["shrink_ray_fling_range"];
            view_pos = attacker getweaponmuzzlepoint();
            test_origin = self getcentroid();
            test_range_squared = distancesquared(view_pos, test_origin);
            dist_mult = (fling_range_squared - test_range_squared) / fling_range_squared;
            fling_vec = vectornormalize(test_origin - view_pos);
            fling_vec = (fling_vec[0], fling_vec[1], abs(fling_vec[2]));
            fling_vec = vectorscale(fling_vec, 100 + 100 * dist_mult);
            self dodamage(self.health + 666, attacker.origin, attacker);
            self startragdoll();
            self launchragdoll(fling_vec);
        }
    } else if (self function_f23d2379()) {
        self function_6140a171(attacker);
    } else {
        self playsound("evt_shrink");
        self.var_2209ea1b thread zm_audio::create_and_play_dialog("kill", "shrink");
        self thread function_259d2f7a("shrink", "J_MainRoot");
        var_939fbc94 = self.meleedamage;
        self.meleedamage = 5;
        self.no_gib = 1;
        self zombie_utility::zombie_eye_glow_stop();
        attachedmodels = [];
        var_a276831a = [];
        hatmodel = self.hatmodel;
        var_36333499 = self getattachsize();
        for (i = var_36333499 - 1; i >= 0; i--) {
            model = self getattachmodelname(i);
            tag = self getattachtagname(i);
            var_4f32ff14 = isdefined(self.hatmodel) && self.hatmodel == model;
            if (var_4f32ff14) {
                self.hatmodel = undefined;
            }
            attachedmodels[attachedmodels.size] = model;
            var_a276831a[var_a276831a.size] = tag;
            self detach(model);
            attachmodel = level.var_ac0866f[model];
            if (isdefined(attachmodel)) {
                self attach(attachmodel);
                if (var_4f32ff14) {
                    self.hatmodel = attachmodel;
                }
            }
        }
        var_87aa5c26 = level.var_ac0866f[self.model];
        if (isdefined(var_87aa5c26)) {
            self setmodel(var_87aa5c26);
        }
        if (!self.missinglegs) {
            self setphysparams(8, -2, 32);
        } else {
            self allowpitchangle(0);
            neworigin = self.origin + (0, 0, 10);
            self teleport(neworigin, self.angles);
            self setphysparams(8, -16, 10);
        }
        self.health = 1;
        self thread function_6d284e94();
        self thread function_643fa9c8();
        self thread watch_for_death();
        self.var_cbce0122 = &function_8b44a1f8;
        if (isdefined(self.var_399caee8)) {
            self [[ self.var_399caee8 ]]();
        }
        wait var_50d1f39;
        self playsound("evt_unshrink");
        self thread function_259d2f7a("unshrink", "J_MainRoot");
        wait 0.5;
        self.var_cbce0122 = undefined;
        if (isdefined(self.var_c1d20f2f)) {
            self [[ self.var_c1d20f2f ]]();
        }
        var_36333499 = self getattachsize();
        for (i = var_36333499 - 1; i >= 0; i--) {
            model = self getattachmodelname(i);
            tag = self getattachtagname(i);
            self detach(model);
        }
        self.hatmodel = hatmodel;
        for (i = 0; i < attachedmodels.size; i++) {
            self attach(attachedmodels[i]);
        }
        self setmodel(var_cd13f0ff);
        if (!self.missinglegs) {
            self setphysparams(15, 0, 72);
        } else {
            self setphysparams(15, 0, 24);
            self allowpitchangle(1);
        }
        self.health = health;
        self.meleedamage = var_939fbc94;
        self.no_gib = 0;
    }
    self zombie_utility::zombie_eye_glow();
    if (isactor(self)) {
        self clientfield::set("fun_size", 0);
    }
    self notify(#"unshrink");
    self.shrinked = 0;
    self.var_2209ea1b = undefined;
    self.kill_on_wine_coccon = undefined;
}

// Namespace zm_weap_shrink_ray
// Params 0, eflags: 0x0
// Checksum 0x3608522c, Offset: 0x1640
// Size: 0x62
function function_f23d2379() {
    if (isdefined(self getlinkedent())) {
        return true;
    }
    if (isdefined(self.sliding) && self.sliding) {
        return true;
    }
    if (isdefined(self.in_the_ceiling) && self.in_the_ceiling) {
        return true;
    }
    return false;
}

// Namespace zm_weap_shrink_ray
// Params 0, eflags: 0x0
// Checksum 0xf402627f, Offset: 0x16b0
// Size: 0xa0
function function_6d284e94() {
    self endon(#"unshrink");
    self endon(#"hash_b6537d92");
    self endon(#"kicked");
    self endon(#"death");
    wait randomfloatrange(0.2, 0.5);
    while (true) {
        self playsound("zmb_mini_ambient");
        wait randomfloatrange(1, 2.25);
    }
}

// Namespace zm_weap_shrink_ray
// Params 3, eflags: 0x0
// Checksum 0x4fd1895a, Offset: 0x1758
// Size: 0x44
function function_259d2f7a(fxname, var_80afd72e, offset) {
    playfxontag(level._effect[fxname], self, "tag_origin");
}

// Namespace zm_weap_shrink_ray
// Params 1, eflags: 0x0
// Checksum 0x1c90f728, Offset: 0x17a8
// Size: 0x44
function function_206493fd(alias) {
    self endon(#"death");
    wait randomfloat(0.5);
    self zm_utility::play_sound_on_ent(alias);
}

// Namespace zm_weap_shrink_ray
// Params 0, eflags: 0x0
// Checksum 0xc2fa3375, Offset: 0x17f8
// Size: 0x2e0
function function_643fa9c8() {
    self endon(#"death");
    self endon(#"unshrink");
    self.var_f0dec186 = spawn("trigger_radius", self.origin, 0, 30, 24);
    self.var_f0dec186 sethintstring("");
    self.var_f0dec186 setcursorhint("HINT_NOICON");
    self.var_f0dec186 enablelinkto();
    self.var_f0dec186 linkto(self);
    self.var_f0dec186 thread function_2c318bd(self);
    self.var_f0dec186 endon(#"death");
    while (true) {
        self.var_f0dec186 waittill(#"trigger", who);
        if (!isplayer(who)) {
            continue;
        }
        if (!(isdefined(self.completed_emerging_into_playable_area) && self.completed_emerging_into_playable_area)) {
            continue;
        }
        if (isdefined(self.magic_bullet_shield) && self.magic_bullet_shield) {
            continue;
        }
        movement = who getnormalizedmovement();
        if (length(movement) < 0.1) {
            continue;
        }
        toenemy = self.origin - who.origin;
        toenemy = (toenemy[0], toenemy[1], 0);
        toenemy = vectornormalize(toenemy);
        forward_view_angles = anglestoforward(who.angles);
        var_884fd8ec = vectordot(forward_view_angles, toenemy);
        if (var_884fd8ec > 0.5 && movement[0] > 0) {
            self notify(#"kicked");
            who notify(#"hash_49423c6f");
            self function_867ec02b(who);
            continue;
        }
        self notify(#"hash_b6537d92");
        self function_6140a171(who);
    }
}

// Namespace zm_weap_shrink_ray
// Params 1, eflags: 0x0
// Checksum 0x6e64fe79, Offset: 0x1ae0
// Size: 0x3c
function function_2c318bd(var_34c9bd99) {
    self endon(#"death");
    var_34c9bd99 waittill(#"death");
    self delete();
}

// Namespace zm_weap_shrink_ray
// Params 0, eflags: 0x0
// Checksum 0x73db3762, Offset: 0x1b28
// Size: 0x4c
function watch_for_death() {
    self endon(#"unshrink");
    self endon(#"hash_b6537d92");
    self endon(#"kicked");
    self waittill(#"death");
    self function_6140a171();
}

// Namespace zm_weap_shrink_ray
// Params 1, eflags: 0x0
// Checksum 0x19f2988a, Offset: 0x1b80
// Size: 0x64
function function_12c1fddf(v_launch) {
    if (!isdefined(level.var_6d0abb4c)) {
        level.var_6d0abb4c = 0;
    }
    if (level.var_6d0abb4c < 5) {
        level.var_6d0abb4c++;
        self launchragdoll(v_launch);
        wait 3;
        level.var_6d0abb4c--;
    }
}

// Namespace zm_weap_shrink_ray
// Params 1, eflags: 0x0
// Checksum 0x5c097801, Offset: 0x1bf0
// Size: 0x28c
function function_867ec02b(killer) {
    if (level flag::get("world_is_paused")) {
        self setignorepauseworld(1);
    }
    self thread function_9ac50518();
    var_786c71b = killer.angles;
    var_786c71b += (randomfloatrange(-30, -20), randomfloatrange(-5, 5), 0);
    launchdir = anglestoforward(var_786c71b);
    if (killer issprinting()) {
        launchforce = randomfloatrange(350, 400);
    } else {
        vel = killer getvelocity();
        speed = length(vel);
        scale = math::clamp(speed / -66, 0.1, 1);
        launchforce = randomfloatrange(-56 * scale, -6 * scale);
    }
    self startragdoll();
    self thread function_12c1fddf(launchdir * launchforce);
    util::wait_network_frame();
    killer thread zm_audio::create_and_play_dialog("kill", "shrunken");
    self dodamage(self.health + 666, self.origin, killer);
    if (isdefined(self.var_f0dec186)) {
        self.var_f0dec186 delete();
    }
}

// Namespace zm_weap_shrink_ray
// Params 0, eflags: 0x0
// Checksum 0x35555096, Offset: 0x1e88
// Size: 0x64
function function_9ac50518() {
    if (!isdefined(level.var_1b24c8b0)) {
        level thread function_ebf92008();
    }
    if (level.var_1b24c8b0 > 3) {
        return;
    }
    level.var_1b24c8b0++;
    playsoundatposition("zmb_mini_kicked", self.origin);
}

// Namespace zm_weap_shrink_ray
// Params 1, eflags: 0x0
// Checksum 0xf1818aa6, Offset: 0x1ef8
// Size: 0x12c
function function_6140a171(killer) {
    playsoundatposition("zmb_mini_squashed", self.origin);
    if (level flag::get("world_is_paused")) {
        self setignorepauseworld(1);
    }
    playfx(level._effect["shrink_ray_stepped_on_no_gore"], self.origin);
    self thread zombie_utility::zombie_eye_glow_stop();
    util::wait_network_frame();
    self hide();
    self dodamage(self.health + 666, self.origin, killer);
    if (isdefined(self.var_f0dec186)) {
        self.var_f0dec186 delete();
    }
}

// Namespace zm_weap_shrink_ray
// Params 2, eflags: 0x0
// Checksum 0x9dee8efa, Offset: 0x2030
// Size: 0x586
function function_66ab6f95(upgraded, var_5eafa9ab) {
    range = 480;
    radius = 60;
    if (upgraded) {
        range = 1200;
        radius = 84;
    }
    var_91820d09 = [];
    view_pos = self getweaponmuzzlepoint();
    var_6d86f57c = undefined;
    if (var_5eafa9ab) {
        var_6d86f57c = level.var_c50bd012;
        range *= 5;
    } else {
        var_6d86f57c = getaispeciesarray(level.zombie_team, "all");
    }
    zombies = util::get_array_of_closest(view_pos, var_6d86f57c, undefined, undefined, range * 1.1);
    if (!isdefined(zombies)) {
        return;
    }
    range_squared = range * range;
    radius_squared = radius * radius;
    forward_view_angles = self getweaponforwarddir();
    end_pos = view_pos + vectorscale(forward_view_angles, range);
    /#
        if (2 == getdvarint("<dev string:x28>")) {
            near_circle_pos = view_pos + vectorscale(forward_view_angles, 2);
            circle(near_circle_pos, radius, (1, 0, 0), 0, 0, 100);
            line(near_circle_pos, end_pos, (0, 0, 1), 1, 0, 100);
            circle(end_pos, radius, (1, 0, 0), 0, 0, 100);
        }
    #/
    for (i = 0; i < zombies.size; i++) {
        if (isai(zombies[i]) && (!isdefined(zombies[i]) || !isalive(zombies[i]))) {
            continue;
        }
        if (isdefined(zombies[i].shrinked) && zombies[i].shrinked) {
            zombies[i] function_9ae4cf1b("shrinked", (1, 0, 0));
            continue;
        }
        if (isdefined(zombies[i].no_shrink) && zombies[i].no_shrink) {
            zombies[i] function_9ae4cf1b("no_shrink", (1, 0, 0));
            continue;
        }
        test_origin = zombies[i] getcentroid();
        test_range_squared = distancesquared(view_pos, test_origin);
        if (test_range_squared > range_squared) {
            zombies[i] function_9ae4cf1b("range", (1, 0, 0));
            break;
        }
        normal = vectornormalize(test_origin - view_pos);
        dot = vectordot(forward_view_angles, normal);
        if (0 > dot) {
            zombies[i] function_9ae4cf1b("dot", (1, 0, 0));
            continue;
        }
        radial_origin = pointonsegmentnearesttopoint(view_pos, end_pos, test_origin);
        if (distancesquared(test_origin, radial_origin) > radius_squared) {
            zombies[i] function_9ae4cf1b("cylinder", (1, 0, 0));
            continue;
        }
        if (0 == zombies[i] damageconetrace(view_pos, self)) {
            zombies[i] function_9ae4cf1b("cone", (1, 0, 0));
            continue;
        }
        var_91820d09[var_91820d09.size] = zombies[i];
    }
    return var_91820d09;
}

// Namespace zm_weap_shrink_ray
// Params 2, eflags: 0x0
// Checksum 0xa6f3c4c6, Offset: 0x25c0
// Size: 0x8c
function function_9ae4cf1b(msg, color) {
    /#
        if (!getdvarint("<dev string:x28>")) {
            return;
        }
        if (!isdefined(color)) {
            color = (1, 1, 1);
        }
        print3d(self.origin + (0, 0, 60), msg, color, 1, 1, 40);
    #/
}

// Namespace zm_weap_shrink_ray
// Params 0, eflags: 0x0
// Checksum 0x71aca6d8, Offset: 0x2658
// Size: 0x54
function function_8b44a1f8() {
    self endon(#"death");
    self endon(#"unshrink");
    while (true) {
        taunt_anim = array::random(level.var_89cbbe56["zombie"]);
    }
}

