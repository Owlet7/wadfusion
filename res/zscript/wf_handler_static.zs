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
	String nextMap;
	String intermission;
	bool fullRunNewGame;
	bool fullRunFinished;
	
	override void OnRegister()
	{
		Console.Printf(StringTable.Localize("$WF_TITLE").." version "..WF_VERSION);
	}
	
	override void OnEngineInitialize()
	{
		if ( Wads.CheckNumForFullName("music/d_dm2ttl.mus") == -1 )
			S_ChangeMusic("d_intro", 0, false);
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
		if ( e.Name ~== "wf_reset2defaults" )
			WadFusionReset2Defaults(); // wf_defaults.zs
	}
	
	override void NetworkProcess(ConsoleEvent e)
	{
		if (e.Name ~== "NewGameChangeLevelInputEvent")
			NewGameChangeLevelInput(); // wf_newgame.zs
		
		if (e.Name ~== "IntermissionStoryEvent")
			Level.StartIntermission(intermission, FSTATE_INLEVELNOWIPE);
	}
	
	override void WorldLoaded(WorldEvent e)
	{
		// reset global variables when starting maps where they're not used
		string mapName = Level.MapName.MakeLower();
		if ( mapName.Left(10) != "wf_newgame" && mapName.Left(8) != "wf_story" )
		{
			nextMap = "";
			intermission = "";
			fullRunNewGame = false;
			fullRunFinished = false;
		}
	}
	
	override void WorldUnloaded(WorldEvent e)
	{
		// force pistol start on half of the master levels.
		// this is needed to support switching between the xaser order,
		// in which they should have pistol starts,
		// and the rejects order, in which they shouldn't
		if ( CVar.FindCVar("wf_compat_pistolstart").GetBool() )
		{
			if ( !CVar.FindCVar("wf_map_mlr").GetBool() )
			{
				if ( Level.NextMap == "ml_map10" || Level.NextMap == "ml_map11" ||
					 Level.NextMap == "ml_map12" || Level.NextMap == "ml_map13" ||
					 Level.NextMap == "ml_map14" || Level.NextMap == "ml_map15" || 
					 Level.NextMap == "ml_map18" || Level.NextMap == "ml_map20" )
				{
					ForcePistolStart();
				}
			}
		}
		
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
		
		FullRunMultiplayerTakeStuff(); // wf_story.zs
	}
	
	override void RenderOverlay(RenderEvent e)
	{
		NewGameTitlePic(); // wf_newgame.zs
		FullRunMultiplayer(); // wf_story.zs
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
					EventHandler.SendNetworkEvent("NewGameChangeLevelInputEvent");
			}
		}
		return false;
	}
	
	void ForcePistolStart()
	{
		for ( int i; i < MAXPLAYERS; i++ )
		{
			if ( !playerInGame[i] || !players[i].mo )
				continue;
			
			PlayerPawn pPawn = PlayerPawn(players[i].mo);
			
			if ( pPawn.Health > 0 )
			{
				players[i].Health = pPawn.Default.Health;
				pPawn.Health = pPawn.Default.Health;
				pPawn.ClearInventory();
				pPawn.GiveDefaultInventory();
			}
		}
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
