#using scripts/codescripts/struct;
#using scripts/shared/flag_shared;
#using scripts/shared/math_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;

#using_animtree("generic");

#namespace vehicle_death;

// Namespace vehicle_death
// Params 0, eflags: 0x2
// Checksum 0xa2d3384b, Offset: 0x450
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("vehicle_death", &__init__, undefined, undefined);
}

// Namespace vehicle_death
// Params 0, eflags: 0x0
// Checksum 0x4cd01a4b, Offset: 0x490
// Size: 0x24
function __init__() {
    setdvar("debug_crash_type", -1);
}

// Namespace vehicle_death
// Params 0, eflags: 0x0
// Checksum 0xf31df8c6, Offset: 0x4c0
// Size: 0x630
function main() {
    self endon(#"nodeath_thread");
    while (isdefined(self)) {
        self waittill(#"death", attacker, damagefromunderneath, weapon, point, dir);
        if (isdefined(self.death_enter_cb)) {
            [[ self.death_enter_cb ]]();
        }
        if (isdefined(self.script_deathflag)) {
            level flag::set(self.script_deathflag);
        }
        if (!isdefined(self.delete_on_death)) {
            self thread play_death_audio();
        }
        if (!isdefined(self)) {
            return;
        }
        self death_cleanup_level_variables();
        if (vehicle::is_corpse(self)) {
            if (!(isdefined(self.dont_kill_riders) && self.dont_kill_riders)) {
                self death_cleanup_riders();
            }
            self notify(#"delete_destructible");
            return;
        }
        self vehicle::lights_off();
        if (isdefined(level.vehicle_death_thread[self.vehicletype])) {
            thread [[ level.vehicle_death_thread[self.vehicletype] ]]();
        }
        if (!isdefined(self.delete_on_death)) {
            thread death_radius_damage();
        }
        is_aircraft = isdefined(self.vehicleclass) && (isdefined(self.vehicleclass) && self.vehicleclass == "plane" || self.vehicleclass == "helicopter");
        if (!isdefined(self.destructibledef)) {
            if (!is_aircraft && !(self.vehicletype == "horse" || self.vehicletype == "horse_player" || self.vehicletype == "horse_player_low" || self.vehicletype == "horse_low" || self.vehicletype == "horse_axis") && isdefined(self.deathmodel) && self.deathmodel != "") {
                self thread set_death_model(self.deathmodel, self.modelswapdelay);
            }
            if ((!isdefined(self.mantled) || !isdefined(self.delete_on_death) && !self.mantled) && !isdefined(self.nodeathfx)) {
                thread death_fx();
            }
            if (isdefined(self.delete_on_death)) {
                wait 0.05;
                if (self.disconnectpathonstop === 1) {
                    self vehicle::disconnect_paths();
                }
                if (!(isdefined(self.no_free_on_death) && self.no_free_on_death)) {
                    self freevehicle();
                    self.isacorpse = 1;
                    wait 0.05;
                    if (isdefined(self)) {
                        self notify(#"death_finished");
                        self delete();
                    }
                }
                continue;
            }
        }
        thread death_make_badplace(self.vehicletype);
        if (isdefined(level.vehicle_deathnotify) && isdefined(level.vehicle_deathnotify[self.vehicletype])) {
            level notify(level.vehicle_deathnotify[self.vehicletype], attacker);
        }
        if (target_istarget(self)) {
            target_remove(self);
        }
        if (self.classname == "script_vehicle") {
            self thread death_jolt(self.vehicletype);
        }
        if (do_scripted_crash()) {
            self thread death_update_crash(point, dir);
        }
        if (isdefined(self.turretweapon) && self.turretweapon != level.weaponnone) {
            self clearturrettarget();
        }
        self waittill_crash_done_or_stopped();
        if (isdefined(self)) {
            while (isdefined(self) && isdefined(self.dontfreeme)) {
                wait 0.05;
            }
            self notify(#"stop_looping_death_fx");
            self notify(#"death_finished");
            wait 0.05;
            if (isdefined(self)) {
                if (vehicle::is_corpse(self)) {
                    continue;
                }
                if (!isdefined(self)) {
                    continue;
                }
                occupants = self getvehoccupants();
                if (isdefined(occupants) && occupants.size) {
                    for (i = 0; i < occupants.size; i++) {
                        self usevehicle(occupants[i], 0);
                    }
                }
                if (!(isdefined(self.no_free_on_death) && self.no_free_on_death)) {
                    self freevehicle();
                    self.isacorpse = 1;
                }
                if (self.modeldummyon) {
                    self hide();
                }
            }
        }
    }
}

// Namespace vehicle_death
// Params 0, eflags: 0x0
// Checksum 0x3e34d393, Offset: 0xaf8
// Size: 0x26
function do_scripted_crash() {
    return isdefined(self.do_scripted_crash) && (!isdefined(self.do_scripted_crash) || self.do_scripted_crash);
}

// Namespace vehicle_death
// Params 0, eflags: 0x0
// Checksum 0x41e563d8, Offset: 0xb28
// Size: 0x7c
function play_death_audio() {
    if (isdefined(self.vehicleclass) && isdefined(self) && self.vehicleclass == "helicopter") {
        if (!isdefined(self.death_counter)) {
            self.death_counter = 0;
        }
        if (self.death_counter == 0) {
            self.death_counter++;
            self playsound("exp_veh_helicopter_hit");
        }
    }
}

// Namespace vehicle_death
// Params 0, eflags: 0x0
// Checksum 0x60d9fa49, Offset: 0xbb0
// Size: 0x74
function play_spinning_plane_sound() {
    self playloopsound("veh_drone_spin", 0.05);
    level util::waittill_any("crash_move_done", "death");
    self stoploopsound(0.02);
}

// Namespace vehicle_death
// Params 2, eflags: 0x0
// Checksum 0xdca0f9b2, Offset: 0xc30
// Size: 0x10c
function set_death_model(smodel, fdelay) {
    if (!isdefined(smodel)) {
        return;
    }
    if (isdefined(fdelay) && fdelay > 0) {
        wait fdelay;
    }
    if (!isdefined(self)) {
        return;
    }
    if (isdefined(self.deathmodel_attached)) {
        return;
    }
    emodel = vehicle::get_dummy();
    if (!isdefined(emodel)) {
        return;
    }
    if (!isdefined(emodel.death_anim) && isdefined(emodel.animtree)) {
        emodel clearanim(generic%root, 0);
    }
    if (smodel != self.vehmodel) {
        emodel setmodel(smodel);
        emodel setenemymodel(smodel);
    }
}

// Namespace vehicle_death
// Params 2, eflags: 0x0
// Checksum 0x1cfbc55, Offset: 0xd48
// Size: 0x84
function aircraft_crash(point, dir) {
    self.crashing = 1;
    if (isdefined(self.unloading)) {
        while (isdefined(self.unloading)) {
            wait 0.05;
        }
    }
    if (!isdefined(self)) {
        return;
    }
    self thread aircraft_crash_move(point, dir);
    self thread play_spinning_plane_sound();
}

// Namespace vehicle_death
// Params 2, eflags: 0x0
// Checksum 0xbe09bf78, Offset: 0xdd8
// Size: 0x7c
function helicopter_crash(point, dir) {
    self.crashing = 1;
    self thread play_crashing_loop();
    if (isdefined(self.unloading)) {
        while (isdefined(self.unloading)) {
            wait 0.05;
        }
    }
    if (!isdefined(self)) {
        return;
    }
    self thread helicopter_crash_movement(point, dir);
}

// Namespace vehicle_death
// Params 2, eflags: 0x0
// Checksum 0x93541dd2, Offset: 0xe60
// Size: 0x4b6
function helicopter_crash_movement(point, dir) {
    self endon(#"crash_done");
    self cancelaimove();
    self clearvehgoalpos();
    if (isdefined(level.var_7315c8bb)) {
        if (issubstr(self.vehicletype, "v78")) {
            playfxontag(level.var_7315c8bb, self, "tag_origin");
        } else if (self.vehicletype == "drone_firescout_axis" || self.vehicletype == "drone_firescout_isi") {
            playfxontag(level.var_7315c8bb, self, "tag_main_rotor");
        } else {
            playfxontag(level.var_7315c8bb, self, "tag_engine_left");
        }
    }
    crash_zones = struct::get_array("heli_crash_zone", "targetname");
    if (crash_zones.size > 0) {
        best_dist = 99999;
        best_idx = -1;
        if (isdefined(self.a_crash_zones)) {
            crash_zones = self.a_crash_zones;
        }
        for (i = 0; i < crash_zones.size; i++) {
            vec_to_crash_zone = crash_zones[i].origin - self.origin;
            vec_to_crash_zone = (vec_to_crash_zone[0], vec_to_crash_zone[1], 0);
            dist = length(vec_to_crash_zone);
            vec_to_crash_zone /= dist;
            veloctiy_scale = vectordot(self.velocity, vec_to_crash_zone) * -1;
            dist += 500 * veloctiy_scale;
            if (dist < best_dist) {
                best_dist = dist;
                best_idx = i;
            }
        }
        if (best_idx != -1) {
            self.crash_zone = crash_zones[best_idx];
            self thread helicopter_crash_zone_accel(dir);
        }
    } else {
        if (isdefined(dir)) {
            dir = vectornormalize(dir);
        } else {
            dir = (1, 0, 0);
        }
        side_dir = vectorcross(dir, (0, 0, 1));
        side_dir_mag = randomfloatrange(-500, 500);
        side_dir_mag += math::sign(side_dir_mag) * 60;
        side_dir *= side_dir_mag;
        side_dir += (0, 0, 150);
        self setphysacceleration((randomintrange(-500, 500), randomintrange(-500, 500), -1000));
        self setvehvelocity(self.velocity + side_dir);
        self thread helicopter_crash_accel();
        if (isdefined(point)) {
            self thread helicopter_crash_rotation(point, dir);
        } else {
            self thread helicopter_crash_rotation(self.origin, dir);
        }
    }
    self thread crash_collision_test();
    wait 15;
    if (isdefined(self)) {
        self notify(#"crash_done");
    }
}

// Namespace vehicle_death
// Params 0, eflags: 0x0
// Checksum 0xe91642b0, Offset: 0x1320
// Size: 0xa8
function helicopter_crash_accel() {
    self endon(#"crash_done");
    self endon(#"crash_move_done");
    self endon(#"death");
    if (!isdefined(self.crash_accel)) {
        self.crash_accel = randomfloatrange(50, 80);
    }
    while (isdefined(self)) {
        self setvehvelocity(self.velocity + anglestoup(self.angles) * self.crash_accel);
        wait 0.1;
    }
}

// Namespace vehicle_death
// Params 2, eflags: 0x0
// Checksum 0x40006202, Offset: 0x13d0
// Size: 0x388
function helicopter_crash_rotation(point, dir) {
    self endon(#"crash_done");
    self endon(#"crash_move_done");
    self endon(#"death");
    start_angles = self.angles;
    start_angles = (start_angles[0] + 10, start_angles[1], start_angles[2]);
    start_angles = (start_angles[0], start_angles[1], start_angles[2] + 10);
    ang_vel = self getangularvelocity();
    ang_vel = (0, ang_vel[1] * randomfloatrange(2, 3), 0);
    self setangularvelocity(ang_vel);
    point_2d = (point[0], point[1], self.origin[2]);
    torque = (0, randomintrange(90, -76), 0);
    if (self getangularvelocity()[1] < 0) {
        torque *= -1;
    }
    if (distance(self.origin, point_2d) > 5) {
        local_hit_point = point_2d - self.origin;
        dir_2d = (dir[0], dir[1], 0);
        if (length(dir_2d) > 0.01) {
            dir_2d = vectornormalize(dir_2d);
            torque = vectorcross(vectornormalize(local_hit_point), dir);
            torque = (0, 0, torque[2]);
            torque = vectornormalize(torque);
            torque = (0, torque[2] * -76, 0);
        }
    }
    while (true) {
        ang_vel = self getangularvelocity();
        ang_vel += torque * 0.05;
        if (ang_vel[1] < 360 * -1) {
            ang_vel = (ang_vel[0], 360 * -1, ang_vel[2]);
        } else if (ang_vel[1] > 360) {
            ang_vel = (ang_vel[0], 360, ang_vel[2]);
        }
        self setangularvelocity(ang_vel);
        wait 0.05;
    }
}

// Namespace vehicle_death
// Params 1, eflags: 0x0
// Checksum 0x31b6e14b, Offset: 0x1760
// Size: 0x640
function helicopter_crash_zone_accel(dir) {
    self endon(#"crash_done");
    self endon(#"crash_move_done");
    torque = (0, randomintrange(90, -106), 0);
    ang_vel = self getangularvelocity();
    torque *= math::sign(ang_vel[1]);
    /#
        if (isdefined(self.crash_zone.height)) {
            self.crash_zone.height = 0;
        }
    #/
    if (abs(self.angles[2]) < 3) {
        self.angles = (self.angles[0], self.angles[1], randomintrange(3, 6) * math::sign(self.angles[2]));
    }
    var_ed7b90ff = issubstr(self.vehicletype, "v78");
    if (var_ed7b90ff) {
        torque *= 0.3;
    }
    while (isdefined(self)) {
        assert(isdefined(self.crash_zone));
        dist = distance2d(self.origin, self.crash_zone.origin);
        if (dist < self.crash_zone.radius) {
            self setphysacceleration((0, 0, -400));
            /#
                circle(self.crash_zone.origin + (0, 0, self.crash_zone.height), self.crash_zone.radius, (0, 1, 0), 0, 2000);
            #/
            self.crash_accel = 0;
        } else {
            self setphysacceleration((0, 0, -50));
            /#
                circle(self.crash_zone.origin + (0, 0, self.crash_zone.height), self.crash_zone.radius, (1, 0, 0), 0, 2);
            #/
        }
        self.crash_vel = self.crash_zone.origin - self.origin;
        self.crash_vel = (self.crash_vel[0], self.crash_vel[1], 0);
        self.crash_vel = vectornormalize(self.crash_vel);
        self.crash_vel *= self getmaxspeed() * 0.5;
        if (var_ed7b90ff) {
            self.crash_vel *= 0.5;
        }
        crash_vel_forward = anglestoup(self.angles) * self getmaxspeed() * 2;
        crash_vel_forward = (crash_vel_forward[0], crash_vel_forward[1], 0);
        self.crash_vel += crash_vel_forward;
        vel_x = difftrack(self.crash_vel[0], self.velocity[0], 1, 0.1);
        vel_y = difftrack(self.crash_vel[1], self.velocity[1], 1, 0.1);
        vel_z = difftrack(self.crash_vel[2], self.velocity[2], 1, 0.1);
        self setvehvelocity((vel_x, vel_y, vel_z));
        ang_vel = self getangularvelocity();
        ang_vel = (0, ang_vel[1], 0);
        ang_vel += torque * 0.1;
        max_angluar_vel = -56;
        if (var_ed7b90ff) {
            max_angluar_vel = 100;
        }
        if (ang_vel[1] < max_angluar_vel * -1) {
            ang_vel = (ang_vel[0], max_angluar_vel * -1, ang_vel[2]);
        } else if (ang_vel[1] > max_angluar_vel) {
            ang_vel = (ang_vel[0], max_angluar_vel, ang_vel[2]);
        }
        self setangularvelocity(ang_vel);
        wait 0.1;
    }
}

// Namespace vehicle_death
// Params 0, eflags: 0x0
// Checksum 0x4790c3d, Offset: 0x1da8
// Size: 0xda
function helicopter_collision() {
    self endon(#"crash_done");
    while (true) {
        self waittill(#"veh_collision", velocity, normal);
        ang_vel = self getangularvelocity() * 0.5;
        self setangularvelocity(ang_vel);
        if (normal[2] < 0.7) {
            self setvehvelocity(self.velocity + normal * 70);
            continue;
        }
        self notify(#"crash_done");
    }
}

// Namespace vehicle_death
// Params 0, eflags: 0x0
// Checksum 0x34bd476f, Offset: 0x1e90
// Size: 0xac
function play_crashing_loop() {
    ent = spawn("script_origin", self.origin);
    ent linkto(self);
    ent playloopsound("exp_heli_crash_loop");
    self util::waittill_any("death", "snd_impact");
    ent delete();
}

// Namespace vehicle_death
// Params 1, eflags: 0x0
// Checksum 0x360caf15, Offset: 0x1f48
// Size: 0x84
function helicopter_explode(delete_me) {
    self endon(#"death");
    self vehicle::do_death_fx();
    if (isdefined(delete_me) && delete_me == 1) {
        self delete();
    }
    self thread set_death_model(self.deathmodel, self.modelswapdelay);
}

// Namespace vehicle_death
// Params 2, eflags: 0x0
// Checksum 0xa1cbe6cd, Offset: 0x1fd8
// Size: 0x5a8
function aircraft_crash_move(point, dir) {
    self endon(#"crash_move_done");
    self endon(#"death");
    self thread crash_collision_test();
    self clearvehgoalpos();
    self cancelaimove();
    self setrotorspeed(0.2);
    if (isdefined(self) && isdefined(self.vehicletype)) {
        b_custom_deathmodel_setup = 1;
        switch (self.vehicletype) {
        default:
            b_custom_deathmodel_setup = 0;
            break;
        }
        if (b_custom_deathmodel_setup) {
            self.deathmodel_attached = 1;
        }
    }
    ang_vel = self getangularvelocity();
    ang_vel = (0, 0, 0);
    self setangularvelocity(ang_vel);
    nodes = self getvehicleavoidancenodes(10000);
    closest_index = -1;
    best_dist = 999999;
    if (nodes.size > 0) {
        for (i = 0; i < nodes.size; i++) {
            dir = vectornormalize(nodes[i] - self.origin);
            forward = anglestoforward(self.angles);
            dot = vectordot(dir, forward);
            if (dot < 0) {
                continue;
            }
            dist = distance2d(self.origin, nodes[i]);
            if (dist < best_dist) {
                best_dist = dist;
                closest_index = i;
            }
        }
        if (closest_index >= 0) {
            o = nodes[closest_index];
            o = (o[0], o[1], self.origin[2]);
            dir = vectornormalize(o - self.origin);
            self setvehvelocity(self.velocity + dir * 2000);
        } else {
            self setvehvelocity(self.velocity + anglestoright(self.angles) * randomintrange(-1000, 1000) + (0, 0, randomintrange(0, 1500)));
        }
    } else {
        self setvehvelocity(self.velocity + anglestoright(self.angles) * randomintrange(-1000, 1000) + (0, 0, randomintrange(0, 1500)));
    }
    self thread delay_set_gravity(randomfloatrange(1.5, 3));
    torque = (0, randomintrange(-90, 90), randomintrange(90, 720));
    if (randomint(100) < 50) {
        torque = (torque[0], torque[1], torque[2] * -1);
    }
    while (isdefined(self)) {
        ang_vel = self getangularvelocity();
        ang_vel += torque * 0.05;
        if (ang_vel[2] < 500 * -1) {
            ang_vel = (ang_vel[0], ang_vel[1], 500 * -1);
        } else if (ang_vel[2] > 500) {
            ang_vel = (ang_vel[0], ang_vel[1], 500);
        }
        self setangularvelocity(ang_vel);
        wait 0.05;
    }
}

// Namespace vehicle_death
// Params 1, eflags: 0x0
// Checksum 0x5cea5205, Offset: 0x2588
// Size: 0x74
function delay_set_gravity(delay) {
    self endon(#"crash_move_done");
    self endon(#"death");
    wait delay;
    self setphysacceleration((randomintrange(-1600, 1600), randomintrange(-1600, 1600), -1600));
}

// Namespace vehicle_death
// Params 2, eflags: 0x0
// Checksum 0x56026486, Offset: 0x2608
// Size: 0x378
function helicopter_crash_move(point, dir) {
    self endon(#"crash_move_done");
    self endon(#"death");
    self thread crash_collision_test();
    self cancelaimove();
    self clearvehgoalpos();
    self setturningability(0);
    self setphysacceleration((0, 0, -800));
    vel = self.velocity;
    dir = vectornormalize(dir);
    ang_vel = self getangularvelocity();
    ang_vel = (0, ang_vel[1] * randomfloatrange(1, 3), 0);
    self setangularvelocity(ang_vel);
    point_2d = (point[0], point[1], self.origin[2]);
    torque = (0, 720, 0);
    if (distance(self.origin, point_2d) > 5) {
        local_hit_point = point_2d - self.origin;
        dir_2d = (dir[0], dir[1], 0);
        if (length(dir_2d) > 0.01) {
            dir_2d = vectornormalize(dir_2d);
            torque = vectorcross(vectornormalize(local_hit_point), dir);
            torque = (0, 0, torque[2]);
            torque = vectornormalize(torque);
            torque = (0, torque[2] * -76, 0);
        }
    }
    while (true) {
        ang_vel = self getangularvelocity();
        ang_vel += torque * 0.05;
        if (ang_vel[1] < 360 * -1) {
            ang_vel = (ang_vel[0], 360 * -1, ang_vel[2]);
        } else if (ang_vel[1] > 360) {
            ang_vel = (ang_vel[0], 360, ang_vel[2]);
        }
        self setangularvelocity(ang_vel);
        wait 0.05;
    }
}

// Namespace vehicle_death
// Params 2, eflags: 0x0
// Checksum 0xfbe3ab51, Offset: 0x2988
// Size: 0x6c
function boat_crash(point, dir) {
    self.crashing = 1;
    if (isdefined(self.unloading)) {
        while (isdefined(self.unloading)) {
            wait 0.05;
        }
    }
    if (!isdefined(self)) {
        return;
    }
    self thread boat_crash_movement(point, dir);
}

// Namespace vehicle_death
// Params 2, eflags: 0x0
// Checksum 0xd69d1e48, Offset: 0x2a00
// Size: 0x2c0
function boat_crash_movement(point, dir) {
    self endon(#"crash_move_done");
    self endon(#"death");
    self cancelaimove();
    self clearvehgoalpos();
    self setphysacceleration((0, 0, -50));
    vel = self.velocity;
    dir = vectornormalize(dir);
    ang_vel = self getangularvelocity();
    ang_vel = (0, 0, 0);
    self setangularvelocity(ang_vel);
    torque = (randomintrange(-5, -3), 0, randomintrange(0, 100) < 50 ? -5 : 5);
    self thread boat_crash_monitor(point, dir, 4);
    while (true) {
        ang_vel = self getangularvelocity();
        ang_vel += torque * 0.05;
        if (ang_vel[1] < 360 * -1) {
            ang_vel = (ang_vel[0], 360 * -1, ang_vel[2]);
        } else if (ang_vel[1] > 360) {
            ang_vel = (ang_vel[0], 360, ang_vel[2]);
        }
        self setangularvelocity(ang_vel);
        velocity = self.velocity;
        velocity = (velocity[0] * 0.975, velocity[1], velocity[2]);
        velocity = (velocity[0], velocity[1] * 0.975, velocity[2]);
        self setvehvelocity(velocity);
        wait 0.05;
    }
}

// Namespace vehicle_death
// Params 3, eflags: 0x0
// Checksum 0xad262dea, Offset: 0x2cc8
// Size: 0x5a
function boat_crash_monitor(point, dir, crash_time) {
    self endon(#"death");
    wait crash_time;
    self notify(#"crash_move_done");
    self crash_stop();
    self notify(#"crash_done");
}

// Namespace vehicle_death
// Params 0, eflags: 0x0
// Checksum 0x5d209fc5, Offset: 0x2d30
// Size: 0x19c
function crash_stop() {
    self endon(#"death");
    self setphysacceleration((0, 0, 0));
    self setrotorspeed(0);
    speed = self getspeedmph();
    while (speed > 2) {
        velocity = self.velocity;
        velocity *= 0.9;
        self setvehvelocity(velocity);
        angular_velocity = self getangularvelocity();
        angular_velocity *= 0.9;
        self setangularvelocity(angular_velocity);
        speed = self getspeedmph();
        wait 0.05;
    }
    self setvehvelocity((0, 0, 0));
    self setangularvelocity((0, 0, 0));
    self vehicle::toggle_tread_fx(0);
    self vehicle::toggle_exhaust_fx(0);
    self vehicle::toggle_sounds(0);
}

// Namespace vehicle_death
// Params 0, eflags: 0x0
// Checksum 0x77e5cbfe, Offset: 0x2ed8
// Size: 0x15c
function crash_collision_test() {
    self endon(#"death");
    self waittill(#"veh_collision", velocity, normal);
    self helicopter_explode();
    self notify(#"crash_move_done");
    if (normal[2] > 0.7) {
        forward = anglestoforward(self.angles);
        right = vectorcross(normal, forward);
        desired_forward = vectorcross(right, normal);
        self setphysangles(vectortoangles(desired_forward));
        self crash_stop();
        self notify(#"crash_done");
        return;
    }
    wait 0.05;
    self delete();
}

// Namespace vehicle_death
// Params 1, eflags: 0x0
// Checksum 0x97b039a5, Offset: 0x3040
// Size: 0x1b2
function crash_path_check(node) {
    targ = node;
    for (search_depth = 5; isdefined(targ) && search_depth >= 0; search_depth--) {
        if (isdefined(targ.detoured) && targ.detoured == 0) {
            detourpath = vehicle::path_detour_get_detourpath(getvehiclenode(targ.target, "targetname"));
            if (isdefined(detourpath) && isdefined(detourpath.script_crashtype)) {
                return true;
            }
        }
        if (isdefined(targ.target)) {
            targ1 = getvehiclenode(targ.target, "targetname");
            if (isdefined(targ1) && isdefined(targ1.target) && isdefined(targ.targetname) && targ1.target == targ.targetname) {
                return false;
            } else if (isdefined(targ1) && targ1 == node) {
                return false;
            } else {
                targ = targ1;
            }
            continue;
        }
        targ = undefined;
    }
    return false;
}

// Namespace vehicle_death
// Params 1, eflags: 0x0
// Checksum 0x37dd2dab, Offset: 0x3200
// Size: 0x70
function death_firesound(sound) {
    self thread sound::loop_on_tag(sound, undefined, 0);
    self util::waittill_any("fire_extinguish", "stop_crash_loop_sound");
    if (!isdefined(self)) {
        return;
    }
    self notify("stop sound" + sound);
}

// Namespace vehicle_death
// Params 0, eflags: 0x0
// Checksum 0x99a681cf, Offset: 0x3278
// Size: 0x6c
function death_fx() {
    if (self vehicle::is_destructible()) {
        return;
    }
    self util::explode_notify_wrapper();
    if (isdefined(self.do_death_fx)) {
        self [[ self.do_death_fx ]]();
        return;
    }
    self vehicle::do_death_fx();
}

// Namespace vehicle_death
// Params 1, eflags: 0x0
// Checksum 0x8674df3e, Offset: 0x32f0
// Size: 0xa4
function death_make_badplace(type) {
    if (!isdefined(level.vehicle_death_badplace[type])) {
        return;
    }
    struct = level.vehicle_death_badplace[type];
    if (isdefined(struct.delay)) {
        wait struct.delay;
    }
    if (!isdefined(self)) {
        return;
    }
    badplace_box("vehicle_kill_badplace", struct.duration, self.origin, struct.radius, "all");
}

// Namespace vehicle_death
// Params 1, eflags: 0x0
// Checksum 0x9b380fa3, Offset: 0x33a0
// Size: 0x174
function death_jolt(type) {
    self endon(#"death");
    if (isdefined(self.ignore_death_jolt) && self.ignore_death_jolt) {
        return;
    }
    self joltbody(self.origin + (23, 33, 64), 3);
    if (isdefined(self.death_anim)) {
        self animscripted("death_anim", self.origin, self.angles, self.death_anim, "normal", generic%root, 1, 0);
        self waittillmatch(#"death_anim", "end");
        return;
    }
    if (self.isphysicsvehicle) {
        num_launch_multiplier = 1;
        if (isdefined(self.physicslaunchdeathscale)) {
            num_launch_multiplier = self.physicslaunchdeathscale;
        }
        self launchvehicle((0, 0, 180) * num_launch_multiplier, (randomfloatrange(5, 10), randomfloatrange(-5, 5), 0), 1, 0, 1);
    }
}

// Namespace vehicle_death
// Params 0, eflags: 0x0
// Checksum 0x5449791f, Offset: 0x3520
// Size: 0x20
function deathrollon() {
    if (self.health > 0) {
        self.rollingdeath = 1;
    }
}

// Namespace vehicle_death
// Params 0, eflags: 0x0
// Checksum 0x1b628b79, Offset: 0x3548
// Size: 0x1a
function deathrolloff() {
    self.rollingdeath = undefined;
    self notify(#"deathrolloff");
}

// Namespace vehicle_death
// Params 3, eflags: 0x0
// Checksum 0x1043dc4e, Offset: 0x3570
// Size: 0xbe
function loop_fx_on_vehicle_tag(effect, looptime, tag) {
    assert(isdefined(effect));
    assert(isdefined(tag));
    assert(isdefined(looptime));
    self endon(#"stop_looping_death_fx");
    while (isdefined(self)) {
        playfxontag(effect, deathfx_ent(), tag);
        wait looptime;
    }
}

// Namespace vehicle_death
// Params 0, eflags: 0x0
// Checksum 0xe7a1d4c, Offset: 0x3638
// Size: 0x12a
function deathfx_ent() {
    if (!isdefined(self.deathfx_ent)) {
        ent = spawn("script_model", (0, 0, 0));
        emodel = vehicle::get_dummy();
        ent setmodel(self.model);
        ent.origin = emodel.origin;
        ent.angles = emodel.angles;
        ent notsolid();
        ent hide();
        ent linkto(emodel);
        self.deathfx_ent = ent;
    } else {
        self.deathfx_ent setmodel(self.model);
    }
    return self.deathfx_ent;
}

// Namespace vehicle_death
// Params 0, eflags: 0x0
// Checksum 0x274ba33d, Offset: 0x3770
// Size: 0x12c
function death_cleanup_level_variables() {
    script_linkname = self.script_linkname;
    targetname = self.targetname;
    if (isdefined(script_linkname)) {
        arrayremovevalue(level.vehicle_link[script_linkname], self);
    }
    if (isdefined(self.script_vehiclespawngroup)) {
        if (isdefined(level.vehicle_spawngroup[self.script_vehiclespawngroup])) {
            arrayremovevalue(level.vehicle_spawngroup[self.script_vehiclespawngroup], self);
            arrayremovevalue(level.vehicle_spawngroup[self.script_vehiclespawngroup], undefined);
        }
    }
    if (isdefined(self.script_vehiclestartmove)) {
        arrayremovevalue(level.vehicle_startmovegroup[self.script_vehiclestartmove], self);
    }
    if (isdefined(self.script_vehiclegroupdelete)) {
        arrayremovevalue(level.vehicle_deletegroup[self.script_vehiclegroupdelete], self);
    }
}

// Namespace vehicle_death
// Params 0, eflags: 0x0
// Checksum 0xd35c1aca, Offset: 0x38a8
// Size: 0x90
function death_cleanup_riders() {
    if (isdefined(self.riders)) {
        for (j = 0; j < self.riders.size; j++) {
            if (isdefined(self.riders[j])) {
                self.riders[j] delete();
            }
        }
    }
    if (vehicle::is_corpse(self)) {
        self.riders = [];
    }
}

// Namespace vehicle_death
// Params 1, eflags: 0x0
// Checksum 0x65e7fa1d, Offset: 0x3940
// Size: 0x114
function death_radius_damage(meansofdamage) {
    if (!isdefined(meansofdamage)) {
        meansofdamage = "MOD_EXPLOSIVE";
    }
    self endon(#"death");
    if (!isdefined(self) || self.abandoned === 1 || self.damage_on_death === 0 || self.radiusdamageradius <= 0) {
        return;
    }
    position = self.origin + (0, 0, 15);
    radius = self.radiusdamageradius;
    damagemax = self.radiusdamagemax;
    damagemin = self.radiusdamagemin;
    attacker = self;
    wait 0.05;
    if (isdefined(self)) {
        self radiusdamage(position, radius, damagemax, damagemin, attacker, meansofdamage);
    }
}

// Namespace vehicle_death
// Params 2, eflags: 0x0
// Checksum 0xc1a92822, Offset: 0x3a60
// Size: 0x2f4
function death_update_crash(point, dir) {
    if (!isdefined(self.destructibledef)) {
        if (isdefined(self.script_crashtypeoverride)) {
            crashtype = self.script_crashtypeoverride;
        } else if (isdefined(self.vehicleclass) && self.vehicleclass == "plane") {
            crashtype = "aircraft";
        } else if (isdefined(self.vehicleclass) && self.vehicleclass == "helicopter") {
            crashtype = "helicopter";
        } else if (isdefined(self.vehicleclass) && self.vehicleclass == "boat") {
            crashtype = "boat";
        } else if (isdefined(self.currentnode) && crash_path_check(self.currentnode)) {
            crashtype = "none";
        } else {
            crashtype = "tank";
        }
        if (crashtype == "aircraft") {
            self thread aircraft_crash(point, dir);
            return;
        }
        if (crashtype == "helicopter") {
            if (isdefined(self.script_nocorpse)) {
                self thread helicopter_explode();
            } else {
                self thread helicopter_crash(point, dir);
            }
            return;
        }
        if (crashtype == "boat") {
            self thread boat_crash(point, dir);
            return;
        }
        if (crashtype == "tank") {
            if (!isdefined(self.rollingdeath)) {
                self vehicle::set_speed(0, 25, "Dead");
            } else {
                self waittill(#"deathrolloff");
                self vehicle::set_speed(0, 25, "Dead, finished path intersection");
            }
            wait 0.4;
            if (isdefined(self) && !vehicle::is_corpse(self)) {
                self vehicle::set_speed(0, 10000, "deadstop");
                self notify(#"deadstop");
                if (self.disconnectpathonstop === 1) {
                    self vehicle::disconnect_paths();
                }
                if (isdefined(self.tankgetout) && self.tankgetout > 0) {
                    self waittill(#"animsdone");
                }
            }
        }
    }
}

// Namespace vehicle_death
// Params 0, eflags: 0x0
// Checksum 0xe1b657a3, Offset: 0x3d60
// Size: 0x180
function waittill_crash_done_or_stopped() {
    self endon(#"death");
    if (isdefined(self.vehicleclass) && (isdefined(self.vehicleclass) && self.vehicleclass == "plane" || isdefined(self) && self.vehicleclass == "boat")) {
        if (isdefined(self.crashing) && self.crashing == 1) {
            self waittill(#"crash_done");
        }
        return;
    }
    wait 0.2;
    if (self.isphysicsvehicle) {
        self clearvehgoalpos();
        self cancelaimove();
        stable_count = 0;
        while (stable_count < 3) {
            if (isdefined(self.velocity) && lengthsquared(self.velocity) > 1) {
                stable_count = 0;
            } else {
                stable_count++;
            }
            wait 0.3;
        }
        self vehicle::disconnect_paths();
        return;
    }
    while (isdefined(self) && self getspeedmph() > 0) {
        wait 0.3;
    }
}

// Namespace vehicle_death
// Params 2, eflags: 0x0
// Checksum 0xb9c422e9, Offset: 0x3ee8
// Size: 0x1ac
function vehicle_damage_filter_damage_watcher(driver, heavy_damage_threshold) {
    self endon(#"death");
    self endon(#"exit_vehicle");
    self endon(#"end_damage_filter");
    if (!isdefined(heavy_damage_threshold)) {
        heavy_damage_threshold = 100;
    }
    while (true) {
        self waittill(#"damage", damage, attacker, direction, point, type, tagname, modelname, partname, weapon);
        earthquake(0.25, 0.15, self.origin, 512, self);
        driver playrumbleonentity("damage_light");
        time = gettime();
        if (time - level.n_last_damage_time > 500) {
            level.n_hud_damage = 1;
            if (damage > heavy_damage_threshold) {
                driver playsound("veh_damage_filter_heavy");
            } else {
                driver playsound("veh_damage_filter_light");
            }
            level.n_last_damage_time = gettime();
        }
    }
}

// Namespace vehicle_death
// Params 1, eflags: 0x0
// Checksum 0x87bd53c7, Offset: 0x40a0
// Size: 0x3c
function vehicle_damage_filter_exit_watcher(driver) {
    self util::waittill_any("exit_vehicle", "death", "end_damage_filter");
}

// Namespace vehicle_death
// Params 4, eflags: 0x0
// Checksum 0x7743d4cb, Offset: 0x40e8
// Size: 0x188
function vehicle_damage_filter(vision_set, heavy_damage_threshold, filterid, b_use_player_damage) {
    if (!isdefined(filterid)) {
        filterid = 0;
    }
    if (!isdefined(b_use_player_damage)) {
        b_use_player_damage = 0;
    }
    self endon(#"death");
    self endon(#"exit_vehicle");
    self endon(#"end_damage_filter");
    driver = self getseatoccupant(0);
    if (!isdefined(self.damage_filter_init)) {
        self.damage_filter_init = 1;
    }
    if (isdefined(vision_set)) {
    }
    level.n_hud_damage = 0;
    level.n_last_damage_time = gettime();
    damagee = isdefined(b_use_player_damage) && b_use_player_damage ? driver : self;
    damagee thread vehicle_damage_filter_damage_watcher(driver, heavy_damage_threshold);
    damagee thread vehicle_damage_filter_exit_watcher(driver);
    while (true) {
        if (isdefined(level.n_hud_damage) && level.n_hud_damage) {
            time = gettime();
            if (time - level.n_last_damage_time > 500) {
                level.n_hud_damage = 0;
            }
        }
        wait 0.05;
    }
}

// Namespace vehicle_death
// Params 2, eflags: 0x0
// Checksum 0x5430d41c, Offset: 0x4278
// Size: 0x19c
function flipping_shooting_death(attacker, hitdir) {
    if (isdefined(self.delete_on_death)) {
        if (isdefined(self)) {
            self delete();
        }
        return;
    }
    if (!isdefined(self)) {
        return;
    }
    self endon(#"death");
    self death_cleanup_level_variables();
    self disableaimassist();
    self death_fx();
    self thread death_radius_damage();
    self thread set_death_model(self.deathmodel, self.modelswapdelay);
    self vehicle::toggle_tread_fx(0);
    self vehicle::toggle_exhaust_fx(0);
    self vehicle::toggle_sounds(0);
    self vehicle::lights_off();
    self thread flipping_shooting_crash_movement(attacker, hitdir);
    self waittill(#"crash_done");
    while (isdefined(self.controlled) && self.controlled) {
        wait 0.05;
    }
    self delete();
}

// Namespace vehicle_death
// Params 0, eflags: 0x0
// Checksum 0x41e158cd, Offset: 0x4420
// Size: 0x28c
function plane_crash() {
    self endon(#"death");
    self setphysacceleration((0, 0, -1000));
    self.vehcheckforpredictedcrash = 1;
    forward = anglestoforward(self.angles);
    forward_mag = randomfloatrange(0, 300);
    forward_mag += math::sign(forward_mag) * 400;
    forward *= forward_mag;
    new_vel = forward + self.velocity * 0.2;
    ang_vel = self getangularvelocity();
    yaw_vel = randomfloatrange(0, -126) * math::sign(ang_vel[1]);
    yaw_vel += math::sign(yaw_vel) * 20;
    ang_vel = (randomfloatrange(-1, 1), yaw_vel, 0);
    roll_amount = abs(ang_vel[1]) / 150 * 30;
    if (ang_vel[1] > 0) {
        roll_amount *= -1;
    }
    self.angles = (self.angles[0], self.angles[1], roll_amount);
    ang_vel = (ang_vel[0], ang_vel[1], roll_amount * 0.9);
    self.velocity_rotation_frac = 1;
    self.crash_accel = randomfloatrange(65, 90);
    set_movement_and_accel(new_vel, ang_vel);
}

// Namespace vehicle_death
// Params 0, eflags: 0x0
// Checksum 0xd0997231, Offset: 0x46b8
// Size: 0x24c
function barrel_rolling_crash() {
    self endon(#"death");
    self setphysacceleration((0, 0, -1000));
    self.vehcheckforpredictedcrash = 1;
    forward = anglestoforward(self.angles);
    forward_mag = randomfloatrange(0, -6);
    forward_mag += math::sign(forward_mag) * 300;
    forward *= forward_mag;
    new_vel = forward + (0, 0, 70);
    ang_vel = self getangularvelocity();
    yaw_vel = randomfloatrange(0, 60) * math::sign(ang_vel[1]);
    yaw_vel += math::sign(yaw_vel) * 30;
    roll_vel = randomfloatrange(-200, -56);
    roll_vel += math::sign(roll_vel) * 300;
    ang_vel = (randomfloatrange(-5, 5), yaw_vel, roll_vel);
    self.velocity_rotation_frac = 1;
    self.crash_accel = randomfloatrange(-111, -46);
    self setphysacceleration((0, 0, -250));
    set_movement_and_accel(new_vel, ang_vel);
}

// Namespace vehicle_death
// Params 1, eflags: 0x0
// Checksum 0x7325c797, Offset: 0x4910
// Size: 0x31c
function random_crash(hitdir) {
    self endon(#"death");
    self setphysacceleration((0, 0, -1000));
    self.vehcheckforpredictedcrash = 1;
    if (!isdefined(hitdir)) {
        hitdir = (1, 0, 0);
    }
    hitdir = vectornormalize(hitdir);
    side_dir = vectorcross(hitdir, (0, 0, 1));
    side_dir_mag = randomfloatrange(-280, 280);
    side_dir_mag += math::sign(side_dir_mag) * -106;
    side_dir *= side_dir_mag;
    forward = anglestoforward(self.angles);
    forward_mag = randomfloatrange(0, 300);
    forward_mag += math::sign(forward_mag) * 30;
    forward *= forward_mag;
    new_vel = self.velocity * 1.2 + forward + side_dir + (0, 0, 50);
    ang_vel = self getangularvelocity();
    ang_vel = (ang_vel[0] * 0.3, ang_vel[1], ang_vel[2] * 1.2);
    yaw_vel = randomfloatrange(0, -126) * math::sign(ang_vel[1]);
    yaw_vel += math::sign(yaw_vel) * 50;
    ang_vel += (randomfloatrange(-5, 5), yaw_vel, randomfloatrange(-18, 18));
    self.velocity_rotation_frac = randomfloatrange(0.3, 0.99);
    self.crash_accel = randomfloatrange(65, 90);
    set_movement_and_accel(new_vel, ang_vel);
}

// Namespace vehicle_death
// Params 2, eflags: 0x0
// Checksum 0x4b3e7008, Offset: 0x4c38
// Size: 0x20e
function set_movement_and_accel(new_vel, ang_vel) {
    self death_fx();
    self thread death_radius_damage();
    self setvehvelocity(new_vel);
    self setangularvelocity(ang_vel);
    if (!isdefined(self.off)) {
        self thread flipping_shooting_crash_accel();
    }
    self thread vehicle_ai::nudge_collision();
    self playsound("veh_wasp_dmg_hit");
    self vehicle::toggle_sounds(0);
    if (!isdefined(self.off)) {
        self thread flipping_shooting_dmg_snd();
    }
    wait 0.1;
    if (randomint(100) < 40 && !isdefined(self.off) && self.variant !== "rocket") {
        self thread vehicle_ai::fire_for_time(randomfloatrange(0.7, 2));
    }
    result = self util::waittill_any_timeout(15, "crash_done");
    if (result === "crash_done") {
        self vehicle::do_death_dynents();
        self set_death_model(self.deathmodel, self.modelswapdelay);
        return;
    }
    self notify(#"crash_done");
}

// Namespace vehicle_death
// Params 2, eflags: 0x0
// Checksum 0xaad4f63d, Offset: 0x4e50
// Size: 0x19a
function flipping_shooting_crash_movement(attacker, hitdir) {
    self endon(#"crash_done");
    self endon(#"death");
    self cancelaimove();
    self clearvehgoalpos();
    self clearlookatent();
    self setphysacceleration((0, 0, -1000));
    self.vehcheckforpredictedcrash = 1;
    if (!isdefined(hitdir)) {
        hitdir = (1, 0, 0);
    }
    hitdir = vectornormalize(hitdir);
    new_vel = self.velocity;
    self.crash_style = getdvarint("debug_crash_type");
    if (self.crash_style == -1) {
        self.crash_style = randomint(3);
    }
    switch (self.crash_style) {
    case 0:
        barrel_rolling_crash();
        break;
    case 1:
        plane_crash();
        break;
    default:
        random_crash(hitdir);
        break;
    }
}

// Namespace vehicle_death
// Params 0, eflags: 0x0
// Checksum 0x3cbae300, Offset: 0x4ff8
// Size: 0xcc
function flipping_shooting_dmg_snd() {
    dmg_ent = spawn("script_origin", self.origin);
    dmg_ent linkto(self);
    dmg_ent playloopsound("veh_wasp_dmg_loop");
    self util::waittill_any("crash_done", "death");
    dmg_ent stoploopsound(1);
    wait 2;
    dmg_ent delete();
}

// Namespace vehicle_death
// Params 0, eflags: 0x0
// Checksum 0x41466a4e, Offset: 0x50d0
// Size: 0x300
function flipping_shooting_crash_accel() {
    self endon(#"crash_done");
    self endon(#"death");
    count = 0;
    prev_forward = anglestoforward(self.angles);
    prev_forward_vel = vectordot(self.velocity, prev_forward) * self.velocity_rotation_frac;
    if (prev_forward_vel < 0) {
        prev_forward_vel = 0;
    }
    while (true) {
        self setvehvelocity(self.velocity + anglestoup(self.angles) * self.crash_accel);
        self.crash_accel *= 0.98;
        new_velocity = self.velocity;
        new_velocity -= prev_forward * prev_forward_vel;
        forward = anglestoforward(self.angles);
        new_velocity += forward * prev_forward_vel;
        prev_forward = forward;
        prev_forward_vel = vectordot(new_velocity, prev_forward) * self.velocity_rotation_frac;
        if (prev_forward_vel < 10) {
            new_velocity += forward * 40;
            prev_forward_vel = 0;
        }
        self setvehvelocity(new_velocity);
        wait 0.1;
        count++;
        if (count % 8 == 0 && randomint(100) > 40) {
            if (self.velocity[2] > 130) {
                self.crash_accel *= 0.75;
                continue;
            }
            if (self.velocity[2] < 40 && count < 60) {
                if (abs(self.angles[0]) > 35 || abs(self.angles[2]) > 35) {
                    self.crash_accel = randomfloatrange(100, -106);
                    continue;
                }
                self.crash_accel = randomfloatrange(45, 70);
            }
        }
    }
}

// Namespace vehicle_death
// Params 0, eflags: 0x0
// Checksum 0xec5f4fe7, Offset: 0x53d8
// Size: 0x8c
function death_fire_loop_audio() {
    sound_ent = spawn("script_origin", self.origin);
    sound_ent playloopsound("veh_qrdrone_death_fire_loop", 0.1);
    wait 11;
    sound_ent stoploopsound(1);
    sound_ent delete();
}

// Namespace vehicle_death
// Params 1, eflags: 0x0
// Checksum 0x4091733c, Offset: 0x5470
// Size: 0x3c
function freewhensafe(time) {
    if (!isdefined(time)) {
        time = 4;
    }
    self thread delayedremove_thread(time, 0);
}

// Namespace vehicle_death
// Params 1, eflags: 0x0
// Checksum 0x884277c2, Offset: 0x54b8
// Size: 0x3c
function deletewhensafe(time) {
    if (!isdefined(time)) {
        time = 4;
    }
    self thread delayedremove_thread(time, 1);
}

// Namespace vehicle_death
// Params 2, eflags: 0x0
// Checksum 0xc9daef3b, Offset: 0x5500
// Size: 0xdc
function delayedremove_thread(time, shoulddelete) {
    if (!isdefined(self)) {
        return;
    }
    self endon(#"death");
    self endon(#"free_vehicle");
    if (shoulddelete === 1) {
        self setvehvelocity((0, 0, 0));
        self ghost();
        self notsolid();
    }
    util::waitfortimeandnetworkframe(time);
    if (shoulddelete === 1) {
        self delete();
        return;
    }
    self freevehicle();
}

// Namespace vehicle_death
// Params 0, eflags: 0x0
// Checksum 0x6da5e86a, Offset: 0x55e8
// Size: 0x34
function cleanup() {
    if (isdefined(self.cleanup_after_time)) {
        wait self.cleanup_after_time;
        if (isdefined(self)) {
            self delete();
        }
    }
}

