#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;

#namespace serversettings;

// Namespace serversettings
// Params 0, eflags: 0x2
// Checksum 0xf8365579, Offset: 0x1a8
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("serversettings", &__init__, undefined, undefined);
}

// Namespace serversettings
// Params 0, eflags: 0x0
// Checksum 0xc62c73c9, Offset: 0x1e8
// Size: 0x24
function __init__() {
    callback::on_start_gametype(&main);
}

// Namespace serversettings
// Params 0, eflags: 0x0
// Checksum 0x1e9c1d4d, Offset: 0x218
// Size: 0x40e
function main() {
    level.hostname = getdvarstring("sv_hostname");
    if (level.hostname == "") {
        level.hostname = "CoDHost";
    }
    setdvar("sv_hostname", level.hostname);
    setdvar("ui_hostname", level.hostname);
    level.motd = getdvarstring("scr_motd");
    if (level.motd == "") {
        level.motd = "";
    }
    setdvar("scr_motd", level.motd);
    setdvar("ui_motd", level.motd);
    level.allowvote = getdvarstring("g_allowvote");
    if (level.allowvote == "") {
        level.allowvote = "1";
    }
    setdvar("g_allowvote", level.allowvote);
    setdvar("ui_allowvote", level.allowvote);
    level.allow_teamchange = "0";
    if (sessionmodeisprivate() || !sessionmodeisonlinegame()) {
        level.allow_teamchange = "1";
    }
    setdvar("ui_allow_teamchange", level.allow_teamchange);
    level.friendlyfire = getgametypesetting("friendlyfiretype");
    setdvar("ui_friendlyfire", level.friendlyfire);
    if (getdvarstring("scr_mapsize") == "") {
        setdvar("scr_mapsize", "64");
    } else if (getdvarfloat("scr_mapsize") >= 64) {
        setdvar("scr_mapsize", "64");
    } else if (getdvarfloat("scr_mapsize") >= 32) {
        setdvar("scr_mapsize", "32");
    } else if (getdvarfloat("scr_mapsize") >= 16) {
        setdvar("scr_mapsize", "16");
    } else {
        setdvar("scr_mapsize", "8");
    }
    level.mapsize = getdvarfloat("scr_mapsize");
    constraingametype(getdvarstring("g_gametype"));
    function_11d2785d(level.mapsize);
    for (;;) {
        updateserversettings();
        wait 5;
    }
}

// Namespace serversettings
// Params 0, eflags: 0x0
// Checksum 0xcd72235f, Offset: 0x630
// Size: 0x184
function updateserversettings() {
    sv_hostname = getdvarstring("sv_hostname");
    if (level.hostname != sv_hostname) {
        level.hostname = sv_hostname;
        setdvar("ui_hostname", level.hostname);
    }
    scr_motd = getdvarstring("scr_motd");
    if (level.motd != scr_motd) {
        level.motd = scr_motd;
        setdvar("ui_motd", level.motd);
    }
    g_allowvote = getdvarstring("g_allowvote");
    if (level.allowvote != g_allowvote) {
        level.allowvote = g_allowvote;
        setdvar("ui_allowvote", level.allowvote);
    }
    scr_friendlyfire = getgametypesetting("friendlyfiretype");
    if (level.friendlyfire != scr_friendlyfire) {
        level.friendlyfire = scr_friendlyfire;
        setdvar("ui_friendlyfire", level.friendlyfire);
    }
}

// Namespace serversettings
// Params 1, eflags: 0x0
// Checksum 0x95fa68ba, Offset: 0x7c0
// Size: 0x276
function constraingametype(gametype) {
    entities = getentarray();
    for (i = 0; i < entities.size; i++) {
        entity = entities[i];
        if (gametype == "dm") {
            if (isdefined(entity.script_gametype_dm) && entity.script_gametype_dm != "1") {
                entity delete();
            }
            continue;
        }
        if (gametype == "tdm") {
            if (isdefined(entity.script_gametype_tdm) && entity.script_gametype_tdm != "1") {
                entity delete();
            }
            continue;
        }
        if (gametype == "ctf") {
            if (isdefined(entity.script_gametype_ctf) && entity.script_gametype_ctf != "1") {
                entity delete();
            }
            continue;
        }
        if (gametype == "hq") {
            if (isdefined(entity.script_gametype_hq) && entity.script_gametype_hq != "1") {
                entity delete();
            }
            continue;
        }
        if (gametype == "sd") {
            if (isdefined(entity.script_gametype_sd) && entity.script_gametype_sd != "1") {
                entity delete();
            }
            continue;
        }
        if (gametype == "koth") {
            if (isdefined(entity.script_gametype_koth) && entity.script_gametype_koth != "1") {
                entity delete();
            }
        }
    }
}

// Namespace serversettings
// Params 1, eflags: 0x0
// Checksum 0x769f991c, Offset: 0xa40
// Size: 0x206
function function_11d2785d(mapsize) {
    entities = getentarray();
    for (i = 0; i < entities.size; i++) {
        entity = entities[i];
        if (int(mapsize) == 8) {
            if (isdefined(entity.script_mapsize_08) && entity.script_mapsize_08 != "1") {
                entity delete();
            }
            continue;
        }
        if (int(mapsize) == 16) {
            if (isdefined(entity.script_mapsize_16) && entity.script_mapsize_16 != "1") {
                entity delete();
            }
            continue;
        }
        if (int(mapsize) == 32) {
            if (isdefined(entity.script_mapsize_32) && entity.script_mapsize_32 != "1") {
                entity delete();
            }
            continue;
        }
        if (int(mapsize) == 64) {
            if (isdefined(entity.script_mapsize_64) && entity.script_mapsize_64 != "1") {
                entity delete();
            }
        }
    }
}

