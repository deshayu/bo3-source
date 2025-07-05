#using scripts/codescripts/struct;
#using scripts/shared/audio_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_filter;

#namespace zm_castle_tram;

// Namespace zm_castle_tram
// Params 0, eflags: 0x2
// Checksum 0xb3d00fdf, Offset: 0x278
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_castle_tram", &__init__, undefined, undefined);
}

// Namespace zm_castle_tram
// Params 0, eflags: 0x0
// Checksum 0xe0202e89, Offset: 0x2b8
// Size: 0x174
function __init__() {
    level._effect["tram_fuse_destroy"] = "dlc1/castle/fx_glow_115_fuse_burst_castle";
    level._effect["tram_fuse_fx"] = "dlc1/castle/fx_glow_115_fuse_castle";
    clientfield::register("scriptmover", "tram_fuse_destroy", 1, 1, "counter", &tram_fuse_destroy, 0, 0);
    clientfield::register("scriptmover", "tram_fuse_fx", 1, 1, "counter", &function_1383302a, 0, 0);
    clientfield::register("scriptmover", "cleanup_dynents", 1, 1, "counter", &function_8a2bbd06, 0, 0);
    clientfield::register("world", "snd_tram", 5000, 2, "int", &snd_tram, 0, 0);
    thread function_58a73de9();
    thread function_60283937();
}

// Namespace zm_castle_tram
// Params 7, eflags: 0x0
// Checksum 0x3a75998a, Offset: 0x438
// Size: 0x5c
function function_b84c3341(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self thread function_19082f83();
    }
}

// Namespace zm_castle_tram
// Params 0, eflags: 0x0
// Checksum 0x162940b6, Offset: 0x4a0
// Size: 0x84
function function_19082f83() {
    self endon(#"entityshutdown");
    self function_2d89f1a7(7.5, 0.5);
    self function_2d89f1a7(2.5, 0.25);
    self function_2d89f1a7(1.5, 0.1);
}

// Namespace zm_castle_tram
// Params 2, eflags: 0x0
// Checksum 0x9caa2046, Offset: 0x530
// Size: 0xa4
function function_2d89f1a7(var_e2026f3a, var_a97a56af) {
    self endon(#"entityshutdown");
    n_counter = 0;
    n_timer = 0;
    while (n_timer < var_e2026f3a) {
        if (n_counter % 2) {
            self show();
        } else {
            self hide();
        }
        wait var_a97a56af;
        n_timer += var_a97a56af;
        n_counter++;
    }
}

// Namespace zm_castle_tram
// Params 7, eflags: 0x0
// Checksum 0x13841580, Offset: 0x5e0
// Size: 0x74
function function_1383302a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self.tram_fuse_fx = playfxontag(localclientnum, level._effect["tram_fuse_fx"], self, "j_fuse_main");
}

// Namespace zm_castle_tram
// Params 7, eflags: 0x0
// Checksum 0x9bd35b3a, Offset: 0x660
// Size: 0xa4
function tram_fuse_destroy(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self.tram_fuse_fx)) {
        deletefx(localclientnum, self.tram_fuse_fx, 1);
        self.tram_fuse_fx = undefined;
    }
    playfxontag(localclientnum, level._effect["tram_fuse_destroy"], self, "j_fuse_main");
}

// Namespace zm_castle_tram
// Params 7, eflags: 0x0
// Checksum 0xcbf25b09, Offset: 0x710
// Size: 0x2da
function snd_tram(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (newval == 1) {
            playsound(0, "evt_tram_motor_start", (342, 979, -121));
            foreach (location in level.var_4ea0a9e6) {
                audio::playloopat("evt_tram_pulley_large_loop", location);
            }
            foreach (location in level.var_a49222f2) {
                audio::playloopat("evt_tram_pulley_small_loop", location);
            }
        }
        if (newval == 2) {
            playsound(0, "evt_tram_motor_stop", (342, 979, -121));
            foreach (location in level.var_4ea0a9e6) {
                audio::stoploopat("evt_tram_pulley_large_loop", location);
            }
            foreach (location in level.var_a49222f2) {
                audio::stoploopat("evt_tram_pulley_small_loop", location);
            }
        }
    }
}

// Namespace zm_castle_tram
// Params 0, eflags: 0x0
// Checksum 0xb1f8a7d8, Offset: 0x9f8
// Size: 0x84
function function_58a73de9() {
    level.var_4ea0a9e6 = array((-97, 999, 265), (276, 1186, 264), (511, 1077, 264));
    level.var_a49222f2 = array((273, 431, -14), (603, 499, -18));
}

// Namespace zm_castle_tram
// Params 0, eflags: 0x0
// Checksum 0x22eddf39, Offset: 0xa88
// Size: 0x90
function function_60283937() {
    while (true) {
        level waittill(#"hash_dc18b3bb", duration);
        if (duration == "long") {
            playsound(0, "evt_tram_motor_long", (342, 979, -121));
            continue;
        }
        playsound(0, "evt_tram_motor_short", (342, 979, -121));
    }
}

// Namespace zm_castle_tram
// Params 7, eflags: 0x0
// Checksum 0x12c754a6, Offset: 0xb20
// Size: 0x4c
function function_8a2bbd06(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    cleanupspawneddynents();
}

