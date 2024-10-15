

class WadFusionRomeroHandler : EventHandler
{
	override void WorldLoaded(WorldEvent e)
	{
		if(level.MapName == "E1M3")
		{
			if ( (CVar.FindCVar("wf_e1m4b").GetBool() ) )
			{
				level.NextMap = "e1m4b";
			}
		}

		if(level.MapName == "E1M7")
		{
			if ( (CVar.FindCVar("wf_e1m8b").GetBool() ) )
			{
				level.NextMap = "e1m8b";
			}
		}
	}
}