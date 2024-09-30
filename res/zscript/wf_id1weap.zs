//-----------------------------------------------------------------------------
//
// Copyright 2024 jdbrowndev, Owlet VII
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

const INCINERATOR_FLAME_DAMAGE = 5;
const INCINERATOR_FLAME_VELOCITY = 40;
const INCINERATOR_BURN_DAMAGE = 5;
const INCINERATOR_BURN_RADIUS = 64;
const HEATWAVE_RIPPER_DAMAGE = 10;
const HEATWAVE_RIPPER_VELOCITY = 20;

class Incinerator : DoomWeapon
{
	Default
	{
		Weapon.SelectionOrder 200;
		Weapon.SlotNumber 6;
		Weapon.AmmoUse 1;
		Weapon.AmmoGive 20;
		Weapon.AmmoType "Fuel";
		Inventory.PickupMessage "$ID24_GOTINCINERATOR";
		Tag "$TAG_INCINERATOR";
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
			Goto FireReal;	
		FireSound2:
			FLMF A 0 Bright A_StartSound("weapons/incinerator/incfi2");
			Goto FireReal;
		FireReal:
			FLMF A 0 Bright A_GunFlash;
			FLMF A 1 Bright A_FireIncinerator();
			FLMF B 1 Bright;
			FLMG A 1;
			FLMG A 0 A_ReFire;
			Goto Ready;
		Flash:
			TNT1 A 2 A_Light2;
			TNT1 A 1 A_Light1;
			Goto LightDone;
		Spawn:
			INCN A -1;
			Stop;
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
		}
		
		SpawnPlayerMissile("IncineratorFlame");
	}
}

class IncineratorFlame : Actor
{
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
			Stop;
		Death:
			IFLM A 0 Bright A_Jump(128, "DeathSound2");
			IFLM A 0 Bright A_StartSound("weapons/incinerator/incht1");
			Goto Burninate;
		DeathSound2:
			IFLM A 0 Bright A_StartSound("weapons/incinerator/incht2");
			Goto Burninate;
		Burninate:
			IFLM I 2 Bright A_Explode(INCINERATOR_BURN_DAMAGE, INCINERATOR_BURN_RADIUS);
			IFLM J 2 Bright;
			IFLM I 2 Bright;
			IFLM J 2 Bright A_Explode(INCINERATOR_BURN_DAMAGE, INCINERATOR_BURN_RADIUS);
			IFLM K 2 Bright;
			IFLM J 2 Bright;
			IFLM K 2 Bright A_Explode(INCINERATOR_BURN_DAMAGE, INCINERATOR_BURN_RADIUS);
			IFLM L 2 Bright;
			IFLM K 2 Bright A_StartSound("weapons/incinerator/incht3");
			IFLM L 2 Bright A_Explode(INCINERATOR_BURN_DAMAGE, INCINERATOR_BURN_RADIUS);
			IFLM M 2 Bright;
			IFLM L 2 Bright;
			IFLM M 2 Bright A_Explode(INCINERATOR_BURN_DAMAGE, INCINERATOR_BURN_RADIUS);
			IFLM N 2 Bright;
			IFLM M 2 Bright;
			IFLM N 2 Bright A_Explode(INCINERATOR_BURN_DAMAGE, INCINERATOR_BURN_RADIUS);
			IFLM O 2 Bright;
			IFLM N 2 Bright;
			IFLM O 2 Bright;
			IFLM POP 2 Bright;
			Stop;
	}
}

class Heatwave : DoomWeapon
{
	Default
	{
		Weapon.SelectionOrder 2900;
		Weapon.SlotNumber 7;
		Weapon.AmmoUse 10;
		Weapon.AmmoGive 20;
		Weapon.AmmoType "Fuel";
		Inventory.PickupMessage "$ID24_GOTCALAMITYBLADE";
		Tag "$TAG_CALAMITYBLADE";
	}
	
	States
	{
		Ready:
			HETG A 1 A_WeaponReady;
			Loop;
		Deselect:
			HETG A 1 A_Lower;
			Loop;
		Select:
			HETG A 1 A_Raise;
			Loop;
		Fire:
		Charge1:
			HETG A 0 A_ConsumeAmmo();
			HETG A 0 A_GunFlash("FlashCharge1");
			HETG A 20 A_StartSound("weapons/heatwave/hetchg");
			HETG A 0 A_JumpIfNoAmmo("Fire1");
			HETG A 0 A_ReFire("Charge2");
			Goto Fire1;
		Charge2:
			HETG A 0 A_ConsumeAmmo();
			HETG A 0 A_GunFlash("FlashCharge2");
			HETG A 20 A_StartSound("weapons/heatwave/hetchg");
			HETG A 0 A_JumpIfNoAmmo("Fire2");
			HETG A 0 A_ReFire("Charge3");
			Goto Fire2;
		Charge3:
			HETG A 0 A_ConsumeAmmo();
			HETG A 0 A_GunFlash("FlashCharge3");
			HETG A 20 A_StartSound("weapons/heatwave/hetchg");
			HETG A 0 A_JumpIfNoAmmo("Fire3");
			HETG A 0 A_ReFire("Charge4");
			Goto Fire3;
		Charge4:
			HETG A 0 A_ConsumeAmmo();
			HETG A 0 A_GunFlash("FlashCharge4");
			HETG A 20 A_StartSound("weapons/heatwave/hetchg");
			HETG A 0 A_JumpIfNoAmmo("Fire4");
			HETG A 0 A_ReFire("Charge5");
			Goto Fire4;
		Charge5:
			HETG A 0 A_ConsumeAmmo();
			HETG A 0 A_GunFlash("FlashCharge5");
			HETG A 20 A_StartSound("weapons/heatwave/hetchg");
			Goto Fire5;
		Fire1:
			HETF A 0 Bright A_SpawnHeatwaveRipper(-5.0);
			HETF A 0 Bright A_SpawnHeatwaveRipper(0.0);
			HETF A 0 Bright A_SpawnHeatwaveRipper(5.0);
			Goto FireEnd;
		Fire2:
			HETF A 0 Bright A_SpawnHeatwaveRipper(-12.5);
			HETF A 0 Bright A_SpawnHeatwaveRipper(-7.5);
			HETF A 0 Bright A_SpawnHeatwaveRipper(-2.5);
			HETF A 0 Bright A_SpawnHeatwaveRipper(2.5);
			HETF A 0 Bright A_SpawnHeatwaveRipper(7.5);
			HETF A 0 Bright A_SpawnHeatwaveRipper(12.5);
			Goto FireEnd;
		Fire3:
			HETF A 0 Bright A_SpawnHeatwaveRipper(-20.0);
			HETF A 0 Bright A_SpawnHeatwaveRipper(-15.0);
			HETF A 0 Bright A_SpawnHeatwaveRipper(-10.0);
			HETF A 0 Bright A_SpawnHeatwaveRipper(-5.0);
			HETF A 0 Bright A_SpawnHeatwaveRipper(0.0);
			HETF A 0 Bright A_SpawnHeatwaveRipper(5.0);
			HETF A 0 Bright A_SpawnHeatwaveRipper(10.0);
			HETF A 0 Bright A_SpawnHeatwaveRipper(15.0);
			HETF A 0 Bright A_SpawnHeatwaveRipper(20.0);
			Goto FireEnd;
		Fire4:
			HETF A 0 Bright A_SpawnHeatwaveRipper(-27.5);
			HETF A 0 Bright A_SpawnHeatwaveRipper(-22.5);
			HETF A 0 Bright A_SpawnHeatwaveRipper(-17.5);
			HETF A 0 Bright A_SpawnHeatwaveRipper(-12.5);
			HETF A 0 Bright A_SpawnHeatwaveRipper(-7.5);
			HETF A 0 Bright A_SpawnHeatwaveRipper(-2.5);
			HETF A 0 Bright A_SpawnHeatwaveRipper(2.5);
			HETF A 0 Bright A_SpawnHeatwaveRipper(7.5);
			HETF A 0 Bright A_SpawnHeatwaveRipper(12.5);
			HETF A 0 Bright A_SpawnHeatwaveRipper(17.5);
			HETF A 0 Bright A_SpawnHeatwaveRipper(22.5);
			HETF A 0 Bright A_SpawnHeatwaveRipper(27.5);
			Goto FireEnd;
		Fire5:
			HETF A 0 Bright A_SpawnHeatwaveRipper(-35.0);
			HETF A 0 Bright A_SpawnHeatwaveRipper(-30.0);
			HETF A 0 Bright A_SpawnHeatwaveRipper(-25.0);
			HETF A 0 Bright A_SpawnHeatwaveRipper(-20.0);
			HETF A 0 Bright A_SpawnHeatwaveRipper(-15.0);
			HETF A 0 Bright A_SpawnHeatwaveRipper(-10.0);
			HETF A 0 Bright A_SpawnHeatwaveRipper(-5.0);
			HETF A 0 Bright A_SpawnHeatwaveRipper(0.0);
			HETF A 0 Bright A_SpawnHeatwaveRipper(5.0);
			HETF A 0 Bright A_SpawnHeatwaveRipper(10.0);
			HETF A 0 Bright A_SpawnHeatwaveRipper(15.0);
			HETF A 0 Bright A_SpawnHeatwaveRipper(20.0);
			HETF A 0 Bright A_SpawnHeatwaveRipper(25.0);
			HETF A 0 Bright A_SpawnHeatwaveRipper(30.0);
			HETF A 0 Bright A_SpawnHeatwaveRipper(35.0);
			Goto FireEnd;
		FireEnd:
			HETF A 0 Bright A_StartSound("weapons/heatwave/hetsht");
			HETF A 3 Bright A_GunFlash;
			HETF B 5 Bright;
			HETG D 4;
			HETG C 4;
			HETG B 4;
			HETG A 0 A_ReFire;
			Goto Ready;
		FlashCharge1:
			HETC A 6 Bright;
			HETC BCD 5 Bright;
			Goto LightDone;
		FlashCharge2:
			HETC E 6 Bright;
			HETC FGH 5 Bright;
			Goto LightDone;
		FlashCharge3:
			HETC I 6 Bright;
			HETC JKL 5 Bright;
			Goto LightDone;
		FlashCharge4:
			HETC M 6 Bright;
			HETC NOP 5 Bright;
			Goto LightDone;
		FlashCharge5:
			HETC Q 6 Bright;
			HETC RST 5 Bright;
			Goto LightDone;
		Flash:
			TNT1 A 3 A_Light1;
			TNT1 A 5 A_Light2;
			Goto LightDone;
		Spawn:
			CBLD A -1;
			Stop;
	}
	
	action bool A_ConsumeAmmo()
	{
		if (player != null)
		{
			Weapon weap = player.ReadyWeapon;
			if (weap != null && invoker == weap && stateinfo != null && stateinfo.mStateType == STATE_Psprite)
			{
				return weap.DepleteAmmo(weap.bAltFire, true);
			}
		}
		
		return false;
	}
	
	action void A_SpawnHeatwaveRipper(double angle)
	{
		SpawnPlayerMissile("HeatwaveRipper", self.angle + angle, 0, 0, 0, null, false, true);
	}
}

class HeatwaveRipper : Actor
{
	Default
	{
		Damage HEATWAVE_RIPPER_DAMAGE;
		Speed HEATWAVE_RIPPER_VELOCITY;
		Radius 16;
		Height 8;
		RenderStyle "Translucent";
		Alpha 0.65;
		DeathSound "weapons/heatwave/hetxpl";

		+NOBLOCKMAP
		+NOGRAVITY
		+DROPOFF
		+MISSILE
		+RIPPER
	}
	
	States
	{
		Spawn:
			HETB ABC 3 Bright;
			Loop;
		Death:
			HETB DEFGHI 3 Bright;
			Stop;
	}
}

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
		int weapSwap = CVar.FindCVar("wf_id1_weapswap").GetInt();
		string mapName = level.MapName.MakeLower();
		if ( ( weapSwap == 1 && mapName.Left(3) == "lr_" ) || weapSwap >= 2 )
		{
			if ( Level.MapTime == 0 )
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
