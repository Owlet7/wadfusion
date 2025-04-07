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
	override void PostUiTick()
	{
		if ( CVar.FindCVar("wf_compat_changemusic").GetBool() )
		{
			DoSigilMusicReplacements(); // wf_music_sigil.zs
			DoIdkfaMusicReplacements(); // wf_music_idkfa.zs
		}
	}
	
	override void ConsoleProcess(ConsoleEvent e)
	{
		// reset all custom cvars to their defaults
		if ( e.Name == "wf_reset2defaults" )
		{
			WadFusionReset2Defaults();
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
			DoSigilIntroMusicReplacements(); // wf_music_sigil.zs
			DoIdkfaTitleMusicReplacements(); // wf_music_idkfa.zs
			
			if ( music == titleMusic[i] )
				return;
			else if ( i == titleMusic.Size() - 1 )
				S_ChangeMusic(music);
		}
	}
	
	ui void WadFusionReset2Defaults()
	{
		CVar.FindCVar("wf_mus_sigilmp3").ResetToDefault();
		CVar.FindCVar("wf_mus_sigil2mp3").ResetToDefault();
		CVar.FindCVar("wf_mus_idkfa").ResetToDefault();
		CVar.FindCVar("wf_map_e1m8b").ResetToDefault();
		CVar.FindCVar("wf_map_e1m4b").ResetToDefault();
		CVar.FindCVar("wf_id24trans").ResetToDefault();
		
		CVar.FindCVar("wf_compat_id24_weapons").ResetToDefault();
		CVar.FindCVar("wf_compat_sigil2spiderboss").ResetToDefault();
		CVar.FindCVar("wf_compat_xboxsecretexits").ResetToDefault();
		CVar.FindCVar("wf_compat_mapfixes").ResetToDefault();
		CVar.FindCVar("wf_compat_killcountfix").ResetToDefault();
		CVar.FindCVar("wf_compat_nextmap").ResetToDefault();
		CVar.FindCVar("wf_compat_changemusic").ResetToDefault();
		
		CVar.FindCVar("wf_compat_texswap_d1").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_fd").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_id1").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_ml").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_d2sky").ResetToDefault();
		
		CVar.FindCVar("wf_compat_texswap_all").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_d1_00").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_d1_01").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_d1_02").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_d1_03").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_d1_04").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_d1_05").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_d1_06").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_d1_07").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_d1_08").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_d1_09").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_d1_10").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_d1_11").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_d1_12").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_d1_13").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_d1_14").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_d1_15").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_tn_00").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_tn_01").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_tn_02").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_tn_03").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_tn_04").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_tn_05").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_tn_06").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_tn_07").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_tn_08").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_tn_09").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_tn_10").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_tn_11").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_tn_12").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_pl_00").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_pl_01").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_pl_02").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_pl_03").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_pl_04").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_pl_05").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_pl_06").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_pl_07").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_pl_08").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_id1_00").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_id1_01").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_id1_02").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_id1_03").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_id1_04").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_id1_05").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_id1_06").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_id1_07").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_id1_08").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_id1_09").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_id1_10").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_id1_11").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_id1_12").ResetToDefault();
		CVar.FindCVar("wf_compat_texswap_all_id1_13").ResetToDefault();
		
		CVar.FindCVar("wf_hud_id24").ResetToDefault();
		CVar.FindCVar("wf_hud_swaphealtharmor").ResetToDefault();
		CVar.FindCVar("wf_hud_ultrawide").ResetToDefault();
		CVar.FindCVar("wf_hud_ultrawide_fullscreen").ResetToDefault();
		
		CVar.FindCVar("wf_hud_alt").ResetToDefault();
		CVar.FindCVar("wf_hud_alt_mugshot").ResetToDefault();
		CVar.FindCVar("wf_hud_alt_health").ResetToDefault();
		CVar.FindCVar("wf_hud_alt_armor").ResetToDefault();
		CVar.FindCVar("wf_hud_alt_ammo").ResetToDefault();
		CVar.FindCVar("wf_hud_alt_ammoinv").ResetToDefault();
		CVar.FindCVar("wf_hud_alt_powerup").ResetToDefault();
		CVar.FindCVar("wf_hud_alt_weapinv").ResetToDefault();
		CVar.FindCVar("wf_hud_alt_keys").ResetToDefault();
		CVar.FindCVar("wf_hud_alt_frags").ResetToDefault();
		CVar.FindCVar("wf_hud_alt_stats_icons").ResetToDefault();
		CVar.FindCVar("wf_hud_alt_stats_kills").ResetToDefault();
		CVar.FindCVar("wf_hud_alt_stats_items").ResetToDefault();
		CVar.FindCVar("wf_hud_alt_stats_secrets").ResetToDefault();
		CVar.FindCVar("wf_hud_alt_stats_time").ResetToDefault();
		CVar.FindCVar("wf_hud_alt_stats_totaltime").ResetToDefault();
		CVar.FindCVar("wf_hud_alt_stats_timemillis").ResetToDefault();
		CVar.FindCVar("wf_hud_alt_stats_mapname").ResetToDefault();
		CVar.FindCVar("wf_hud_alt_stats_maplabel").ResetToDefault();
		CVar.FindCVar("wf_hud_alt_alpha_health").ResetToDefault();
		CVar.FindCVar("wf_hud_alt_alpha_ammo").ResetToDefault();
		CVar.FindCVar("wf_hud_alt_alpha_powerup").ResetToDefault();
		CVar.FindCVar("wf_hud_alt_alpha_ammoinv").ResetToDefault();
		CVar.FindCVar("wf_hud_alt_alpha_weapinv").ResetToDefault();
		CVar.FindCVar("wf_hud_alt_alpha_weapinvinactive").ResetToDefault();
		CVar.FindCVar("wf_hud_alt_alpha_keys").ResetToDefault();
		CVar.FindCVar("wf_hud_alt_alpha_frags").ResetToDefault();
		CVar.FindCVar("wf_hud_alt_alpha_stats").ResetToDefault();
		CVar.FindCVar("wf_hud_alt_alpha_stats_time").ResetToDefault();
		CVar.FindCVar("wf_hud_alt_alpha_stats_mapname").ResetToDefault();
	}
}
