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

}

public void ZP_OnClientDamaged(int client, int attacker, int inflicter, float damage, int bits, int weapon, int health, int armor)
{
	if(ZP_IsPlayerHuman(attacker))
	{
		float randomY = GetRandomFloat(0.46, 0.43);
		float randomX = GetRandomFloat(0.48, 0.52);
    			
		SetHudTextParams(randomX, randomY, 2.0, 30,144,255, 50, 1);
		ShowHudText(attacker, 5, "%i", RoundToNearest(damage));
	}
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
