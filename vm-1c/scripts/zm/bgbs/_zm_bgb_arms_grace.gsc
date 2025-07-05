#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_pack_a_punch_util;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;

#namespace zm_bgb_arms_grace;

// Namespace zm_bgb_arms_grace
// Params 0, eflags: 0x2
// Checksum 0xa0b58439, Offset: 0x1e8
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_bgb_arms_grace", &__init__, undefined, "bgb");
}

// Namespace zm_bgb_arms_grace
// Params 0, eflags: 0x0
// Checksum 0x6faa7cb9, Offset: 0x228
// Size: 0x6c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_arms_grace", "event", &event, undefined, undefined, undefined);
    level.givestartloadout = &givestartloadout;
}

// Namespace zm_bgb_arms_grace
// Params 0, eflags: 0x0
// Checksum 0x38795b6c, Offset: 0x2a0
// Size: 0x50
function event() {
    self endon(#"disconnect");
    self endon(#"bgb_update");
    self waittill(#"bgb_about_to_take_on_bled_out");
    self bgb::do_one_shot_use(1);
    self.var_e445bfc6 = 1;
}

// Namespace zm_bgb_arms_grace
// Params 0, eflags: 0x0
// Checksum 0x43beadfe, Offset: 0x2f8
// Size: 0x5c
function givestartloadout() {
    if (isdefined(self.var_e445bfc6) && self.var_e445bfc6) {
        self.var_e445bfc6 = 0;
        function_f1adaf91(self);
        return;
    }
    if (isdefined(level.givecustomloadout)) {
        self [[ level.givecustomloadout ]]();
    }
}

// Namespace zm_bgb_arms_grace
// Params 1, eflags: 0x0
// Checksum 0x9c90067d, Offset: 0x360
// Size: 0x35c
function function_f1adaf91(player) {
    var_f49711f9 = player getcurrentweapon();
    weapon_limit = zm_utility::get_player_weapon_limit(player);
    var_a430f97e = 0;
    var_86380dd7 = 0;
    var_10f9c82c = zm_pap_util::function_f925b7b9();
    var_1fc5e233 = getweapon("ray_gun");
    var_52633155 = 0;
    player giveweapon(level.weaponbasemelee);
    if (isdefined(player.var_7e00777a)) {
        var_f0e082e = 0;
        foreach (weapon in player.var_7e00777a) {
            if (weapon.isprimary) {
                if (var_1fc5e233 == zm_weapons::get_base_weapon(weapon)) {
                    var_f0e082e = 1;
                    break;
                }
            }
        }
        foreach (weapon in player.var_7e00777a) {
            if (weapon == var_f49711f9) {
                continue;
            }
            if (weapon.isprimary) {
                var_cbbc46c5 = undefined;
                w_base = zm_weapons::get_base_weapon(weapon);
                if (!zm_weapons::limited_weapon_below_quota(w_base, player, var_10f9c82c) && weapon != level.start_weapon) {
                    if (!var_52633155) {
                        if (!var_f0e082e && !player zm_weapons::has_weapon_or_upgrade(var_1fc5e233)) {
                            var_cbbc46c5 = var_1fc5e233;
                            var_52633155 = 1;
                        }
                    }
                } else {
                    var_cbbc46c5 = weapon;
                }
                if (isdefined(var_cbbc46c5)) {
                    player zm_weapons::weapon_give(var_cbbc46c5, 0, 0, 1, !var_86380dd7);
                    var_a430f97e++;
                    var_86380dd7 = 1;
                }
            }
            if (weapon_limit <= var_a430f97e) {
                break;
            }
        }
    }
}

