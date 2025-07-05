#using scripts/codescripts/struct;
#using scripts/shared/system_shared;
#using scripts/zm/_zm_powerups;

#namespace zm_powerup_beast_mana;

// Namespace zm_powerup_beast_mana
// Params 0, eflags: 0x2
// Checksum 0x6ec27e63, Offset: 0xf8
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_powerup_beast_mana", &__init__, undefined, undefined);
}

// Namespace zm_powerup_beast_mana
// Params 0, eflags: 0x0
// Checksum 0xa44738f2, Offset: 0x138
// Size: 0x34
function __init__() {
    zm_powerups::include_zombie_powerup("beast_mana");
    zm_powerups::add_zombie_powerup("beast_mana");
}

