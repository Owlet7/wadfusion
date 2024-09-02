//-----------------------------------------------------------------------------
//
// Copyright 2024 Owlet VII
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/
//
//-----------------------------------------------------------------------------
//

class Incinerator : PlasmaRifle
{
    Default
    {
		Weapon.SlotNumber 6;
		Weapon.AmmoType "Fuel";
		Inventory.PickupMessage "$ID24_GOTINCINERATOR";
		//Weapon.AmmoUse 1;
		//Weapon.SelectionOrder 350;
		//Inventory.PickupSound "misc/usgpickup";
		//Weapon.AmmoType "Shell";
		//Weapon.AmmoGive 12;
		//Weapon.AmmoUse 4;
		//Weapon.SlotNumber 3;
		//AttackSound "weapons/ubersgf"; // This sound will be played automatically by A_FireBullets
    }

    States
    {
		Ready:
			FLMG A 1 A_WeaponReady;
			Loop;
		Deselect:
			FLMG A 1 A_Lower;
			Loop;
		Select:
			FLMG A 1 A_Raise;
			Loop;
		Fire:
			FLMF A 0 Bright A_Jump(128, "FireSound2");
			FLMF A 0 Bright A_StartSound("weapons/incinerator/incfi1");
			goto FireReal;	
		FireSound2:
			FLMF A 0 Bright A_StartSound("weapons/incinerator/incfi2");
			goto FireReal;
		FireReal:
			FLMF A 1 Bright A_FireIncinerator();
			FLMF B 1 Bright;
			FLMG A 1;
			FLMG A 0 A_ReFire;
			Goto Ready;
		Flash:
			TNT1 A 2 A_Light2;
			TNT1 A 1 A_Light1;
			Goto LightDone;
    }

	action void A_FireIncinerator()
	{
		if (player == null)
		{
			return;
		}

		Weapon weap = player.ReadyWeapon;
		if (weap != null && invoker == weap && stateinfo != null && stateinfo.mStateType == STATE_Psprite)
		{
			if (!weap.DepleteAmmo(weap.bAltFire, true))
				return;
			
			State flash = weap.FindState('Flash');
			if (flash != null)
			{
				player.SetSafeFlash(weap, flash, random[FireIncinerator](0, 1));
			}
		}
		
		SpawnPlayerMissile("IncineratorFlame");
	}
}

class IncineratorFlame : Actor
{
	const INCINERATOR_FLAME_DAMAGE = 5;
	const INCINERATOR_FLAME_VELOCITY = 40;
	const INCINERATOR_BURN_DAMAGE = 5;
	const INCINERATOR_BURN_RADIUS = 64;

	Default
	{
		Damage INCINERATOR_FLAME_DAMAGE;
		Speed INCINERATOR_FLAME_VELOCITY;
		Radius 13;
		Height 8;
		RenderStyle "Translucent";
		Alpha 0.65;

		+NOBLOCKMAP
		+NOGRAVITY
		+DROPOFF
		+MISSILE
		+FORCERADIUSDMG
	}

	States
	{
		Spawn:
			TNT1 A 1 Bright;
			IFLM A 2 Bright;
			IFLM B 2 Bright A_StartSound("weapons/incinerator/incbrn");
			IFLM CDEFGH 2 Bright;
			stop;
		Death:
			IFLM A 0 Bright A_Jump(128, "DeathSound2");
			IFLM A 0 Bright A_StartSound("weapons/incinerator/incht1");
			goto Burninate;
		DeathSound2:
			IFLM A 0 Bright A_StartSound("weapons/incinerator/incht2");
			goto Burninate;
		Burninate:
			IFLM I 2 bright A_Explode(INCINERATOR_BURN_DAMAGE, INCINERATOR_BURN_RADIUS);
			IFLM J 2 bright;
			IFLM I 2 bright;
			IFLM J 2 bright A_Explode(INCINERATOR_BURN_DAMAGE, INCINERATOR_BURN_RADIUS);
			IFLM K 2 bright;
			IFLM J 2 bright;
			IFLM K 2 bright A_Explode(INCINERATOR_BURN_DAMAGE, INCINERATOR_BURN_RADIUS);
			IFLM L 2 bright;
			IFLM K 2 bright A_StartSound("weapons/incinerator/incht3");
			IFLM L 2 bright A_Explode(INCINERATOR_BURN_DAMAGE, INCINERATOR_BURN_RADIUS);
			IFLM M 2 bright;
			IFLM L 2 bright;
			IFLM M 2 bright A_Explode(INCINERATOR_BURN_DAMAGE, INCINERATOR_BURN_RADIUS);
			IFLM N 2 bright;
			IFLM M 2 bright;
			IFLM N 2 bright A_Explode(INCINERATOR_BURN_DAMAGE, INCINERATOR_BURN_RADIUS);
			IFLM O 2 bright;
			IFLM N 2 bright;
			IFLM O 2 bright;
			IFLM POP 2 bright;
			stop;
	}
}

//temp weap

class Heatwave : BFG9000
{
	Default
	{
		Weapon.AmmoType "Fuel";
		Weapon.SlotNumber 7;
	}
}

//ammo

class Fuel : Ammo
{
	Default
	{
		Inventory.PickupMessage "$ID24_GOTFUELCAN";
		Inventory.Amount 10;
		Inventory.MaxAmount 150;
		Ammo.BackpackAmount 10;
		Ammo.BackpackMaxAmount 300;
		Inventory.Icon "FCPUA0";
		Tag "$AMMO_FUEL";
	}
	States
	{
	Spawn:
		FCPU A -1;
		Stop;
	}
}

class FuelTank : Fuel
{
	Default
	{
		Inventory.PickupMessage "$ID24_GOTFUELTANK";
		Inventory.Amount 50;
	}
	States
	{
	Spawn:
		FTNK A -1;
		Stop;
	}
}

class Id1WeaponHandler : EventHandler
{
	override void CheckReplacement (ReplaceEvent e)
	{
		string mapName = level.MapName.MakeLower();
		if ( mapName.Left(3) == "id_" )
		{
			if ( CVar.FindCVar("wf_id1_weapswap").GetBool() )
			{
				if (e.Replacee is "PlasmaRifle")
					e.Replacement = "Incinerator";
				if (e.Replacee is "BFG9000")
					e.Replacement = "Heatwave";
				if (e.Replacee is "Cell")
					e.Replacement = "Fuel";
				if (e.Replacee is "CellPack")
					e.Replacement = "FuelTank";
			}
		}
	}
}
