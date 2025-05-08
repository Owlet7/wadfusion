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

extend class WadFusionHandler
{
	void IntermissionStory()
	{
		string nextMap = CVar.FindCVar("wf_nextmap").GetString();
		string mapName = Level.MapName.MakeLower();
		// play episode into stories
		if ( mapName == "wf_story" )
		{
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
			// change to the map which was set in NewGameIntro()
			if ( Level.MapTime >= 1 )
			{
				Level.ChangeLevel(nextMap, 0, CHANGELEVEL_RESETINVENTORY|CHANGELEVEL_RESETHEALTH|CHANGELEVEL_NOINTERMISSION);
				CVar.FindCVar("wf_nextmap").ResetToDefault();
			}
		}
		
		// play master levels rejects stories at the start of each mini-campaign
		if ( mapName.Left(15) == "wf_story_ml_map" )
		{
			let mapSuffix = mapName.Mid(15, 2);
			if ( mapSuffix == "29" )
			{
				Level.StartIntermission("MasterLevels_Intro1", FSTATE_INLEVELNOWIPE);
				CVar.FindCVar("wf_nextmap").SetString("ml_map29");
			}
			else if ( mapSuffix == "33" )
			{
				Level.StartIntermission("MasterLevels_Intro2", FSTATE_INLEVELNOWIPE);
				CVar.FindCVar("wf_nextmap").SetString("ml_map33");
			}
			else if ( mapSuffix == "19" )
			{
				Level.StartIntermission("MasterLevels_Intro3", FSTATE_INLEVELNOWIPE);
				CVar.FindCVar("wf_nextmap").SetString("ml_map19");
			}
			
			if ( Level.MapTime >= 1 && mapSuffix != "34" )
			{
				Level.ChangeLevel(nextMap, 0, CHANGELEVEL_RESETINVENTORY|CHANGELEVEL_RESETHEALTH|CHANGELEVEL_NOINTERMISSION);
				CVar.FindCVar("wf_nextmap").ResetToDefault();
			}
			
			// play multi-page intermission between ml_map33 and ml_map34
			if ( mapSuffix == "34" )
			{
				Level.StartIntermission("MasterLevels_Map34", FSTATE_INLEVELNOWIPE);
				if ( Level.MapTime >= 1 )
					Level.ChangeLevel("ml_map34", 0, CHANGELEVEL_NOINTERMISSION);
			}
			
			// play intermission between ml_map10 and ml_map43
			// needed to have a different background when entering and exiting
			if ( mapSuffix == "43" )
			{
				Level.StartIntermission("MasterLevels_Map43", FSTATE_INLEVELNOWIPE);
				if ( Level.MapTime >= 1 )
					Level.ChangeLevel("ml_map43", 0, CHANGELEVEL_NOINTERMISSION);
			}
		}
	}
}
