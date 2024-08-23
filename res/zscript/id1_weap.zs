
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
