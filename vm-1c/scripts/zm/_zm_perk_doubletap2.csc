#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_zm_perks;

#namespace zm_perk_doubletap2;

// Namespace zm_perk_doubletap2
// Params 0, eflags: 0x2
// Checksum 0x1d225cce, Offset: 0x1a0
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_perk_doubletap2", &__init__, undefined, undefined);
}

// Namespace zm_perk_doubletap2
// Params 0, eflags: 0x0
// Checksum 0xe6b7d0f8, Offset: 0x1e0
// Size: 0x14
function __init__() {
    function_67e7f8cd();
}

// Namespace zm_perk_doubletap2
// Params 0, eflags: 0x0
// Checksum 0x736f2ae, Offset: 0x200
// Size: 0x84
function function_67e7f8cd() {
    zm_perks::register_perk_clientfields("specialty_doubletap2", &function_4cff622d, &function_cc3fec48);
    zm_perks::register_perk_effects("specialty_doubletap2", "doubletap2_light");
    zm_perks::register_perk_init_thread("specialty_doubletap2", &function_a6e30992);
}

// Namespace zm_perk_doubletap2
// Params 0, eflags: 0x0
// Checksum 0x663eaa6a, Offset: 0x290
// Size: 0x36
function function_a6e30992() {
    if (isdefined(level.enable_magic) && level.enable_magic) {
        level._effect["doubletap2_light"] = "zombie/fx_perk_doubletap2_zmb";
    }
}

// Namespace zm_perk_doubletap2
// Params 0, eflags: 0x0
// Checksum 0x8e0cbd4b, Offset: 0x2d0
// Size: 0x3c
function function_4cff622d() {
    clientfield::register("clientuimodel", "hudItems.perks.doubletap2", 1, 2, "int", undefined, 0, 1);
}

// Namespace zm_perk_doubletap2
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x318
// Size: 0x4
function function_cc3fec48() {
    
}

