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

int vida_inicio[MAXPLAYERS];

/*
public void OnPluginStart()
{
    for (int i = 1; i <= MaxClients; i++) 
		if(IsClientInGame(i)) 
			OnClientPutInServer(i);
}

public void OnClientPutInServer(int client)
{
   	SDKHook(client, SDKHook_TraceAttack, TraceAttack);
}
*/
public void ZP_OnClientValidateDamage(int client, int &attacker, int &inflicter, float &damage, int &bits, int &weapon)
{
	vida_inicio[client] = GetClientHealth(client);
	PrintToConsole(client, "Vida actual antes del daño es %i", vida_inicio[client]);
}

public void ZP_OnClientDamaged(int client, int attacker, int inflicter, float damage, int bits, int weapon, int health, int armor)
{
	if(ZP_IsPlayerHuman(attacker))
	{
		float randomY = GetRandomFloat(0.46, 0.43);
		float randomX = GetRandomFloat(0.48, 0.52);
		int vida_despues = GetClientHealth(client);
    	
		PrintToConsole(client, "Vida despues del daño es %i", vida_despues);
		int vida_total = vida_inicio[client] - vida_despues;
		PrintToConsole(client, "Resta total es %i", vida_total);
    	
		SetHudTextParams(randomX, randomY, 2.0, 30,144,255, 50, 1);
		ShowHudText(attacker, 5, "%i", vida_total);
	}
}

/*
public Action TraceAttack(int victim, int &attacker, int &inflictor, float &damage, int &damagetype, int &ammotype, int hitbox, int hitgroup)
{
    vida_inicio[victim] = GetClientHealth(victim);
}
*/
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
