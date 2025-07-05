#using scripts/shared/array_shared;
#using scripts/shared/rat_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_devgui;

#namespace rat;

/#

    // Namespace rat
    // Params 0, eflags: 0x2
    // Checksum 0x1f2990b3, Offset: 0x100
    // Size: 0x34
    function autoexec __init__sytem__() {
        system::register("<dev string:x28>", &__init__, undefined, undefined);
    }

    // Namespace rat
    // Params 0, eflags: 0x0
    // Checksum 0x7b1372c7, Offset: 0x140
    // Size: 0x6c
    function __init__() {
        rat_shared::init();
        level.rat.common.gethostplayer = &util::gethostplayer;
        rat_shared::addratscriptcmd("<dev string:x2c>", &derriesezombiespawnnavmeshtest);
    }

    // Namespace rat
    // Params 2, eflags: 0x0
    // Checksum 0x4e9d15a5, Offset: 0x1b8
    // Size: 0x514
    function derriesezombiespawnnavmeshtest(params, inrat) {
        if (!isdefined(inrat)) {
            inrat = 1;
        }
        if (inrat) {
            wait 10;
        }
        enemy = zm_devgui::devgui_zombie_spawn();
        enemy.is_rat_test = 1;
        failed_spawn_origin = [];
        failed_node_origin = [];
        failed_attack_spot_spawn_origin = [];
        failed_attack_spot = [];
        size = 0;
        failed_attack_spot_size = 0;
        wait 0.2;
        foreach (zone in level.zones) {
            foreach (loc in zone.a_loc_types["<dev string:x40>"]) {
                angles = (0, 0, 0);
                enemy forceteleport(loc.origin, angles);
                wait 0.2;
                node = undefined;
                for (j = 0; j < level.exterior_goals.size; j++) {
                    if (isdefined(level.exterior_goals[j].script_string) && level.exterior_goals[j].script_string == loc.script_string) {
                        node = level.exterior_goals[j];
                    }
                }
                if (isdefined(node)) {
                    ispath = enemy setgoal(node.origin);
                    if (!ispath) {
                        failed_spawn_origin[size] = loc.origin;
                        failed_node_origin[size] = node.origin;
                        size++;
                    }
                    wait 0.2;
                    for (j = 0; j < node.attack_spots.size; j++) {
                        isattackpath = enemy setgoal(node.attack_spots[j]);
                        if (!isattackpath) {
                            failed_attack_spot_spawn_origin[failed_attack_spot_size] = loc.origin;
                            failed_attack_spot[failed_attack_spot_size] = node.attack_spots[j];
                            failed_attack_spot_size++;
                        }
                        wait 0.2;
                    }
                }
            }
        }
        if (inrat) {
            errmsg = "<dev string:x50>";
            for (i = 0; i < size; i++) {
                errmsg += "<dev string:x68>" + failed_spawn_origin[i] + "<dev string:x71>" + failed_node_origin[i] + "<dev string:x7a>";
            }
            for (i = 0; i < failed_attack_spot_size; i++) {
                errmsg += "<dev string:x68>" + failed_attack_spot_spawn_origin[i] + "<dev string:x7d>" + failed_attack_spot[i] + "<dev string:x7a>";
            }
            if (size > 0 || failed_attack_spot_size > 0) {
                ratreportcommandresult(params._id, 0, errmsg);
                return;
            }
            ratreportcommandresult(params._id, 1);
        }
    }

#/
