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

extend class WadFusionStaticHandler
{
	ui void DoIdkfaTitleMusicReplacements()
	{
		let music = MusPlaying.Name.MakeLower();
		// change title music to Andrew Hulshult's soundtrack if true, without looping
		if ( CVar.FindCVar("wf_mus_idkfa").GetBool() )
		{
			if ( music == "d_intro" || music == "d_introa" )
				S_ChangeMusic("h_intro", 0, false);
			else if ( music == "p_dm2ttl" )
				S_ChangeMusic("h_dm2ttl", 0, false);
			else if ( music == "d_dm2ttl" )
				S_ChangeMusic("h_dm2ttl", 0, false);
		}
		else
		{
			if ( music == "h_intro" )
				S_ChangeMusic("d_intro", 0, false);
			else if ( music == "h_dm2ttl" )
			{
				// TODO: replace with different logic when intros are added
				if ( Level.MapName.MakeLower().Left(3) == "pl_" )
					S_ChangeMusic("p_dm2ttl", 0, false);
				else
					S_ChangeMusic("d_dm2ttl", 0, false);
			}
		}
	}
	
	ui void DoIdkfaMusicReplacements()
	{
		// get map name and currently playing music
		string mapName = Level.MapName.MakeLower();
		string music = MusPlaying.Name.MakeLower();
		
		// change music to Andrew Hulshult's soundtrack if true
		if ( CVar.FindCVar("wf_mus_idkfa").GetBool() )
		{
			// Doom 1
			
			if ( music == "d_e1m1" )
				music = "h_e1m1";
			
			if ( music == "d_e1m2" )
				music = "h_e1m2";
			
			if ( music == "d_e1m3" )
				music = "h_e1m3";
			
			if ( music == "d_e1m4" )
				music = "h_e1m4";
			
			if ( music == "d_e1m5" )
				music = "h_e1m5";
			
			if ( music == "d_e1m6" || music == "d_e3m6" )
				music = "h_e1m6";
			
			if ( music == "d_e1m7" || music == "d_e2m5" || music == "d_e3m5" )
				music = "h_e1m7";
			
			if ( music == "d_e1m8" || music == "d_e3m4" )
				music = "h_e1m8";
			
			if ( music == "d_e1m9" || music == "d_e3m9" )
				music = "h_e1m9";
			
			if ( music == "d_e2m1" )
				music = "h_e2m1";
			
			if ( music == "d_e2m2" )
				music = "h_e2m2";
			
			if ( music == "d_e2m3" || music == "d_inter" )
				music = "h_e2m3";
			
			if ( music == "d_e2m4" )
				music = "h_e2m4";
			
			if ( music == "d_e2m6" )
				music = "h_e2m6";
			
			if ( music == "d_e2m7" || music == "d_e3m7" )
				music = "h_e2m7";
			
			if ( music == "d_e2m8" )
				music = "h_e2m8";
			
			if ( music == "d_e2m9" || music == "d_e3m1" )
				music = "h_e2m9";
			
			if ( music == "d_e3m2" )
				music = "h_e3m2";
			
			if ( music == "d_e3m3" )
				music = "h_e3m3";
			
			if ( music == "d_e3m8" )
				music = "h_e3m8";
			
		//	if ( music == "d_intro" || music == "d_introa" )
		//		music = "h_intro";
			
			if ( music == "d_victor" )
				music = "h_victor";
			
			if ( music == "d_bunny" )
				music = "h_bunny";
			
			// Doom 2
			
			if ( music == "d_adrian" )
				music = "h_adrian";
			
			if ( music == "d_ampie" )
				music = "h_ampie";
			
			if ( music == "d_betwee" )
				music = "h_betwee";
			
			if ( music == "d_countd" || music == "d_count2" )
				music = "h_countd";
			
			if ( music == "d_ddtblu" || music == "d_ddtbl2" || music == "d_ddtbl3" )
				music = "h_ddtblu";
			
			if ( music == "d_dead" || music == "d_dead2" )
				music = "h_dead";
			
			if ( music == "d_doom" || music == "d_doom2" )
				music = "h_doom";
			
			if ( music == "d_evil" )
				music = "h_evil";
			
			if ( music == "d_in_cit" )
				music = "h_in_cit";
			
			if ( music == "d_messag" || music == "d_messg2" )
				music = "h_messag";
			
			if ( music == "d_openin" )
				music = "h_openin";
			
			if ( music == "d_romero" || music == "d_romer2" )
				music = "h_romero";
			
			if ( music == "d_runnin" || music == "d_runni2" )
				music = "h_runnin";
			
			if ( music == "d_shawn" || music == "d_shawn2" || music == "d_shawn3" )
				music = "h_shawn";
			
			if ( music == "d_stalks" || music == "d_stlks2" || music == "d_stlks3" )
				music = "h_stalks";
			
			if ( music == "d_tense" )
				music = "h_tense";
			
			if ( music == "d_the_da" || music == "d_theda2" || music == "d_theda3" )
				music = "h_the_da";
			
			if ( music == "d_ultima" )
				music = "h_ultima";
			
		//	if ( music == "d_dm2ttl" )
		//		music = "h_dm2ttl";
			
			if ( music == "d_dm2int" )
				music = "h_dm2int";
			
			if ( music == "d_read_m" )
				music = "h_read_m";
			
			// Plutonia
			
			if ( music == "p_runnin" )
				music = "h_e1m2";
			
			if ( music == "p_stalks" )
				music = "h_e1m3";
			
			if ( music == "p_countd" )
				music = "h_e1m6";
			
			if ( music == "p_betwee" )
				music = "h_e1m4";
			
			if ( music == "p_doom" )
				music = "h_e1m9";
			
			if ( music == "p_the_da" || music == "p_evil" )
				music = "h_e1m8";
			
			if ( music == "p_shawn" || music == "p_romer2" )
				music = "h_e2m1";
			
			if ( music == "p_ddtblu" || music == "p_tense" )
				music = "h_e2m2";
			
			if ( music == "p_in_cit" )
				music = "h_e3m3";
			
			if ( music == "p_dead" || music == "p_romero" )
				music = "h_e1m7";
			
			if ( music == "p_stlks2" )
				music = "h_bunny";
			
			if ( music == "p_theda2" )
				music = "h_e3m8";
			
			if ( music == "p_doom2" )
				music = "h_e3m2";
			
			if ( music == "p_ddtbl2" || music == "p_ultima" )
				music = "h_e2m8";
			
			if ( music == "p_runni2" )
				music = "h_e2m7";
			
			if ( music == "p_dead2" )
				music = "h_e3m1";
			
			if ( music == "p_stlks3" || music == "p_shawn3" )
				music = "h_e1m1";
			
			if ( music == "p_shawn2" )
				music = "h_e1m5";
			
			if ( music == "p_messag" || music == "p_messg2" )
				music = "h_messag";
			
			if ( music == "p_count2" || music == "p_read_m" )
				music = "h_read_m";
			
			if ( music == "p_ddtbl3" )
				music = "h_ddtblu";
			
			if ( music == "p_ampie" )
				music = "h_ampie";
			
			if ( music == "p_theda3" )
				music = "h_the_da";
			
			if ( music == "p_adrian" )
				music = "h_adrian";
			
			if ( music == "p_openin" )
				music = "h_victor";
			
		//	if ( music == "p_dm2ttl" )
		//		music = "h_dm2ttl";
			
			if ( music == "p_dm2int" )
				music = "h_dm2int";
			
			// TNT Evilution
			
			if ( music == "t_countd" )
				music = "h_messag";
			
			if ( music == "t_theda2" )
				music = "h_ddtblu";
			
			if ( music == "t_shawn2" )
				music = "h_countd";
			
			if ( music == "t_count2" )
				music = "h_in_cit";
			
			if ( music == "t_ampie" )
				music = "h_ampie";
			
			if ( music == "t_theda3" )
				music = "h_betwee";
			
			if ( music == "t_adrian" )
				music = "h_doom";
			
			if ( music == "t_ultima" )
				music = "h_in_cit";
		}
		// change back to playing the original midi music when turning off Andrew Hulshult's soundtrack
		else
		{
			// check if on a Plutonia map, which are meant to play music with a "p_" prefix
			if ( mapName.Left(3) == "pl_" )
			{
				if ( music == "h_e1m2" )
					music = "p_runnin";
				
				if ( music == "h_e1m3" )
					music = "p_stalks";
				
				if ( music == "h_e1m6" )
					music = "p_countd";
				
				if ( music == "h_e1m4" )
					music = "p_betwee";
				
				if ( music == "h_e1m9" )
					music = "p_doom";
				
				if ( music == "h_e1m8" )
				{
					if ( mapName == "pl_map06" )
						music = "p_the_da";
					else
						music = "p_evil";
				}
				
				if ( music == "h_e2m1" )
				{
					if ( mapName == "pl_map07" )
						music = "p_shawn";
					else
						music = "p_romer2";
				}
				
				if ( music == "h_e2m2" )
				{
					if ( mapName == "pl_map08" )
						music = "p_ddtblu";
					else
						music = "p_tense";
				}
				
				if ( music == "h_e3m3" )
					music = "p_in_cit";
				
				if ( music == "h_e1m7" )
				{
					if ( mapName == "pl_map10" )
						music = "p_dead";
					else
						music = "p_romero";
				}
				
				if ( music == "h_bunny" )
					music = "p_stlks2";
				
				if ( music == "h_e3m8" )
					music = "p_theda2";
				
				if ( music == "h_e3m2" )
					music = "p_doom2";
				
				if ( music == "h_e2m8" )
				{
					if ( mapName == "pl_map14" )
						music = "p_ddtbl2";
					else
						music = "p_ultima";
				}
				
				if ( music == "h_e2m7" )
					music = "p_runni2";
				
				if ( music == "h_e3m1" )
					music = "p_dead2";
				
				if ( music == "h_e1m1" )
				{
					if ( mapName == "pl_map17" )
						music = "p_stlks3";
					else
						music = "p_shawn3";
				}
				
				if ( music == "h_e1m5" )
					music = "p_shawn2";
				
				if ( music == "h_messag" )
				{
					if ( mapName == "pl_map20" )
						music = "p_messag";
					else
						music = "p_messg2";
				}
				
				if ( music == "h_read_m" )
				{
					if ( mapName == "pl_map21" )
						music = "p_count2";
					else
						music = "p_read_m";
				}
				
				if ( music == "h_ddtblu" )
					music = "p_ddtbl3";
				
				if ( music == "h_ampie" )
					music = "p_ampie";
				
				if ( music == "h_the_da" )
					music = "p_theda3";
				
				if ( music == "h_adrian" )
					music = "p_adrian";
				
				if ( music == "h_victor" )
					music = "p_openin";
				
			//	if ( music == "h_dm2ttl" )
			//		music = "p_dm2ttl";
				
				if ( music == "h_dm2int" )
					music = "p_dm2int";
			}
			// check if on a TNT Evilution map, which are meant to play music with a "t_" prefix
			else if ( mapName.Left(3) == "tn_" )
			{
				if ( music == "h_messag" )
					music = "t_countd";
				
				if ( music == "h_ddtblu" )
					music = "t_theda2";
				
				if ( music == "h_countd" )
					music = "t_shawn2";
				
				if ( music == "h_in_cit" )
				{
					if ( mapName == "tn_map32" )
						music = "t_ultima";
					else
						music = "t_count2";
				}
				
				if ( music == "h_ampie" )
					music = "t_ampie";
				
				if ( music == "h_betwee" )
					music = "t_theda3";
				
				if ( music == "h_doom" )
					music = "t_adrian";
			}
			else
			{
				// Doom 1
				
				if ( music == "h_e1m1" )
					music = "d_e1m1";
				
				if ( music == "h_e1m2" )
					music = "d_e1m2";
				
				if ( music == "h_e1m3" )
					music = "d_e1m3";
				
				if ( music == "h_e1m4" )
					music = "d_e1m4";
				
				if ( music == "h_e1m5" )
					music = "d_e1m5";
				
				if ( music == "h_e1m6" )
				{
					if ( mapName == "e3m6" )
						music = "d_e3m6";
					else
						music = "d_e1m6";
				}
				
				if ( music == "h_e1m7" )
				{
					if ( mapName == "e2m5" || mapName == "e4m8" )
						music = "d_e2m5";
					else if ( mapName == "e3m5" )
						music = "d_e3m5";
					else
						music = "d_e1m7";
				}
				
				if ( music == "h_e1m8" )
				{
					if ( mapName == "e3m4" || mapName == "e4m1" )
						music = "d_e3m4";
					else
						music = "d_e1m8";
				}
				
				if ( music == "h_e1m9" )
				{
					if ( mapName == "e3m9" )
						music = "d_e3m9";
					else
						music = "d_e1m9";
				}
				
				if ( music == "h_e2m1" )
					music = "d_e2m1";
				
				if ( music == "h_e2m2" )
					music = "d_e2m2";
				
				if ( music == "h_e2m3" )
				{
					if ( mapName == "e2m3" )
						music = "d_e2m3";
					else
						music = "d_inter";
				}
				
				if ( music == "h_e2m4" )
					music = "d_e2m4";
				
				if ( music == "h_e2m6" )
					music = "d_e2m6";
				
				if ( music == "h_e2m7" )
				{
					if ( mapName == "e3m7" )
						music = "d_e3m7";
					else
						music = "d_e2m7";
				}
				
				if ( music == "h_e2m8" )
					music = "d_e2m8";
				
				if ( music == "h_e2m9" )
				{
					if ( mapName == "e3m1" )
						music = "d_e3m1";
					else
						music = "d_e2m9";
				}
				
				if ( music == "h_e3m2" )
					music = "d_e3m2";
				
				if ( music == "h_e3m3" )
					music = "d_e3m3";
				
				if ( music == "h_e3m8" )
					music = "d_e3m8";
				
			//	if ( music == "h_intro" )
			//		music = "d_intro";
				
				if ( music == "h_victor" )
					music = "d_victor";
				
				if ( music == "h_bunny" )
					music = "d_bunny";
				
				// Doom 2
				
				if ( music == "h_adrian" )
					music = "d_adrian";
				
				if ( music == "h_ampie" )
					music = "d_ampie";
				
				if ( music == "h_betwee" )
					music = "d_betwee";
				
				if ( music == "h_countd" )
				{
					if ( mapName == "map21" )
						music = "d_count2";
					else
						music = "d_countd";
				}
				
				if ( music == "h_ddtblu" )
				{
					if ( mapName == "map22" )
						music = "d_ddtbl3";
					else if ( mapName == "map14" )
						music = "d_ddtbl2";
					else
						music = "d_ddtblu";
				}
				
				if ( music == "h_dead" )
				{
					if ( mapName == "map16" )
						music = "d_dead2";
					else
						music = "d_dead";
				}
				
				if ( music == "h_doom" )
				{
					if ( mapName == "map13" )
						music = "d_doom2";
					else
						music = "d_doom";
				}
				
				if ( music == "h_evil" )
					music = "d_evil";
				
				if ( music == "h_in_cit" )
					music = "d_in_cit";
				
				if ( music == "h_messag" )
				{
					if ( mapName == "map26" )
						music = "d_messg2";
					else
						music = "d_messag";
				}
				
				if ( music == "h_openin" )
					music = "d_openin";
				
				if ( music == "h_romero" )
				{
					if ( mapName == "map27" )
						music = "d_romer2";
					else
						music = "d_romero";
				}
				
				if ( music == "h_runnin" )
				{
					if ( mapName == "map15" )
						music = "d_runni2";
					else
						music = "d_runnin";
				}
				
				if ( music == "h_shawn" )
				{
					if ( mapName == "map29" )
						music = "d_shawn3";
					else if ( mapName == "map19" )
						music = "d_shawn2";
					else
						music = "d_shawn";
				}
				
				if ( music == "h_stalks" )
				{
					if ( mapName == "map17" )
						music = "d_stlks3";
					else if ( mapName == "map11" )
						music = "d_stlks2";
					else
						music = "d_stalks";
				}
				
				if ( music == "h_tense" )
					music = "d_tense";
				
				if ( music == "h_the_da" )
				{
					if ( mapName == "map24" )
						music = "d_theda3";
					else if ( mapName == "map12" )
						music = "d_theda2";
					else
						music = "d_the_da";
				}
				
				if ( music == "h_ultima" )
					music = "d_ultima";
				
			//	if ( music == "h_dm2ttl" )
			//		music = "d_dm2ttl";
				
				if ( music == "h_dm2int" )
					music = "d_dm2int";
				
				if ( music == "h_read_m" )
					music = "d_read_m";
			}
		}
		
		DoChangeMusic(music);
	}
}
