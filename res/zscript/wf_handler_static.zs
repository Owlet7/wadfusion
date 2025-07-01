//-----------------------------------------------------------------------------
//
// Copyright 2024-2025 Owlet VII
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

class WadFusionStaticHandler : StaticEventHandler
{
	// global variable
	string nextMap;
	string intermission;
	bool fullRunNewGame;
	bool fullRunEnd;
	
	override void OnEngineInitialize()
	{
		if ( Wads.CheckNumForFullName('music/d_dm2ttl.mus') == -1 )
			S_ChangeMusic('d_intro', 0, false);
	}
	
	override void PostUiTick()
	{
		if ( CVar.FindCVar("wf_compat_changemusic").GetBool() )
		{
			DoSigilMusicReplacements(); // wf_mus_sigil.zs
			DoIdkfaMusicReplacements(); // wf_mus_idkfa.zs
			DoMusicReplacements();      // wf_mus_swap.zs
		}
	}
	
	override void ConsoleProcess(ConsoleEvent e)
	{
		// wf_defaults.zs
		// reset all custom cvars to their defaults
		if ( e.Name == "wf_reset2defaults" )
		{
			WadFusionReset2Defaults();
		}
	}
	
	override void NetworkProcess(ConsoleEvent e)
	{
		if (e.Name ~== "NewGameChangeLevelEvent")
		{
			// wf_newgame.zs
			NewGameChangeLevelInput();
		}
	}
	
	override void WorldLoaded(WorldEvent e)
	{
		// reset global variables when starting maps where they're not used,
		// to reduce the possibility of scripts breaking when transitioning to a hack dummy map
		string mapName = Level.MapName.MakeLower();
		if ( mapName.Left(10) != "wf_newgame" && mapName.Left(8) != "wf_story" )
		{
			nextMap = "";
			intermission = "";
			fullRunNewGame = false;
			fullRunEnd = false;
		}
	}
	
	override void WorldUnloaded(WorldEvent e)
	{
		if ( CVar.FindCVar("wf_compat_nextmap").GetBool() )
			FullRun(); // wf_fullrun.zs
	}
	
	override void WorldTick()
	{
		if ( CVar.FindCVar("wf_compat_nextmap").GetBool() )
			FullRunStory(); // wf_fullrun.zs
		
		// very hacky methods of adding optional titlescreens
		// and story intermissions when starting new games
		// saving and loading on the hack dummy maps will break these sequences!
		NewGameIntro(); // wf_newgame.zs
		IntermissionStory(); // wf_story.zs
		
		// wf_story_masterlevels.zs
		// hack for adding optional story intermissions in the master levels rejects
		MasterLevelsStory();
	}
	
	override void RenderOverlay(RenderEvent e)
	{
		// wf_newgame.zs
		// sets the correct titlepic for the hacky titlescreens
		NewGameTitlePic();
	}
	
	override bool InputProcess(InputEvent e)
	{
		// press any key on the hacky titlescreens to continue
		if ( CVar.FindCVar("wf_compat_titlepics").GetBool() )
		{
			string mapName = Level.MapName.MakeLower();
			if ( mapName.Left(10) == "wf_newgame" && mapName != "wf_newgame" )
			{
				if (e.Type == InputEvent.Type_KeyDown)
				{
					EventHandler.SendNetworkEvent("NewGameChangeLevelEvent");
				}
			}
		}
		return false;
	}
	
	ui void DoChangeMusic(string music)
	{
		// define array of supported title themes
		string titleMusic[] =
		{
			"d_intro",
			"d_introa",
			"s_intro",
			"s_introa",
			"s2_intro",
			"s2_intra",
			"d_dm2ttl",
			"t_dm2ttl",
			"p_dm2ttl",
			"x_dm2ttl",
			"h_dm2ttl",
			"h_intro"
		};
		
		// don't loop title themes
		for ( int i = 0; i < titleMusic.Size(); i++ )
		{
			DoSigilTitleMusicReplacements(); // wf_mus_sigil.zs
			DoIdkfaTitleMusicReplacements(); // wf_mus_idkfa.zs
			DoTitleMusicReplacements();      // wf_mus_swap.zs
			
			if ( music == titleMusic[i] )
				return;
			else if ( i == titleMusic.Size() - 1 )
				S_ChangeMusic(music);
		}
	}
}
