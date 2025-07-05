#using scripts/codescripts/struct;
#using scripts/mp/_challenges;
#using scripts/mp/_teamops;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/callbacks_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/rank_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_weapon_utils;

#namespace scoreevents;

// Namespace scoreevents
// Params 0, eflags: 0x2
// Checksum 0x64c12f86, Offset: 0x1728
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("scoreevents", &__init__, undefined, undefined);
}

// Namespace scoreevents
// Params 0, eflags: 0x0
// Checksum 0x6abb7c69, Offset: 0x1768
// Size: 0x24
function __init__() {
    callback::on_start_gametype(&init);
}

// Namespace scoreevents
// Params 0, eflags: 0x0
// Checksum 0x70a5481e, Offset: 0x1798
// Size: 0x4c
function init() {
    level.scoreeventcallbacks = [];
    level.scoreeventgameendcallback = &ongameend;
    registerscoreeventcallback("playerKilled", &scoreeventplayerkill);
}

// Namespace scoreevents
// Params 2, eflags: 0x0
// Checksum 0x5e39930a, Offset: 0x17f0
// Size: 0x52
function scoreeventtablelookupint(index, scoreeventcolumn) {
    return int(tablelookup(getscoreeventtablename(), 0, index, scoreeventcolumn));
}

// Namespace scoreevents
// Params 2, eflags: 0x0
// Checksum 0xa78c0c72, Offset: 0x1850
// Size: 0x42
function scoreeventtablelookup(index, scoreeventcolumn) {
    return tablelookup(getscoreeventtablename(), 0, index, scoreeventcolumn);
}

// Namespace scoreevents
// Params 2, eflags: 0x0
// Checksum 0xa25334bd, Offset: 0x18a0
// Size: 0x5c
function registerscoreeventcallback(callback, func) {
    if (!isdefined(level.scoreeventcallbacks[callback])) {
        level.scoreeventcallbacks[callback] = [];
    }
    level.scoreeventcallbacks[callback][level.scoreeventcallbacks[callback].size] = func;
}

// Namespace scoreevents
// Params 2, eflags: 0x0
// Checksum 0x3e9dbc23, Offset: 0x1908
// Size: 0x3104
function scoreeventplayerkill(data, time) {
    victim = data.victim;
    attacker = data.attacker;
    time = data.time;
    level.numkills++;
    attacker.lastkilledplayer = victim;
    wasdefusing = data.wasdefusing;
    wasplanting = data.wasplanting;
    victimwasonground = data.victimonground;
    attackerwasonground = data.attackeronground;
    meansofdeath = data.smeansofdeath;
    attackertraversing = data.attackertraversing;
    var_e4763e35 = data.var_e4763e35;
    var_3828b415 = data.var_3828b415;
    attackersliding = data.attackersliding;
    var_f67ec791 = data.var_f67ec791;
    var_b9995fb9 = data.var_b9995fb9;
    attackerspeedburst = data.attackerspeedburst;
    victimspeedburst = data.victimspeedburst;
    victimcombatefficieny = data.victimcombatefficieny;
    var_dc7e5b14 = data.var_dc7e5b14;
    var_8eff9c3 = data.var_8eff9c3;
    victimspeedburstlastontime = data.victimspeedburstlastontime;
    victimcombatefficiencylastontime = data.victimcombatefficiencylastontime;
    victimvisionpulseactivatetime = data.victimvisionpulseactivatetime;
    attackervisionpulseactivatetime = data.attackervisionpulseactivatetime;
    victimvisionpulseactivatetime = data.victimvisionpulseactivatetime;
    attackervisionpulsearray = data.attackervisionpulsearray;
    victimvisionpulsearray = data.victimvisionpulsearray;
    attackervisionpulseoriginarray = data.attackervisionpulseoriginarray;
    victimvisionpulseoriginarray = data.victimvisionpulseoriginarray;
    attackervisionpulseorigin = data.attackervisionpulseorigin;
    victimvisionpulseorigin = data.victimvisionpulseorigin;
    attackerwasflashed = data.attackerwasflashed;
    attackerwasconcussed = data.attackerwasconcussed;
    victimwasunderwater = data.wasunderwater;
    victimheroabilityactive = data.victimheroabilityactive;
    victimheroability = data.victimheroability;
    attackerheroabilityactive = data.attackerheroabilityactive;
    attackerheroability = data.attackerheroability;
    attackerwasheatwavestunned = data.attackerwasheatwavestunned;
    victimwasheatwavestunned = data.victimwasheatwavestunned;
    victimelectrifiedby = data.victimelectrifiedby;
    victimwasinslamstate = data.victimwasinslamstate;
    victimbledout = data.bledout;
    victimwaslungingwitharmblades = data.victimwaslungingwitharmblades;
    victimpowerarmorlasttookdamagetime = data.victimpowerarmorlasttookdamagetime;
    var_8d6b69ec = data.var_8d6b69ec;
    victimgadgetpower = data.victimgadgetpower;
    victimgadgetwasactivelastdamage = data.victimgadgetwasactivelastdamage === 1;
    victimisthieforroulette = data.victimisthieforroulette;
    attackerisroulette = data.attackerisroulette;
    victimheroabilityname = data.victimheroabilityname;
    var_7cb22418 = data.var_7cb22418;
    if (isdefined(victimheroabilityname)) {
        victimheroabilityequipped = getweapon(victimheroabilityname);
    }
    if (victimbledout == 1) {
        return;
    }
    exlosivedamage = 0;
    attackershotvictim = meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_HEAD_SHOT";
    weapon = level.weaponnone;
    inflictor = data.einflictor;
    isgrenade = 0;
    if (isdefined(data.weapon)) {
        weapon = data.weapon;
        weaponclass = util::getweaponclass(data.weapon);
        isgrenade = weapon.isgrenadeweapon;
        killstreak = killstreaks::get_from_weapon(data.weapon);
    }
    victim.anglesondeath = victim getplayerangles();
    if (meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_GRENADE_SPLASH" || meansofdeath == "MOD_EXPLOSIVE" || meansofdeath == "MOD_EXPLOSIVE_SPLASH" || meansofdeath == "MOD_PROJECTILE" || meansofdeath == "MOD_PROJECTILE_SPLASH") {
        if (weapon == level.weaponnone && isdefined(data.victim.explosiveinfo["weapon"])) {
            weapon = data.victim.explosiveinfo["weapon"];
        }
        exlosivedamage = 1;
    }
    if (!isdefined(killstreak)) {
        if (level.teambased) {
            if (isdefined(victim.lastkilltime) && victim.lastkilltime > time - 3000) {
                if (isdefined(victim.lastkilledplayer) && victim.lastkilledplayer util::isenemyplayer(attacker) == 0 && attacker != victim.lastkilledplayer) {
                    processscoreevent("kill_enemy_who_killed_teammate", attacker, victim, weapon);
                    victim recordkillmodifier("avenger");
                }
            }
            if (isdefined(victim.damagedplayers)) {
                keys = getarraykeys(victim.damagedplayers);
                for (i = 0; i < keys.size; i++) {
                    key = keys[i];
                    if (key == attacker.clientid) {
                        continue;
                    }
                    if (!isdefined(victim.damagedplayers[key].entity)) {
                        continue;
                    }
                    if (attacker util::isenemyplayer(victim.damagedplayers[key].entity)) {
                        continue;
                    }
                    if (time - victim.damagedplayers[key].time < 1000) {
                        processscoreevent("kill_enemy_injuring_teammate", attacker, victim, weapon);
                        if (isdefined(victim.damagedplayers[key].entity)) {
                            victim.damagedplayers[key].entity.lastrescuedby = attacker;
                            victim.damagedplayers[key].entity.lastrescuedtime = time;
                        }
                        victim recordkillmodifier("defender");
                    }
                }
            }
        }
        if (isgrenade == 0 || weapon.name == "hero_gravityspikes") {
            if (var_b9995fb9 == 1) {
                if (var_3828b415 == 1) {
                    processscoreevent("kill_enemy_while_both_in_air", attacker, victim, weapon);
                }
                processscoreevent("kill_enemy_that_is_in_air", attacker, victim, weapon);
                attacker addplayerstat("kill_enemy_that_in_air", 1);
            }
            if (var_3828b415 == 1) {
                processscoreevent("kill_enemy_while_in_air", attacker, victim, weapon);
                attacker addplayerstat("kill_while_in_air", 1);
            }
            if (var_f67ec791 == 1) {
                processscoreevent("kill_enemy_that_is_wallrunning", attacker, victim, weapon);
                attacker addplayerstat("kill_enemy_thats_wallrunning", 1);
            }
            if (var_e4763e35 == 1) {
                processscoreevent("kill_enemy_while_wallrunning", attacker, victim, weapon);
                attacker addplayerstat("kill_while_wallrunning", 1);
            }
            if (attackersliding == 1) {
                processscoreevent("kill_enemy_while_sliding", attacker, victim, weapon);
                attacker addplayerstat("kill_while_sliding", 1);
            }
            if (attackertraversing == 1) {
                processscoreevent("traversal_kill", attacker, victim, weapon);
                attacker addplayerstat("kill_while_mantling", 1);
            }
            if (attackerwasflashed) {
                processscoreevent("kill_enemy_while_flashbanged", attacker, victim, weapon);
            }
            if (attackerwasconcussed) {
                processscoreevent("kill_enemy_while_stunned", attacker, victim, weapon);
            }
            if (attackerwasheatwavestunned) {
                processscoreevent("kill_enemy_that_heatwaved_you", attacker, victim, weapon);
                attacker util::player_contract_event("killed_hero_ability_enemy");
            }
            if (victimwasheatwavestunned) {
                if (isdefined(victim._heat_wave_stunned_by) && isdefined(victim._heat_wave_stunned_by[attacker.clientid]) && victim._heat_wave_stunned_by[attacker.clientid] >= time) {
                    processscoreevent("heatwave_kill", attacker, victim, weapon);
                    attacker hero_ability_kill_event(getweapon("gadget_heat_wave"), get_equipped_hero_ability(victimheroabilityname));
                    attacker specialistmedalachievement();
                    attacker thread specialiststatabilityusage(4, 0);
                }
                if (attackerisroulette && !victimisthieforroulette && victimheroabilityname === "gadget_heat_wave") {
                    processscoreevent("kill_enemy_with_their_hero_ability", attacker, victim, weapon);
                }
            }
        }
        if (attackerspeedburst == 1) {
            processscoreevent("speed_burst_kill", attacker, victim, weapon);
            attacker hero_ability_kill_event(getweapon("gadget_speed_burst"), get_equipped_hero_ability(victimheroabilityname));
            attacker specialistmedalachievement();
            attacker thread specialiststatabilityusage(4, 0);
            if (attackerisroulette && !victimisthieforroulette && victimheroabilityname === "gadget_speed_burst") {
                processscoreevent("kill_enemy_with_their_hero_ability", attacker, victim, weapon);
            }
        }
        if (victimspeedburstlastontime > time - 50) {
            processscoreevent("kill_enemy_who_is_speedbursting", attacker, victim, weapon);
            attacker util::player_contract_event("killed_hero_ability_enemy");
        }
        if (victimcombatefficiencylastontime > time - 50) {
            processscoreevent("kill_enemy_who_is_using_focus", attacker, victim, weapon);
            attacker util::player_contract_event("killed_hero_ability_enemy");
        }
        if (var_dc7e5b14 != 0 && var_dc7e5b14 > time - 4000) {
            processscoreevent("flashback_kill", attacker, victim, weapon);
            attacker hero_ability_kill_event(getweapon("gadget_flashback"), get_equipped_hero_ability(victimheroabilityname));
            attacker specialistmedalachievement();
            attacker thread specialiststatabilityusage(4, 0);
            if (attackerisroulette && !victimisthieforroulette && victimheroabilityname === "gadget_flashback") {
                processscoreevent("kill_enemy_with_their_hero_ability", attacker, victim, weapon);
            }
        }
        if (var_8eff9c3 != 0 && var_8eff9c3 > time - 4000) {
            processscoreevent("kill_enemy_who_has_flashbacked", attacker, victim, weapon);
            attacker util::player_contract_event("killed_hero_ability_enemy");
        }
        if (victimwasinslamstate) {
            processscoreevent("end_enemy_gravity_spike_attack", attacker, victim, weapon);
            attacker util::player_contract_event("killed_hero_weapon_enemy");
        }
        if (challenges::ishighestscoringplayer(victim)) {
            processscoreevent("kill_enemy_who_has_high_score", attacker, victim, weapon);
        }
        if (victimwasunderwater && exlosivedamage) {
            processscoreevent("kill_underwater_enemy_explosive", attacker, victim, weapon);
        }
        if (isdefined(victimelectrifiedby) && victimelectrifiedby != attacker) {
            processscoreevent("electrified", victimelectrifiedby, victim, weapon);
        }
        if (victimvisionpulseactivatetime != 0 && victimvisionpulseactivatetime > time - 4000) {
            gadgetweapon = getweapon("gadget_vision_pulse");
            for (i = 0; i < victimvisionpulsearray.size; i++) {
                player = victimvisionpulsearray[i];
                if (player == attacker) {
                    gadget = getweapon("gadget_vision_pulse");
                    if (victimvisionpulseactivatetime + 300 > time - gadgetweapon.gadget_pulse_duration) {
                        distancetopulse = distance(victimvisionpulseoriginarray[i], victimvisionpulseorigin);
                        ratio = distancetopulse / gadgetweapon.gadget_pulse_max_range;
                        timing = ratio * gadgetweapon.gadget_pulse_duration;
                        if (victimvisionpulseactivatetime + 300 > time - timing) {
                            break;
                        }
                    }
                    processscoreevent("kill_enemy_that_pulsed_you", attacker, victim, weapon);
                    attacker util::player_contract_event("killed_hero_ability_enemy");
                    break;
                }
            }
            if (isdefined(victimheroability)) {
                attacker notify(#"hero_shutdown", victimheroability);
                attacker notify(#"hero_shutdown_gadget", victimheroability, victim);
            }
        }
        if (attackervisionpulseactivatetime != 0 && attackervisionpulseactivatetime > time - 6500) {
            gadgetweapon = getweapon("gadget_vision_pulse");
            for (i = 0; i < attackervisionpulsearray.size; i++) {
                player = attackervisionpulsearray[i];
                if (player == victim) {
                    gadget = getweapon("gadget_vision_pulse");
                    if (attackervisionpulseactivatetime > time - gadgetweapon.gadget_pulse_duration) {
                        distancetopulse = distance(attackervisionpulseoriginarray[i], attackervisionpulseorigin);
                        ratio = distancetopulse / gadgetweapon.gadget_pulse_max_range;
                        timing = ratio * gadgetweapon.gadget_pulse_duration;
                        if (attackervisionpulseactivatetime > time - timing) {
                            break;
                        }
                    }
                    processscoreevent("vision_pulse_kill", attacker, victim, weapon);
                    attacker hero_ability_kill_event(gadgetweapon, get_equipped_hero_ability(victimheroabilityname));
                    attacker specialistmedalachievement();
                    attacker thread specialiststatabilityusage(4, 0);
                    if (attackerisroulette && !victimisthieforroulette && victimheroabilityname === "gadget_vision_pulse") {
                        processscoreevent("kill_enemy_with_their_hero_ability", attacker, victim, weapon);
                    }
                    break;
                }
            }
        }
        if (victimheroabilityactive && isdefined(victimheroability)) {
            attacker notify(#"hero_shutdown", victimheroability);
            attacker notify(#"hero_shutdown_gadget", victimheroability, victim);
            switch (victimheroability.name) {
            case "gadget_armor":
                processscoreevent("kill_enemy_who_has_powerarmor", attacker, victim, weapon);
                attacker util::player_contract_event("killed_hero_ability_enemy");
                break;
            case "gadget_resurrect":
                processscoreevent("kill_enemy_that_used_resurrect", attacker, victim, weapon);
                attacker util::player_contract_event("killed_hero_ability_enemy");
                break;
            case "gadget_camo":
                processscoreevent("kill_enemy_that_is_using_optic_camo", attacker, victim, weapon);
                attacker util::player_contract_event("killed_hero_ability_enemy");
                break;
            case "gadget_clone":
                processscoreevent("end_enemy_psychosis", attacker, victim, weapon);
                attacker util::player_contract_event("killed_hero_ability_enemy");
                break;
            }
        } else if (isdefined(victimpowerarmorlasttookdamagetime) && time - victimpowerarmorlasttookdamagetime <= 3000) {
            attacker notify(#"hero_shutdown", victimheroability);
            attacker notify(#"hero_shutdown_gadget", victimheroability, victim);
            processscoreevent("kill_enemy_who_has_powerarmor", attacker, victim, weapon);
            attacker util::player_contract_event("killed_hero_ability_enemy");
        }
        if (isdefined(data.victimweapon) && isdefined(data.victimweapon.isheroweapon) && data.victimweapon.isheroweapon == 1) {
            attacker notify(#"hero_shutdown", data.victimweapon);
            attacker notify(#"hero_shutdown_gadget", data.victimweapon, victim);
        } else if (isdefined(victim.heroweapon) && victimgadgetwasactivelastdamage && victimgadgetpower < 100) {
            attacker notify(#"hero_shutdown", victim.heroweapon);
            attacker notify(#"hero_shutdown_gadget", victim.heroweapon, victim);
        }
        if (attackerheroabilityactive && isdefined(attackerheroability)) {
            abilitytocheck = undefined;
            switch (attackerheroability.name) {
            case "gadget_armor":
                processscoreevent("power_armor_kill", attacker, victim, weapon);
                attacker hero_ability_kill_event(attackerheroability, get_equipped_hero_ability(victimheroabilityname));
                attacker specialistmedalachievement();
                attacker thread specialiststatabilityusage(4, 0);
                abilitytocheck = attackerheroability.name;
                break;
            case "gadget_resurrect":
                processscoreevent("resurrect_kill", attacker, victim, weapon);
                attacker hero_ability_kill_event(attackerheroability, get_equipped_hero_ability(victimheroabilityname));
                attacker specialistmedalachievement();
                attacker thread specialiststatabilityusage(4, 0);
                abilitytocheck = attackerheroability.name;
                break;
            case "gadget_camo":
                processscoreevent("optic_camo_kill", attacker, victim, weapon);
                attacker hero_ability_kill_event(attackerheroability, get_equipped_hero_ability(victimheroabilityname));
                attacker specialistmedalachievement();
                attacker thread specialiststatabilityusage(4, 0);
                abilitytocheck = attackerheroability.name;
                break;
            case "gadget_clone":
                processscoreevent("kill_enemy_while_using_psychosis", attacker, victim, weapon);
                attacker hero_ability_kill_event(attackerheroability, get_equipped_hero_ability(victimheroabilityname));
                attacker specialistmedalachievement();
                attacker thread specialiststatabilityusage(4, 0);
                abilitytocheck = attackerheroability.name;
                break;
            }
            if (attackerisroulette && !victimisthieforroulette && isdefined(abilitytocheck) && victimheroabilityname === abilitytocheck) {
                processscoreevent("kill_enemy_with_their_hero_ability", attacker, victim, weapon);
            }
        }
        if (victimwaslungingwitharmblades) {
            processscoreevent("end_enemy_armblades_attack", attacker, victim, weapon);
        }
        if (isdefined(data.victimweapon)) {
            function_2a6156(attacker, victim, weapon, data.victimweapon, victimgadgetpower, victimgadgetwasactivelastdamage);
            if (data.victimweapon.name == "minigun") {
                processscoreevent("killed_death_machine_enemy", attacker, victim, weapon);
            } else if (data.victimweapon.name == "m32") {
                processscoreevent("killed_multiple_grenade_launcher_enemy", attacker, victim, weapon);
            }
            var_c2d7abde = isdefined(victim.heroweapon) && victim.heroweapon.name == "hero_armblade" && victimgadgetwasactivelastdamage;
            if ((data.victimweapon.inventorytype == "hero" || var_c2d7abde) && victimgadgetpower < 100) {
                if (var_8d6b69ec == 0) {
                    attacker addplayerstat("kill_before_specialist_weapon_use", 1);
                }
                if (weapon.inventorytype == "hero") {
                    attacker addplayerstat("kill_specialist_with_specialist", 1);
                }
                var_eceaee76 = isdefined(attacker.heroweapon) && attacker.heroweapon.name == "gadget_thief";
                if (!var_eceaee76) {
                    processscoreevent("end_enemy_specialist_weapon", attacker, victim, weapon);
                }
            }
        }
        if (weapon.rootweapon.name == "frag_grenade") {
            attacker thread function_22ab88ed(victim, weapon, weaponclass, killstreak);
        }
        attacker thread updatemultikills(weapon, weaponclass, killstreak, victim);
        if (level.numkills == 1) {
            victim recordkillmodifier("firstblood");
            processscoreevent("first_kill", attacker, victim, weapon);
        } else {
            if (isdefined(attacker.lastkilledby)) {
                if (attacker.lastkilledby == victim) {
                    level.globalpaybacks++;
                    processscoreevent("revenge_kill", attacker, victim, weapon);
                    attacker addweaponstat(weapon, "revenge_kill", 1);
                    victim recordkillmodifier("revenge");
                    attacker.lastkilledby = undefined;
                }
            }
            if (victim killstreaks::is_an_a_killstreak()) {
                level.globalbuzzkills++;
                processscoreevent("stop_enemy_killstreak", attacker, victim, weapon);
                victim recordkillmodifier("buzzkill");
            }
            if (isdefined(victim.lastmansd) && victim.lastmansd == 1) {
                processscoreevent("final_kill_elimination", attacker, victim, weapon);
                if (isdefined(attacker.lastmansd) && attacker.lastmansd == 1) {
                    processscoreevent("elimination_and_last_player_alive", attacker, victim, weapon);
                }
            }
        }
        if (is_weapon_valid(meansofdeath, weapon, weaponclass, killstreak)) {
            if (isdefined(victim.vattackerorigin)) {
                attackerorigin = victim.vattackerorigin;
            } else {
                attackerorigin = attacker.origin;
            }
            disttovictim = distancesquared(victim.origin, attackerorigin);
            weap_min_dmg_range = get_distance_for_weapon(weapon, weaponclass);
            if (disttovictim > weap_min_dmg_range) {
                attacker challenges::longdistancekillmp(weapon);
                if (weapon.rootweapon.name == "hatchet") {
                    attacker challenges::longdistancehatchetkill();
                }
                processscoreevent("longshot_kill", attacker, victim, weapon);
                attacker.pers["longshots"]++;
                attacker.longshots = attacker.pers["longshots"];
                victim recordkillmodifier("longshot");
            }
            killdistance = distance(victim.origin, attackerorigin);
            attacker.pers["kill_distances"] = attacker.pers["kill_distances"] + killdistance;
            attacker.pers["num_kill_distance_entries"]++;
        }
        if (isalive(attacker)) {
            if (attacker.health < attacker.maxhealth * 0.35) {
                attacker.lastkillwheninjured = time;
                processscoreevent("kill_enemy_when_injured", attacker, victim, weapon);
                attacker addweaponstat(weapon, "kill_enemy_when_injured", 1);
                if (attacker util::has_toughness_perk_purchased_and_equipped()) {
                    attacker addplayerstat("perk_bulletflinch_kills", 1);
                }
            }
        } else if (isdefined(attacker.deathtime) && attacker.deathtime + 800 < time && !attacker isinvehicle()) {
            level.globalafterlifes++;
            processscoreevent("kill_enemy_after_death", attacker, victim, weapon);
            victim recordkillmodifier("posthumous");
        }
        if (attacker.cur_death_streak >= 3) {
            level.globalcomebacks++;
            processscoreevent("comeback_from_deathstreak", attacker, victim, weapon);
            victim recordkillmodifier("comeback");
        }
        if (isdefined(victim.lastmicrowavedby)) {
            foreach (beingmicrowavedby in victim.beingmicrowavedby) {
                if (isdefined(beingmicrowavedby) && attacker util::isenemyplayer(beingmicrowavedby) == 0) {
                    if (beingmicrowavedby != attacker) {
                        scoregiven = processscoreevent("microwave_turret_assist", beingmicrowavedby, victim, weapon);
                        if (isdefined(scoregiven)) {
                            beingmicrowavedby challenges::earnedmicrowaveassistscore(scoregiven);
                        }
                        continue;
                    }
                    attackermicrowavedvictim = 1;
                }
            }
            if (attackermicrowavedvictim === 1 && weapon.name != "microwave_turret") {
                attacker challenges::killwhiledamagingwithhpm();
            }
        }
        if (weapon_utils::ismeleemod(meansofdeath) && !weapon.isriotshield) {
            attacker.pers["stabs"]++;
            attacker.stabs = attacker.pers["stabs"];
            if (meansofdeath == "MOD_MELEE_WEAPON_BUTT" && weapon.name != "ball") {
                processscoreevent("kill_enemy_with_gunbutt", attacker, victim, weapon);
            } else if (weapon_utils::ispunch(weapon)) {
                processscoreevent("kill_enemy_with_fists", attacker, victim, weapon);
            } else if (weapon_utils::isnonbarehandsmelee(weapon)) {
                vangles = victim.anglesondeath[1];
                pangles = attacker.anglesonkill[1];
                anglediff = angleclamp180(vangles - pangles);
                if (anglediff > -30 && anglediff < 70) {
                    level.globalbackstabs++;
                    processscoreevent("backstabber_kill", attacker, victim, weapon);
                    weaponpickedup = 0;
                    if (isdefined(attacker.pickedupweapons) && isdefined(attacker.pickedupweapons[weapon])) {
                        weaponpickedup = 1;
                    }
                    attacker addweaponstat(weapon, "backstabber_kill", 1, attacker.class_num, weaponpickedup, undefined, attacker.primaryloadoutgunsmithvariantindex, attacker.secondaryloadoutgunsmithvariantindex);
                    attacker.pers["backstabs"]++;
                    attacker.backstabs = attacker.pers["backstabs"];
                }
            }
        } else if (isdefined(victim.firsttimedamaged) && victim.firsttimedamaged == time && !(isdefined(weapon.isheroweapon) && weapon.isheroweapon)) {
            if (attackershotvictim) {
                attacker thread updateoneshotmultikills(victim, weapon, victim.firsttimedamaged);
                attacker addweaponstat(weapon, "kill_enemy_one_bullet", 1);
            }
        }
        if (isdefined(attacker.tookweaponfrom) && isdefined(attacker.tookweaponfrom[weapon]) && isdefined(attacker.tookweaponfrom[weapon].previousowner)) {
            pickedupweapon = attacker.tookweaponfrom[weapon];
            if (pickedupweapon.previousowner == victim) {
                processscoreevent("kill_enemy_with_their_weapon", attacker, victim, weapon);
                attacker addweaponstat(weapon, "kill_enemy_with_their_weapon", 1);
                if (isdefined(pickedupweapon.sweapon) && isdefined(pickedupweapon.smeansofdeath) && weapon_utils::ismeleemod(pickedupweapon.smeansofdeath)) {
                    foreach (meleeweapon in level.meleeweapons) {
                        if (weapon != meleeweapon && pickedupweapon.sweapon.rootweapon == meleeweapon) {
                            attacker addweaponstat(meleeweapon, "kill_enemy_with_their_weapon", 1);
                            break;
                        }
                    }
                }
            }
        }
        if (wasdefusing) {
            processscoreevent("killed_bomb_defuser", attacker, victim, weapon);
        } else if (wasplanting) {
            processscoreevent("killed_bomb_planter", attacker, victim, weapon);
        }
        function_3ae86df1(attacker, victim, weapon);
    }
    specificweaponkill(attacker, victim, weapon, killstreak, inflictor);
    if (weapon.name == "helicopter_gunner_turret_secondary" || isdefined(level.vtol) && isdefined(level.vtol.owner) && weapon.name == "helicopter_gunner_turret_tertiary") {
        attacker addplayerstat("kill_as_support_gunner", 1);
        processscoreevent("mothership_assist_kill", level.vtol.owner, victim, weapon);
    }
    if (isdefined(var_7cb22418)) {
        if (var_7cb22418 == "siegebot") {
            if (meansofdeath == "MOD_CRUSH") {
                processscoreevent("kill_enemy_with_siegebot_crush", attacker, victim, weapon);
            }
            if (!isdefined(attacker.var_881b2df7)) {
                attacker.var_881b2df7 = 0;
            }
            attacker.var_881b2df7++;
            if (attacker.var_881b2df7 % 5 == 0) {
                processscoreevent("siegebot_killstreak_5", attacker, victim, weapon);
            }
        }
    }
    switch (weapon.rootweapon.name) {
    case "hatchet":
        attacker.pers["tomahawks"]++;
        attacker.tomahawks = attacker.pers["tomahawks"];
        processscoreevent("hatchet_kill", attacker, victim, weapon);
        if (isdefined(data.victim.explosiveinfo["projectile_bounced"]) && data.victim.explosiveinfo["projectile_bounced"] == 1) {
            level.globalbankshots++;
            processscoreevent("bounce_hatchet_kill", attacker, victim, weapon);
        }
        break;
    case "inventory_supplydrop":
    case "inventory_supplydrop_marker":
    case "supplydrop":
    case "supplydrop_marker":
        if (meansofdeath == "MOD_HIT_BY_OBJECT" || meansofdeath == "MOD_CRUSH") {
            processscoreevent("kill_enemy_with_care_package_crush", attacker, victim, weapon);
        } else {
            processscoreevent("kill_enemy_with_hacked_care_package", attacker, victim, weapon);
        }
        break;
    }
    if (isdefined(killstreak)) {
        attacker thread updatemultikills(weapon, weaponclass, killstreak, victim);
        victim recordkillmodifier("killstreak");
    }
    attacker.cur_death_streak = 0;
    attacker disabledeathstreak();
}

// Namespace scoreevents
// Params 1, eflags: 0x0
// Checksum 0x59a60fa6, Offset: 0x4a18
// Size: 0x32
function get_equipped_hero_ability(ability_name) {
    if (!isdefined(ability_name)) {
        return undefined;
    }
    return getweapon(ability_name);
}

// Namespace scoreevents
// Params 3, eflags: 0x0
// Checksum 0xd4876161, Offset: 0x4a58
// Size: 0x1b4
function function_3ae86df1(attacker, victim, weapon) {
    if (!isdefined(weapon)) {
        return;
    }
    if (isdefined(weapon.isheroweapon) && !weapon.isheroweapon) {
        return;
    }
    switch (weapon.name) {
    case "hero_minigun":
    case "hero_minigun_body3":
        event = "minigun_kill";
        break;
    case "hero_flamethrower":
        event = "flamethrower_kill";
        break;
    case "hero_lightninggun":
    case "hero_lightninggun_arc":
        event = "lightninggun_kill";
        break;
    case "hero_chemicalgelgun":
    case "hero_firefly_swarm":
        event = "gelgun_kill";
        break;
    case "hero_pineapple_grenade":
    case "hero_pineapplegun":
        event = "pineapple_kill";
        break;
    case "hero_armblade":
        event = "armblades_kill";
        break;
    case "hero_bowlauncher":
    case "hero_bowlauncher2":
    case "hero_bowlauncher3":
    case "hero_bowlauncher4":
        event = "bowlauncher_kill";
        break;
    case "hero_gravityspikes":
        event = "gravityspikes_kill";
        break;
    case "hero_annihilator":
        event = "annihilator_kill";
        break;
    default:
        return;
    }
    processscoreevent(event, attacker, victim, weapon);
}

// Namespace scoreevents
// Params 6, eflags: 0x0
// Checksum 0x8f84e64b, Offset: 0x4c18
// Size: 0x1fc
function function_2a6156(attacker, victim, weapon, victim_weapon, victim_gadget_power, victimgadgetwasactivelastdamage) {
    if (!isdefined(victim_weapon)) {
        return;
    }
    if (victim_gadget_power >= 100) {
        return;
    }
    switch (victim_weapon.name) {
    case "hero_minigun":
    case "hero_minigun_body3":
        event = "killed_minigun_enemy";
        break;
    case "hero_flamethrower":
        event = "killed_flamethrower_enemy";
        break;
    case "hero_lightninggun":
    case "hero_lightninggun_arc":
        event = "killed_lightninggun_enemy";
        break;
    case "hero_chemicalgelgun":
        event = "killed_gelgun_enemy";
        break;
    case "hero_pineapplegun":
        event = "killed_pineapple_enemy";
        break;
    case "hero_bowlauncher":
    case "hero_bowlauncher2":
    case "hero_bowlauncher3":
    case "hero_bowlauncher4":
        event = "killed_bowlauncher_enemy";
        break;
    case "hero_gravityspikes":
        event = "killed_gravityspikes_enemy";
        break;
    case "hero_annihilator":
        event = "killed_annihilator_enemy";
        break;
    default:
        if (isdefined(victim.heroweapon) && victim.heroweapon.name == "hero_armblade" && victimgadgetwasactivelastdamage) {
            event = "killed_armblades_enemy";
        } else {
            return;
        }
        break;
    }
    processscoreevent(event, attacker, victim, weapon);
    attacker util::player_contract_event("killed_hero_weapon_enemy");
}

// Namespace scoreevents
// Params 5, eflags: 0x0
// Checksum 0x6b553ecd, Offset: 0x4e20
// Size: 0x3ec
function specificweaponkill(attacker, victim, weapon, killstreak, inflictor) {
    switchweapon = weapon.name;
    if (isdefined(killstreak)) {
        switchweapon = killstreak;
    }
    switch (switchweapon) {
    case "inventory_remote_missile":
    case "remote_missile":
        event = "remote_missile_kill";
        break;
    case "autoturret":
    case "inventory_autoturret":
        event = "sentry_gun_kill";
        break;
    case "inventory_planemortar":
    case "planemortar":
        event = "plane_mortar_kill";
        break;
    case "ai_tank_drop":
    case "inventory_ai_tank_drop":
        event = "aitank_kill";
        if (isdefined(inflictor) && isdefined(inflictor.controlled)) {
            if (inflictor.controlled == 1) {
                attacker addplayerstat("kill_with_controlled_ai_tank", 1);
            }
        }
        break;
    case "inventory_microwave_turret":
    case "inventory_microwaveturret":
    case "microwave_turret":
    case "microwaveturret":
        event = "microwave_turret_kill";
        break;
    case "inventory_raps":
    case "raps":
        event = "raps_kill";
        break;
    case "inventory_sentinel":
    case "sentinel":
        event = "sentinel_kill";
        if (isdefined(inflictor) && isdefined(inflictor.controlled)) {
            if (inflictor.controlled == 1) {
                attacker addplayerstat("kill_with_controlled_sentinel", 1);
            }
        }
        break;
    case "combat_robot":
    case "inventory_combat_robot":
        event = "combat_robot_kill";
        break;
    case "inventory_rcbomb":
    case "rcbomb":
        event = "hover_rcxd_kill";
        break;
    case "helicopter_gunner":
    case "helicopter_gunner_assistant":
    case "inventory_helicopter_gunner":
    case "inventory_helicopter_gunner_assistant":
        event = "vtol_mothership_kill";
        break;
    case "helicopter_comlink":
    case "inventory_helicopter_comlink":
        event = "helicopter_comlink_kill";
        break;
    case "drone_strike":
    case "inventory_drone_strike":
        event = "drone_strike_kill";
        break;
    case "dart":
    case "dart_turret":
    case "inventory_dart":
        event = "dart_kill";
        break;
    default:
        return;
    }
    if (isdefined(inflictor)) {
        if (isdefined(inflictor.killstreak_id) && isdefined(level.matchrecorderkillstreakkills[inflictor.killstreak_id])) {
            level.matchrecorderkillstreakkills[inflictor.killstreak_id]++;
        } else if (isdefined(inflictor.killcament) && isdefined(inflictor.killcament.killstreak_id) && isdefined(level.matchrecorderkillstreakkills[inflictor.killcament.killstreak_id])) {
            level.matchrecorderkillstreakkills[inflictor.killcament.killstreak_id]++;
        }
    }
    processscoreevent(event, attacker, victim, weapon);
}

// Namespace scoreevents
// Params 2, eflags: 0x0
// Checksum 0x1598000d, Offset: 0x5218
// Size: 0x104
function multikill(killcount, weapon) {
    assert(killcount > 1);
    self challenges::multikill(killcount, weapon);
    if (killcount > 8) {
        processscoreevent("multikill_more_than_8", self, undefined, weapon);
    } else {
        processscoreevent("multikill_" + killcount, self, undefined, weapon);
    }
    if (killcount > 2) {
        if (isdefined(self.challenge_objectivedefensivekillcount) && self.challenge_objectivedefensivekillcount > 0) {
            self.challenge_objectivedefensivetriplekillmedalorbetterearned = 1;
        }
    }
    self recordmultikill(killcount);
}

// Namespace scoreevents
// Params 2, eflags: 0x0
// Checksum 0x1253c2f, Offset: 0x5328
// Size: 0x114
function multiheroabilitykill(killcount, weapon) {
    if (killcount > 1) {
        self addplayerstat("multikill_2_with_heroability", int(killcount / 2));
        self addweaponstat(weapon, "heroability_doublekill", int(killcount / 2));
        self addplayerstat("multikill_3_with_heroability", int(killcount / 3));
        self addweaponstat(weapon, "heroability_triplekill", int(killcount / 3));
    }
}

// Namespace scoreevents
// Params 4, eflags: 0x0
// Checksum 0xa22cc850, Offset: 0x5448
// Size: 0x1d6
function is_weapon_valid(meansofdeath, weapon, weaponclass, killstreak) {
    valid_weapon = 0;
    if (isdefined(killstreak)) {
        valid_weapon = 0;
    } else if (get_distance_for_weapon(weapon, weaponclass) == 0) {
        valid_weapon = 0;
    } else if (meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_RIFLE_BULLET") {
        valid_weapon = 1;
    } else if (meansofdeath == "MOD_HEAD_SHOT") {
        valid_weapon = 1;
    } else if (weapon.rootweapon.name == "hatchet" && meansofdeath == "MOD_IMPACT") {
        valid_weapon = 1;
    } else {
        baseweapon = challenges::getbaseweapon(weapon);
        if (baseweapon == level.weaponspecialcrossbow && meansofdeath == "MOD_IMPACT") {
            valid_weapon = 1;
        } else if (baseweapon == level.weaponballisticknife && meansofdeath == "MOD_IMPACT") {
            valid_weapon = 1;
        } else if ((baseweapon.forcedamagehitlocation || baseweapon == level.weaponshotgunenergy || baseweapon == level.var_a0d4ce4d) && meansofdeath == "MOD_PROJECTILE") {
            valid_weapon = 1;
        }
    }
    return valid_weapon;
}

// Namespace scoreevents
// Params 4, eflags: 0x0
// Checksum 0x892fd8fa, Offset: 0x5628
// Size: 0x110
function function_22ab88ed(victim, weapon, weaponclass, killstreak) {
    self endon(#"disconnect");
    level endon(#"game_ended");
    self notify(#"hash_22ab88ed");
    self endon(#"hash_22ab88ed");
    if (!isdefined(self.var_1b55e77a) || self.var_253ec259 != victim.explosiveinfo["damageid"]) {
        self.var_1b55e77a = 0;
    }
    self.var_253ec259 = victim.explosiveinfo["damageid"];
    self.var_1b55e77a++;
    self waittilltimeoutordeath(0.05);
    if (self.var_1b55e77a >= 2) {
        processscoreevent("frag_multikill", self, victim, weapon);
    }
    self.var_1b55e77a = 0;
}

// Namespace scoreevents
// Params 4, eflags: 0x0
// Checksum 0x1189eefa, Offset: 0x5740
// Size: 0xd54
function updatemultikills(weapon, weaponclass, killstreak, victim) {
    self endon(#"disconnect");
    level endon(#"game_ended");
    self notify(#"updaterecentkills");
    self endon(#"updaterecentkills");
    baseweaponparam = [[ level.var_2453cf4a ]](weapon);
    baseweapon = getweapon(getreffromitemindex(getbaseweaponitemindex(baseweaponparam)));
    if (!isdefined(self.recentkillvariables)) {
        self resetrecentkillvariables();
    }
    if (!isdefined(self.recentkillcountweapon) || self.recentkillcountweapon != baseweapon) {
        self.recentkillcountsameweapon = 0;
        self.recentkillcountweapon = baseweapon;
    }
    if (!isdefined(killstreak)) {
        self.recentkillcountsameweapon++;
        self.recentkillcount++;
    }
    if (isdefined(weaponclass)) {
        if (weaponclass == "weapon_lmg" || weaponclass == "weapon_smg") {
            if (self playerads() < 1) {
                self.recent_lmg_smg_killcount++;
            }
        }
        if (weaponclass == "weapon_grenade") {
            self.recentlethalcount++;
        }
    }
    if (weapon.name == "satchel_charge") {
        self.recentc4killcount++;
    }
    if (isdefined(level.killstreakweapons) && isdefined(level.killstreakweapons[weapon])) {
        switch (level.killstreakweapons[weapon]) {
        case "inventory_remote_missile":
        case "remote_missile":
            self.recentremotemissilecount++;
            break;
        case "inventory_rcbomb":
        case "rcbomb":
            self.recentrcbombcount++;
            break;
        }
    }
    if (isdefined(weapon.isheroweapon) && weapon.isheroweapon == 1) {
        self.var_93b3a434 = gettime();
        self.recentheroweaponkillcount++;
        if (isdefined(victim)) {
            self.var_c9da93ab[victim getentitynumber()] = victim;
        }
        switch (weapon.name) {
        case "hero_annihilator":
            self.recentanihilatorcount++;
            break;
        case "hero_minigun":
        case "hero_minigun_body3":
            self.recentminiguncount++;
            break;
        case "hero_bowlauncher":
        case "hero_bowlauncher2":
        case "hero_bowlauncher3":
        case "hero_bowlauncher4":
            self.recentbowlaunchercount++;
            break;
        case "hero_flamethrower":
            self.recentflamethrowercount++;
            break;
        case "hero_gravityspikes":
            self.var_a0ea7e5c++;
            break;
        case "hero_lightninggun":
        case "hero_lightninggun_arc":
            self.recentlightningguncount++;
            break;
        case "hero_pineapple_grenade":
        case "hero_pineapplegun":
            self.recentpineappleguncount++;
            break;
        case "hero_chemicalgun":
        case "hero_firefly_swarm":
            self.recentgelguncount++;
            break;
        case "hero_armblade":
            self.recentarmbladecount++;
            break;
        }
    }
    if (isdefined(self.heroability) && isdefined(victim)) {
        if (victim ability_player::gadget_checkheroabilitykill(self)) {
            if (isdefined(self.recentheroabilitykillweapon) && self.recentheroabilitykillweapon != self.heroability) {
                self.recentheroabilitykillcount = 0;
            }
            self.recentheroabilitykillweapon = self.heroability;
            self.recentheroabilitykillcount++;
        }
    }
    if (isdefined(killstreak)) {
        switch (killstreak) {
        case "remote_missile":
            self.recentremotemissilekillcount++;
            break;
        case "rcbomb":
            self.recentrcbombkillcount++;
            break;
        case "inventory_m32":
        case "m32":
            self.recentmglkillcount++;
            break;
        }
    }
    if (self.recentkillcountsameweapon == 2) {
        self addweaponstat(weapon, "multikill_2", 1);
    } else if (self.recentkillcountsameweapon == 3) {
        self addweaponstat(weapon, "multikill_3", 1);
    }
    self waittilltimeoutordeath(4);
    if (self.recent_lmg_smg_killcount >= 3) {
        self challenges::multi_lmg_smg_kill();
    }
    if (self.recentrcbombkillcount >= 2) {
        self challenges::multi_rcbomb_kill();
    }
    if (self.recentmglkillcount >= 3) {
        self challenges::multi_mgl_kill();
    }
    if (self.recentremotemissilekillcount >= 3) {
        self challenges::multi_remotemissile_kill();
    }
    if (self.recentheroweaponkillcount > 1) {
        self hero_weapon_multikill_event(self.recentheroweaponkillcount, weapon);
    }
    if (self.recentheroweaponkillcount > 5) {
        arrayremovevalue(self.var_c9da93ab, undefined);
        if (self.var_c9da93ab.size > 5) {
            self addplayerstat("kill_entire_team_with_specialist_weapon", 1);
        }
    }
    if (self.recentanihilatorcount >= 3) {
        processscoreevent("annihilator_multikill", self, undefined, weapon);
        self multikillmedalachievement();
    } else if (self.recentanihilatorcount == 2) {
        processscoreevent("annihilator_multikill_2", self, undefined, weapon);
        self multikillmedalachievement();
    }
    if (self.recentminiguncount >= 3) {
        processscoreevent("minigun_multikill", self, undefined, weapon);
        self multikillmedalachievement();
    } else if (self.recentminiguncount == 2) {
        processscoreevent("minigun_multikill_2", self, undefined, weapon);
        self multikillmedalachievement();
    }
    if (self.recentbowlaunchercount >= 3) {
        processscoreevent("bowlauncher_multikill", self, undefined, weapon);
        self multikillmedalachievement();
    } else if (self.recentbowlaunchercount == 2) {
        processscoreevent("bowlauncher_multikill_2", self, undefined, weapon);
        self multikillmedalachievement();
    }
    if (self.recentflamethrowercount >= 3) {
        processscoreevent("flamethrower_multikill", self, undefined, weapon);
        self multikillmedalachievement();
    } else if (self.recentflamethrowercount == 2) {
        processscoreevent("flamethrower_multikill_2", self, undefined, weapon);
        self multikillmedalachievement();
    }
    if (self.var_a0ea7e5c >= 3) {
        processscoreevent("gravityspikes_multikill", self, undefined, weapon);
        self multikillmedalachievement();
    } else if (self.var_a0ea7e5c == 2) {
        processscoreevent("gravityspikes_multikill_2", self, undefined, weapon);
        self multikillmedalachievement();
    }
    if (self.recentlightningguncount >= 3) {
        processscoreevent("lightninggun_multikill", self, undefined, weapon);
        self multikillmedalachievement();
    } else if (self.recentlightningguncount == 2) {
        processscoreevent("lightninggun_multikill_2", self, undefined, weapon);
        self multikillmedalachievement();
    }
    if (self.recentpineappleguncount >= 3) {
        processscoreevent("pineapple_multikill", self, undefined, weapon);
        self multikillmedalachievement();
    } else if (self.recentpineappleguncount == 2) {
        processscoreevent("pineapple_multikill_2", self, undefined, weapon);
        self multikillmedalachievement();
    }
    if (self.recentgelguncount >= 3) {
        processscoreevent("gelgun_multikill", self, undefined, weapon);
        self multikillmedalachievement();
    } else if (self.recentgelguncount == 2) {
        processscoreevent("gelgun_multikill_2", self, undefined, weapon);
        self multikillmedalachievement();
    }
    if (self.recentarmbladecount >= 3) {
        processscoreevent("armblades_multikill", self, undefined, weapon);
        self multikillmedalachievement();
    } else if (self.recentarmbladecount == 2) {
        processscoreevent("armblades_multikill_2", self, undefined, weapon);
        self multikillmedalachievement();
    }
    if (self.recentc4killcount >= 2) {
        processscoreevent("c4_multikill", self, undefined, weapon);
    }
    if (self.recentremotemissilecount >= 3) {
        self addplayerstat("multikill_3_remote_missile", 1);
    }
    if (self.recentrcbombcount >= 2) {
        self addplayerstat("multikill_2_rcbomb", 1);
    }
    if (self.recentlethalcount >= 2) {
        if (!isdefined(self.pers["challenge_kills_double_kill_lethal"])) {
            self.pers["challenge_kills_double_kill_lethal"] = 0;
        }
        self.pers["challenge_kills_double_kill_lethal"]++;
        if (self.pers["challenge_kills_double_kill_lethal"] >= 3) {
            self addplayerstat("kills_double_kill_3_lethal", 1);
        }
    }
    if (self.recentkillcount > 1) {
        self multikill(self.recentkillcount, weapon);
    }
    if (self.recentheroabilitykillcount > 1) {
        self multiheroabilitykill(self.recentheroabilitykillcount, self.recentheroabilitykillweapon);
        self hero_ability_multikill_event(self.recentheroabilitykillcount, self.recentheroabilitykillweapon);
    }
    self resetrecentkillvariables();
}

// Namespace scoreevents
// Params 0, eflags: 0x0
// Checksum 0x15cb0e08, Offset: 0x64a0
// Size: 0x120
function resetrecentkillvariables() {
    self.recent_lmg_smg_killcount = 0;
    self.recentanihilatorcount = 0;
    self.recentarmbladecount = 0;
    self.recentbowlaunchercount = 0;
    self.recentc4killcount = 0;
    self.recentflamethrowercount = 0;
    self.recentgelguncount = 0;
    self.var_a0ea7e5c = 0;
    self.recentheroabilitykillcount = 0;
    self.recentheroweaponkillcount = 0;
    self.var_c9da93ab = [];
    self.recentkillcount = 0;
    self.recentkillcountsameweapon = 0;
    self.recentkillcountweapon = undefined;
    self.recentlethalcount = 0;
    self.recentlightningguncount = 0;
    self.recentmglkillcount = 0;
    self.recentminiguncount = 0;
    self.recentpineappleguncount = 0;
    self.recentrcbombcount = 0;
    self.recentrcbombkillcount = 0;
    self.recentremotemissilecount = 0;
    self.recentremotemissilekillcount = 0;
    self.recentkillvariables = 1;
}

// Namespace scoreevents
// Params 1, eflags: 0x0
// Checksum 0x143be0a0, Offset: 0x65c8
// Size: 0x1c
function waittilltimeoutordeath(timeout) {
    self endon(#"death");
    wait timeout;
}

// Namespace scoreevents
// Params 3, eflags: 0x0
// Checksum 0xe9adfcb, Offset: 0x65f0
// Size: 0x110
function updateoneshotmultikills(victim, weapon, firsttimedamaged) {
    self endon(#"death");
    self endon(#"disconnect");
    self notify("updateoneshotmultikills" + firsttimedamaged);
    self endon("updateoneshotmultikills" + firsttimedamaged);
    if (!isdefined(self.oneshotmultikills) || firsttimedamaged > (isdefined(self.oneshotmultikillsdamagetime) ? self.oneshotmultikillsdamagetime : 0)) {
        self.oneshotmultikills = 0;
    }
    self.oneshotmultikills++;
    self.oneshotmultikillsdamagetime = firsttimedamaged;
    wait 1;
    if (self.oneshotmultikills > 1) {
        processscoreevent("kill_enemies_one_bullet", self, victim, weapon);
    } else {
        processscoreevent("kill_enemy_one_bullet", self, victim, weapon);
    }
    self.oneshotmultikills = 0;
}

// Namespace scoreevents
// Params 2, eflags: 0x0
// Checksum 0xc415295f, Offset: 0x6708
// Size: 0x1c2
function get_distance_for_weapon(weapon, weaponclass) {
    distance = 0;
    if (!isdefined(weaponclass)) {
        return 0;
    }
    if (weapon.rootweapon.name == "pistol_shotgun") {
        weaponclass = "weapon_cqb";
    }
    switch (weaponclass) {
    case "weapon_smg":
        distance = 2250000;
        break;
    case "weapon_assault":
        distance = 3062500;
        break;
    case "weapon_lmg":
        distance = 3062500;
        break;
    case "weapon_sniper":
        distance = 4000000;
        break;
    case "weapon_pistol":
        distance = 1000000;
        break;
    case "weapon_cqb":
        distance = 302500;
        break;
    case "weapon_special":
        baseweapon = challenges::getbaseweapon(weapon);
        if (baseweapon == level.weaponballisticknife || baseweapon == level.weaponspecialcrossbow || baseweapon == level.var_a0d4ce4d) {
            distance = 2250000;
        }
        break;
    case "weapon_grenade":
        if (weapon.rootweapon.name == "hatchet") {
            distance = 2250000;
        }
        break;
    default:
        distance = 0;
        break;
    }
    return distance;
}

// Namespace scoreevents
// Params 1, eflags: 0x0
// Checksum 0x170d6d, Offset: 0x68d8
// Size: 0x174
function ongameend(data) {
    player = data.player;
    winner = data.winner;
    if (isdefined(winner)) {
        if (level.teambased) {
            if (winner != "tie" && player.team == winner) {
                processscoreevent("won_match", player);
                return;
            }
        } else {
            placement = level.placement["all"];
            topthreeplayers = min(3, placement.size);
            for (index = 0; index < topthreeplayers; index++) {
                if (level.placement["all"][index] == player) {
                    processscoreevent("won_match", player);
                    return;
                }
            }
        }
    }
    processscoreevent("completed_match", player);
}

// Namespace scoreevents
// Params 0, eflags: 0x0
// Checksum 0x9efd134f, Offset: 0x6a58
// Size: 0xa4
function specialistmedalachievement() {
    if (level.rankedmatch) {
        if (!isdefined(self.pers["specialistMedalAchievement"])) {
            self.pers["specialistMedalAchievement"] = 0;
        }
        self.pers["specialistMedalAchievement"]++;
        if (self.pers["specialistMedalAchievement"] == 5) {
            self giveachievement("MP_SPECIALIST_MEDALS");
        }
        self util::player_contract_event("earned_specialist_ability_medal");
    }
}

// Namespace scoreevents
// Params 2, eflags: 0x0
// Checksum 0xc9adff77, Offset: 0x6b08
// Size: 0x218
function specialiststatabilityusage(usagesinglegame, multitrackperlife) {
    self endon(#"disconnect");
    level endon(#"game_ended");
    self notify(#"hash_359cf118");
    self endon(#"hash_359cf118");
    isroulette = self.isroulette === 1;
    if (isdefined(self.heroability) && !isroulette) {
        self addweaponstat(self.heroability, "combatRecordStat", 1);
    }
    self challenges::processspecialistchallenge("kills_ability");
    if (!isdefined(self.pers["specialistUsagePerGame"])) {
        self.pers["specialistUsagePerGame"] = 0;
    }
    self.pers["specialistUsagePerGame"]++;
    if (self.pers["specialistUsagePerGame"] >= usagesinglegame) {
        self challenges::processspecialistchallenge("kill_one_game_ability");
        self.pers["specialistUsagePerGame"] = 0;
    }
    if (multitrackperlife) {
        self.pers["specialistStatAbilityUsage"]++;
        if (self.pers["specialistStatAbilityUsage"] >= 2) {
            self challenges::processspecialistchallenge("multikill_ability");
        }
        return;
    }
    if (!isdefined(self.specialiststatabilityusage)) {
        self.specialiststatabilityusage = 0;
    }
    self.specialiststatabilityusage++;
    self waittilltimeoutordeath(4);
    if (self.specialiststatabilityusage >= 2) {
        self challenges::processspecialistchallenge("multikill_ability");
    }
    self.specialiststatabilityusage = 0;
}

// Namespace scoreevents
// Params 0, eflags: 0x0
// Checksum 0x54a0423f, Offset: 0x6d28
// Size: 0x4c
function multikillmedalachievement() {
    if (level.rankedmatch) {
        self giveachievement("MP_MULTI_KILL_MEDALS");
        self challenges::processspecialistchallenge("multikill_weapon");
    }
}

