#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_utility;

#namespace zm_weapons;

// Namespace zm_weapons
// Params 0, eflags: 0x2
// Checksum 0x3aa1875c, Offset: 0x2b0
// Size: 0x3c
function autoexec __init__sytem__() {
    system::register("zm_weapons", &__init__, &__main__, undefined);
}

// Namespace zm_weapons
// Params 0, eflags: 0x0
// Checksum 0xb42e9433, Offset: 0x2f8
// Size: 0x64
function __init__() {
    level flag::init("weapon_table_loaded");
    level flag::init("weapon_wallbuys_created");
    callback::on_localclient_connect(&on_player_connect);
}

// Namespace zm_weapons
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x368
// Size: 0x4
function __main__() {
    
}

// Namespace zm_weapons
// Params 1, eflags: 0x4
// Checksum 0x4d6c5ac0, Offset: 0x378
// Size: 0x16a
function private on_player_connect(localclientnum) {
    if (getmigrationstatus(localclientnum)) {
        return;
    }
    resetweaponcosts(localclientnum);
    level flag::wait_till("weapon_table_loaded");
    level flag::wait_till("weapon_wallbuys_created");
    foreach (weaponcost in level.weapon_costs) {
        player_cost = compute_player_weapon_ammo_cost(weaponcost.weapon, weaponcost.ammo_cost, weaponcost.upgraded);
        setweaponcosts(localclientnum, weaponcost.weapon, weaponcost.cost, weaponcost.ammo_cost, player_cost);
    }
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x672f56cb, Offset: 0x4f0
// Size: 0x36
function is_weapon_included(weapon) {
    if (!isdefined(level._included_weapons)) {
        return false;
    }
    return isdefined(level._included_weapons[weapon.rootweapon]);
}

// Namespace zm_weapons
// Params 5, eflags: 0x0
// Checksum 0x61490fb, Offset: 0x530
// Size: 0x11a
function compute_player_weapon_ammo_cost(weapon, cost, upgraded, n_base_non_wallbuy_cost, n_upgraded_non_wallbuy_cost) {
    if (!isdefined(n_base_non_wallbuy_cost)) {
        n_base_non_wallbuy_cost = 750;
    }
    if (!isdefined(n_upgraded_non_wallbuy_cost)) {
        n_upgraded_non_wallbuy_cost = 5000;
    }
    w_root = weapon.rootweapon;
    if (upgraded) {
        if (is_wallbuy(level.zombie_weapons_upgraded[w_root])) {
            n_ammo_cost = 4000;
        } else {
            n_ammo_cost = n_upgraded_non_wallbuy_cost;
        }
    } else if (is_wallbuy(w_root)) {
        n_ammo_cost = cost;
        n_ammo_cost = zm_utility::halve_score(n_ammo_cost);
    } else {
        n_ammo_cost = n_base_non_wallbuy_cost;
    }
    return n_ammo_cost;
}

// Namespace zm_weapons
// Params 5, eflags: 0x0
// Checksum 0x2bc594ea, Offset: 0x658
// Size: 0x24c
function include_weapon(weapon_name, display_in_box, cost, ammo_cost, upgraded) {
    if (!isdefined(upgraded)) {
        upgraded = 0;
    }
    if (!isdefined(level._included_weapons)) {
        level._included_weapons = [];
    }
    weapon = getweapon(weapon_name);
    level._included_weapons[weapon] = weapon;
    if (!isdefined(level.weapon_costs)) {
        level.weapon_costs = [];
    }
    if (!isdefined(level.weapon_costs[weapon_name])) {
        level.weapon_costs[weapon_name] = spawnstruct();
        level.weapon_costs[weapon_name].weapon = weapon;
    }
    level.weapon_costs[weapon_name].cost = cost;
    if (!isdefined(ammo_cost) || ammo_cost == 0) {
        ammo_cost = zm_utility::round_up_to_ten(int(cost * 0.5));
    }
    level.weapon_costs[weapon_name].ammo_cost = ammo_cost;
    level.weapon_costs[weapon_name].upgraded = upgraded;
    if (isdefined(display_in_box) && !display_in_box) {
        return;
    }
    if (!isdefined(level._resetzombieboxweapons)) {
        level._resetzombieboxweapons = 1;
        resetzombieboxweapons();
    }
    if (!isdefined(weapon.worldmodel)) {
        thread util::error("Missing worldmodel for weapon " + weapon_name + " (or weapon may be missing from fastfile).");
        return;
    }
    addzombieboxweapon(weapon, weapon.worldmodel, weapon.isdualwield);
}

// Namespace zm_weapons
// Params 5, eflags: 0x0
// Checksum 0x2092c57, Offset: 0x8b0
// Size: 0xc2
function include_upgraded_weapon(weapon_name, upgrade_name, display_in_box, cost, ammo_cost) {
    include_weapon(upgrade_name, display_in_box, cost, ammo_cost, 1);
    if (!isdefined(level.zombie_weapons_upgraded)) {
        level.zombie_weapons_upgraded = [];
    }
    weapon = getweapon(weapon_name);
    upgrade = getweapon(upgrade_name);
    level.zombie_weapons_upgraded[upgrade] = weapon;
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xe907d068, Offset: 0x980
// Size: 0x42
function is_weapon_upgraded(weapon) {
    rootweapon = weapon.rootweapon;
    if (isdefined(level.zombie_weapons_upgraded[rootweapon])) {
        return true;
    }
    return false;
}

// Namespace zm_weapons
// Params 0, eflags: 0x0
// Checksum 0xbd801785, Offset: 0x9d0
// Size: 0x64c
function init() {
    spawn_list = [];
    spawnable_weapon_spawns = struct::get_array("weapon_upgrade", "targetname");
    spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("bowie_upgrade", "targetname"), 1, 0);
    spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("sickle_upgrade", "targetname"), 1, 0);
    spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("tazer_upgrade", "targetname"), 1, 0);
    spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("buildable_wallbuy", "targetname"), 1, 0);
    if (isdefined(level.use_autofill_wallbuy) && level.use_autofill_wallbuy) {
        spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, level.active_autofill_wallbuys, 1, 0);
    }
    if (!(isdefined(level.headshots_only) && level.headshots_only)) {
        spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("claymore_purchase", "targetname"), 1, 0);
    }
    location = level.scr_zm_map_start_location;
    if ((location == "default" || location == "") && isdefined(level.default_start_location)) {
        location = level.default_start_location;
    }
    match_string = level.scr_zm_ui_gametype;
    if ("" != location) {
        match_string = match_string + "_" + location;
    }
    match_string_plus_space = " " + match_string;
    for (i = 0; i < spawnable_weapon_spawns.size; i++) {
        spawnable_weapon = spawnable_weapon_spawns[i];
        spawnable_weapon.weapon = getweapon(spawnable_weapon.zombie_weapon_upgrade);
        if (isdefined(level.headshots_only) && isdefined(spawnable_weapon.zombie_weapon_upgrade) && spawnable_weapon.weapon.isgrenadeweapon && level.headshots_only) {
            continue;
        }
        if (!isdefined(spawnable_weapon.script_noteworthy) || spawnable_weapon.script_noteworthy == "") {
            spawn_list[spawn_list.size] = spawnable_weapon;
            continue;
        }
        matches = strtok(spawnable_weapon.script_noteworthy, ",");
        for (j = 0; j < matches.size; j++) {
            if (matches[j] == match_string || matches[j] == match_string_plus_space) {
                spawn_list[spawn_list.size] = spawnable_weapon;
            }
        }
    }
    level._active_wallbuys = [];
    for (i = 0; i < spawn_list.size; i++) {
        spawn_list[i].script_label = spawn_list[i].zombie_weapon_upgrade + "_" + spawn_list[i].origin;
        level._active_wallbuys[spawn_list[i].script_label] = spawn_list[i];
        numbits = 2;
        if (isdefined(level._wallbuy_override_num_bits)) {
            numbits = level._wallbuy_override_num_bits;
        }
        clientfield::register("world", spawn_list[i].script_label, 1, numbits, "int", &wallbuy_callback, 0, 1);
        target_struct = struct::get(spawn_list[i].target, "targetname");
        if (spawn_list[i].targetname == "buildable_wallbuy") {
            bits = 4;
            if (isdefined(level.buildable_wallbuy_weapons)) {
                bits = getminbitcountfornum(level.buildable_wallbuy_weapons.size + 1);
            }
            clientfield::register("world", spawn_list[i].script_label + "_idx", 1, bits, "int", &wallbuy_callback_idx, 0, 1);
        }
    }
    level flag::set("weapon_wallbuys_created");
    callback::on_localclient_connect(&wallbuy_player_connect);
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xf495bd10, Offset: 0x1028
// Size: 0xe6
function is_wallbuy(w_to_check) {
    w_base = w_to_check.rootweapon;
    foreach (s_wallbuy in level._active_wallbuys) {
        if (s_wallbuy.weapon == w_base) {
            return true;
        }
    }
    if (isdefined(level._additional_wallbuy_weapons)) {
        if (isinarray(level._additional_wallbuy_weapons, w_base)) {
            return true;
        }
    }
    return false;
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x89ab75c0, Offset: 0x1118
// Size: 0x1c4
function wallbuy_player_connect(localclientnum) {
    keys = getarraykeys(level._active_wallbuys);
    println("<dev string:x28>" + localclientnum);
    for (i = 0; i < keys.size; i++) {
        wallbuy = level._active_wallbuys[keys[i]];
        fx = level._effect["870mcs_zm_fx"];
        if (isdefined(level._effect[wallbuy.zombie_weapon_upgrade + "_fx"])) {
            fx = level._effect[wallbuy.zombie_weapon_upgrade + "_fx"];
        }
        target_struct = struct::get(wallbuy.target, "targetname");
        target_model = zm_utility::spawn_buildkit_weapon_model(localclientnum, wallbuy.weapon, undefined, target_struct.origin, target_struct.angles);
        target_model hide();
        target_model.parent_struct = target_struct;
        wallbuy.models[localclientnum] = target_model;
    }
}

// Namespace zm_weapons
// Params 7, eflags: 0x0
// Checksum 0x18aa2680, Offset: 0x12e8
// Size: 0x436
function wallbuy_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (binitialsnap) {
        while (!isdefined(level._active_wallbuys) || !isdefined(level._active_wallbuys[fieldname])) {
            wait 0.05;
        }
    }
    struct = level._active_wallbuys[fieldname];
    println("<dev string:x3e>" + localclientnum);
    switch (newval) {
    case 0:
        struct.models[localclientnum].origin = struct.models[localclientnum].parent_struct.origin;
        struct.models[localclientnum].angles = struct.models[localclientnum].parent_struct.angles;
        struct.models[localclientnum] hide();
        break;
    case 1:
        if (binitialsnap) {
            if (!isdefined(struct.models)) {
                while (!isdefined(struct.models)) {
                    wait 0.05;
                }
                while (!isdefined(struct.models[localclientnum])) {
                    wait 0.05;
                }
            }
            struct.models[localclientnum] show();
            struct.models[localclientnum].origin = struct.models[localclientnum].parent_struct.origin;
        } else {
            wait 0.05;
            if (localclientnum == 0) {
                playsound(0, "zmb_weap_wall", struct.origin);
            }
            vec_offset = (0, 0, 0);
            if (isdefined(struct.models[localclientnum].parent_struct.script_vector)) {
                vec_offset = struct.models[localclientnum].parent_struct.script_vector;
            }
            struct.models[localclientnum].origin = struct.models[localclientnum].parent_struct.origin + anglestoright(struct.models[localclientnum].angles + vec_offset) * 8;
            struct.models[localclientnum] show();
            struct.models[localclientnum] moveto(struct.models[localclientnum].parent_struct.origin, 1);
        }
        break;
    case 2:
        if (isdefined(level.var_606e6080)) {
            struct.models[localclientnum] [[ level.var_606e6080 ]]();
        }
        break;
    }
}

// Namespace zm_weapons
// Params 7, eflags: 0x0
// Checksum 0x13830c4c, Offset: 0x1728
// Size: 0x47a
function wallbuy_callback_idx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    basefield = getsubstr(fieldname, 0, fieldname.size - 4);
    struct = level._active_wallbuys[basefield];
    if (newval == 0) {
        if (isdefined(struct.models[localclientnum])) {
            struct.models[localclientnum] hide();
        }
        return;
    }
    if (newval > 0) {
        weaponname = level.buildable_wallbuy_weapons[newval - 1];
        weapon = getweapon(weaponname);
        if (!isdefined(struct.models)) {
            struct.models = [];
        }
        if (!isdefined(struct.models[localclientnum])) {
            target_struct = struct::get(struct.target, "targetname");
            model = undefined;
            if (isdefined(level.buildable_wallbuy_weapon_models[weaponname])) {
                model = level.buildable_wallbuy_weapon_models[weaponname];
            }
            angles = target_struct.angles;
            if (isdefined(level.var_4b2570c[weaponname])) {
                switch (level.var_4b2570c[weaponname]) {
                case 90:
                    angles = vectortoangles(anglestoright(angles));
                    break;
                case 180:
                    angles = vectortoangles(anglestoforward(angles) * -1);
                    break;
                case 270:
                    angles = vectortoangles(anglestoright(angles) * -1);
                    break;
                }
            }
            target_model = zm_utility::spawn_buildkit_weapon_model(localclientnum, weapon, undefined, target_struct.origin, angles);
            target_model hide();
            target_model.parent_struct = target_struct;
            struct.models[localclientnum] = target_model;
            if (isdefined(struct.fx[localclientnum])) {
                stopfx(localclientnum, struct.fx[localclientnum]);
                struct.fx[localclientnum] = undefined;
            }
            fx = level._effect["870mcs_zm_fx"];
            if (isdefined(level._effect[weaponname + "_fx"])) {
                fx = level._effect[weaponname + "_fx"];
            }
            struct.fx[localclientnum] = playfx(localclientnum, fx, struct.origin, anglestoforward(struct.angles), anglestoup(struct.angles), 0.1);
            level notify(#"wallbuy_updated");
        }
    }
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xfd7b7392, Offset: 0x1bb0
// Size: 0x24
function checkstringvalid(str) {
    if (str != "") {
        return str;
    }
    return undefined;
}

// Namespace zm_weapons
// Params 2, eflags: 0x0
// Checksum 0xf3c38a0e, Offset: 0x1be0
// Size: 0x44c
function load_weapon_spec_from_table(table, first_row) {
    gametype = getdvarstring("ui_gametype");
    index = 1;
    for (row = tablelookuprow(table, index); isdefined(row); row = tablelookuprow(table, index)) {
        weapon_name = checkstringvalid(row[0]);
        upgrade_name = checkstringvalid(row[1]);
        hint = checkstringvalid(row[2]);
        cost = int(row[3]);
        weaponvo = checkstringvalid(row[4]);
        weaponvoresp = checkstringvalid(row[5]);
        ammo_cost = undefined;
        if ("" != row[6]) {
            ammo_cost = int(row[6]);
        }
        create_vox = checkstringvalid(row[7]);
        is_zcleansed = tolower(row[8]) == "true";
        in_box = tolower(row[9]) == "true";
        upgrade_in_box = tolower(row[10]) == "true";
        is_limited = tolower(row[11]) == "true";
        limit = int(row[12]);
        upgrade_limit = int(row[13]);
        content_restrict = row[14];
        wallbuy_autospawn = tolower(row[15]) == "true";
        weapon_class = checkstringvalid(row[16]);
        is_wonder_weapon = tolower(row[18]) == "true";
        var_e44dc8f1 = tolower(row[19]);
        include_weapon(weapon_name, in_box, cost, ammo_cost, 0);
        if (isdefined(upgrade_name)) {
            include_upgraded_weapon(weapon_name, upgrade_name, upgrade_in_box, cost, 4500);
        }
        index++;
    }
    level flag::set("weapon_table_loaded");
}

// Namespace zm_weapons
// Params 0, eflags: 0x0
// Checksum 0xac0d7e8e, Offset: 0x2038
// Size: 0x6a6
function function_9e8dccbe() {
    wallbuys = struct::get_array("wallbuy_autofill", "targetname");
    if (!isdefined(wallbuys) || wallbuys.size == 0 || !isdefined(level.var_723d0afa) || level.var_723d0afa.size == 0) {
        return;
    }
    level.use_autofill_wallbuy = 1;
    var_69e24b8b["all"] = getarraykeys(level.var_723d0afa["all"]);
    index = 0;
    var_7e5108a3 = [];
    level.active_autofill_wallbuys = [];
    foreach (wallbuy in wallbuys) {
        weapon_class = wallbuy.script_string;
        weapon = undefined;
        if (isdefined(weapon_class) && weapon_class != "") {
            if (!isdefined(var_69e24b8b[weapon_class]) && isdefined(level.var_723d0afa[weapon_class])) {
                var_69e24b8b[weapon_class] = getarraykeys(level.var_723d0afa[weapon_class]);
            }
            if (isdefined(var_69e24b8b[weapon_class])) {
                for (i = 0; i < var_69e24b8b[weapon_class].size; i++) {
                    if (level.var_723d0afa["all"][var_69e24b8b[weapon_class][i]]) {
                        weapon = var_69e24b8b[weapon_class][i];
                        level.var_723d0afa["all"][weapon] = 0;
                        break;
                    }
                }
            } else {
                continue;
            }
        } else {
            var_7e5108a3[var_7e5108a3.size] = wallbuy;
            continue;
        }
        if (!isdefined(weapon)) {
            continue;
        }
        wallbuy.zombie_weapon_upgrade = weapon.name;
        wallbuy.weapon = weapon;
        right = anglestoright(wallbuy.angles);
        wallbuy.origin -= right * 2;
        wallbuy.target = "autofill_wallbuy_" + index;
        target_struct = spawnstruct();
        target_struct.targetname = wallbuy.target;
        target_struct.angles = wallbuy.angles;
        target_struct.origin = wallbuy.origin;
        model = wallbuy.weapon.worldmodel;
        target_struct.model = model;
        target_struct struct::init();
        level.active_autofill_wallbuys[level.active_autofill_wallbuys.size] = wallbuy;
        index++;
    }
    foreach (wallbuy in var_7e5108a3) {
        weapon_name = undefined;
        for (i = 0; i < var_69e24b8b["all"].size; i++) {
            if (level.var_723d0afa["all"][var_69e24b8b["all"][i]]) {
                weapon = var_69e24b8b["all"][i];
                level.var_723d0afa["all"][weapon] = 0;
                break;
            }
        }
        if (!isdefined(weapon)) {
            break;
        }
        wallbuy.zombie_weapon_upgrade = weapon.name;
        wallbuy.weapon = weapon;
        right = anglestoright(wallbuy.angles);
        wallbuy.origin -= right * 2;
        wallbuy.target = "autofill_wallbuy_" + index;
        target_struct = spawnstruct();
        target_struct.targetname = wallbuy.target;
        target_struct.angles = wallbuy.angles;
        target_struct.origin = wallbuy.origin;
        model = wallbuy.weapon.worldmodel;
        target_struct.model = model;
        target_struct struct::init();
        level.active_autofill_wallbuys[level.active_autofill_wallbuys.size] = wallbuy;
        index++;
    }
}

