
class WadSmooshMusicHandler : EventHandler
{
	// Sigil's map music should be defined as something invalid in
	// MAPINFO, that way it keeps playing the last music file
	// until it gets replaced by the script
	override void WorldLoaded(WorldEvent e)
	{
		// get map name and map music name
		string mapName = level.MapName.MakeLower();
		string mapMusic = "d_"..mapName;
		string mapMusicShreds = mapMusic.."a";
		// set music for Sigil maps
		if ( mapName.Left(3) == "e5m" )
		{
			// play the mp3 soundtrack
			if ( (CVar.FindCVar("ws_sigil_shreds").GetBool() ) )
			{
				S_ChangeMusic( mapMusicShreds );
			}
			// play the midi soundtrack
			else
			{
				S_ChangeMusic( mapMusic );
			}
		}
		// set music for Sigil2 maps
		if ( mapName.Left(3) == "e6m" )
		{
			// play the mp3 soundtrack
			if ( (CVar.FindCVar("ws_sigil2_shreds").GetBool() ) )
			{
				S_ChangeMusic( mapMusicShreds );
			}
			// play the midi soundtrack
			else
			{
				S_ChangeMusic( mapMusic );
			}
		}
	}
	
	// Doom1, Doom2, and Sigil's InterMusic should be defined as something
	// invalid in MAPINFO, that way it keeps playing the music file set by
	// the script once the map unloads and enters the intermission screen
	override void WorldUnloaded(WorldEvent e)
	{
		// get map name
		string mapName = level.MapName.MakeLower();
		// set music for Sigil intermissions
		if ( mapName.Left(3) == "e5m" )
		{
			// play the mp3 soundtrack
			if ( (CVar.FindCVar("ws_sigil_shreds").GetBool() ) )
				S_ChangeMusic("s_intera");
			// play the midi soundtrack
			else
				S_ChangeMusic("s_inter");
		}
		// set music for Sigil2 intermissions
		if ( mapName.Left(3) == "e6m" )
		{
			// play the mp3 soundtrack
			if ( (CVar.FindCVar("ws_sigil2_shreds").GetBool() ) )
				S_ChangeMusic("s2_intea");
			// play the midi soundtrack
			else
				S_ChangeMusic("s2_inter");
		}
	}
}
