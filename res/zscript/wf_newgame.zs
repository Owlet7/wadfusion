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
	ui void NewGameTitlePic()
	{
		string mapName = Level.MapName.MakeLower();
		if ( mapName.Left(10) == "wf_newgame" || mapName.Left(8) == "wf_story" )
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
			
			// draw a black overlay over the entire screen
			// hides the HUD under the titlepic overlay that gets drawn next
			int resX = Screen.GetWidth();
			int resY = Screen.GetHeight();
			Screen.DrawTexture(titlePic, false, 0, 0, DTA_ScaleX, resX, DTA_ScaleY, resY, DTA_FillColor, 0);
			
			if ( mapName.Left(10) == "wf_newgame" )
			{
				if ( CVar.FindCVar("wf_compat_titlepics").GetBool() )
				{
					if ( nextMap == "e1m1" || nextMap == "e2m1" || nextMap == "e3m1" )
						Screen.DrawTexture(titleD1, false, 0, 0, DTA_FullScreen, 1);
					else if ( nextMap == "e4m1" )
						Screen.DrawTexture(titleUD, false, 0, 0, DTA_FullScreen, 1);
					else if ( nextMap == "e5m1" )
						Screen.DrawTexture(titleS1, false, 0, 0, DTA_FullScreen, 1);
					else if ( nextMap == "e6m1" )
						Screen.DrawTexture(titleS2, false, 0, 0, DTA_FullScreen, 1);
					else if ( nextMap == "map01" )
						Screen.DrawTexture(titleD2, false, 0, 0, DTA_FullScreen, 1);
					else if ( nextMap == "ml_map01" )
						Screen.DrawTexture(titleML, false, 0, 0, DTA_FullScreen, 1);
					else if ( nextMap == "nv_map01" )
						Screen.DrawTexture(titleNV, false, 0, 0, DTA_FullScreen, 1);
					else if ( nextMap == "lr_map01" || nextMap == "lr_map08" )
						Screen.DrawTexture(titleLR, false, 0, 0, DTA_FullScreen, 1);
					else if ( nextMap == "tn_map01" )
						Screen.DrawTexture(titleTN, false, 0, 0, DTA_FullScreen, 1);
					else if ( nextMap == "pl_map01" )
						Screen.DrawTexture(titlePL, false, 0, 0, DTA_FullScreen, 1);
					else
						Screen.DrawTexture(titlePic, false, 0, 0, DTA_FullScreen, 1);
				}
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
				if ( !fullRunNewGame )
					Level.StartIntermission("WadFusionNewGame", FSTATE_INLEVELNOWIPE);
				
				if ( mapName != "wf_newgame" )
					nextMap = mapName.Mid(11);
				
				if ( CVar.FindCVar("wf_compat_titlepics").GetBool() )
				{
					// play title music for each game
					if ( nextMap == "e1m1" || nextMap == "e2m1" || nextMap == "e3m1" || nextMap == "e4m1" )
						S_ChangeMusic("d_intro", 0, false);
					else if ( nextMap == "e5m1" )
						PlaySigilIntroMusic();
					else if ( nextMap == "e6m1" )
						PlaySigil2IntroMusic();
					else if ( nextMap == "map01" || nextMap == "ml_map01" || nextMap == "nv_map01" )
						S_ChangeMusic("d_dm2ttl", 0, false);
					else if ( nextMap == "lr_map01" || nextMap == "lr_map08" )
						S_ChangeMusic("x_dm2ttl", 0, false);
					else if ( nextMap == "tn_map01" )
						S_ChangeMusic("t_dm2ttl", 0, false);
					else if ( nextMap == "pl_map01" )
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
		string mapName = Level.MapName.MakeLower();
		if ( mapName.Left(10) == "wf_newgame" )
			Level.ChangeLevel(nextMap, 0, CHANGELEVEL_RESETINVENTORY|CHANGELEVEL_RESETHEALTH|CHANGELEVEL_NOINTERMISSION);
	}
	
	void NewGameChangeLevelInput()
	{
		if ( CVar.FindCVar("wf_intros").GetBool() )
		{
			if ( nextMap != "e2m1" && nextMap != "e3m1" && nextMap != "e4m1" && nextMap != "ml_map01" && nextMap != "lr_map08" )
				Level.ChangeLevel("wf_story", 0, CHANGELEVEL_RESETINVENTORY|CHANGELEVEL_RESETHEALTH|CHANGELEVEL_NOINTERMISSION);
			else
				Level.ChangeLevel(nextMap, 0, CHANGELEVEL_RESETINVENTORY|CHANGELEVEL_RESETHEALTH|CHANGELEVEL_NOINTERMISSION);
		}
		else
			Level.ChangeLevel(nextMap, 0, CHANGELEVEL_RESETINVENTORY|CHANGELEVEL_RESETHEALTH|CHANGELEVEL_NOINTERMISSION);
	}
}
