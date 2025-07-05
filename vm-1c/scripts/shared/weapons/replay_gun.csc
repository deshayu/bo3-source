#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/filter_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace replay_gun;

// Namespace replay_gun
// Params 0, eflags: 0x2
// Checksum 0x2fa347fc, Offset: 0x1c0
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("replay_gun", &__init__, undefined, undefined);
}

// Namespace replay_gun
// Params 0, eflags: 0x0
// Checksum 0xc7683596, Offset: 0x200
// Size: 0x4c
function __init__() {
    level thread player_init();
    duplicate_render::set_dr_filter_offscreen("replay", 75, "replay_locked", undefined, 2, "mc/hud_outline_model_red", 0);
}

// Namespace replay_gun
// Params 0, eflags: 0x0
// Checksum 0x22f3e668, Offset: 0x258
// Size: 0xc2
function player_init() {
    util::waitforclient(0);
    players = getlocalplayers();
    foreach (player in players) {
        player thread watch_lockon(0);
    }
}

// Namespace replay_gun
// Params 1, eflags: 0x0
// Checksum 0xd0edc5dc, Offset: 0x328
// Size: 0x176
function watch_lockon(localclientnum) {
    while (true) {
        self waittill(#"lockon_changed", state, target);
        if (!isdefined(target) || isdefined(self.replay_lock) && self.replay_lock != target) {
            self.replay_lock duplicate_render::change_dr_flags(localclientnum, undefined, "replay_locked");
            self.replay_lock = undefined;
        }
        if ((target isplayer() || isdefined(target) && target isai()) && isalive(target)) {
            switch (state) {
            case 0:
            case 1:
            case 3:
                target duplicate_render::change_dr_flags(localclientnum, undefined, "replay_locked");
                break;
            case 2:
            case 4:
                target duplicate_render::change_dr_flags(localclientnum, "replay_locked", undefined);
                self.replay_lock = target;
                break;
            }
        }
    }
}

