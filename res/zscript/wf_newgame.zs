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
			
			if ( CVar.FindCVar("wf_intros").GetInt() >= 1 )
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
		if ( mapName.Left(10) == "wf_newgame" && mapName != "wf_newgame_story" )
		{
			if ( Level.MapTime == 0 )
			{
				// starting an empty intermission on the first tic removes
				// the screen wipe that usually heppens when changing levels
				Level.StartIntermission("WadFusionNewGame", FSTATE_INLEVELNOWIPE);
				
				let mapSuffix = mapName.Mid(10, 3);
				
				// set which map to switch to
				if ( mapName.Mid(10, 3) == "_d1" )
					CVar.FindCVar("wf_newgame").SetString("e1m1");
				else if ( mapSuffix == "_ud" )
					CVar.FindCVar("wf_newgame").SetString("e4m1");
				else if ( mapSuffix == "_s1" )
					CVar.FindCVar("wf_newgame").SetString("e5m1");
				else if ( mapSuffix == "_s2" )
					CVar.FindCVar("wf_newgame").SetString("e6m1");
				else if ( mapSuffix == "_d2" )
					CVar.FindCVar("wf_newgame").SetString("map01");
				else if ( mapSuffix == "_ml" )
					CVar.FindCVar("wf_newgame").SetString("ml_map01");
				else if ( mapSuffix == "_nv" )
					CVar.FindCVar("wf_newgame").SetString("nv_map01");
				else if ( mapSuffix == "_lr" )
					CVar.FindCVar("wf_newgame").SetString("lr_map01");
				else if ( mapSuffix == "_tn" )
					CVar.FindCVar("wf_newgame").SetString("tn_map01");
				else if ( mapSuffix == "_pl" )
					CVar.FindCVar("wf_newgame").SetString("pl_map01");
				
				if ( CVar.FindCVar("wf_intros").GetInt() >= 1 )
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
	
	void NewGameStory()
	{
		string newGame = CVar.FindCVar("wf_newgame").GetString();
		string mapName = Level.MapName.MakeLower();
		// play episode into stories
		if ( mapName == "wf_newgame_story" )
		{
			if ( newGame == "e1m1" )
				Level.StartIntermission("Doom1_Intro", FSTATE_INLEVELNOWIPE);
			else if ( newGame == "e5m1" )
				Level.StartIntermission("Sigil_Intro", FSTATE_INLEVELNOWIPE);
			else if ( newGame == "e6m1" )
				Level.StartIntermission("Sigil2_Intro", FSTATE_INLEVELNOWIPE);
			else if ( newGame == "map01" )
				Level.StartIntermission("Doom2_Intro", FSTATE_INLEVELNOWIPE);
			else if ( newGame == "nv_map01" )
				Level.StartIntermission("Nerve_Intro", FSTATE_INLEVELNOWIPE);
			else if ( newGame == "lr_map01" )
				Level.StartIntermission("Id1_Intro", FSTATE_INLEVELNOWIPE);
			else if ( newGame == "tn_map01" )
				Level.StartIntermission("Tnt_Intro", FSTATE_INLEVELNOWIPE);
			else if ( newGame == "pl_map01" )
				Level.StartIntermission("Plutonia_Intro", FSTATE_INLEVELNOWIPE);
			// change to the map which was set in NewGameIntro()
			if ( Level.MapTime >= 1 )
			{
				Level.ChangeLevel(newGame, 0, CHANGELEVEL_RESETINVENTORY|CHANGELEVEL_RESETHEALTH|CHANGELEVEL_NOINTERMISSION);
				CVar.FindCVar("wf_newgame").ResetToDefault();
			}
		}
		// play master levels rejects stories at the start of each mini-campaign
		if ( mapName.Left(21) == "wf_masterlevels_story" )
		{
			let mapSuffix = mapName.Mid(21, 1);
			if ( mapSuffix == "1" )
			{
				Level.StartIntermission("MasterLevels_Intro1", FSTATE_INLEVELNOWIPE);
				CVar.FindCVar("wf_newgame").SetString("ml_map29");
			}
			else if ( mapSuffix == "2" )
			{
				Level.StartIntermission("MasterLevels_Intro2", FSTATE_INLEVELNOWIPE);
				CVar.FindCVar("wf_newgame").SetString("ml_map33");
			}
			else if ( mapSuffix == "3" )
			{
				Level.StartIntermission("MasterLevels_Intro3", FSTATE_INLEVELNOWIPE);
				CVar.FindCVar("wf_newgame").SetString("ml_map34");
			}
			else if ( mapSuffix == "4" )
			{
				Level.StartIntermission("MasterLevels_Intro4", FSTATE_INLEVELNOWIPE);
				CVar.FindCVar("wf_newgame").SetString("ml_map19");
			}
			if ( Level.MapTime >= 1 && newGame != "ml_map34" )
			{
				Level.ChangeLevel(newGame, 0, CHANGELEVEL_RESETINVENTORY|CHANGELEVEL_RESETHEALTH|CHANGELEVEL_NOINTERMISSION);
				CVar.FindCVar("wf_newgame").ResetToDefault();
			}
			else if ( Level.MapTime >= 1 && newGame == "ml_map34" )
			{
				Level.ChangeLevel(newGame, 0, CHANGELEVEL_NOINTERMISSION);
				CVar.FindCVar("wf_newgame").ResetToDefault();
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
		string newGame = CVar.FindCVar("wf_newgame").GetString();
		string mapName = Level.MapName.MakeLower();
		if ( mapName.Left(10) == "wf_newgame" && mapName != "wf_newgame_story" )
			Level.ChangeLevel(newGame, 0, CHANGELEVEL_RESETINVENTORY|CHANGELEVEL_RESETHEALTH|CHANGELEVEL_NOINTERMISSION);
		CVar.FindCVar("wf_newgame").ResetToDefault();
	}
	
	ui void NewGameChangeLevelInput()
	{
		string newGame = CVar.FindCVar("wf_newgame").GetString();
		string mapName = Level.MapName.MakeLower();
		if ( CVar.FindCVar("wf_intros").GetInt() >= 2 )
		{
			if ( mapName != "wf_newgame_story" && mapName != "wf_newgame_ml" && mapName != "wf_newgame_ud" && mapName != "wf_newgame" )
				Level.ChangeLevel("wf_newgame_story", 0, CHANGELEVEL_RESETINVENTORY|CHANGELEVEL_RESETHEALTH|CHANGELEVEL_NOINTERMISSION);
			else if ( mapName != "wf_newgame_story" )
				Level.ChangeLevel(newGame, 0, CHANGELEVEL_RESETINVENTORY|CHANGELEVEL_RESETHEALTH|CHANGELEVEL_NOINTERMISSION);
		}
		else
			Level.ChangeLevel(newGame, 0, CHANGELEVEL_RESETINVENTORY|CHANGELEVEL_RESETHEALTH|CHANGELEVEL_NOINTERMISSION);
	}
}
