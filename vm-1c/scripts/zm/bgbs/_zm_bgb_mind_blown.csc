#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_utility;

#namespace zm_bgb_mind_blown;

// Namespace zm_bgb_mind_blown
// Params 0, eflags: 0x2
// Checksum 0xc885ac39, Offset: 0x218
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_bgb_mind_blown", &__init__, undefined, undefined);
}

// Namespace zm_bgb_mind_blown
// Params 0, eflags: 0x0
// Checksum 0x1380574b, Offset: 0x258
// Size: 0xcc
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    clientfield::register("actor", "zm_bgb_mind_pop_fx", 15000, 1, "int", &function_f10358c6, 0, 0);
    clientfield::register("actor", "zm_bgb_mind_ray_fx", 15000, 1, "int", &function_57f7c3a1, 0, 0);
    bgb::register("zm_bgb_mind_blown", "activated");
}

// Namespace zm_bgb_mind_blown
// Params 7, eflags: 0x0
// Checksum 0x7cb530b7, Offset: 0x330
// Size: 0xd4
function function_57f7c3a1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playsound(0, "zmb_bgb_mindblown_start", self gettagorigin("j_neck"));
    self.var_f40a5f31 = playfxontag(localclientnum, "zombie/fx_bgb_head_pop_ray", self, "j_neck");
    self.var_bbd257f7 = playfxontag(localclientnum, "dlc4/genesis/fx_bgb_mindblown_heatup", self, "j_spine4");
}

// Namespace zm_bgb_mind_blown
// Params 7, eflags: 0x0
// Checksum 0x4e4097de, Offset: 0x410
// Size: 0xb4
function function_f10358c6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self.var_f40a5f31)) {
        killfx(localclientnum, self.var_f40a5f31);
    }
    if (isdefined(self.var_bbd257f7)) {
        stopfx(localclientnum, self.var_bbd257f7);
    }
    playfxontag(localclientnum, "zombie/fx_bgb_head_pop", self, "j_neck");
}

