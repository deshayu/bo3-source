#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace cp_mi_cairo_ramses_utility;

// Namespace cp_mi_cairo_ramses_utility
// Params 0, eflags: 0x2
// Checksum 0xd939f113, Offset: 0x208
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("ramses_util", &__init__, undefined, undefined);
}

// Namespace cp_mi_cairo_ramses_utility
// Params 0, eflags: 0x0
// Checksum 0x83d10330, Offset: 0x240
// Size: 0xaa
function __init__() {
    clientfield::register("toplayer", "ramses_sun_color", 1, 1, "int", &function_93fe9aa, 0, 0);
    clientfield::register("toplayer", "dni_eye", 1, 1, "int", &function_1561b96d, 1, 0);
    clientfield::register("scriptmover", "hide_graphic_content", 1, 1, "counter", &function_1edfa950, 0, 0);
}

// Namespace cp_mi_cairo_ramses_utility
// Params 7, eflags: 0x0
// Checksum 0xa7a583a3, Offset: 0x2f8
// Size: 0x92
function function_93fe9aa(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        setdvar("r_sunTweak", 1);
        setdvar("r_sunColor", "1 0.8549 0.6235 1");
        return;
    }
    setdvar("r_sunTweak", 0);
}

// Namespace cp_mi_cairo_ramses_utility
// Params 7, eflags: 0x0
// Checksum 0xe5aa2ee9, Offset: 0x398
// Size: 0x82
function function_1561b96d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self mapshaderconstant(localclientnum, 0, "scriptVector0", 0, 1, 0, 0);
        return;
    }
    self mapshaderconstant(localclientnum, 0, "scriptVector0", 0, 0, 0, 0);
}

// Namespace cp_mi_cairo_ramses_utility
// Params 7, eflags: 0x0
// Checksum 0xfb5cb046, Offset: 0x428
// Size: 0x62
function function_1edfa950(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (util::is_gib_restricted_build()) {
        if (newval == 1) {
            self hide();
        }
    }
}

