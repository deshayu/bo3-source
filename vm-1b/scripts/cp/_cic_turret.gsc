#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/statemachine_shared;
#using scripts/shared/system_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_death_shared;
#using scripts/shared/vehicle_shared;

#namespace cic_turret;

// Namespace cic_turret
// Params 0, eflags: 0x2
// Checksum 0xd265561e, Offset: 0x500
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("cic_turret", &__init__, undefined, undefined);
}

// Namespace cic_turret
// Params 0, eflags: 0x0
// Checksum 0x9a536174, Offset: 0x538
// Size: 0x19b
function __init__() {
    vehicle::add_main_callback("turret_cic", &function_4bf69f84);
    vehicle::add_main_callback("turret_cic_world", &function_4bf69f84);
    vehicle::add_main_callback("turret_sentry", &function_4bf69f84);
    vehicle::add_main_callback("turret_sentry_world", &function_4bf69f84);
    vehicle::add_main_callback("turret_sentry_cic", &function_4bf69f84);
    vehicle::add_main_callback("turret_sentry_rts", &function_4bf69f84);
    level._effect["cic_turret_damage01"] = "destruct/fx_dest_turret_1";
    level._effect["cic_turret_damage02"] = "destruct/fx_dest_turret_2";
    level._effect["sentry_turret_damage01"] = "destruct/fx_dest_turret_1";
    level._effect["sentry_turret_damage02"] = "destruct/fx_dest_turret_2";
    level._effect["cic_turret_death"] = "_t6/destructibles/fx_cic_turret_death";
    level._effect["cic_turret_stun"] = "_t6/electrical/fx_elec_sp_emp_stun_cic_turret";
    level._effect["sentry_turret_stun"] = "_t6/electrical/fx_elec_sp_emp_stun_sentry_turret";
}

// Namespace cic_turret
// Params 0, eflags: 0x0
// Checksum 0x780b7945, Offset: 0x6e0
// Size: 0x272
function function_4bf69f84() {
    self enableaimassist();
    if (issubstr(self.vehicletype, "cic")) {
        self.scanning_arc = 60;
        self.var_e7379303 = 15;
    } else {
        self.scanning_arc = 60;
        self.var_e7379303 = 0;
    }
    self.state_machine = statemachine::create("brain", self);
    main = self.state_machine statemachine::add_state("main", undefined, &function_6bf457cb, undefined);
    scripted = self.state_machine statemachine::add_state("scripted", undefined, &function_2fae15b2, undefined);
    vehicle_ai::set_role("brain");
    vehicle_ai::add_interrupt_connection("main", "scripted", "enter_vehicle");
    vehicle_ai::add_interrupt_connection("main", "scripted", "scripted");
    vehicle_ai::add_interrupt_connection("scripted", "main", "exit_vehicle");
    vehicle_ai::add_interrupt_connection("scripted", "main", "scripted_done");
    self disconnectpaths();
    self thread cic_turret_death();
    self thread function_6c405c27();
    self thread turret::track_lens_flare();
    self.overridevehicledamage = &function_df1adf01;
    if (isdefined(self.script_startstate)) {
        if (self.script_startstate == "off") {
            self function_31d70ab3(self.angles);
        } else {
            self.state_machine statemachine::set_state(self.script_startstate);
        }
    } else {
        function_73a1f565();
    }
    self laseron();
}

// Namespace cic_turret
// Params 0, eflags: 0x0
// Checksum 0xd08eeb55, Offset: 0x960
// Size: 0x22
function function_64047fb9() {
    self.state_machine statemachine::set_state("scripted");
}

// Namespace cic_turret
// Params 0, eflags: 0x0
// Checksum 0x5e21e13b, Offset: 0x990
// Size: 0x22
function function_73a1f565() {
    self.state_machine statemachine::set_state("main");
}

// Namespace cic_turret
// Params 1, eflags: 0x0
// Checksum 0x73c99e3, Offset: 0x9c0
// Size: 0x3a
function function_6bf457cb(params) {
    if (isalive(self)) {
        self enableaimassist();
        self thread function_8929bfc3();
    }
}

// Namespace cic_turret
// Params 1, eflags: 0x0
// Checksum 0x40f825a, Offset: 0xa08
// Size: 0x102
function function_31d70ab3(angles) {
    self.state_machine statemachine::set_state("scripted");
    self vehicle::lights_off();
    self laseroff();
    self vehicle::toggle_sounds(0);
    self vehicle::toggle_exhaust_fx(0);
    if (!isdefined(angles)) {
        angles = self gettagangles("tag_flash");
    }
    target_vec = self.origin + anglestoforward((0, angles[1], 0)) * 1000;
    target_vec += (0, 0, -1700);
    self function_63f13a8e(target_vec);
    self.off = 1;
    if (!isdefined(self.emped)) {
        self disableaimassist();
    }
    self.ignoreme = 1;
}

// Namespace cic_turret
// Params 0, eflags: 0x0
// Checksum 0xa397e31f, Offset: 0xb18
// Size: 0xa2
function function_d20b689f() {
    self endon(#"death");
    self playsound("veh_cic_turret_boot");
    self vehicle::lights_on();
    self enableaimassist();
    self vehicle::toggle_sounds(1);
    self function_4ebb4502();
    self vehicle::toggle_exhaust_fx(1);
    self.off = undefined;
    self laseron();
    function_73a1f565();
    self.ignoreme = 0;
}

// Namespace cic_turret
// Params 0, eflags: 0x0
// Checksum 0xff0df41a, Offset: 0xbc8
// Size: 0xce
function function_4ebb4502() {
    for (i = 0; i < 6; i++) {
        wait 0.1;
        vehicle::lights_off();
        wait 0.1;
        vehicle::lights_on();
    }
    if (!isdefined(self.player)) {
        angles = self gettagangles("tag_flash");
        target_vec = self.origin + anglestoforward((self.var_e7379303, angles[1], 0)) * 1000;
        self.turretrotscale = 0.3;
        self function_63f13a8e(target_vec);
        wait 1;
        self.turretrotscale = 1;
    }
}

// Namespace cic_turret
// Params 0, eflags: 0x0
// Checksum 0x3b0c479f, Offset: 0xca0
// Size: 0x39d
function function_8929bfc3() {
    self endon(#"death");
    self endon(#"change_state");
    var_65801466 = 0;
    wait 0.2;
    origin = self gettagorigin("tag_barrel");
    var_77333bf3 = origin + anglestoforward(self.angles + (self.var_e7379303, self.scanning_arc, 0)) * 1000;
    var_9823c256 = origin + anglestoforward(self.angles + (self.var_e7379303, self.scanning_arc * -1, 0)) * 1000;
    while (true) {
        if (isdefined(self.enemy) && self function_4246bc05(self.enemy)) {
            self.turretrotscale = 1;
            if (var_65801466 > 0 && isplayer(self.enemy)) {
                function_c9760e52();
                wait 0.5;
            }
            var_65801466 = 0;
            for (i = 0; i < 3; i++) {
                if (isdefined(self.enemy) && isalive(self.enemy) && self function_4246bc05(self.enemy)) {
                    self setturrettargetent(self.enemy);
                    wait 0.1;
                    self function_20d6503c(randomfloatrange(0.4, 1.5));
                } else {
                    self cleartargetentity();
                }
                if (isdefined(self.enemy) && isplayer(self.enemy)) {
                    wait randomfloatrange(0.3, 0.6);
                    continue;
                }
                wait randomfloatrange(0.3, 0.6) * 2;
            }
            if (isdefined(self.enemy) && isalive(self.enemy) && self function_4246bc05(self.enemy)) {
                if (isplayer(self.enemy)) {
                    wait randomfloatrange(0.5, 1.3);
                } else {
                    wait randomfloatrange(0.5, 1.3) * 2;
                }
            }
        } else {
            self.turretrotscale = 0.25;
            var_65801466++;
            wait 1;
            if (var_65801466 > 1) {
                self.var_f5d48615 = 0;
                while (!isdefined(self.enemy) || !self function_4246bc05(self.enemy)) {
                    if (self.turretontarget) {
                        self.var_f5d48615++;
                        if (self.var_f5d48615 > 1) {
                            self.var_f5d48615 = 0;
                        }
                    }
                    if (self.var_f5d48615 == 0) {
                        self setturrettargetvec(var_77333bf3);
                    } else {
                        self setturrettargetvec(var_9823c256);
                    }
                    wait 0.5;
                }
            } else {
                self cleartargetentity();
            }
        }
        wait 0.5;
    }
}

// Namespace cic_turret
// Params 1, eflags: 0x0
// Checksum 0x631d733b, Offset: 0x1048
// Size: 0x9a
function function_2fae15b2(params) {
    driver = self getseatoccupant(0);
    if (isdefined(driver)) {
        self.turretrotscale = 1;
        self disableaimassist();
        if (driver == level.players[0]) {
            self thread vehicle_death::vehicle_damage_filter("firestorm_turret");
            level.players[0] thread function_2790de05(self);
        }
    }
    self cleartargetentity();
}

// Namespace cic_turret
// Params 1, eflags: 0x0
// Checksum 0xf4f2c60e, Offset: 0x10f0
// Size: 0x97
function function_b149aa04(health_pct) {
    if (issubstr(self.vehicletype, "turret_sentry")) {
        if (health_pct < 0.6) {
            return level._effect["sentry_turret_damage02"];
        } else {
            return level._effect["sentry_turret_damage01"];
        }
        return;
    }
    if (health_pct < 0.6) {
        return level._effect["cic_turret_damage02"];
    }
    return level._effect["cic_turret_damage01"];
}

// Namespace cic_turret
// Params 2, eflags: 0x0
// Checksum 0xbc3273b, Offset: 0x1190
// Size: 0x14a
function function_197cacdf(effect, tag) {
    if (isdefined(self.damage_fx_ent)) {
        if (self.damage_fx_ent.effect == effect) {
            return;
        }
        self.damage_fx_ent delete();
    }
    if (!isdefined(self gettagangles(tag))) {
        return;
    }
    ent = spawn("script_model", (0, 0, 0));
    ent setmodel("tag_origin");
    ent.origin = self gettagorigin(tag);
    ent.angles = self gettagangles(tag);
    ent notsolid();
    ent hide();
    ent linkto(self, tag);
    ent.effect = effect;
    playfxontag(effect, ent, "tag_origin");
    ent playsound("veh_cic_turret_sparks");
    self.damage_fx_ent = ent;
}

// Namespace cic_turret
// Params 0, eflags: 0x0
// Checksum 0x5e2049ca, Offset: 0x12e8
// Size: 0x7d
function function_6c405c27() {
    self endon(#"crash_done");
    while (isdefined(self)) {
        self waittill(#"damage");
        if (self.health > 0) {
            effect = self function_b149aa04(self.health / self.healthdefault);
            tag = "tag_fx";
            function_197cacdf(effect, tag);
        }
        wait 0.3;
    }
}

// Namespace cic_turret
// Params 0, eflags: 0x0
// Checksum 0x263e8b26, Offset: 0x1370
// Size: 0x1aa
function cic_turret_death() {
    wait 0.1;
    self notify(#"nodeath_thread");
    self waittill(#"death", attacker, damagefromunderneath, weapon, point, dir);
    if (isdefined(self.delete_on_death)) {
        if (isdefined(self.damage_fx_ent)) {
            self.damage_fx_ent delete();
        }
        self delete();
        return;
    }
    if (!isdefined(self)) {
        return;
    }
    self vehicle_death::death_cleanup_level_variables();
    self disableaimassist();
    self cleartargetentity();
    self vehicle::lights_off();
    self laseroff();
    self setturretspinning(0);
    self turret::toggle_lensflare(0);
    self death_fx();
    self thread vehicle_death::death_radius_damage();
    self thread vehicle_death::set_death_model(self.deathmodel, self.modelswapdelay);
    self vehicle::toggle_sounds(0);
    self thread function_969be05e(attacker, dir);
    if (isdefined(self.damage_fx_ent)) {
        self.damage_fx_ent delete();
    }
    self.ignoreme = 1;
    self waittill(#"crash_done");
    self freevehicle();
}

// Namespace cic_turret
// Params 0, eflags: 0x0
// Checksum 0x6206c1a7, Offset: 0x1528
// Size: 0x8a
function death_fx() {
    self vehicle::do_death_fx();
    self playsound("veh_cic_turret_sparks");
    fire_ent = spawn("script_origin", self.origin);
    fire_ent playloopsound("veh_cic_turret_dmg_fire_loop", 0.5);
    wait 2;
    fire_ent delete();
}

// Namespace cic_turret
// Params 2, eflags: 0x0
// Checksum 0x5e1a96c7, Offset: 0x15c0
// Size: 0xcf
function function_969be05e(attacker, hitdir) {
    self endon(#"crash_done");
    self endon(#"death");
    self playsound("veh_cic_turret_dmg_hit");
    wait 0.1;
    self.turretrotscale = 0.5;
    tag_angles = self gettagangles("tag_flash");
    target_pos = self.origin + anglestoforward((0, tag_angles[1], 0)) * 1000 + (0, 0, -1800);
    self setturrettargetvec(target_pos);
    wait 4;
    self notify(#"crash_done");
}

// Namespace cic_turret
// Params 1, eflags: 0x0
// Checksum 0x45efa700, Offset: 0x1698
// Size: 0x19a
function function_20d6503c(totalfiretime) {
    self endon(#"crash_done");
    self endon(#"death");
    function_c9760e52();
    wait 0.1;
    weapon = self seatgetweapon(0);
    firetime = weapon.firetime;
    time = 0;
    is_minigun = 0;
    if (issubstr(weapon.name, "minigun")) {
        is_minigun = 1;
        self setturretspinning(1);
        wait 0.5;
    }
    var_cb645151 = 2;
    if (isdefined(self.enemy) && isplayer(self.enemy)) {
        var_cb645151 = 1;
    }
    firecount = 1;
    while (time < totalfiretime) {
        if (isdefined(self.enemy) && isdefined(self.enemy.attackeraccuracy) && self.enemy.attackeraccuracy == 0) {
            self fireweapon();
        } else if (var_cb645151 > 1) {
            self fireweapon();
        } else {
            self fireweapon();
        }
        firecount++;
        wait firetime;
        time += firetime;
    }
    if (is_minigun) {
        self setturretspinning(0);
    }
}

// Namespace cic_turret
// Params 0, eflags: 0x0
// Checksum 0xcf8449e0, Offset: 0x1840
// Size: 0x1a
function function_c9760e52() {
    self playsound("veh_turret_alert");
}

// Namespace cic_turret
// Params 1, eflags: 0x0
// Checksum 0x59e1a81b, Offset: 0x1868
// Size: 0x2a
function function_44158b0(team) {
    self.team = team;
    if (!isdefined(self.off)) {
        function_38baa992();
    }
}

// Namespace cic_turret
// Params 0, eflags: 0x0
// Checksum 0xb31db029, Offset: 0x18a0
// Size: 0x32
function function_38baa992() {
    self endon(#"death");
    self vehicle::lights_off();
    wait 0.1;
    self vehicle::lights_on();
}

// Namespace cic_turret
// Params 0, eflags: 0x0
// Checksum 0x8083dc91, Offset: 0x18e0
// Size: 0x192
function function_39f05215() {
    self endon(#"death");
    self notify(#"emped");
    self endon(#"emped");
    self.emped = 1;
    playsoundatposition("veh_cic_turret_emp_down", self.origin);
    self.turretrotscale = 0.2;
    self function_31d70ab3();
    if (!isdefined(self.stun_fx)) {
        self.stun_fx = spawn("script_model", self.origin);
        self.stun_fx setmodel("tag_origin");
        self.stun_fx linkto(self, "tag_fx", (0, 0, 0), (0, 0, 0));
        if (issubstr(self.vehicletype, "turret_sentry")) {
            playfxontag(level._effect["sentry_turret_stun"], self.stun_fx, "tag_origin");
        } else {
            playfxontag(level._effect["cic_turret_stun"], self.stun_fx, "tag_origin");
        }
    }
    wait randomfloatrange(6, 10);
    self.stun_fx delete();
    self.emped = undefined;
    self function_d20b689f();
}

// Namespace cic_turret
// Params 14, eflags: 0x0
// Checksum 0x64b4843, Offset: 0x1a80
// Size: 0x136
function function_df1adf01(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname) {
    if (weapon.isemp && smeansofdeath != "MOD_IMPACT") {
        driver = self getseatoccupant(0);
        if (!isdefined(driver)) {
            self thread function_39f05215();
        }
    }
    if (weapon == getweapon("shotgun_pump_taser") && smeansofdeath == "MOD_PISTOL_BULLET") {
        idamage = int(idamage * 3);
        self thread function_d8937095();
    }
    if (!isplayer(eattacker)) {
        idamage = int(idamage / 4);
    }
    return idamage;
}

// Namespace cic_turret
// Params 1, eflags: 0x0
// Checksum 0xf35cae8a, Offset: 0x1bc0
// Size: 0xe5
function function_2790de05(turret) {
    self endon(#"exit_vehicle");
    turret endon(#"hash_973e6741");
    level endon(#"hash_161a3f68");
    heat = 0;
    overheat = 0;
    while (true) {
        if (isdefined(self.viewlockedentity)) {
            var_aee11f71 = heat;
            heat = self.viewlockedentity getturretheatvalue(0);
            var_26c60357 = overheat;
            overheat = self.viewlockedentity isvehicleturretoverheating(0);
            if (var_aee11f71 != heat || var_26c60357 != overheat) {
                luinotifyevent(%hud_cic_weapon_heat, 2, int(heat), overheat);
            }
        }
        wait 0.05;
    }
}

// Namespace cic_turret
// Params 0, eflags: 0x0
// Checksum 0x90e66e78, Offset: 0x1cb0
// Size: 0x19a
function function_d8937095() {
    self endon(#"death");
    self notify(#"stunned");
    self endon(#"stunned");
    self.stunned = 1;
    self.turretrotscale = 0.2;
    self function_31d70ab3();
    if (!isdefined(self.stun_fx)) {
        playsoundatposition("veh_cic_turret_emp_down", self.origin);
        self.stun_fx = spawn("script_model", self.origin);
        self.stun_fx setmodel("tag_origin");
        self.stun_fx linkto(self, "tag_fx", (0, 0, 0), (0, 0, 0));
        if (issubstr(self.vehicletype, "turret_sentry")) {
            playfxontag(level._effect["sentry_turret_stun"], self.stun_fx, "tag_origin");
        } else {
            playfxontag(level._effect["cic_turret_stun"], self.stun_fx, "tag_origin");
        }
    }
    wait randomfloatrange(3, 5);
    self.stun_fx delete();
    self.stunned = undefined;
    self function_d20b689f();
}

