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
		
		if ( mapName.Left(8) == "wf_story" )
		{
			if ( mapName.Mid(9, 6) != "ml_map" )
			{
				// play episode into stories
				if ( nextMap == "e1m1" )
					intermission = "Doom1_Intro";
				else if ( nextMap == "e5m1" )
					intermission = "Sigil_Intro";
				else if ( nextMap == "e6m1" )
					intermission = "Sigil2_Intro";
				else if ( nextMap == "map01" )
					intermission = "Doom2_Intro";
				else if ( nextMap == "nv_map01" )
					intermission = "Nerve_Intro";
				else if ( nextMap == "lr_map01" )
					intermission = "Id1_Intro";
				else if ( nextMap == "tn_map01" )
					intermission = "Tnt_Intro";
				else if ( nextMap == "pl_map01" )
					intermission = "Plutonia_Intro";
				
				StoryStartIntermission();
				
				// don't skip the screen wipe when loading a newgame hack map
				int fullRun = CVar.FindCVar("wf_fullrun").GetInt();
				if ( fullRun >= 1 && fullRun <= 3 )
					fullRunNewGame = true;
				
				// change to the map which was set in NewGameIntro() or FullRun()
				if ( Level.MapTime >= 1 )
				{
					if ( !fullRunEnd )
						Level.ChangeLevel(nextMap, 0, CHANGELEVEL_RESETINVENTORY|CHANGELEVEL_RESETHEALTH|CHANGELEVEL_NOINTERMISSION);
					// try changing to a level that doesn't exist
					// this triggets the default ending sequence -- Fusion_GotoTitle
					else if ( !multiplayer )
						Level.ChangeLevel("", 0, CHANGELEVEL_NOINTERMISSION);
				}
			}
			else
			{
				// hack for adding optional story intermissions in the master levels rejects
				string mapSuffix = mapName.Mid(15, 2);
				intermission = "MasterLevels_Map"..mapSuffix;
				nextMap = "ml_map"..mapSuffix;
				
				StoryStartIntermission();
				
				if ( Level.MapTime >= 1 )
				{
					if ( mapSuffix == "29" || mapSuffix == "30" ||
							mapSuffix == "31" || mapSuffix == "32" ||
							mapSuffix == "16" || mapSuffix == "17" ||
							mapSuffix == "33" || mapSuffix == "19" )
						Level.ChangeLevel(nextMap, 0, CHANGELEVEL_RESETINVENTORY|CHANGELEVEL_RESETHEALTH|CHANGELEVEL_NOINTERMISSION);
					else
						Level.ChangeLevel(nextMap, 0, CHANGELEVEL_NOINTERMISSION);
				}
			}
		}
	}
	
	void StoryStartIntermission()
	{
		if ( !multiplayer )
			Level.StartIntermission(intermission, FSTATE_INLEVELNOWIPE);
		else if ( Level.MapTime == 0 )
			EventHandler.SendNetworkEvent("IntermissionStoryEvent");
	}
	
	void FullRunEndMultiplayerTakeStuff()
	{
		string mapName = Level.MapName.MakeLower();
		
		if ( mapName == "wf_story" && Level.MapTime == 0 )
		{
			if ( fullRunEnd && multiplayer )
				ForcePistolStart();
		}
	}
	
	ui void FullRunEndMultiplayer()
	{
		string mapName = Level.MapName.MakeLower();
		
		if ( mapName == "wf_story" )
		{
			if ( fullRunEnd && multiplayer )
				Screen.DrawText(smallfont, Font.CR_UNTRANSLATED, 1, 1, "$WF_FULLRUN_END_MULTIPLAYER", DTA_320x200, true);
		}
	}
}
