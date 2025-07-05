#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;

#namespace serverfaceanim;

// Namespace serverfaceanim
// Params 0, eflags: 0x2
// Checksum 0xe6ab256c, Offset: 0x180
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("serverfaceanim", &__init__, undefined, undefined);
}

// Namespace serverfaceanim
// Params 0, eflags: 0x0
// Checksum 0x82f7fe, Offset: 0x1c0
// Size: 0x3c
function __init__() {
    if (!(isdefined(level._use_faceanim) && level._use_faceanim)) {
        return;
    }
    callback::on_spawned(&init_serverfaceanim);
}

// Namespace serverfaceanim
// Params 0, eflags: 0x0
// Checksum 0xa6e06f9, Offset: 0x208
// Size: 0x19c
function init_serverfaceanim() {
    self.do_face_anims = 1;
    if (!isdefined(level.face_event_handler)) {
        level.face_event_handler = spawnstruct();
        level.face_event_handler.events = [];
        level.face_event_handler.events["death"] = "face_death";
        level.face_event_handler.events["grenade danger"] = "face_alert";
        level.face_event_handler.events["bulletwhizby"] = "face_alert";
        level.face_event_handler.events["projectile_impact"] = "face_alert";
        level.face_event_handler.events["explode"] = "face_alert";
        level.face_event_handler.events["alert"] = "face_alert";
        level.face_event_handler.events["shoot"] = "face_shoot_single";
        level.face_event_handler.events["melee"] = "face_melee";
        level.face_event_handler.events["damage"] = "face_pain";
        level thread wait_for_face_event();
    }
}

// Namespace serverfaceanim
// Params 0, eflags: 0x0
// Checksum 0x43055e4f, Offset: 0x3b0
// Size: 0xa8
function wait_for_face_event() {
    while (true) {
        level waittill(#"face", face_notify, ent);
        if (isdefined(ent) && isdefined(ent.do_face_anims) && ent.do_face_anims) {
            if (isdefined(level.face_event_handler.events[face_notify])) {
                ent sendfaceevent(level.face_event_handler.events[face_notify]);
            }
        }
    }
}

