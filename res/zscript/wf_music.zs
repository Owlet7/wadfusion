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

class WadFusionMusicHandler : EventHandler
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
			if ( (CVar.FindCVar("wf_sigil_shreds").GetBool() ) )
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
			if ( (CVar.FindCVar("wf_sigil2_shreds").GetBool() ) )
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
			if ( (CVar.FindCVar("wf_sigil_shreds").GetBool() ) )
				S_ChangeMusic("s_intera");
			// play the midi soundtrack
			else
				S_ChangeMusic("s_inter");
		}
		// set music for Sigil2 intermissions
		if ( mapName.Left(3) == "e6m" )
		{
			// play the mp3 soundtrack
			if ( (CVar.FindCVar("wf_sigil2_shreds").GetBool() ) )
				S_ChangeMusic("s2_intea");
			// play the midi soundtrack
			else
				S_ChangeMusic("s2_inter");
		}
	}
}
