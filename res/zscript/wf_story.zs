//-----------------------------------------------------------------------------
//
// Copyright 2025 Owlet VII
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

// everything here is a gross hack
extend class WadFusionStaticHandler
{
	void IntermissionStory()
	{
		string mapName = Level.MapName.MakeLower();
		
		if ( mapName == "wf_story" )
		{
			// play episode into stories
			if ( nextMap == "e1m1" )
				Level.StartIntermission("Doom1_Intro", FSTATE_INLEVELNOWIPE);
			else if ( nextMap == "e5m1" )
				Level.StartIntermission("Sigil_Intro", FSTATE_INLEVELNOWIPE);
			else if ( nextMap == "e6m1" )
				Level.StartIntermission("Sigil2_Intro", FSTATE_INLEVELNOWIPE);
			else if ( nextMap == "map01" )
				Level.StartIntermission("Doom2_Intro", FSTATE_INLEVELNOWIPE);
			else if ( nextMap == "nv_map01" )
				Level.StartIntermission("Nerve_Intro", FSTATE_INLEVELNOWIPE);
			else if ( nextMap == "lr_map01" )
				Level.StartIntermission("Id1_Intro", FSTATE_INLEVELNOWIPE);
			else if ( nextMap == "tn_map01" )
				Level.StartIntermission("Tnt_Intro", FSTATE_INLEVELNOWIPE);
			else if ( nextMap == "pl_map01" )
				Level.StartIntermission("Plutonia_Intro", FSTATE_INLEVELNOWIPE);
			else if ( !fullRunEnd )
			{
				Level.StartIntermission(intermission, FSTATE_INLEVELNOWIPE);
				fullRunNewGame = true;
				fullRunEnd = true;
			}
			else
				Level.StartIntermission("Fusion_FullRun_End", FSTATE_INLEVELNOWIPE);
			
			// change to the map which was set in NewGameIntro()
			if ( Level.MapTime >= 1 )
				Level.ChangeLevel(nextMap, 0, CHANGELEVEL_RESETINVENTORY|CHANGELEVEL_RESETHEALTH|CHANGELEVEL_NOINTERMISSION);
		}
	}
}
