#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_util;
#using scripts/zm/gametypes/_globallogic;
#using scripts/zm/gametypes/_globallogic_player;
#using scripts/zm/gametypes/_spectating;

#namespace globallogic_ui;

// Namespace globallogic_ui
// Params 0, eflags: 0x2
// Checksum 0x5a958bed, Offset: 0x248
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("globallogic_ui", &__init__, undefined, undefined);
}

// Namespace globallogic_ui
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x288
// Size: 0x4
function __init__() {
    
}

// Namespace globallogic_ui
// Params 0, eflags: 0x0
// Checksum 0xe1c11b17, Offset: 0x298
// Size: 0x64
function setupcallbacks() {
    level.autoassign = &menuautoassign;
    level.spectator = &menuspectator;
    level.curclass = &menuclass;
    level.teammenu = &menuteam;
}

// Namespace globallogic_ui
// Params 0, eflags: 0x0
// Checksum 0x4f9fe9df, Offset: 0x308
// Size: 0x27c
function freegameplayhudelems() {
    if (isdefined(self.perkicon)) {
        for (numspecialties = 0; numspecialties < level.maxspecialties; numspecialties++) {
            if (isdefined(self.perkicon[numspecialties])) {
                self.perkicon[numspecialties] hud::destroyelem();
                self.perkname[numspecialties] hud::destroyelem();
            }
        }
    }
    if (isdefined(self.perkhudelem)) {
        self.perkhudelem hud::destroyelem();
    }
    if (isdefined(self.killstreakicon)) {
        if (isdefined(self.killstreakicon[0])) {
            self.killstreakicon[0] hud::destroyelem();
        }
        if (isdefined(self.killstreakicon[1])) {
            self.killstreakicon[1] hud::destroyelem();
        }
        if (isdefined(self.killstreakicon[2])) {
            self.killstreakicon[2] hud::destroyelem();
        }
        if (isdefined(self.killstreakicon[3])) {
            self.killstreakicon[3] hud::destroyelem();
        }
        if (isdefined(self.killstreakicon[4])) {
            self.killstreakicon[4] hud::destroyelem();
        }
    }
    if (isdefined(self.lowermessage)) {
        self.lowermessage hud::destroyelem();
    }
    if (isdefined(self.lowertimer)) {
        self.lowertimer hud::destroyelem();
    }
    if (isdefined(self.proxbar)) {
        self.proxbar hud::destroyelem();
    }
    if (isdefined(self.proxbartext)) {
        self.proxbartext hud::destroyelem();
    }
    if (isdefined(self.carryicon)) {
        self.carryicon hud::destroyelem();
    }
}

// Namespace globallogic_ui
// Params 1, eflags: 0x0
// Checksum 0xfb20dd7d, Offset: 0x590
// Size: 0xc6
function teamplayercountsequal(playercounts) {
    count = undefined;
    foreach (team in level.teams) {
        if (!isdefined(count)) {
            count = playercounts[team];
            continue;
        }
        if (count != playercounts[team]) {
            return false;
        }
    }
    return true;
}

// Namespace globallogic_ui
// Params 2, eflags: 0x0
// Checksum 0xcbd00bf2, Offset: 0x660
// Size: 0xda
function teamwithlowestplayercount(playercounts, ignore_team) {
    count = 9999;
    lowest_team = undefined;
    foreach (team in level.teams) {
        if (count > playercounts[team]) {
            count = playercounts[team];
            lowest_team = team;
        }
    }
    return lowest_team;
}

// Namespace globallogic_ui
// Params 1, eflags: 0x0
// Checksum 0xe330584f, Offset: 0x748
// Size: 0x56c
function menuautoassign(comingfrommenu) {
    teamkeys = getarraykeys(level.teams);
    assignment = teamkeys[randomint(teamkeys.size)];
    self closemenus();
    if (isdefined(level.forceallallies) && level.forceallallies) {
        assignment = "allies";
    } else if (level.teambased) {
        if (getdvarint("party_autoteams") == 1) {
            if (self.hasspawned || level.allow_teamchange == "1" && comingfrommenu) {
                assignment = "";
            } else {
                team = getassignedteam(self);
                switch (team) {
                case 1:
                    assignment = teamkeys[1];
                    break;
                case 2:
                    assignment = teamkeys[0];
                    break;
                case 3:
                    assignment = teamkeys[2];
                    break;
                case 4:
                    if (!isdefined(level.forceautoassign) || !level.forceautoassign) {
                        self setclientscriptmainmenu(game["menu_start_menu"]);
                        return;
                    }
                default:
                    assignment = "";
                    if (isdefined(level.teams[team])) {
                        assignment = team;
                    } else if (team == "spectator" && !level.forceautoassign) {
                        self setclientscriptmainmenu(game["menu_start_menu"]);
                        return;
                    }
                    break;
                }
            }
        }
        if (assignment == "" || getdvarint("party_autoteams") == 0) {
            if (sessionmodeiszombiesgame()) {
                assignment = "allies";
            }
        }
        if (self.sessionstate == "playing" || assignment == self.pers["team"] && self.sessionstate == "dead") {
            self beginclasschoice();
            return;
        }
    } else if (getdvarint("party_autoteams") == 1) {
        if (!self.hasspawned && (level.allow_teamchange != "1" || !comingfrommenu)) {
            team = getassignedteam(self);
            if (isdefined(level.teams[team])) {
                assignment = team;
            } else if (team == "spectator" && !level.forceautoassign) {
                self setclientscriptmainmenu(game["menu_start_menu"]);
                return;
            }
        }
    }
    if (self.sessionstate == "playing" || assignment != self.pers["team"] && self.sessionstate == "dead") {
        self.switching_teams = 1;
        self.joining_team = assignment;
        self.leaving_team = self.pers["team"];
        self suicide();
    }
    self.pers["team"] = assignment;
    self.team = assignment;
    self.pers["class"] = undefined;
    self.curclass = undefined;
    self.pers["weapon"] = undefined;
    self.pers["savedmodel"] = undefined;
    self updateobjectivetext();
    self.sessionteam = assignment;
    if (!isalive(self)) {
        self.statusicon = "hud_status_dead";
    }
    self notify(#"joined_team");
    level notify(#"joined_team");
    self callback::callback(#"hash_95a6c4c0");
    self notify(#"end_respawn");
    self beginclasschoice();
    self setclientscriptmainmenu(game["menu_start_menu"]);
}

// Namespace globallogic_ui
// Params 0, eflags: 0x0
// Checksum 0xff84dac, Offset: 0xcc0
// Size: 0xce
function teamscoresequal() {
    score = undefined;
    foreach (team in level.teams) {
        if (!isdefined(score)) {
            score = getteamscore(team);
            continue;
        }
        if (score != getteamscore(team)) {
            return false;
        }
    }
    return true;
}

// Namespace globallogic_ui
// Params 0, eflags: 0x0
// Checksum 0xc3aab7dc, Offset: 0xd98
// Size: 0xc4
function teamwithlowestscore() {
    score = 99999999;
    lowest_team = undefined;
    foreach (team in level.teams) {
        if (score > getteamscore(team)) {
            lowest_team = team;
        }
    }
    return lowest_team;
}

// Namespace globallogic_ui
// Params 1, eflags: 0x0
// Checksum 0x29e3fccd, Offset: 0xe68
// Size: 0x74
function pickteamfromscores(teams) {
    assignment = "allies";
    if (teamscoresequal()) {
        assignment = teams[randomint(teams.size)];
    } else {
        assignment = teamwithlowestscore();
    }
    return assignment;
}

// Namespace globallogic_ui
// Params 0, eflags: 0x0
// Checksum 0x45c3eb7e, Offset: 0xee8
// Size: 0xce
function getsplitscreenteam() {
    for (index = 0; index < level.players.size; index++) {
        if (!isdefined(level.players[index])) {
            continue;
        }
        if (level.players[index] == self) {
            continue;
        }
        if (!self isplayeronsamemachine(level.players[index])) {
            continue;
        }
        team = level.players[index].sessionteam;
        if (team != "spectator") {
            return team;
        }
    }
    return "";
}

// Namespace globallogic_ui
// Params 0, eflags: 0x0
// Checksum 0xc3c4a600, Offset: 0xfc0
// Size: 0xd4
function updateobjectivetext() {
    if (sessionmodeiszombiesgame() || self.pers["team"] == "spectator") {
        self setclientcgobjectivetext("");
        return;
    }
    if (level.scorelimit > 0) {
        self setclientcgobjectivetext(util::getobjectivescoretext(self.pers["team"]));
        return;
    }
    self setclientcgobjectivetext(util::getobjectivetext(self.pers["team"]));
}

// Namespace globallogic_ui
// Params 0, eflags: 0x0
// Checksum 0x51601f7a, Offset: 0x10a0
// Size: 0x1c
function closemenus() {
    self closeingamemenu();
}

// Namespace globallogic_ui
// Params 1, eflags: 0x0
// Checksum 0xa82ba665, Offset: 0x10c8
// Size: 0x12c
function beginclasschoice(forcenewchoice) {
    assert(isdefined(level.teams[self.pers["<dev string:x28>"]]));
    team = self.pers["team"];
    if (level.disablecac == 1) {
        self.pers["class"] = level.defaultclass;
        self.curclass = level.defaultclass;
        if (self.sessionstate != "playing" && game["state"] == "playing") {
            self thread [[ level.spawnclient ]]();
        }
        level thread globallogic::updateteamstatus();
        self thread spectating::setspectatepermissionsformachine();
        return;
    }
    self openmenu(game["menu_changeclass_" + team]);
}

// Namespace globallogic_ui
// Params 0, eflags: 0x0
// Checksum 0x28668455, Offset: 0x1200
// Size: 0x74
function showmainmenuforteam() {
    assert(isdefined(level.teams[self.pers["<dev string:x28>"]]));
    team = self.pers["team"];
    self openmenu(game["menu_changeclass_" + team]);
}

// Namespace globallogic_ui
// Params 1, eflags: 0x0
// Checksum 0xd64fa18, Offset: 0x1280
// Size: 0x204
function menuteam(team) {
    self closemenus();
    if (isdefined(self.hasdonecombat) && !level.console && level.allow_teamchange == "0" && self.hasdonecombat) {
        return;
    }
    if (self.pers["team"] != team) {
        if (!isdefined(self.hasdonecombat) || level.ingraceperiod && !self.hasdonecombat) {
            self.hasspawned = 0;
        }
        if (self.sessionstate == "playing") {
            self.switching_teams = 1;
            self.joining_team = team;
            self.leaving_team = self.pers["team"];
            self suicide();
        }
        self.pers["team"] = team;
        self.team = team;
        self.pers["class"] = undefined;
        self.curclass = undefined;
        self.pers["weapon"] = undefined;
        self.pers["savedmodel"] = undefined;
        self updateobjectivetext();
        self.sessionteam = team;
        self setclientscriptmainmenu(game["menu_start_menu"]);
        self notify(#"joined_team");
        level notify(#"joined_team");
        self callback::callback(#"hash_95a6c4c0");
        self notify(#"end_respawn");
    }
    self beginclasschoice();
}

// Namespace globallogic_ui
// Params 0, eflags: 0x0
// Checksum 0x4384b87a, Offset: 0x1490
// Size: 0x182
function menuspectator() {
    self closemenus();
    if (self.pers["team"] != "spectator") {
        if (isalive(self)) {
            self.switching_teams = 1;
            self.joining_team = "spectator";
            self.leaving_team = self.pers["team"];
            self suicide();
        }
        self.pers["team"] = "spectator";
        self.team = "spectator";
        self.pers["class"] = undefined;
        self.curclass = undefined;
        self.pers["weapon"] = undefined;
        self.pers["savedmodel"] = undefined;
        self updateobjectivetext();
        self.sessionteam = "spectator";
        [[ level.spawnspectator ]]();
        self thread globallogic_player::spectate_player_watcher();
        self setclientscriptmainmenu(game["menu_start_menu"]);
        self notify(#"joined_spectators");
    }
}

// Namespace globallogic_ui
// Params 1, eflags: 0x0
// Checksum 0x310e6512, Offset: 0x1620
// Size: 0x24
function menuclass(response) {
    self closemenus();
}

// Namespace globallogic_ui
// Params 1, eflags: 0x0
// Checksum 0xe5cde140, Offset: 0x1650
// Size: 0x44
function removespawnmessageshortly(delay) {
    self endon(#"disconnect");
    waittillframeend();
    self endon(#"end_respawn");
    wait delay;
    self util::clearlowermessage(2);
}

