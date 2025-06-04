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
	ui void NewGameTitlePic()
	{
		string mapName = Level.MapName.MakeLower();
		if ( mapName.Left(10) == "wf_newgame" )
		{
			TextureId titlePic = TexMan.CheckForTexture("TITLEPIC");
			TextureId titleD1 = TexMan.CheckForTexture("TITLED1");
			TextureId titleUD = TexMan.CheckForTexture("TITLEUD");
			TextureId titleS1 = TexMan.CheckForTexture("TITLES1");
			TextureId titleS2 = TexMan.CheckForTexture("TITLES2");
			TextureId titleD2 = TexMan.CheckForTexture("TITLED2");
			TextureId titleML = TexMan.CheckForTexture("TITLEML");
			TextureId titleNV = TexMan.CheckForTexture("TITLENV");
			TextureId titleLR = TexMan.CheckForTexture("TITLELR");
			TextureId titleTN = TexMan.CheckForTexture("TITLETN");
			TextureId titlePL = TexMan.CheckForTexture("TITLEPL");
			
			if ( CVar.FindCVar("wf_compat_titlepics").GetBool() )
			{
				let mapSuffix = mapName.Mid(10, 3);
				
				if ( mapSuffix == "_d1" )
					Screen.DrawTexture(titleD1, false, 0, 0, DTA_FullScreen, 1);
				else if ( mapSuffix == "_ud" )
					Screen.DrawTexture(titleUD, false, 0, 0, DTA_FullScreen, 1);
				else if ( mapSuffix == "_s1" )
					Screen.DrawTexture(titleS1, false, 0, 0, DTA_FullScreen, 1);
				else if ( mapSuffix == "_s2" )
					Screen.DrawTexture(titleS2, false, 0, 0, DTA_FullScreen, 1);
				else if ( mapSuffix == "_d2" )
					Screen.DrawTexture(titleD2, false, 0, 0, DTA_FullScreen, 1);
				else if ( mapSuffix == "_ml" )
					Screen.DrawTexture(titleML, false, 0, 0, DTA_FullScreen, 1);
				else if ( mapSuffix == "_nv" )
					Screen.DrawTexture(titleNV, false, 0, 0, DTA_FullScreen, 1);
				else if ( mapSuffix == "_lr" )
					Screen.DrawTexture(titleLR, false, 0, 0, DTA_FullScreen, 1);
				else if ( mapSuffix == "_tn" )
					Screen.DrawTexture(titleTN, false, 0, 0, DTA_FullScreen, 1);
				else if ( mapSuffix == "_pl" )
					Screen.DrawTexture(titlePL, false, 0, 0, DTA_FullScreen, 1);
				else
					Screen.DrawTexture(titlePic, false, 0, 0, DTA_FullScreen, 1);
			}
			else
				Screen.DrawTexture(titlePic, false, 0, 0, DTA_FullScreen, 1);
		}
	}
	
	void NewGameIntro()
	{
		string mapName = Level.MapName.MakeLower();
		if ( mapName.Left(10) == "wf_newgame" )
		{
			if ( Level.MapTime == 0 )
			{
				// starting an empty intermission on the first tic removes
				// the screen wipe that usually happens when changing levels
				Level.StartIntermission("WadFusionNewGame", FSTATE_INLEVELNOWIPE);
				
				let mapSuffix = mapName.Mid(10, 3);
				
				// set which map to switch to
				if ( mapSuffix == "_d1" )
					CVar.FindCVar("wf_nextmap").SetString("e1m1");
				else if ( mapSuffix == "_ud" )
					CVar.FindCVar("wf_nextmap").SetString("e4m1");
				else if ( mapSuffix == "_s1" )
					CVar.FindCVar("wf_nextmap").SetString("e5m1");
				else if ( mapSuffix == "_s2" )
					CVar.FindCVar("wf_nextmap").SetString("e6m1");
				else if ( mapSuffix == "_d2" )
					CVar.FindCVar("wf_nextmap").SetString("map01");
				else if ( mapSuffix == "_ml" )
					CVar.FindCVar("wf_nextmap").SetString("ml_map01");
				else if ( mapSuffix == "_nv" )
					CVar.FindCVar("wf_nextmap").SetString("nv_map01");
				else if ( mapSuffix == "_lr" )
					CVar.FindCVar("wf_nextmap").SetString("lr_map01");
				else if ( mapSuffix == "_tn" )
					CVar.FindCVar("wf_nextmap").SetString("tn_map01");
				else if ( mapSuffix == "_pl" )
					CVar.FindCVar("wf_nextmap").SetString("pl_map01");
				
				if ( CVar.FindCVar("wf_compat_titlepics").GetBool() )
				{
					// play title music for each game
					if ( mapSuffix == "_d1" || mapSuffix == "_ud" )
						S_ChangeMusic("d_intro", 0, false);
					else if ( mapSuffix == "_s1" )
						PlaySigilIntroMusic();
					else if ( mapSuffix == "_s2" )
						PlaySigil2IntroMusic();
					else if ( mapSuffix == "_d2" || mapSuffix == "_ml" || mapSuffix == "_nv" )
						S_ChangeMusic("d_dm2ttl", 0, false);
					else if ( mapSuffix == "_lr" )
						S_ChangeMusic("x_dm2ttl", 0, false);
					else if ( mapSuffix == "_tn" )
						S_ChangeMusic("t_dm2ttl", 0, false);
					else if ( mapSuffix == "_pl" )
						S_ChangeMusic("p_dm2ttl", 0, false);
					// immediately switch to the set map if not starting an episode
					else
						NewGameChangeLevel();
				}
				else
					NewGameChangeLevel();
			}
		}
	}
	
	void PlaySigilIntroMusic()
	{
		// play the mp3 soundtrack
		if ( CVar.FindCVar("wf_mus_sigilmp3").GetBool() )
		{
			S_ChangeMusic("s_introa", 0, false);
		}
		// play the midi soundtrack
		else
		{
			S_ChangeMusic("s_intro", 0, false);
		}
	}
	
	void PlaySigil2IntroMusic()
	{
		// play the mp3 soundtrack
		if ( CVar.FindCVar("wf_mus_sigil2mp3").GetBool() )
		{
			S_ChangeMusic("s2_intra", 0, false);
		}
		// play the midi soundtrack
		else
		{
			S_ChangeMusic("s2_intro", 0, false);
		}
	}
	
	void NewGameChangeLevel()
	{
		string nextMap = CVar.FindCVar("wf_nextmap").GetString();
		string mapName = Level.MapName.MakeLower();
		if ( mapName.Left(10) == "wf_newgame" )
			Level.ChangeLevel(nextMap, 0, CHANGELEVEL_RESETINVENTORY|CHANGELEVEL_RESETHEALTH|CHANGELEVEL_NOINTERMISSION);
		CVar.FindCVar("wf_nextmap").ResetToDefault();
	}
	
	ui void NewGameChangeLevelInput()
	{
		string nextMap = CVar.FindCVar("wf_nextmap").GetString();
		string mapName = Level.MapName.MakeLower();
		if ( CVar.FindCVar("wf_intros").GetBool() )
		{
			if ( mapName != "wf_newgame_ml" && mapName != "wf_newgame_ud" )
				Level.ChangeLevel("wf_story", 0, CHANGELEVEL_RESETINVENTORY|CHANGELEVEL_RESETHEALTH|CHANGELEVEL_NOINTERMISSION);
			else
			{
				Level.ChangeLevel(nextMap, 0, CHANGELEVEL_RESETINVENTORY|CHANGELEVEL_RESETHEALTH|CHANGELEVEL_NOINTERMISSION);
				CVar.FindCVar("wf_nextmap").ResetToDefault();
			}
		}
		else
		{
			Level.ChangeLevel(nextMap, 0, CHANGELEVEL_RESETINVENTORY|CHANGELEVEL_RESETHEALTH|CHANGELEVEL_NOINTERMISSION);
			CVar.FindCVar("wf_nextmap").ResetToDefault();
		}
	}
}
