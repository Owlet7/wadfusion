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
	ui void DoTitleMusicReplacements()
	{
		// get map name and currently playing music
		int musSwap = CVar.FindCVar("wf_compat_musswap").GetInt();
		string mapName = Level.MapName.MakeLower();
		string music = MusPlaying.Name.MakeLower();
		
		// change title music to tnt's or plutonia's, without looping
		if ( CVar.FindCVar("wf_compat_musswap_00").GetBool() )
		{
			if ( music == "d_dm2ttl" || music == "h_dm2ttl" )
			{
				if ( musSwap == 1 )
					S_ChangeMusic("t_dm2ttl", 0, false);
				if ( musSwap == 2 )
				{
					if ( music != "h_dm2ttl" )
						S_ChangeMusic("p_dm2ttl", 0, false);
				}
			}
		}
	}
	
	ui void DoMusicReplacements()
	{
		// get map name and currently playing music
		int musSwap = CVar.FindCVar("wf_compat_musswap").GetInt();
		string mapName = Level.MapName.MakeLower();
		string music = MusPlaying.Name.MakeLower();
		
		// change music to tnt's or plutonia's
		if ( CVar.FindCVar("wf_compat_musswap_01").GetBool() && mapName == "map01" )
		{
			if ( music == "d_runnin" || music == "h_runnin" )
			{
				if ( musSwap == 1 )
					music = "t_runnin";
				if ( musSwap == 2 )
				{
					if ( music == "h_runnin" )
						music = "h_e1m2";
					else
						music = "p_runnin";
				}
			}
		}
		
		if ( CVar.FindCVar("wf_compat_musswap_02").GetBool() && mapName == "map02" )
		{
			if ( music == "d_stalks" || music == "h_stalks" )
			{
				if ( musSwap == 1 )
					music = "t_stalks";
				if ( musSwap == 2 )
				{
					if ( music == "h_stalks" )
						music = "h_e1m3";
					else
						music = "p_stalks";
				}
			}
		}
		
		if ( CVar.FindCVar("wf_compat_musswap_03").GetBool() && mapName == "map03" )
		{
			if ( music == "d_countd" || music == "h_countd" )
			{
				if ( musSwap == 1 )
				{
					if ( music == "h_countd" )
						music = "h_messag";
					else
						music = "t_countd";
				}
				if ( musSwap == 2 )
				{
					if ( music == "h_countd" )
						music = "h_e1m6";
					else
						music = "p_countd";
				}
			}
		}
		
		if ( CVar.FindCVar("wf_compat_musswap_04").GetBool() && mapName == "map04" )
		{
			if ( music == "d_betwee" || music == "h_betwee" )
			{
				if ( musSwap == 1 )
					music = "t_betwee";
				if ( musSwap == 2 )
				{
					if ( music == "h_betwee" )
						music = "h_e1m4";
					else
						music = "p_betwee";
				}
			}
		}
		
		if ( CVar.FindCVar("wf_compat_musswap_05").GetBool() && mapName == "map05" )
		{
			if ( music == "d_doom" || music == "h_doom" )
			{
				if ( musSwap == 1 )
					music = "t_doom";
				if ( musSwap == 2 )
				{
					if ( music == "h_doom" )
						music = "h_e1m9";
					else
						music = "p_doom";
				}
			}
		}
		
		if ( CVar.FindCVar("wf_compat_musswap_06").GetBool() && mapName == "map06" )
		{
			if ( music == "d_the_da" || music == "h_the_da" )
			{
				if ( musSwap == 1 )
					music = "t_the_da";
				if ( musSwap == 2 )
				{
					if ( music == "h_the_da" )
						music = "h_e1m8";
					else
						music = "p_the_da";
				}
			}
		}
		
		if ( CVar.FindCVar("wf_compat_musswap_07").GetBool() && mapName == "map07" )
		{
			if ( music == "d_shawn" || music == "h_shawn" )
			{
				if ( musSwap == 1 )
					music = "t_shawn";
				if ( musSwap == 2 )
				{
					if ( music == "h_shawn" )
						music = "h_e2m1";
					else
						music = "p_shawn";
				}
			}
		}
		
		if ( CVar.FindCVar("wf_compat_musswap_08").GetBool() && mapName == "map08" )
		{
			if ( music == "d_ddtblu" || music == "h_ddtblu" )
			{
				if ( musSwap == 1 )
					music = "t_ddtblu";
				if ( musSwap == 2 )
				{
					if ( music == "h_ddtblu" )
						music = "h_e2m2";
					else
						music = "p_ddtblu";
				}
			}
		}
		
		if ( CVar.FindCVar("wf_compat_musswap_09").GetBool() && mapName == "map09" )
		{
			if ( music == "d_in_cit" || music == "h_in_cit" )
			{
				if ( musSwap == 1 )
					music = "t_in_cit";
				if ( musSwap == 2 )
				{
					if ( music == "h_in_cit" )
						music = "h_e3m3";
					else
						music = "p_in_cit";
				}
			}
		}
		
		if ( CVar.FindCVar("wf_compat_musswap_10").GetBool() && mapName == "map10" )
		{
			if ( music == "d_dead" || music == "h_dead" )
			{
				if ( musSwap == 1 )
					music = "t_dead";
				if ( musSwap == 2 )
				{
					if ( music == "h_dead" )
						music = "h_e1m7";
					else
						music = "p_dead";
				}
			}
		}
		
		if ( CVar.FindCVar("wf_compat_musswap_11").GetBool() && mapName == "map11" )
		{
			if ( music == "d_stlks2" || music == "h_stalks" )
			{
				if ( musSwap == 1 )
					music = "t_stlks2";
				if ( musSwap == 2 )
				{
					if ( music == "h_stalks" )
						music = "h_bunny";
					else
						music = "p_stlks2";
				}
			}
		}
		
		if ( CVar.FindCVar("wf_compat_musswap_12").GetBool() && mapName == "map12" )
		{
			if ( music == "d_theda2" || music == "h_the_da" )
			{
				if ( musSwap == 1 )
				{
					if ( music == "h_the_da" )
						music = "h_ddtblu";
					else
						music = "t_theda2";
				}
				if ( musSwap == 2 )
				{
					if ( music == "h_the_da" )
						music = "h_e3m8";
					else
						music = "p_theda2";
				}
			}
		}
		
		if ( CVar.FindCVar("wf_compat_musswap_13").GetBool() && mapName == "map13" )
		{
			if ( music == "d_doom2" || music == "h_doom" )
			{
				if ( musSwap == 1 )
					music = "t_doom2";
				if ( musSwap == 2 )
				{
					if ( music == "h_doom" )
						music = "h_e3m2";
					else
						music = "p_doom2";
				}
			}
		}
		
		if ( CVar.FindCVar("wf_compat_musswap_14").GetBool() && mapName == "map14" )
		{
			if ( music == "d_ddtbl2" || music == "h_ddtblu" )
			{
				if ( musSwap == 1 )
					music = "t_ddtbl2";
				if ( musSwap == 2 )
				{
					if ( music == "h_ddtblu" )
						music = "h_e2m8";
					else
						music = "p_ddtbl2";
				}
			}
		}
		
		if ( CVar.FindCVar("wf_compat_musswap_15").GetBool() && mapName == "map15" )
		{
			if ( music == "d_runni2" || music == "h_runnin" )
			{
				if ( musSwap == 1 )
					music = "t_runni2";
				if ( musSwap == 2 )
				{
					if ( music == "h_runnin" )
						music = "h_e2m7";
					else
						music = "p_runni2";
				}
			}
		}
		
		if ( CVar.FindCVar("wf_compat_musswap_16").GetBool() && mapName == "map16" )
		{
			if ( music == "d_dead2" || music == "h_dead" )
			{
				if ( musSwap == 1 )
					music = "t_dead2";
				if ( musSwap == 2 )
				{
					if ( music == "h_dead" )
						music = "h_e2m9";
					else
						music = "p_dead2";
				}
			}
		}
		
		if ( CVar.FindCVar("wf_compat_musswap_17").GetBool() && mapName == "map17" )
		{
			if ( music == "d_stlks3" || music == "h_stalks" )
			{
				if ( musSwap == 1 )
					music = "t_stlks3";
				if ( musSwap == 2 )
				{
					if ( music == "h_stalks" )
						music = "h_e1m1";
					else
						music = "p_stlks3";
				}
			}
		}
		
		if ( CVar.FindCVar("wf_compat_musswap_18").GetBool() && mapName == "map18" )
		{
			if ( music == "d_romero" || music == "h_romero" )
			{
				if ( musSwap == 1 )
					music = "t_romero";
				if ( musSwap == 2 )
				{
					if ( music == "h_romero" )
						music = "h_e1m7";
					else
						music = "p_romero";
				}
			}
		}
		
		if ( CVar.FindCVar("wf_compat_musswap_19").GetBool() && mapName == "map19" )
		{
			if ( music == "d_shawn2" || music == "h_shawn" )
			{
				if ( musSwap == 1 )
				{
					if ( music == "h_shawn" )
						music = "h_countd";
					else
						music = "t_shawn2";
				}
				if ( musSwap == 2 )
				{
					if ( music == "h_shawn" )
						music = "h_e1m5";
					else
						music = "p_shawn2";
				}
			}
		}
		
		if ( CVar.FindCVar("wf_compat_musswap_20").GetBool() && mapName == "map20" )
		{
			if ( music == "d_messag" || music == "h_messag" )
			{
				if ( musSwap == 1 )
					music = "t_messag";
				if ( musSwap == 2 )
				{
					if ( music != "h_messag" )
						music = "p_messag";
				}
			}
		}
		
		if ( CVar.FindCVar("wf_compat_musswap_21").GetBool() && mapName == "map21" )
		{
			if ( music == "d_count2" || music == "h_countd" )
			{
				if ( musSwap == 1 )
				{
					if ( music == "h_countd" )
						music = "h_in_cit";
					else
						music = "t_count2";
				}
				if ( musSwap == 2 )
				{
					if ( music == "h_countd" )
						music = "h_read_m";
					else
						music = "p_count2";
				}
			}
		}
		
		if ( CVar.FindCVar("wf_compat_musswap_22").GetBool() && mapName == "map22" )
		{
			if ( music == "d_ddtbl3" || music == "h_ddtblu" )
			{
				if ( musSwap == 1 )
					music = "t_ddtbl3";
				if ( musSwap == 2 )
				{
					if ( music != "h_ddtblu" )
						music = "p_ddtbl3";
				}
			}
		}
		
		if ( CVar.FindCVar("wf_compat_musswap_23").GetBool() && mapName == "map23" )
		{
			if ( music == "d_ampie" || music == "h_ampie" )
			{
				if ( musSwap == 1 )
				{
					if ( music != "h_ampie" )
						music = "t_ampie";
				}
				if ( musSwap == 2 )
				{
					if ( music != "h_ampie" )
						music = "p_ampie";
				}
			}
		}
		
		if ( CVar.FindCVar("wf_compat_musswap_24").GetBool() && mapName == "map24" )
		{
			if ( music == "d_theda3" || music == "h_the_da" )
			{
				if ( musSwap == 1 )
				{
					if ( music == "h_the_da" )
						music = "h_betwee";
					else
						music = "t_theda3";
				}
				if ( musSwap == 2 )
				{
					if ( music != "h_the_da" )
						music = "p_theda3";
				}
			}
		}
		
		if ( CVar.FindCVar("wf_compat_musswap_25").GetBool() && mapName == "map25" )
		{
			if ( music == "d_adrian" || music == "h_adrian" )
			{
				if ( musSwap == 1 )
				{
					if ( music == "h_adrian" )
						music = "h_doom";
					else
						music = "t_adrian";
				}
				if ( musSwap == 2 )
				{
					if ( music != "h_adrian" )
						music = "p_adrian";
				}
			}
		}
		
		if ( CVar.FindCVar("wf_compat_musswap_26").GetBool() && mapName == "map26" )
		{
			if ( music == "d_messg2" || music == "h_messag" )
			{
				if ( musSwap == 1 )
					music = "t_messg2";
				if ( musSwap == 2 )
				{
					if ( music != "h_messag" )
						music = "p_messg2";
				}
			}
		}
		
		if ( CVar.FindCVar("wf_compat_musswap_27").GetBool() && mapName == "map27" )
		{
			if ( music == "d_romer2" || music == "h_romero" )
			{
				if ( musSwap == 1 )
					music = "t_romer2";
				if ( musSwap == 2 )
				{
					if ( music == "h_romero" )
						music = "h_e2m1";
					else
						music = "p_romer2";
				}
			}
		}
		
		if ( CVar.FindCVar("wf_compat_musswap_28").GetBool() && mapName == "map28" )
		{
			if ( music == "d_tense" || music == "h_tense" )
			{
				if ( musSwap == 1 )
					music = "t_tense";
				if ( musSwap == 2 )
				{
					if ( music == "h_tense" )
						music = "h_e2m2";
					else
						music = "p_tense";
				}
			}
		}
		
		if ( CVar.FindCVar("wf_compat_musswap_29").GetBool() && mapName == "map29" )
		{
			if ( music == "d_shawn3" || music == "h_shawn" )
			{
				if ( musSwap == 1 )
					music = "t_shawn3";
				if ( musSwap == 2 )
				{
					if ( music == "h_shawn" )
						music = "h_e1m1";
					else
						music = "p_shawn3";
				}
			}
		}
		
		if ( CVar.FindCVar("wf_compat_musswap_30").GetBool() && mapName == "map30" )
		{
			if ( music == "d_openin" || music == "h_openin" )
			{
				if ( musSwap == 1 )
					music = "t_openin";
				if ( musSwap == 2 )
				{
					if ( music == "h_openin" )
						music = "h_victor";
					else
						music = "p_openin";
				}
			}
		}
		
		if ( CVar.FindCVar("wf_compat_musswap_31").GetBool() && mapName == "map31" )
		{
			if ( music == "d_evil" || music == "h_evil" )
			{
				if ( musSwap == 1 )
					music = "t_evil";
				if ( musSwap == 2 )
				{
					if ( music == "h_evil" )
						music = "h_e1m8";
					else
						music = "p_evil";
				}
			}
		}
		
		if ( CVar.FindCVar("wf_compat_musswap_32").GetBool() && mapName == "map32" )
		{
			if ( music == "d_ultima" || music == "h_ultima" )
			{
				if ( musSwap == 1 )
				{
					if ( music == "h_ultima" )
						music = "h_in_cit";
					else
						music = "t_ultima";
				}
				if ( musSwap == 2 )
				{
					if ( music == "h_ultima" )
						music = "h_e2m8";
					else
						music = "p_ultima";
				}
			}
		}
		
		if ( CVar.FindCVar("wf_compat_musswap_33").GetBool() )
		{
			if ( music == "d_read_m" || music == "h_read_m" )
			{
				if ( musSwap == 1 )
					music = "t_read_m";
				if ( musSwap == 2 )
				{
					if ( music != "h_read_m" && mapName != "map21" )
						music = "p_read_m";
				}
			}
		}
		
		if ( CVar.FindCVar("wf_compat_musswap_34").GetBool() )
		{
			if ( music == "d_dm2int" || music == "h_dm2int" )
			{
				if ( musSwap == 1 )
					music = "t_dm2int";
				if ( musSwap == 2 )
				{
					if ( music != "h_dm2int" )
						music = "p_dm2int";
				}
			}
		}
		
		DoChangeMusic(music);
	}
}
