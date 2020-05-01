#include <sourcemod>
#include <sdktools>
#include <cstrike>

#define DATA "1.0"

public Plugin:myinfo =
{
	name = "SM Unlimited Reserve Ammo",
	author = "Franc1sco franug",
	description = "",
	version = DATA,
	url = "http://steamcommunity.com/id/franug"
};

public OnPluginStart()
{
	HookEvent("weapon_fire", ClientWeaponReload);
}

public ClientWeaponReload(Handle:event, const String:name[], bool:dontBroadcast)
{
	new client = GetClientOfUserId(GetEventInt(event,  "userid"));
	new weapon = GetEntPropEnt(client, Prop_Data, "m_hActiveWeapon");
	if(weapon > 0 && (weapon == GetPlayerWeaponSlot(client, CS_SLOT_PRIMARY) || weapon == GetPlayerWeaponSlot(client, CS_SLOT_SECONDARY)))
		SetEntProp(weapon, Prop_Send, "m_iPrimaryReserveAmmoCount", 600);
}