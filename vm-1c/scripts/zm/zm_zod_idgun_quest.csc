#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_load;

#using_animtree("generic");

#namespace zm_zod_idgun_quest;

// Namespace zm_zod_idgun_quest
// Params 0, eflags: 0x2
// Checksum 0x826f946, Offset: 0x188
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_zod_idgun_quest", &__init__, undefined, undefined);
}

// Namespace zm_zod_idgun_quest
// Params 0, eflags: 0x0
// Checksum 0x57843b39, Offset: 0x1c8
// Size: 0x94
function __init__() {
    clientfield::register("world", "add_idgun_to_box", 1, 4, "int", &add_idgun_to_box, 0, 0);
    clientfield::register("world", "remove_idgun_from_box", 1, 4, "int", &remove_idgun_from_box, 0, 0);
}

// Namespace zm_zod_idgun_quest
// Params 7, eflags: 0x0
// Checksum 0x849db830, Offset: 0x268
// Size: 0x9c
function add_idgun_to_box(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_3262a5f7 = getweapon("idgun" + "_" + newval);
    addzombieboxweapon(var_3262a5f7, var_3262a5f7.worldmodel, var_3262a5f7.isdualwield);
}

// Namespace zm_zod_idgun_quest
// Params 7, eflags: 0x0
// Checksum 0xd392ff6, Offset: 0x310
// Size: 0x84
function remove_idgun_from_box(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_3262a5f7 = getweapon("idgun" + "_" + newval);
    removezombieboxweapon(var_3262a5f7);
}

