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

extend class WadFusionHandler
{
	// Sigil's map music should be left undefined in MAPINFO,
	// that way the music playback gets initiated by the script,
	// without potentially playing the wrong music for one tick
	void PlaySigilMusic()
	{
		string mapName = Level.MapName.MakeLower();
		string mapMusic = "d_"..mapName;
		string mapMusicShreds = mapMusic.."a";
		
		if ( mapName.Left(3) == "e5m" )
		{
			if ( CVar.FindCVar("wf_mus_sigilmp3").GetBool() )
			{
				S_ChangeMusic( mapMusicShreds );
			}
			else
			{
				S_ChangeMusic( mapMusic );
			}
		}
		
		if ( mapName.Left(3) == "e6m" )
		{
			if ( CVar.FindCVar("wf_mus_sigil2mp3").GetBool() )
			{
				S_ChangeMusic( mapMusicShreds );
			}
			else
			{
				S_ChangeMusic( mapMusic );
			}
		}
	}
	
	// do the same for intermission music
	void PlaySigilInterMusic()
	{
		string mapName = Level.MapName.MakeLower();
		
		if ( mapName.Left(3) == "e5m" )
		{
			if ( CVar.FindCVar("wf_mus_sigilmp3").GetBool() )
				S_ChangeMusic("s_intera");
			else
				S_ChangeMusic("s_inter");
		}
		
		if ( mapName.Left(3) == "e6m" )
		{
			if ( CVar.FindCVar("wf_mus_sigil2mp3").GetBool() )
				S_ChangeMusic("s2_intea");
			else
				S_ChangeMusic("s2_inter");
		}
	}
}

extend class WadFusionStaticHandler
{
	// change Sigil's title music to mp3/midi if the option is changed, without looping
	ui void DoSigilTitleMusicReplacements()
	{
		string music = MusPlaying.Name.MakeLower();
		
		if ( CVar.FindCVar("wf_mus_sigilmp3").GetBool() )
		{
			if ( music == "s_intro" )
				S_ChangeMusic("s_introa", 0, false);
		}
		else
		{
			if ( music == "s_introa" )
				S_ChangeMusic("s_intro", 0, false);
		}
		
		if ( CVar.FindCVar("wf_mus_sigil2mp3").GetBool() )
		{
			if ( music == "s2_intro" )
				S_ChangeMusic("s2_intra", 0, false);
		}
		else
		{
			if ( music == "s2_intra" )
				S_ChangeMusic("s2_intro", 0, false);
		}
	}
	
	ui void DoSigilMusicReplacements()
	{
		string music = MusPlaying.Name.MakeLower();
		
		// play the Sigil mp3 soundtrack if the option is enabled mid-game
		if ( CVar.FindCVar("wf_mus_sigilmp3").GetBool() )
		{
			if ( music == "d_e5m1" )
				music = "d_e5m1a";
			
			if ( music == "d_e5m2" )
				music = "d_e5m2a";
			
			if ( music == "d_e5m3" )
				music = "d_e5m3a";
			
			if ( music == "d_e5m4" )
				music = "d_e5m4a";
			
			if ( music == "d_e5m5" )
				music = "d_e5m5a";
			
			if ( music == "d_e5m6" )
				music = "d_e5m6a";
			
			if ( music == "d_e5m7" )
				music = "d_e5m7a";
			
			if ( music == "d_e5m8" )
				music = "d_e5m8a";
			
			if ( music == "d_e5m9" )
				music = "d_e5m9a";
			
		//	if ( music == "s_intro" )
		//		music = "s_introa";
			
			if ( music == "s_inter" )
				music = "s_intera";
		}
		// play the Sigil midi soundtrack if the option is disabled mid-game
		else
		{
			if ( music == "d_e5m1a" )
				music = "d_e5m1";
			
			if ( music == "d_e5m2a" )
				music = "d_e5m2";
			
			if ( music == "d_e5m3a" )
				music = "d_e5m3";
			
			if ( music == "d_e5m4a" )
				music = "d_e5m4";
			
			if ( music == "d_e5m5a" )
				music = "d_e5m5";
			
			if ( music == "d_e5m6a" )
				music = "d_e5m6";
			
			if ( music == "d_e5m7a" )
				music = "d_e5m7";
			
			if ( music == "d_e5m8a" )
				music = "d_e5m8";
			
			if ( music == "d_e5m9a" )
				music = "d_e5m9";
			
		//	if ( music == "s_introa" )
		//		music = "s_intro";
			
			if ( music == "s_intera" )
				music = "s_inter";
		}
		
		// play the Sigil2 mp3 soundtrack if the option is enabled mid-game
		if ( CVar.FindCVar("wf_mus_sigil2mp3").GetBool() )
		{
			if ( music == "d_e6m1" )
				music = "d_e6m1a";
			
			if ( music == "d_e6m2" )
				music = "d_e6m2a";
			
			if ( music == "d_e6m3" )
				music = "d_e6m3a";
			
			if ( music == "d_e6m4" )
				music = "d_e6m4a";
			
			if ( music == "d_e6m5" )
				music = "d_e6m5a";
			
			if ( music == "d_e6m6" )
				music = "d_e6m6a";
			
			if ( music == "d_e6m7" )
				music = "d_e6m7a";
			
			if ( music == "d_e6m8" )
				music = "d_e6m8a";
			
			if ( music == "d_e6m9" )
				music = "d_e6m9a";
			
		//	if ( music == "s2_intro" )
		//		music = "s2_intra";
			
			if ( music == "s2_inter" )
				music = "s2_intea";
		}
		// play the Sigil2 midi soundtrack if the option is disabled mid-game
		else
		{
			if ( music == "d_e6m1a" )
				music = "d_e6m1";
			
			if ( music == "d_e6m2a" )
				music = "d_e6m2";
			
			if ( music == "d_e6m3a" )
				music = "d_e6m3";
			
			if ( music == "d_e6m4a" )
				music = "d_e6m4";
			
			if ( music == "d_e6m5a" )
				music = "d_e6m5";
			
			if ( music == "d_e6m6a" )
				music = "d_e6m6";
			
			if ( music == "d_e6m7a" )
				music = "d_e6m7";
			
			if ( music == "d_e6m8a" )
				music = "d_e6m8";
			
			if ( music == "d_e6m9a" )
				music = "d_e6m9";
			
		//	if ( music == "s2_intra" )
		//		music = "s2_intro";
			
			if ( music == "s2_intea" )
				music = "s2_inter";
		}
			
		DoChangeMusic(music);
	}
}
