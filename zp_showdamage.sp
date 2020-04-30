#include <sourcemod>
#include <sdkhooks>
#include <zombieplague>
 
#pragma semicolon 1
#pragma newdecls required
 
int partes_cuerpo[MAXPLAYERS];

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
    for (int i = 1; i <= MaxClients; i++) 
		if(IsClientInGame(i)) 
			OnClientPutInServer(i);
}

public void OnClientPutInServer(int client)
{
    SDKHook(client, SDKHook_OnTakeDamage, Hook_OnTakeDamage);
   	SDKHook(client, SDKHook_TraceAttack, TraceAttack);
}

public Action Hook_OnTakeDamage(int victim, int &attacker, int &inflictor, float &damage, int &damagetype)
{
    if (IsValidClient(attacker) && attacker != victim && victim != 0)
    {
        if(ZP_IsPlayerHuman(attacker))
        {
        		float randomY = GetRandomFloat(0.46, 0.43);
    			float randomX = GetRandomFloat(0.48, 0.52);
    			
				if(partes_cuerpo[victim] == 1) 
					SetHudTextParams(randomX, randomY, 2.0, 30,144,255, 50, 1); 
				else if(partes_cuerpo[victim] == 2)
					SetHudTextParams(randomX, randomY, 2.0, 20,134,255, 50, 1);
				else if(partes_cuerpo[victim] == 2)
					SetHudTextParams(randomX, randomY, 2.0, 10,124,255, 50, 1);
					
				ShowHudText(attacker, 5, "%i", RoundToNearest(damage));
        }
    }
} 

public Action TraceAttack(int victim, int &attacker, int &inflictor, float &damage, int &damagetype, int &ammotype, int hitbox, int hitgroup)
{
    partes_cuerpo[victim] = hitgroup;
}

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
