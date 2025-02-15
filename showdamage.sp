#include <sourcemod>
#include <sdkhooks>
#include <zombieplague>
 
#pragma semicolon 1
#pragma newdecls required
 
public Plugin myinfo =
{
    name = "",
    author = "",
    description = "",
    version = "",
    url = ""
};
 
public void OnPluginStart()
{
    //HookEvent("player_hurt", Event_PlayerHurt, EventHookMode_Pre);
    
    for (int i = 1; i <= MaxClients; i++) 
		if(IsClientInGame(i)) 
			OnClientPutInServer(i);
}

public void OnClientPutInServer(int client)
{
    SDKHook(client, SDKHook_OnTakeDamage, Hook_OnTakeDamage);
}

public Action Hook_OnTakeDamage(int victim, int &attacker, int &inflictor, float &damage, int &damagetype)
{
    if (IsValidClient(attacker) && attacker != victim && victim != 0)
    {
        if(ZP_IsPlayerHuman(attacker))
        {
			SetHudTextParams(-1.0, 0.45, 1.3, 255, 0, 0, 200, 1);
			ShowHudText(attacker, 1, "%i", RoundToNearest(damage));
        }
    }
} 
 
 /*
public Action Event_PlayerHurt(Event event, const char[] name, bool dontBroadcast)
{
    int victim = GetClientOfUserId(event.GetInt("userid"));
    int attacker = GetClientOfUserId(event.GetInt("attacker"));
 
    int damage = event.GetInt("dmg_health");
    
    PrintToConsole(attacker, "evento hurt");
 
    if (IsValidClient(attacker) && attacker != victim && victim != 0)
    {
    	PrintToConsole(attacker, "evento hurt pasado");
        if(ZP_IsPlayerHuman(attacker))
        {
			PrintToConsole(attacker, "evento hurt pasado y hecho");
			SetHudTextParams(-1.0, 0.45, 1.3, 255, 0, 0, 200, 1);
			ShowHudText(attacker, -1, "%i", damage);
        }
    }
}*/
 
// Check for valid clients with bool for bots & dead player 
stock bool IsValidClient(int client, bool bots = true, bool dead = true)
{
	if (client <= 0)
		return false;

	if (client > MaxClients)
		return false;

	if (!IsClientInGame(client))
		return false;

	return true;
}