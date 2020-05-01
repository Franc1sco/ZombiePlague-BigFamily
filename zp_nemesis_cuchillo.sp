#include <sourcemod> 
#include <sdkhooks> 
#include <multicolors>
#include <zombieplague> 

#pragma semicolon 1 
#pragma newdecls required 

#define Prefix "ZP"

int premio = 200;

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

public void OnMapStart()
{
    AddFileToDownloadsTable("sound/nemesis/nemesis.mp3");
    PrecacheSound("nemesis.mp3", true); 
}

public void OnClientPutInServer(int client) 
{ 
    SDKHook(client, SDKHook_OnTakeDamagePost, OnTakeDamagePost); 
} 

public void OnTakeDamagePost(int victim, int attacker, int inflictor, float damage, int damagetype, int weapon, const float damageForce[3], const float damagePosition[3], int damagecustom) 
{ 
	if (IsPlayerAlive(victim))
		return; 
             
	if (victim == attacker || !IsPlayerAlive(attacker)) 
		return; 
		
	int mode = ZP_GetCurrentGameMode();	
	int money = ZP_GetClientMoney(attacker); 	 
	int premio_final = money + premio;
	
	char arma[64];
	GetEntPropString(weapon, Prop_Data, "m_iClassname", arma, sizeof(arma)); 
             
	if (StrContains(arma, "knife", false) == -1) 
		return; 
    	
	if(!ZP_IsGameModeZombieClass(mode, "nemesis"))
		return;

	ZP_SetClientMoney(attacker, premio_final);
	CPrintToChat(attacker, "{green}[%s] {default} Has ganado {green}%i {default}por acuchillar al nemesis", Prefix, premio);
} 
