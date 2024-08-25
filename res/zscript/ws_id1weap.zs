
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
			if ( CVar.FindCVar("ws_id1_weapswap").GetBool() )
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
