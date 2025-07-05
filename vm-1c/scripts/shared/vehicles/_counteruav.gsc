#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/math_shared;
#using scripts/shared/statemachine_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_death_shared;
#using scripts/shared/vehicle_shared;

#using_animtree("generic");

#namespace counteruav;

// Namespace counteruav
// Params 0, eflags: 0x2
// Checksum 0x6da9a314, Offset: 0x200
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("counteruav", &__init__, undefined, undefined);
}

// Namespace counteruav
// Params 0, eflags: 0x0
// Checksum 0xeb419c88, Offset: 0x240
// Size: 0x2c
function __init__() {
    vehicle::add_main_callback("counteruav", &function_3c868cce);
}

// Namespace counteruav
// Params 0, eflags: 0x0
// Checksum 0x9251c15c, Offset: 0x278
// Size: 0x188
function function_3c868cce() {
    self useanimtree(#generic);
    target_set(self, (0, 0, 0));
    self.health = self.healthdefault;
    self vehicle::friendly_fire_shield();
    self setvehicleavoidance(1);
    self sethoverparams(50, 100, 100);
    self.vehaircraftcollisionenabled = 1;
    assert(isdefined(self.scriptbundlesettings));
    self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    self.goalradius = 999999;
    self.goalheight = 999999;
    self setgoal(self.origin, 0, self.goalradius, self.goalheight);
    self.overridevehicledamage = &drone_callback_damage;
    if (isdefined(level.vehicle_initializer_cb)) {
        [[ level.vehicle_initializer_cb ]](self);
    }
}

// Namespace counteruav
// Params 15, eflags: 0x0
// Checksum 0xe530170f, Offset: 0x408
// Size: 0xd4
function drone_callback_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    idamage = vehicle_ai::shared_callback_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
    return idamage;
}

