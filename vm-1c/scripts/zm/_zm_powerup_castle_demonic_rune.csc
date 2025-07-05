#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/zm/_zm_powerups;

#namespace zm_powerup_demonic_rune;

// Namespace zm_powerup_demonic_rune
// Params 0, eflags: 0x2
// Checksum 0xd7ff5007, Offset: 0x1d0
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_powerup_demonic_rune", &__init__, undefined, undefined);
}

// Namespace zm_powerup_demonic_rune
// Params 0, eflags: 0x0
// Checksum 0xe4ced1f7, Offset: 0x210
// Size: 0x16c
function __init__() {
    clientfield::register("scriptmover", "demonic_rune_fx", 5000, 1, "int", &function_4a94c040, 0, 0);
    zm_powerups::include_zombie_powerup("demonic_rune_lor");
    zm_powerups::add_zombie_powerup("demonic_rune_lor");
    zm_powerups::include_zombie_powerup("demonic_rune_ulla");
    zm_powerups::add_zombie_powerup("demonic_rune_ulla");
    zm_powerups::include_zombie_powerup("demonic_rune_oth");
    zm_powerups::add_zombie_powerup("demonic_rune_oth");
    zm_powerups::include_zombie_powerup("demonic_rune_zor");
    zm_powerups::add_zombie_powerup("demonic_rune_zor");
    zm_powerups::include_zombie_powerup("demonic_rune_mar");
    zm_powerups::add_zombie_powerup("demonic_rune_mar");
    zm_powerups::include_zombie_powerup("demonic_rune_uja");
    zm_powerups::add_zombie_powerup("demonic_rune_uja");
}

// Namespace zm_powerup_demonic_rune
// Params 7, eflags: 0x0
// Checksum 0x50a77ded, Offset: 0x388
// Size: 0x6c
function function_4a94c040(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        playfxontag(localclientnum, "dlc1/castle/fx_demon_gate_rune_glow", self, "tag_origin");
    }
}

