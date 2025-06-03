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
extend class WadFusionHandler
{
	void IntermissionStory()
	{
		string nextMap = CVar.FindCVar("wf_nextmap").GetString();
		string mapName = Level.MapName.MakeLower();
		if ( mapName == "wf_story" )
		{
			// play episode into stories
			if ( nextMap == "e1m1" )
				Level.StartIntermission("Doom1_Intro", FSTATE_INLEVELNOWIPE);
			if ( nextMap == "e5m1" )
				Level.StartIntermission("Sigil_Intro", FSTATE_INLEVELNOWIPE);
			if ( nextMap == "e6m1" )
				Level.StartIntermission("Sigil2_Intro", FSTATE_INLEVELNOWIPE);
			if ( nextMap == "map01" )
				Level.StartIntermission("Doom2_Intro", FSTATE_INLEVELNOWIPE);
			if ( nextMap == "nv_map01" )
				Level.StartIntermission("Nerve_Intro", FSTATE_INLEVELNOWIPE);
			if ( nextMap == "lr_map01" )
				Level.StartIntermission("Id1_Intro", FSTATE_INLEVELNOWIPE);
			if ( nextMap == "tn_map01" )
				Level.StartIntermission("Tnt_Intro", FSTATE_INLEVELNOWIPE);
			if ( nextMap == "pl_map01" )
				Level.StartIntermission("Plutonia_Intro", FSTATE_INLEVELNOWIPE);
			
			// play master levels ending
			// a hack needed for the xaser order
			if ( nextMap == "ml_end" )
			{
				CVar.FindCVar("wf_nextmap").ResetToDefault();
				Level.StartIntermission("MasterLevels_End", FSTATE_INLEVELNOWIPE);
			}
			
			// change to the map which was set in NewGameIntro()
			if ( Level.MapTime >= 1 )
			{
				Level.ChangeLevel(nextMap, 0, CHANGELEVEL_RESETINVENTORY|CHANGELEVEL_RESETHEALTH|CHANGELEVEL_NOINTERMISSION);
				CVar.FindCVar("wf_nextmap").ResetToDefault();
			}
		}
		
		// play master levels stories
		if ( mapName.Left(15) == "wf_story_ml_map" )
		{
			let mapSuffix = mapName.Mid(15, 2);
			
			// play multi-page intermission between ml_map33 and ml_map34
			if ( mapSuffix == "34" )
			{
				Level.StartIntermission("MasterLevels_Map34", FSTATE_INLEVELNOWIPE);
				if ( Level.MapTime >= 1 )
					Level.ChangeLevel("ml_map34", 0, CHANGELEVEL_NOINTERMISSION);
			}
			if ( mapSuffix == "11" )
			{
				Level.StartIntermission("MasterLevels_Map11", FSTATE_INLEVELNOWIPE);
				if ( Level.MapTime >= 1 )
					Level.ChangeLevel("ml_map11", 0, CHANGELEVEL_NOINTERMISSION);
			}
			if ( mapSuffix == "12" )
			{
				Level.StartIntermission("MasterLevels_Map12", FSTATE_INLEVELNOWIPE);
				if ( Level.MapTime >= 1 )
					Level.ChangeLevel("ml_map12", 0, CHANGELEVEL_NOINTERMISSION);
			}
			if ( mapSuffix == "13" )
			{
				Level.StartIntermission("MasterLevels_Map13", FSTATE_INLEVELNOWIPE);
				if ( Level.MapTime >= 1 )
					Level.ChangeLevel("ml_map13", 0, CHANGELEVEL_NOINTERMISSION);
			}
			if ( mapSuffix == "15" )
			{
				Level.StartIntermission("MasterLevels_Map15", FSTATE_INLEVELNOWIPE);
				if ( Level.MapTime >= 1 )
					Level.ChangeLevel("ml_map15", 0, CHANGELEVEL_NOINTERMISSION);
			}
			if ( mapSuffix == "37" )
			{
				Level.StartIntermission("MasterLevels_Map37", FSTATE_INLEVELNOWIPE);
				if ( Level.MapTime >= 1 )
					Level.ChangeLevel("ml_map37", 0, CHANGELEVEL_NOINTERMISSION);
			}
			if ( mapSuffix == "38" )
			{
				Level.StartIntermission("MasterLevels_Map38", FSTATE_INLEVELNOWIPE);
				if ( Level.MapTime >= 1 )
					Level.ChangeLevel("ml_map38", 0, CHANGELEVEL_NOINTERMISSION);
			}
			if ( mapSuffix == "20" )
			{
				Level.StartIntermission("MasterLevels_Map20", FSTATE_INLEVELNOWIPE);
				if ( Level.MapTime >= 1 )
					Level.ChangeLevel("ml_map20", 0, CHANGELEVEL_NOINTERMISSION);
			}
			if ( mapSuffix == "18" )
			{
				Level.StartIntermission("MasterLevels_Map18", FSTATE_INLEVELNOWIPE);
				if ( Level.MapTime >= 1 )
					Level.ChangeLevel("ml_map18", 0, CHANGELEVEL_NOINTERMISSION);
			}
			if ( mapSuffix == "41" )
			{
				Level.StartIntermission("MasterLevels_Map41", FSTATE_INLEVELNOWIPE);
				if ( Level.MapTime >= 1 )
					Level.ChangeLevel("ml_map41", 0, CHANGELEVEL_NOINTERMISSION);
			}
			if ( mapSuffix == "42" )
			{
				Level.StartIntermission("MasterLevels_Map42", FSTATE_INLEVELNOWIPE);
				if ( Level.MapTime >= 1 )
					Level.ChangeLevel("ml_map42", 0, CHANGELEVEL_NOINTERMISSION);
			}
			if ( mapSuffix == "10" )
			{
				Level.StartIntermission("MasterLevels_Map10", FSTATE_INLEVELNOWIPE);
				if ( Level.MapTime >= 1 )
					Level.ChangeLevel("ml_map10", 0, CHANGELEVEL_NOINTERMISSION);
			}
			if ( mapSuffix == "43" )
			{
				Level.StartIntermission("MasterLevels_Map43", FSTATE_INLEVELNOWIPE);
				if ( Level.MapTime >= 1 )
					Level.ChangeLevel("ml_map43", 0, CHANGELEVEL_NOINTERMISSION);
			}
			
			// maps that need pistol starts
			if ( mapSuffix == "29" )
			{
				Level.StartIntermission("MasterLevels_Map29", FSTATE_INLEVELNOWIPE);
				CVar.FindCVar("wf_nextmap").SetString("ml_map29");
			}
			if ( mapSuffix == "30" )
			{
				Level.StartIntermission("MasterLevels_Map30", FSTATE_INLEVELNOWIPE);
				CVar.FindCVar("wf_nextmap").SetString("ml_map30");
			}
			if ( mapSuffix == "31" )
			{
				Level.StartIntermission("MasterLevels_Map31", FSTATE_INLEVELNOWIPE);
				CVar.FindCVar("wf_nextmap").SetString("ml_map31");
			}
			if ( mapSuffix == "32" )
			{
				Level.StartIntermission("MasterLevels_Map32", FSTATE_INLEVELNOWIPE);
				CVar.FindCVar("wf_nextmap").SetString("ml_map32");
			}
			if ( mapSuffix == "16" )
			{
				Level.StartIntermission("MasterLevels_Map16", FSTATE_INLEVELNOWIPE);
				CVar.FindCVar("wf_nextmap").SetString("ml_map16");
			}
			if ( mapSuffix == "17" )
			{
				Level.StartIntermission("MasterLevels_Map17", FSTATE_INLEVELNOWIPE);
				CVar.FindCVar("wf_nextmap").SetString("ml_map17");
			}
			if ( mapSuffix == "33" )
			{
				Level.StartIntermission("MasterLevels_Map33", FSTATE_INLEVELNOWIPE);
				CVar.FindCVar("wf_nextmap").SetString("ml_map33");
			}
			if ( mapSuffix == "19" )
			{
				Level.StartIntermission("MasterLevels_Map19", FSTATE_INLEVELNOWIPE);
				CVar.FindCVar("wf_nextmap").SetString("ml_map19");
			}
			
			// change map with pistol start
			if ( Level.MapTime >= 1 )
			{
				Level.ChangeLevel(nextMap, 0, CHANGELEVEL_RESETINVENTORY|CHANGELEVEL_RESETHEALTH|CHANGELEVEL_NOINTERMISSION);
				CVar.FindCVar("wf_nextmap").ResetToDefault();
			}
		}
	}
}
