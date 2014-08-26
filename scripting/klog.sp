#pragma semicolon 1

#include <sourcemod>
#include <sdktools>
#include <tf2>
#include <tf2_stocks>
#include <geoip>

#define PLUGIN_VERSION "0.7"
#define MAX_LINE_WIDTH 36
#define DMG_CRIT (1 << 20)

new Handle:g_DB = INVALID_HANDLE;
new Handle:g_Reconnect = INVALID_HANDLE;
new Handle:g_ExLog = INVALID_HANDLE;
new Handle:g_URL = INVALID_HANDLE;
new bool:g_ExLogEnabled = false;
new g_ConnectTime[MAXPLAYERS + 1];
new g_RowID[MAXPLAYERS + 1] = {-1, ...};

enum _:playerTracker {
	kills,
	deaths,
	assists,
	headshots,
	backstabs,
	dominations,
	revenges,
	feigns,
	p_teleported,
	obj_built,
	obj_destroy,
	flag_pick,
	flag_cap,
	flag_def,
	flag_drop,
	cp_captured,
	cp_blocked,
}

new scores[MAXPLAYERS + 1][playerTracker];

public Plugin:myinfo = {
	name = "TF2 Kill Log",
	author = "Sinclair",
	description = "TF2 Kill Log",
	version = PLUGIN_VERSION,
	url = ""
}

public OnPluginStart() {
	openDB();
	CreateConVar("sm_tf2_kill_log_v", PLUGIN_VERSION, "TF2 Kill Log", FCVAR_PLUGIN|FCVAR_SPONLY|FCVAR_REPLICATED|FCVAR_NOTIFY);
	g_ExLog = CreateConVar("klog_extended", "1", "1 Enables / 0 Disables extended log features");
	g_URL = CreateConVar("klog_url","","Kill Log URL, example: http://yoursite.com/stats/", FCVAR_PLUGIN|FCVAR_SPONLY|FCVAR_REPLICATED|FCVAR_NOTIFY);
	RegConsoleCmd("sm_rank", Command_OpenRank, "Opens player's Kill Log profile"); 
	hookEvent();
}

public Action:Command_OpenRank(client, args) {
	new String:path[255], String:playerURL[255], String:cID[MAX_LINE_WIDTH];
	new Handle:Kv = CreateKeyValues("data");
	GetConVarString(g_URL,path, sizeof(path));
	GetClientAuthString(client, cID, sizeof(cID));

	Format(playerURL, sizeof(playerURL), "http://%splayer.php?id=%s",path,cID);
	KvSetNum(Kv, "customsvr", 1);
	KvSetString(Kv, "type", "2");
	KvSetString(Kv, "title", "");
	KvSetString(Kv, "msg", playerURL);
	ShowVGUIPanel(client, "info", Kv);
	CloseHandle(Kv);

	return Plugin_Handled;
}

public OnPluginEnd() {
	new Handle:hndl = SQL_CreateTransaction();
	for (new client = 1; client <= MaxClients; client++) {
		if (IsClientInGame(client) && !IsFakeClient(client)) {
			if(g_RowID[client] == -1 || g_ConnectTime[client] == 0) {
				g_ConnectTime[client] = 0;
				return;
			}
			new String:auth[32];
			GetClientAuthString(client, auth, sizeof(auth[]));

			decl String:query[1024];
			Format(query, sizeof(query), "UPDATE `playerlog` SET `disconnect_time` = %d, `playtime` = `playtime` + %d, `kills` = `kills` + %d, `deaths` = `deaths` + %d, `feigns` = `feigns` + %d, `assists` = `assists` + %d, `dominations` = `dominations` + %d, `revenges` = `revenges` + %d, `headshots` = `headshots` + %d, `backstabs` = `backstabs` + %d, `obj_built` = `obj_built` + %d, `obj_destroy` = `obj_destroy` + %d, `tele_player` = `tele_player` + %d, `flag_pick` = `flag_pick` + %d, `flag_cap` = `flag_cap` + %d, `flag_def` = `flag_def` + %d, `flag_drop` = `flag_drop` + %d, `cp_cap` = `cp_cap` + %d, `cp_block` = `cp_block` + %d WHERE id = %d",
				GetTime(), GetTime() - g_ConnectTime[client], scores[client][kills], scores[client][deaths], scores[client][feigns], scores[client][assists], scores[client][dominations], scores[client][revenges], scores[client][headshots], scores[client][backstabs], scores[client][p_teleported], scores[client][obj_built], scores[client][obj_destroy], scores[client][flag_pick], scores[client][flag_cap], scores[client][flag_def], scores[client][flag_drop], scores[client][cp_captured], scores[client][cp_blocked], g_RowID[client]);
			SQL_AddQuery(hndl, query, g_RowID[client]);
			g_ConnectTime[client] = 0;
		}
	}
	SQL_ExecuteTransaction(g_DB, hndl);
}

public hookEvent() {
	HookEvent("player_death", Event_player_death);
	HookEvent("teamplay_point_captured", Event_teamplay_point_captured);
	HookEvent("teamplay_capture_blocked", Event_teamplay_capture_blocked);
	HookEvent("teamplay_flag_event", Event_teamplay_flag_event);
	HookEvent("object_destroyed", Event_object_destroyed);
	HookEvent("player_builtobject", Event_player_builtobject);
	HookEvent("player_teleported", Event_player_teleported);
}

openDB() {
	SQL_TConnect(connectDB, "killlog");
}

public connectDB(Handle:owner, Handle:hndl, const String:error[], any:data) {
	if (hndl == INVALID_HANDLE) {
		LogError("Database failure: %s", error);
		return;
	} else {
		LogMessage("TF2 Kill Log Connected to Database!");
		g_DB = hndl;
		SQL_SetCharset(g_DB, "utf8");
		createDBKillLog();
		createDBSmallLog();
		createDBPlayerLog();
		createDBTeamLog();
		createDBObjectLog();
	}
}

public Action:reconnectDB(Handle:timer, any:nothing) {
	if (SQL_CheckConfig("killlog")) {
		SQL_TConnect(connectDB, "killlog");
	}
}

public SQLError(Handle:owner, Handle:hndl, const String:error[], any:data) {
	if (!StrEqual("", error)) {
		LogMessage("SQL Error: %s", error);
	}
}

createDBKillLog() {
	new len = 0;
	decl String:query[1024];
	len += Format(query[len], sizeof(query)-len, "CREATE TABLE IF NOT EXISTS `killlog` (");
	len += Format(query[len], sizeof(query)-len, "`attacker` VARCHAR( 20 ) NOT NULL,");
	len += Format(query[len], sizeof(query)-len, "`ateam` TINYINT( 1 ) NOT NULL,");
	len += Format(query[len], sizeof(query)-len, "`aclass` TINYINT( 1 ) NOT NULL,");
	len += Format(query[len], sizeof(query)-len, "`victim` VARCHAR( 20 ) NOT NULL,");
	len += Format(query[len], sizeof(query)-len, "`vteam` TINYINT( 1 ) NOT NULL,");
	len += Format(query[len], sizeof(query)-len, "`vclass` TINYINT( 1 ) NOT NULL,");
	len += Format(query[len], sizeof(query)-len, "`assister` VARCHAR( 20 ) NOT NULL,");
	len += Format(query[len], sizeof(query)-len, "`asclass` TINYINT( 1 ) NOT NULL,");
	len += Format(query[len], sizeof(query)-len, "`weapon` VARCHAR( 25 ) NOT NULL,");
	len += Format(query[len], sizeof(query)-len, "`killtime` INT( 11 ) NOT NULL,");
	len += Format(query[len], sizeof(query)-len, "`dominated` BOOL NOT NULL,");
	len += Format(query[len], sizeof(query)-len, "`assister_dominated` BOOL NOT NULL,");
	len += Format(query[len], sizeof(query)-len, "`revenge` BOOL NOT NULL,");
	len += Format(query[len], sizeof(query)-len, "`assister_revenge` BOOL NOT NULL,");
	len += Format(query[len], sizeof(query)-len, "`customkill` TINYINT( 2 ) NOT NULL,");
	len += Format(query[len], sizeof(query)-len, "`crit` TINYINT( 2 ) NOT NULL,");
	len += Format(query[len], sizeof(query)-len, "`wep_ks` TINYINT( 3 ) NOT NULL,");
	len += Format(query[len], sizeof(query)-len, "`victim_ks` TINYINT( 3 ) NOT NULL,");
	len += Format(query[len], sizeof(query)-len, "`map` VARCHAR( 36 ) NOT NULL,");
	len += Format(query[len], sizeof(query)-len, "KEY `attacker` (`attacker`),");
	len += Format(query[len], sizeof(query)-len, "KEY `victim` (`victim`),");
	len += Format(query[len], sizeof(query)-len, "KEY `assister` (`assister`),");
	len += Format(query[len], sizeof(query)-len, "KEY `weapon` (`weapon`),");
	len += Format(query[len], sizeof(query)-len, "KEY `killtime` (`killtime`),");
	len += Format(query[len], sizeof(query)-len, "KEY `map` (`map`))");
	len += Format(query[len], sizeof(query)-len, "ENGINE = InnoDB DEFAULT CHARSET=utf8;");
	SQL_FastQuery(g_DB, query);
}

createDBSmallLog() {
	new len = 0;
	decl String:query[512];
	len += Format(query[len], sizeof(query)-len, "CREATE TABLE IF NOT EXISTS `smalllog` (");
	len += Format(query[len], sizeof(query)-len, "`attacker` varchar(20) DEFAULT NULL,");
	len += Format(query[len], sizeof(query)-len, "`weapon` varchar(25) DEFAULT NULL,");
	len += Format(query[len], sizeof(query)-len, "`kills` int(11) DEFAULT '0',");
	len += Format(query[len], sizeof(query)-len, "`deaths` int(11) DEFAULT '0',");
	len += Format(query[len], sizeof(query)-len, "`crits` int(11) DEFAULT '0',");
	len += Format(query[len], sizeof(query)-len, "`ks` int(11) DEFAULT '0',");
	len += Format(query[len], sizeof(query)-len, "`customkill` tinyint(2) DEFAULT NULL,");
	len += Format(query[len], sizeof(query)-len, "UNIQUE KEY `attacker` (`attacker`,`weapon`,`customkill`)");
	len += Format(query[len], sizeof(query)-len, ") ENGINE=InnoDB DEFAULT CHARSET=utf8;");
	SQL_FastQuery(g_DB, query);
}

createDBPlayerLog() {
	new len = 0;
	decl String:query[1024];
	len += Format(query[len], sizeof(query)-len, "CREATE TABLE IF NOT EXISTS `playerlog` (");
	len += Format(query[len], sizeof(query)-len, "`id` int(11) NOT NULL AUTO_INCREMENT,"); 
	len += Format(query[len], sizeof(query)-len, "`name` varchar(32),");
	len += Format(query[len], sizeof(query)-len, "`auth` varchar(32),");
	len += Format(query[len], sizeof(query)-len, "`ip` varchar(32),");
	len += Format(query[len], sizeof(query)-len, "`cc` varchar(2),");
	len += Format(query[len], sizeof(query)-len, "`connect_time` int(11),");
	len += Format(query[len], sizeof(query)-len, "`disconnect_time` int(11),");
	len += Format(query[len], sizeof(query)-len, "`playtime` int(11) DEFAULT '0',");
	len += Format(query[len], sizeof(query)-len, "`kills` int(6) DEFAULT '0',");
	len += Format(query[len], sizeof(query)-len, "`deaths` int(6) DEFAULT '0',");
	len += Format(query[len], sizeof(query)-len, "`assists` int(6) DEFAULT '0',");
	len += Format(query[len], sizeof(query)-len, "`feigns` int(6) DEFAULT '0',");
	len += Format(query[len], sizeof(query)-len, "`dominations` int(6) DEFAULT '0',");
	len += Format(query[len], sizeof(query)-len, "`revenges` int(6) DEFAULT '0',");
	len += Format(query[len], sizeof(query)-len, "`headshots` int(6) DEFAULT '0',");
	len += Format(query[len], sizeof(query)-len, "`backstabs` int(6) DEFAULT '0',");
	len += Format(query[len], sizeof(query)-len, "`obj_built` int(6) DEFAULT '0',");
	len += Format(query[len], sizeof(query)-len, "`obj_destroy` int(6) DEFAULT '0',");
	len += Format(query[len], sizeof(query)-len, "`tele_player` int(6) DEFAULT '0',");
	len += Format(query[len], sizeof(query)-len, "`flag_pick` int(6) DEFAULT '0',");
	len += Format(query[len], sizeof(query)-len, "`flag_cap` int(6) DEFAULT '0',");
	len += Format(query[len], sizeof(query)-len, "`flag_def` int(6) DEFAULT '0',");
	len += Format(query[len], sizeof(query)-len, "`flag_drop` int(6) DEFAULT '0',");
	len += Format(query[len], sizeof(query)-len, "`cp_cap` int(6) DEFAULT '0',");
	len += Format(query[len], sizeof(query)-len, "`cp_block` int(6) DEFAULT '0',");
	len += Format(query[len], sizeof(query)-len, "PRIMARY KEY (`id`), UNIQUE KEY `auth` (`auth`)) ENGINE=InnoDB  DEFAULT CHARSET=utf8;");
	SQL_FastQuery(g_DB, query);
}

createDBTeamLog() {
	new len = 0;
	decl String:query[1024];
	len += Format(query[len], sizeof(query)-len, "CREATE TABLE IF NOT EXISTS `teamlog` (");
	len += Format(query[len], sizeof(query)-len, " `capper` varchar(20) DEFAULT NULL,");
	len += Format(query[len], sizeof(query)-len, " `cteam` tinyint(1) DEFAULT NULL,");
	len += Format(query[len], sizeof(query)-len, " `cclass` tinyint(1) DEFAULT NULL,");
	len += Format(query[len], sizeof(query)-len, " `defender` varchar(20) DEFAULT NULL,");
	len += Format(query[len], sizeof(query)-len, " `dteam` tinyint(1) DEFAULT NULL,");
	len += Format(query[len], sizeof(query)-len, " `dclass` tinyint(1) DEFAULT NULL,");
	len += Format(query[len], sizeof(query)-len, " `killtime` int(11) DEFAULT NULL,");
	len += Format(query[len], sizeof(query)-len, " `event` varchar(20) DEFAULT NULL,");
	len += Format(query[len], sizeof(query)-len, " `map` varchar(32) DEFAULT NULL,");
	len += Format(query[len], sizeof(query)-len, " KEY `capper` (`capper`),");
	len += Format(query[len], sizeof(query)-len, " KEY `defender` (`defender`),");
	len += Format(query[len], sizeof(query)-len, " KEY `killtime` (`killtime`),");
	len += Format(query[len], sizeof(query)-len, " KEY `event` (`event`),");
	len += Format(query[len], sizeof(query)-len, " KEY `map` (`map`)");
	len += Format(query[len], sizeof(query)-len, ") ENGINE=InnoDB DEFAULT CHARSET=utf8;");
	SQL_FastQuery(g_DB, query);
}

createDBObjectLog() {
	new len = 0;
	decl String:query[1024];
	len += Format(query[len], sizeof(query)-len, "CREATE TABLE IF NOT EXISTS `objectlog` (");
	len += Format(query[len], sizeof(query)-len, "`attacker` varchar(20) CHARACTER SET utf8 NOT NULL,");
	len += Format(query[len], sizeof(query)-len, "`ateam` tinyint(1) NOT NULL,");
	len += Format(query[len], sizeof(query)-len, "`aclass` tinyint(1) NOT NULL,");
	len += Format(query[len], sizeof(query)-len, "`victim` varchar(20) CHARACTER SET utf8 NOT NULL,");
	len += Format(query[len], sizeof(query)-len, "`vteam` tinyint(1) NOT NULL,");
	len += Format(query[len], sizeof(query)-len, "`vclass` tinyint(1) NOT NULL,");
	len += Format(query[len], sizeof(query)-len, "`weapon` varchar(25) CHARACTER SET utf8 NOT NULL,");
	len += Format(query[len], sizeof(query)-len, "`killtime` int(11) NOT NULL,");
	len += Format(query[len], sizeof(query)-len, "`object` varchar(25) CHARACTER SET utf8 NOT NULL,");
	len += Format(query[len], sizeof(query)-len, " KEY `attacker` (`attacker`),");
	len += Format(query[len], sizeof(query)-len, " KEY `victim` (`victim`),");
	len += Format(query[len], sizeof(query)-len, " KEY `weapon` (`weapon`),");
	len += Format(query[len], sizeof(query)-len, " KEY `killtime` (`killtime`),");
	len += Format(query[len], sizeof(query)-len, " KEY `object` (`object`)");
	len += Format(query[len], sizeof(query)-len, ") ENGINE=InnoDB DEFAULT CHARSET=utf8;");
	SQL_FastQuery(g_DB, query);
}

public OnClientConnected(client) {
	if(IsFakeClient(client)) {
		return;
	}
	g_ConnectTime[client] = GetTime();
	g_RowID[client] = -1;
}

public OnClientAuthorized(client, const String:authid[]) {
	PurgeClient(client);
}

public OnClientPostAdminCheck(client) {
	if(IsFakeClient(client)) {
		return;
	}
	
	CreateTimer(1.0, Timer_HandleConnect, GetClientUserId(client), TIMER_REPEAT|TIMER_FLAG_NO_MAPCHANGE);
}

public Action:Timer_HandleConnect(Handle:timer, any:userid) {
	new client = GetClientOfUserId(userid);
	if(client == 0) {
		return Plugin_Stop;
	}
	
	if(g_ConnectTime[client] == 0) {
		return Plugin_Continue;
	}
	
	new String:ip[64], String:c_code[3];
	new String:buffers[3][256];

	GetClientName(client, buffers[0], sizeof(buffers[]));
	GetClientAuthString(client, buffers[1], sizeof(buffers[]));
	GetClientIP(client, ip, sizeof(ip));
	GeoipCode2(ip, c_code);

	strcopy(buffers[2], sizeof(buffers[]), c_code);

	decl String:escapedBuffers[3][513];
	for(new i = 0; i < sizeof(buffers); i++) {
		if(strlen(buffers[i]) == 0) {
			strcopy(escapedBuffers[i], sizeof(escapedBuffers[]), "NULL");
		} else {
			SQL_EscapeString(g_DB, buffers[i], escapedBuffers[i], sizeof(escapedBuffers[]));
			Format(escapedBuffers[i], sizeof(escapedBuffers[]), "'%s'", escapedBuffers[i]);
		}
	}
	
	decl String:query[1024];
	Format(query, sizeof(query), "INSERT INTO `playerlog` SET name = %s, auth = %s, ip = '%s', cc = %s, connect_time = '%d', disconnect_time = '0' ON DUPLICATE KEY UPDATE name = %s, auth = %s, ip = '%s', cc = %s, connect_time = '%d', disconnect_time = '0'",
		escapedBuffers[0], escapedBuffers[1], ip, escapedBuffers[2], g_ConnectTime[client],escapedBuffers[0], escapedBuffers[1], ip, escapedBuffers[2], g_ConnectTime[client]);
	SQL_TQuery(g_DB, OnRowInserted, query, GetClientUserId(client));
	return Plugin_Stop;
}

public OnClientDisconnect(client) {
	if(g_RowID[client] == -1 || g_ConnectTime[client] == 0) {
		g_ConnectTime[client] = 0;
		return;
	}

	new String:auth[32];
	GetClientAuthString(client, auth, sizeof(auth[]));

	decl String:query[1024];
	Format(query, sizeof(query), "UPDATE `playerlog` SET `disconnect_time` = %d, `playtime` = `playtime` + %d, `kills` = `kills` + %d, `deaths` = `deaths` + %d, `feigns` = `feigns` + %d, `assists` = `assists` + %d, `dominations` = `dominations` + %d, `revenges` = `revenges` + %d, `headshots` = `headshots` + %d, `backstabs` = `backstabs` + %d, `obj_built` = `obj_built` + %d, `obj_destroy` = `obj_destroy` + %d, `tele_player` = `tele_player` + %d, `flag_pick` = `flag_pick` + %d, `flag_cap` = `flag_cap` + %d, `flag_def` = `flag_def` + %d, `flag_drop` = `flag_drop` + %d, `cp_cap` = `cp_cap` + %d, `cp_block` = `cp_block` + %d WHERE id = %d",
		GetTime(), GetTime() - g_ConnectTime[client], scores[client][kills], scores[client][deaths], scores[client][feigns], scores[client][assists], scores[client][dominations], scores[client][revenges], scores[client][headshots], scores[client][backstabs], scores[client][p_teleported], scores[client][obj_built], scores[client][obj_destroy], scores[client][flag_pick], scores[client][flag_cap], scores[client][flag_def], scores[client][flag_drop], scores[client][cp_captured], scores[client][cp_blocked], g_RowID[client]);
	SQL_TQuery(g_DB, OnRowUpdated, query, g_RowID[client]);
	g_ConnectTime[client] = 0;
}

public OnMapStart() {

}

public OnConfigsExecuted() {
	g_ExLogEnabled = GetConVarBool(g_ExLog);
}

public OnMapEnd() {
	new Handle:hndl = SQL_CreateTransaction();
	for (new client = 1; client <= MaxClients; client++) {
		if (IsClientInGame(client) && !IsFakeClient(client)) {
			if(g_RowID[client] == -1 || g_ConnectTime[client] == 0) {
				g_ConnectTime[client] = 0;
				return;
			}

			new String:auth[32];
			GetClientAuthString(client, auth, sizeof(auth[]));

			decl String:query[1024];
			Format(query, sizeof(query), "UPDATE `playerlog` SET `disconnect_time` = %d, `playtime` = `playtime` + %d, `kills` = `kills` + %d, `deaths` = `deaths` + %d, `feigns` = `feigns` + %d, `assists` = `assists` + %d, `dominations` = `dominations` + %d, `revenges` = `revenges` + %d, `headshots` = `headshots` + %d, `backstabs` = `backstabs` + %d, `obj_built` = `obj_built` + %d, `obj_destroy` = `obj_destroy` + %d, `tele_player` = `tele_player` + %d, `flag_pick` = `flag_pick` + %d, `flag_cap` = `flag_cap` + %d, `flag_def` = `flag_def` + %d, `flag_drop` = `flag_drop` + %d, `cp_cap` = `cp_cap` + %d, `cp_block` = `cp_block` + %d WHERE id = %d",
				GetTime(), GetTime() - g_ConnectTime[client], scores[client][kills], scores[client][deaths], scores[client][feigns], scores[client][assists], scores[client][dominations], scores[client][revenges], scores[client][headshots], scores[client][backstabs], scores[client][p_teleported], scores[client][obj_built], scores[client][obj_destroy], scores[client][flag_pick], scores[client][flag_cap], scores[client][flag_def], scores[client][flag_drop], scores[client][cp_captured], scores[client][cp_blocked], g_RowID[client]);
			SQL_AddQuery(hndl, query, g_RowID[client]);
			g_ConnectTime[client] = 0;
		}
	}
	SQL_ExecuteTransaction(g_DB, hndl, OnSuccess, OnFailure);
}

public OnSuccess(Handle:db, any:data, numQueries, Handle:results[], any:queryData[]) {
	return;
}

public OnFailure(Handle:db, any:data, numQueries, const String:error[], failIndex, any:queryData[]) {
	LogError("Transaction failed: Queries %i, Error: %s, Index: %i", numQueries, error, failIndex);
}

public OnRowInserted(Handle:owner, Handle:hndl, const String:error[], any:userid) {
	new client = GetClientOfUserId(userid);
	if(client == 0) {
		return;
	}
	
	if(hndl == INVALID_HANDLE) {
		LogError("Unable to insert row for %L. %s", client, error);
		return;
	}

	g_RowID[client] = SQL_GetInsertId(hndl);
}

public OnRowUpdated(Handle:owner, Handle:hndl, const String:error[], any:client) {
	if(hndl == INVALID_HANDLE) {
		LogError("Unable to update row %L. %s", client, error);
		return;
	}
}

public Event_player_death(Handle:event, const String:name[], bool:dontBroadcast) {
	if (g_DB == INVALID_HANDLE && g_Reconnect == INVALID_HANDLE) {
		g_Reconnect = CreateTimer(900.0, reconnectDB);
		return;
	}

	new victimId = GetEventInt(event, "userid");
	new attackerId = GetEventInt(event, "attacker");
	new assisterId = GetEventInt(event, "assister");
	new deathflags = GetEventInt(event, "death_flags");
	new customkill = GetEventInt(event, "customkill");
	new killstreak = GetEventInt(event, "kill_streak_victim");
	new killstreak_wep = GetEventInt(event, "kill_streak_wep");
	new dmgtype = GetEventInt(event, "damagebits");

	if(attackerId == 0) {
		return;
	}

	new Handle:hndl = SQL_CreateTransaction();
	new String:aID[MAX_LINE_WIDTH];
	new String:vID[MAX_LINE_WIDTH];
	new String:asID[MAX_LINE_WIDTH];
	new String:map[MAX_LINE_WIDTH];
	new String:weapon[64];

	new assister = GetClientOfUserId(assisterId);
	new victim = GetClientOfUserId(victimId);
	new attacker = GetClientOfUserId(attackerId);

	new attackerteam = GetClientTeam(attacker);
	new victimteam = GetClientTeam(victim);
	new TFClassType:attackerclass = TF2_GetPlayerClass(attacker);
	new TFClassType:victimclass = TF2_GetPlayerClass(victim);
	new TFClassType:assisterclass;

	GetCurrentMap(map, MAX_LINE_WIDTH);
	GetEventString(event, "weapon_logclassname", weapon, sizeof(weapon));
	GetClientAuthString(attacker, aID, sizeof(aID));
	GetClientAuthString(victim, vID, sizeof(vID));

	if (deathflags & 32) {
		scores[victim][feigns]++;
		return;
	}

	scores[attacker][kills]++;
	scores[victim][deaths]++;

	if (assister != 0) {
		GetClientAuthString(assister, asID, sizeof(asID));
		assisterclass = TF2_GetPlayerClass(assister);
		scores[assister][assists]++;
	}

	if(customkill == 1 || customkill == 51) {
		scores[attacker][headshots]++;
	}
	if(customkill == 2) {
		scores[attacker][backstabs]++;
	}

	new df_assisterrevenge = 0;
	new df_killerrevenge = 0;
	new df_assisterdomination = 0;
	new df_killerdomination = 0;

	if (deathflags & 1) {
		df_killerdomination = 1;
		scores[attacker][dominations]++;
	}
	if (deathflags & 2) {
		df_assisterdomination = 1;
		scores[assister][dominations]++;
	}
	if (deathflags & 4) {
		df_killerrevenge = 1;
		scores[attacker][revenges]++;
	}
	if (deathflags & 8) {
		df_assisterrevenge = 1;
		scores[assister][revenges]++;
	}

	new dmg_crit;

	if (dmgtype & DMG_CRIT) {
		dmg_crit = 1;
	}

	if (g_ExLogEnabled) {
		new len = 0;
		decl String:buffer[2512];
		len += Format(buffer[len], sizeof(buffer)-len, "INSERT INTO `killlog` (`attacker`, `ateam`, `aclass`, `victim`, `vteam`, `vclass`, `assister`, `asclass`, `weapon`, `killtime`, `dominated`, `assister_dominated`, `revenge`, `assister_revenge`, `customkill`, `crit`, `wep_ks`, `victim_ks`, `map`)");
		len += Format(buffer[len], sizeof(buffer)-len, " VALUES ('%s', '%i', '%i', '%s', '%i', '%i', '%s', '%i', '%s', '%i', '%i', '%i', '%i', '%i', '%i', '%i', '%i', '%i', '%s');",aID,attackerteam,attackerclass,vID,victimteam,victimclass,asID,assisterclass,weapon,GetTime(),df_killerdomination,df_assisterdomination,df_killerrevenge,df_assisterrevenge,customkill,dmg_crit,killstreak_wep,killstreak,map);	
		SQL_AddQuery(hndl, buffer);
	}

	if (attacker != victim) {
		new len2 = 0;
		decl String:buffer2[1024];
		len2 += Format(buffer2[len2], sizeof(buffer2)-len2, "INSERT INTO `smalllog` (`attacker`, `weapon`, `kills`, `crits`, `ks`, `customkill`)");
		len2 += Format(buffer2[len2], sizeof(buffer2)-len2, " VALUES ('%s', '%s', '%i', '%i', '%i', '%i') ON DUPLICATE KEY UPDATE `kills` = `kills` + 1, `crits` = `crits` + %i, `ks` = GREATEST(`ks`,VALUES(`ks`));",aID,weapon,1,dmg_crit,killstreak_wep,customkill,dmg_crit);
		SQL_AddQuery(hndl, buffer2);
	}

	new len3 = 0;
	decl String:buffer3[1024];
	len3 += Format(buffer3[len3], sizeof(buffer3)-len3, "INSERT INTO `smalllog` (`attacker`, `weapon`, `deaths`, `customkill`)");
	len3 += Format(buffer3[len3], sizeof(buffer3)-len3, " VALUES ('%s', '%s', '%i', '%i') ON DUPLICATE KEY UPDATE `deaths` = `deaths` + 1;",vID,weapon,1,customkill);
	SQL_AddQuery(hndl, buffer3);

	SQL_ExecuteTransaction(g_DB, hndl, OnSuccess, OnFailure);
}

public Action:Event_player_teleported(Handle:event, const String:name[], bool:dontBroadcast) {
	new user = GetClientOfUserId(GetEventInt(event, "userid"));
	new builder = GetClientOfUserId(GetEventInt(event, "builderid"));

	if (user != builder) {
		scores[builder][p_teleported]++;
	}
}

public Action:Event_player_builtobject(Handle:event, const String:name[], bool:dontBroadcast) {
	new user = GetClientOfUserId(GetEventInt(event, "userid"));
	new object = GetEventInt(event, "object");

	if (object != 3) {
		scores[user][obj_built]++;
	}
}

public Action:Event_object_destroyed(Handle:event, const String:name[], bool:dontBroadcast) {
	new String:vID[64], String:aID[64], String:object_name[25], String:object_lvl[25], String:weapon[25];
	new victim = GetClientOfUserId(GetEventInt(event, "userid"));
	GetClientAuthString(victim, vID, sizeof(vID));
	new victimteam = GetClientTeam(victim);
	new TFClassType:victimclass = TF2_GetPlayerClass(victim);

	new attacker = GetClientOfUserId(GetEventInt(event, "attacker"));
	GetClientAuthString(attacker, aID, sizeof(aID));
	new attackerteam = GetClientTeam(attacker);
	new TFClassType:attackerclass = TF2_GetPlayerClass(attacker);
	GetEventString(event, "weapon", weapon, sizeof(weapon));

	if (attacker == victim) {
		return;
	}

	new object = GetEventInt(event, "objecttype");
	new obj_index = GetEventInt(event, "index");
	new lvl = GetEntProp(obj_index, Prop_Send, "m_iUpgradeLevel");
	new bool:mini = (GetEntProp(obj_index, Prop_Send, "m_bMiniBuilding") == 1);
	if (object == 0) {
		object_name = "dispenser";
		scores[attacker][obj_destroy]++;
	}
	if (object == 1) {
		object_name = "teleporter";
		scores[attacker][obj_destroy]++;
	}
	if (object == 2) {
		object_name = "sentry";
		scores[attacker][obj_destroy]++;
	}
	if (object == 3) {
		new sapper = GetPlayerWeaponSlot(victim, 1);
		if (sapper > 0 && IsValidEdict(sapper)) {
			new sapper_index = GetEntProp(sapper, Prop_Send, "m_iItemDefinitionIndex");

			if (sapper_index == 810 || sapper_index == 831) {
				object_name = "recorder";
			}
			else if (sapper_index == 933) {
				object_name = "psapper";
			}
			else if (sapper_index == 1080) {
				object_name = "fsapper";
			}
			else if (sapper_index == 1102) {
				object_name = "snack_attack";
			}
			else {
				object_name = "sapper";
			}
		}
	}
	if (mini == false) {
		if (object == 3) {
			Format(object_lvl, sizeof(object_lvl), "%s", object_name);
		} else {
			Format(object_lvl, sizeof(object_lvl), "%s_%i", object_name, lvl);
		}
	} else {
		object_lvl = "mini_sentry";
	}

	new len = 0;
	decl String:query[2512];
	len += Format(query[len], sizeof(query)-len, "INSERT INTO `objectlog` (`attacker`, `ateam`, `aclass`, `victim`, `vteam`, `vclass`, `weapon`, `killtime`, `object`)");
	len += Format(query[len], sizeof(query)-len, " VALUES ('%s', '%i', '%i', '%s', '%i', '%i', '%s', '%i', '%s');",aID,attackerteam,attackerclass,vID,victimteam,victimclass,weapon,GetTime(),object_lvl);	
	SQL_TQuery(g_DB, SQLError, query);
}

public Action:Event_teamplay_flag_event(Handle:event, const String:name[], bool:dontBroadcast) {
	new String:uID[64], String:action[15], String:map[MAX_LINE_WIDTH], String:cID[64], TFClassType:carrierclass, carrierteam;
	new user = GetEventInt(event, "player");
	new state = GetEventInt(event, "eventtype");
	new userteam = GetClientTeam(user);
	new TFClassType:userclass = TF2_GetPlayerClass(user);

	GetClientAuthString(user,uID, sizeof(uID));
	GetCurrentMap(map, MAX_LINE_WIDTH);

	if (state == 1) {
		scores[user][flag_pick]++;
	}
	if (state == 2) {
		action = "flag_cap";
		scores[user][flag_cap]++;
	}
	if (state == 3) {
		new carrier = GetEventInt(event, "carrier");

		carrierteam = GetClientTeam(carrier);
		carrierclass = TF2_GetPlayerClass(carrier);
		GetClientAuthString(carrier,cID, sizeof(cID));

		action = "flag_def";
		scores[user][flag_def]++;
	}
	if (state == 4) {
		scores[user][flag_drop]++;
	}

	if (state == 2 || state == 3) {
		new len = 0;
		decl String:query[1024];
		len += Format(query[len], sizeof(query)-len, "INSERT INTO `teamlog` (`capper`, `cteam`, `cclass`, `defender`, `dteam`, `dclass`, `killtime`, `event`, `map`)");
		len += Format(query[len], sizeof(query)-len, " VALUES ('%s', '%i', '%i', '%s', '%i', '%i', '%i', '%s', '%s');",uID,userteam,userclass,cID,carrierteam,carrierclass,GetTime(),action,map);	
		SQL_TQuery(g_DB, SQLError, query);
	}
}

public Action:Event_teamplay_point_captured(Handle:event, const String:name[], bool:dontBroadcast) {
	new String:cappers[128], String:action[15], String:map[MAX_LINE_WIDTH];
	new cteam = GetEventInt(event, "team");

	GetEventString(event, "cappers", cappers, sizeof(cappers));
	GetCurrentMap(map, MAX_LINE_WIDTH);

	new x = strlen(cappers);
	action = "cp_captured";

	for (new i = 0; i < x; i++) {
		new String:cID[64];
		new client = cappers{i};
		new TFClassType:capperclass = TF2_GetPlayerClass(client);

		GetClientAuthString(client, cID, sizeof(cID));
		scores[client][cp_captured]++;

		new len = 0;
		decl String:query[1024];
		len += Format(query[len], sizeof(query)-len, "INSERT INTO `teamlog` (`capper`, `cteam`, `cclass`, `killtime`, `event`, `map`)");
		len += Format(query[len], sizeof(query)-len, " VALUES ('%s', '%i', '%i', '%i', '%s', '%s');",cID,cteam,capperclass,GetTime(),action,map);	
		SQL_TQuery(g_DB, SQLError, query);
	}
}

public Action:Event_teamplay_capture_blocked(Handle:event, const String:name[], bool:dontBroadcast) {
	new client = GetEventInt(event, "blocker");

	if (client > 0) {
		scores[client][cp_blocked]++;
	}
}

PurgeClient(clientId) {
	scores[clientId][kills] = 0;
	scores[clientId][deaths] = 0;
	scores[clientId][assists] = 0;
	scores[clientId][headshots] = 0;
	scores[clientId][backstabs] = 0;
	scores[clientId][dominations] = 0;
	scores[clientId][revenges] = 0;
	scores[clientId][feigns] = 0;
	scores[clientId][p_teleported] = 0;
	scores[clientId][obj_built] = 0;
	scores[clientId][obj_destroy] = 0;
	scores[clientId][flag_pick] = 0;
	scores[clientId][flag_cap] = 0;
	scores[clientId][flag_def] = 0;
	scores[clientId][flag_drop] = 0;
	scores[clientId][cp_captured] = 0;
	scores[clientId][cp_blocked] = 0;
}