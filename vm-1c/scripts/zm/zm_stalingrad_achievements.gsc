#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace zm_stalingrad_achievements;

// Namespace zm_stalingrad_achievements
// Params 0, eflags: 0x2
// Checksum 0x585fce64, Offset: 0x238
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_stalingrad_achievements", &__init__, undefined, undefined);
}

// Namespace zm_stalingrad_achievements
// Params 0, eflags: 0x0
// Checksum 0xea67b9d9, Offset: 0x278
// Size: 0x54
function __init__() {
    level thread function_73d8758f();
    level thread function_42b2ae41();
    callback::on_connect(&on_player_connect);
}

// Namespace zm_stalingrad_achievements
// Params 0, eflags: 0x0
// Checksum 0xa6044a79, Offset: 0x2d8
// Size: 0xc4
function on_player_connect() {
    self thread function_69021ea7();
    self thread function_35e5c39b();
    self thread function_68cad44c();
    self thread function_77f84ddb();
    self thread function_3a3c9cc6();
    self thread function_b6e817dd();
    self thread function_bdcf8e90();
    self thread function_54dbe534();
}

// Namespace zm_stalingrad_achievements
// Params 0, eflags: 0x0
// Checksum 0xa321952e, Offset: 0x3a8
// Size: 0x44
function function_73d8758f() {
    level waittill(#"hash_c1471acf");
    array::run_all(level.players, &giveachievement, "ZM_STALINGRAD_NIKOLAI");
}

// Namespace zm_stalingrad_achievements
// Params 0, eflags: 0x0
// Checksum 0xbeb66235, Offset: 0x3f8
// Size: 0x3c
function function_69021ea7() {
    self endon(#"death");
    self waittill(#"hash_4e21f047");
    self giveachievement("ZM_STALINGRAD_WIELD_DRAGON");
}

// Namespace zm_stalingrad_achievements
// Params 0, eflags: 0x0
// Checksum 0x367d7c03, Offset: 0x440
// Size: 0x44
function function_42b2ae41() {
    level waittill(#"hash_399599c1");
    array::run_all(level.players, &giveachievement, "ZM_STALINGRAD_TWENTY_ROUNDS");
}

// Namespace zm_stalingrad_achievements
// Params 0, eflags: 0x0
// Checksum 0x3c8fa777, Offset: 0x490
// Size: 0x3c
function function_35e5c39b() {
    self endon(#"death");
    self waittill(#"hash_2e47bc4a");
    self giveachievement("ZM_STALINGRAD_RIDE_DRAGON");
}

// Namespace zm_stalingrad_achievements
// Params 0, eflags: 0x0
// Checksum 0xdc7c9333, Offset: 0x4d8
// Size: 0x3c
function function_68cad44c() {
    self endon(#"death");
    self waittill(#"hash_1d89afbc");
    self giveachievement("ZM_STALINGRAD_LOCKDOWN");
}

// Namespace zm_stalingrad_achievements
// Params 0, eflags: 0x0
// Checksum 0xbc007367, Offset: 0x520
// Size: 0x3c
function function_77f84ddb() {
    self endon(#"death");
    self waittill(#"hash_41370469");
    self giveachievement("ZM_STALINGRAD_SOLO_TRIALS");
}

// Namespace zm_stalingrad_achievements
// Params 0, eflags: 0x0
// Checksum 0xbc451b59, Offset: 0x568
// Size: 0x6a
function function_3a3c9cc6() {
    self endon(#"death");
    while (true) {
        self waittill(#"hash_c925c266", n_kill_count);
        if (n_kill_count >= 20) {
            self giveachievement("ZM_STALINGRAD_BEAM_KILL");
            return;
        }
    }
}

// Namespace zm_stalingrad_achievements
// Params 0, eflags: 0x0
// Checksum 0x45cca3b4, Offset: 0x5e0
// Size: 0x6a
function function_b6e817dd() {
    self endon(#"death");
    while (true) {
        self waittill(#"hash_ddb84fad", n_kill_count);
        if (n_kill_count >= 8) {
            self giveachievement("ZM_STALINGRAD_STRIKE_DRAGON");
            return;
        }
    }
}

// Namespace zm_stalingrad_achievements
// Params 0, eflags: 0x0
// Checksum 0x8b84fe90, Offset: 0x658
// Size: 0x6a
function function_bdcf8e90() {
    self endon(#"death");
    while (true) {
        self waittill(#"hash_8c80a390", n_kill_count);
        if (n_kill_count >= 10) {
            self giveachievement("ZM_STALINGRAD_FAFNIR_KILL");
            return;
        }
    }
}

// Namespace zm_stalingrad_achievements
// Params 0, eflags: 0x0
// Checksum 0xb2e9eacd, Offset: 0x6d0
// Size: 0x3c
function function_54dbe534() {
    self thread function_99a5ed1a(10);
    self thread function_60593db9(10);
}

// Namespace zm_stalingrad_achievements
// Params 1, eflags: 0x0
// Checksum 0xb42d02c0, Offset: 0x718
// Size: 0x7e
function function_99a5ed1a(n_target_kills) {
    self endon(#"death");
    self endon(#"hash_c43b59a6");
    while (true) {
        self waittill(#"hash_e442448", n_kill_count);
        if (n_kill_count >= n_target_kills) {
            self giveachievement("ZM_STALINGRAD_AIR_ZOMBIES");
            self notify(#"hash_c43b59a6");
        }
    }
}

// Namespace zm_stalingrad_achievements
// Params 1, eflags: 0x0
// Checksum 0xf2cc378b, Offset: 0x7a0
// Size: 0x7e
function function_60593db9(n_target_kills) {
    self endon(#"death");
    self endon(#"hash_c43b59a6");
    while (true) {
        self waittill(#"hash_f7608efe", n_kill_count);
        if (n_kill_count >= n_target_kills) {
            self giveachievement("ZM_STALINGRAD_AIR_ZOMBIES");
            self notify(#"hash_c43b59a6");
        }
    }
}

