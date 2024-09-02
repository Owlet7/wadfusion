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

//temp weap

class Incinerator : PlasmaRifle
{
	Default
	{
		Weapon.AmmoType "Fuel";
		Weapon.SlotNumber 6;
	}
}

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
