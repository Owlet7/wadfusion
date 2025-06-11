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

extend class WadFusionStaticHandler
{
	void FullRun()
	{
		int fullRun = CVar.FindCVar("wf_fullrun").GetInt();
		int fullRunCast = CVar.FindCVar("wf_fullrun_cast").GetBool();
		let rejects = CVar.FindCVar("wf_map_mlr").GetBool();
		let titlePic = CVar.FindCVar("wf_compat_titlepics").GetBool();
		string mapName = Level.MapName.MakeLower();
		
		// set which intermission to play at the end of an episode
		if ( fullRun >= 1 && fullRun <= 3 )
		{
			if ( mapName == "e1m8" )
				intermission = "Doom1_Ep1_Fusion_FullRun";
			if ( mapName == "e2m8" )
				intermission = "Doom1_Ep2_Fusion_FullRun";
			if ( mapName == "e3m8" )
				intermission = "Inter_Bunny_Fusion_FullRun";
			if ( mapName == "e4m8" )
				intermission = "Doom1_Ep4_Fusion_FullRun";
			if ( mapName == "e5m8" )
				intermission = "Doom1_Ep5_Fusion_FullRun";
			if ( mapName == "e6m8" )
				intermission = "Doom1_Ep6_Fusion_FullRun";
			if ( mapName == "map30" )
			{
				if ( fullRunCast )
					intermission = "Inter_Cast_Fusion_FullRun";
				else
					intermission = "Doom2_End_Fusion_FullRun_NoCast";
			}
			if ( ( mapName == "ml_map20" && !rejects ) || mapName == "ml_map43" )
			{
				if ( fullRunCast )
					intermission = "MasterLevels_End_Fusion_FullRun";
				else
					intermission = "MasterLevels_End_Fusion_FullRun_NoCast";
			}
			if ( mapName == "nv_map08" )
			{
				if ( fullRunCast )
					intermission = "Inter_Cast_Fusion_FullRun_NoCredits";
				else
					intermission = "Doom2_End_Fusion_FullRun_NoCast_NoCredits";
			}
			if ( mapName == "lr_map07" )
				intermission = "Id1_Ep1_Fusion_FullRun";
			if ( mapName == "lr_map14" )
			{
				if ( fullRunCast )
					intermission = "Id1Cast_Fusion_FullRun";
				else
					intermission = "Id1_End_Fusion_FullRun_NoCast";
			}
			if ( mapName == "tn_map30" )
			{
				if ( fullRunCast )
					intermission = "Inter_Cast_Tnt_Fusion_FullRun";
				else
					intermission = "Tnt_End_Fusion_FullRun_NoCast";
			}
			if ( mapName == "pl_map30" )
			{
				if ( fullRunCast )
					intermission = "Inter_Cast_Plutonia_Fusion_FullRun";
				else
					intermission = "Plutonia_End_Fusion_FullRun_NoCast";
			}
		}
		// play a vanilla or vanilla-eque intermission if fullrun is off
		// these are needed to support switching it off mid-game
		else
		{
			if ( mapName == "e1m8" )
				intermission = "Doom1_Ep1_Fusion_FullRun_Off";
			if ( mapName == "e2m8" )
				intermission = "Doom1_Ep2_Fusion_FullRun_Off";
			if ( mapName == "e3m8" )
				intermission = "Inter_Bunny_Fusion_FullRun_Off";
			if ( mapName == "e4m8" )
				intermission = "Doom1_Ep4_Fusion_FullRun_Off";
			if ( mapName == "e5m8" )
				intermission = "Doom1_Ep5_Fusion_FullRun_Off";
			if ( mapName == "e6m8" )
				intermission = "Doom1_Ep6_Fusion_FullRun_Off";
			if ( mapName == "map30" )
				intermission = "Inter_Cast";
			if ( ( mapName == "ml_map20" && !rejects ) || mapName == "ml_map43" )
				// also needed for xaser order
				intermission = "MasterLevels_End_Fusion";
			if ( mapName == "nv_map08" )
				intermission = "Inter_Cast";
			if ( mapName == "lr_map07" )
				intermission = "Id1_Ep1_Fusion_FullRun_Off";
			if ( mapName == "lr_map14" )
				intermission = "Id1Cast";
			if ( mapName == "tn_map30" )
				intermission = "Inter_Cast_Tnt";
			if ( mapName == "pl_map30" )
				intermission = "Inter_Cast_Plutonia";
		}
		
		// set which map to switch to at the end of a full run episode
		if ( fullRun == 1 )
		{
			if ( mapName == "e1m8" )
				nextMap = "e2m1";
			if ( mapName == "e2m8" )
				nextMap = "e3m1";
			if ( mapName == "e3m8" )
			{
				if ( Wads.CheckNumForFullName("maps/e4m1.wad") != -1 )
					nextMap = "wf_newgame_e4m1";
				else if ( Wads.CheckNumForFullName("maps/e5m1.wad") != -1 )
					nextMap = "wf_newgame_e5m1";
				else if ( Wads.CheckNumForFullName("maps/e6m1.wad") != -1 )
					nextMap = "wf_newgame_e6m1";
				else if ( Wads.CheckNumForFullName("maps/map01.wad") != -1 )
					nextMap = "wf_newgame_map01";
				else if ( Wads.CheckNumForFullName("maps/ml_map01.wad") != -1 )
					nextMap = "wf_newgame_ml_map01";
				else if ( Wads.CheckNumForFullName("maps/nv_map01.wad") != -1 )
					nextMap = "wf_newgame_nv_map01";
				else if ( Wads.CheckNumForFullName("maps/lr_map01.wad") != -1 )
					nextMap = "wf_newgame_lr_map01";
				else if ( Wads.CheckNumForFullName("maps/tn_map01.wad") != -1 )
					nextMap = "wf_newgame_tn_map01";
				else if ( Wads.CheckNumForFullName("maps/pl_map01.wad") != -1 )
					nextMap = "wf_newgame_pl_map01";
				else
					fullRunEnd = true;
			}
			if ( mapName == "e4m8" )
			{
				if ( Wads.CheckNumForFullName("maps/e5m1.wad") != -1 )
					nextMap = "wf_newgame_e5m1";
				else if ( Wads.CheckNumForFullName("maps/e6m1.wad") != -1 )
					nextMap = "wf_newgame_e6m1";
				else if ( Wads.CheckNumForFullName("maps/map01.wad") != -1 )
					nextMap = "wf_newgame_map01";
				else if ( Wads.CheckNumForFullName("maps/ml_map01.wad") != -1 )
					nextMap = "wf_newgame_ml_map01";
				else if ( Wads.CheckNumForFullName("maps/nv_map01.wad") != -1 )
					nextMap = "wf_newgame_nv_map01";
				else if ( Wads.CheckNumForFullName("maps/lr_map01.wad") != -1 )
					nextMap = "wf_newgame_lr_map01";
				else if ( Wads.CheckNumForFullName("maps/tn_map01.wad") != -1 )
					nextMap = "wf_newgame_tn_map01";
				else if ( Wads.CheckNumForFullName("maps/pl_map01.wad") != -1 )
					nextMap = "wf_newgame_pl_map01";
				else
					fullRunEnd = true;
			}
			if ( mapName == "e5m8" )
			{
				if ( Wads.CheckNumForFullName("maps/e6m1.wad") != -1 )
					nextMap = "wf_newgame_e6m1";
				else if ( Wads.CheckNumForFullName("maps/map01.wad") != -1 )
					nextMap = "wf_newgame_map01";
				else if ( Wads.CheckNumForFullName("maps/ml_map01.wad") != -1 )
					nextMap = "wf_newgame_ml_map01";
				else if ( Wads.CheckNumForFullName("maps/nv_map01.wad") != -1 )
					nextMap = "wf_newgame_nv_map01";
				else if ( Wads.CheckNumForFullName("maps/lr_map01.wad") != -1 )
					nextMap = "wf_newgame_lr_map01";
				else if ( Wads.CheckNumForFullName("maps/tn_map01.wad") != -1 )
					nextMap = "wf_newgame_tn_map01";
				else if ( Wads.CheckNumForFullName("maps/pl_map01.wad") != -1 )
					nextMap = "wf_newgame_pl_map01";
				else
					fullRunEnd = true;
			}
			if ( mapName == "e6m8" )
			{
				if ( Wads.CheckNumForFullName("maps/map01.wad") != -1 )
					nextMap = "wf_newgame_map01";
				else if ( Wads.CheckNumForFullName("maps/ml_map01.wad") != -1 )
					nextMap = "wf_newgame_ml_map01";
				else if ( Wads.CheckNumForFullName("maps/nv_map01.wad") != -1 )
					nextMap = "wf_newgame_nv_map01";
				else if ( Wads.CheckNumForFullName("maps/lr_map01.wad") != -1 )
					nextMap = "wf_newgame_lr_map01";
				else if ( Wads.CheckNumForFullName("maps/tn_map01.wad") != -1 )
					nextMap = "wf_newgame_tn_map01";
				else if ( Wads.CheckNumForFullName("maps/pl_map01.wad") != -1 )
					nextMap = "wf_newgame_pl_map01";
				else
					fullRunEnd = true;
			}
			if ( mapName == "map30" )
			{
				if ( Wads.CheckNumForFullName("maps/ml_map01.wad") != -1 )
					nextMap = "wf_newgame_ml_map01";
				else if ( Wads.CheckNumForFullName("maps/nv_map01.wad") != -1 )
					nextMap = "wf_newgame_nv_map01";
				else if ( Wads.CheckNumForFullName("maps/lr_map01.wad") != -1 )
					nextMap = "wf_newgame_lr_map01";
				else if ( Wads.CheckNumForFullName("maps/tn_map01.wad") != -1 )
					nextMap = "wf_newgame_tn_map01";
				else if ( Wads.CheckNumForFullName("maps/pl_map01.wad") != -1 )
					nextMap = "wf_newgame_pl_map01";
				else
					fullRunEnd = true;
			}
			if ( ( mapName == "ml_map20" && !rejects ) || mapName == "ml_map43" )
			{
				if ( Wads.CheckNumForFullName("maps/nv_map01.wad") != -1 )
					nextMap = "wf_newgame_nv_map01";
				else if ( Wads.CheckNumForFullName("maps/lr_map01.wad") != -1 )
					nextMap = "wf_newgame_lr_map01";
				else if ( Wads.CheckNumForFullName("maps/tn_map01.wad") != -1 )
					nextMap = "wf_newgame_tn_map01";
				else if ( Wads.CheckNumForFullName("maps/pl_map01.wad") != -1 )
					nextMap = "wf_newgame_pl_map01";
				else
					fullRunEnd = true;
			}
			if ( mapName == "nv_map08" )
			{
				if ( Wads.CheckNumForFullName("maps/lr_map01.wad") != -1 )
					nextMap = "wf_newgame_lr_map01";
				else if ( Wads.CheckNumForFullName("maps/tn_map01.wad") != -1 )
					nextMap = "wf_newgame_tn_map01";
				else if ( Wads.CheckNumForFullName("maps/pl_map01.wad") != -1 )
					nextMap = "wf_newgame_pl_map01";
				else
					fullRunEnd = true;
			}
			if ( mapName == "lr_map07" )
			{
				nextMap = "lr_map08";
			}
			if ( mapName == "lr_map14" )
			{
				if ( Wads.CheckNumForFullName("maps/tn_map01.wad") != -1 )
					nextMap = "wf_newgame_tn_map01";
				else if ( Wads.CheckNumForFullName("maps/pl_map01.wad") != -1 )
					nextMap = "wf_newgame_pl_map01";
				else
					fullRunEnd = true;
			}
			if ( mapName == "tn_map30" )
			{
				if ( Wads.CheckNumForFullName("maps/pl_map01.wad") != -1 )
					nextMap = "wf_newgame_pl_map01";
				else
					fullRunEnd = true;
			}
			if ( mapName == "pl_map30" )
				fullRunEnd = true;
		}
		if ( fullRun == 2 )
		{
			if ( mapName == "e1m8" )
				nextMap = "e2m1";
			if ( mapName == "e2m8" )
				nextMap = "e3m1";
			if ( mapName == "e3m8" )
				if ( Wads.CheckNumForFullName("maps/map01.wad") != -1 )
					nextMap = "wf_newgame_map01";
				else if ( Wads.CheckNumForFullName("maps/e4m1.wad") != -1 )
					nextMap = "wf_newgame_e4m1";
				else if ( Wads.CheckNumForFullName("maps/ml_map01.wad") != -1 )
					nextMap = "wf_newgame_ml_map01";
				else if ( Wads.CheckNumForFullName("maps/tn_map01.wad") != -1 )
					nextMap = "wf_newgame_tn_map01";
				else if ( Wads.CheckNumForFullName("maps/pl_map01.wad") != -1 )
					nextMap = "wf_newgame_pl_map01";
				else if ( Wads.CheckNumForFullName("maps/nv_map01.wad") != -1 )
					nextMap = "wf_newgame_nv_map01";
				else if ( Wads.CheckNumForFullName("maps/e5m1.wad") != -1 )
					nextMap = "wf_newgame_e5m1";
				else if ( Wads.CheckNumForFullName("maps/e6m1.wad") != -1 )
					nextMap = "wf_newgame_e6m1";
				else if ( Wads.CheckNumForFullName("maps/lr_map01.wad") != -1 )
					nextMap = "wf_newgame_lr_map01";
				else
					fullRunEnd = true;
			if ( mapName == "map30" )
				if ( Wads.CheckNumForFullName("maps/e4m1.wad") != -1 )
					nextMap = "wf_newgame_e4m1";
				else if ( Wads.CheckNumForFullName("maps/ml_map01.wad") != -1 )
					nextMap = "wf_newgame_ml_map01";
				else if ( Wads.CheckNumForFullName("maps/tn_map01.wad") != -1 )
					nextMap = "wf_newgame_tn_map01";
				else if ( Wads.CheckNumForFullName("maps/pl_map01.wad") != -1 )
					nextMap = "wf_newgame_pl_map01";
				else if ( Wads.CheckNumForFullName("maps/nv_map01.wad") != -1 )
					nextMap = "wf_newgame_nv_map01";
				else if ( Wads.CheckNumForFullName("maps/e5m1.wad") != -1 )
					nextMap = "wf_newgame_e5m1";
				else if ( Wads.CheckNumForFullName("maps/e6m1.wad") != -1 )
					nextMap = "wf_newgame_e6m1";
				else if ( Wads.CheckNumForFullName("maps/lr_map01.wad") != -1 )
					nextMap = "wf_newgame_lr_map01";
				else
					fullRunEnd = true;
			if ( mapName == "e4m8" )
				if ( Wads.CheckNumForFullName("maps/ml_map01.wad") != -1 )
					nextMap = "wf_newgame_ml_map01";
				else if ( Wads.CheckNumForFullName("maps/tn_map01.wad") != -1 )
					nextMap = "wf_newgame_tn_map01";
				else if ( Wads.CheckNumForFullName("maps/pl_map01.wad") != -1 )
					nextMap = "wf_newgame_pl_map01";
				else if ( Wads.CheckNumForFullName("maps/nv_map01.wad") != -1 )
					nextMap = "wf_newgame_nv_map01";
				else if ( Wads.CheckNumForFullName("maps/e5m1.wad") != -1 )
					nextMap = "wf_newgame_e5m1";
				else if ( Wads.CheckNumForFullName("maps/e6m1.wad") != -1 )
					nextMap = "wf_newgame_e6m1";
				else if ( Wads.CheckNumForFullName("maps/lr_map01.wad") != -1 )
					nextMap = "wf_newgame_lr_map01";
				else
					fullRunEnd = true;
			if ( ( mapName == "ml_map20" && !rejects ) || mapName == "ml_map43" )
				if ( Wads.CheckNumForFullName("maps/tn_map01.wad") != -1 )
					nextMap = "wf_newgame_tn_map01";
				else if ( Wads.CheckNumForFullName("maps/pl_map01.wad") != -1 )
					nextMap = "wf_newgame_pl_map01";
				else if ( Wads.CheckNumForFullName("maps/nv_map01.wad") != -1 )
					nextMap = "wf_newgame_nv_map01";
				else if ( Wads.CheckNumForFullName("maps/e5m1.wad") != -1 )
					nextMap = "wf_newgame_e5m1";
				else if ( Wads.CheckNumForFullName("maps/e6m1.wad") != -1 )
					nextMap = "wf_newgame_e6m1";
				else if ( Wads.CheckNumForFullName("maps/lr_map01.wad") != -1 )
					nextMap = "wf_newgame_lr_map01";
				else
					fullRunEnd = true;
			if ( mapName == "tn_map30" )
				if ( Wads.CheckNumForFullName("maps/pl_map01.wad") != -1 )
					nextMap = "wf_newgame_pl_map01";
				else if ( Wads.CheckNumForFullName("maps/nv_map01.wad") != -1 )
					nextMap = "wf_newgame_nv_map01";
				else if ( Wads.CheckNumForFullName("maps/e5m1.wad") != -1 )
					nextMap = "wf_newgame_e5m1";
				else if ( Wads.CheckNumForFullName("maps/e6m1.wad") != -1 )
					nextMap = "wf_newgame_e6m1";
				else if ( Wads.CheckNumForFullName("maps/lr_map01.wad") != -1 )
					nextMap = "wf_newgame_lr_map01";
				else
					fullRunEnd = true;
			if ( mapName == "pl_map30" )
				if ( Wads.CheckNumForFullName("maps/nv_map01.wad") != -1 )
					nextMap = "wf_newgame_nv_map01";
				else if ( Wads.CheckNumForFullName("maps/e5m1.wad") != -1 )
					nextMap = "wf_newgame_e5m1";
				else if ( Wads.CheckNumForFullName("maps/e6m1.wad") != -1 )
					nextMap = "wf_newgame_e6m1";
				else if ( Wads.CheckNumForFullName("maps/lr_map01.wad") != -1 )
					nextMap = "wf_newgame_lr_map01";
				else
					fullRunEnd = true;
			if ( mapName == "nv_map08" )
				if ( Wads.CheckNumForFullName("maps/e5m1.wad") != -1 )
					nextMap = "wf_newgame_e5m1";
				else if ( Wads.CheckNumForFullName("maps/e6m1.wad") != -1 )
					nextMap = "wf_newgame_e6m1";
				else if ( Wads.CheckNumForFullName("maps/lr_map01.wad") != -1 )
					nextMap = "wf_newgame_lr_map01";
				else
					fullRunEnd = true;
			if ( mapName == "e5m8" )
				if ( Wads.CheckNumForFullName("maps/e6m1.wad") != -1 )
					nextMap = "wf_newgame_e6m1";
				else if ( Wads.CheckNumForFullName("maps/lr_map01.wad") != -1 )
					nextMap = "wf_newgame_lr_map01";
				else
					fullRunEnd = true;
			if ( mapName == "e6m8" )
				if ( Wads.CheckNumForFullName("maps/lr_map01.wad") != -1 )
					nextMap = "wf_newgame_lr_map01";
				else
					fullRunEnd = true;
			if ( mapName == "lr_map07" )
				nextMap = "lr_map08";
			if ( mapName == "lr_map14" )
				fullRunEnd = true;
		}
		if ( fullRun == 3 )
		{
			if ( mapName == "e1m8" )
				nextMap = "e2m1";
			if ( mapName == "e2m8" )
				nextMap = "e3m1";
			if ( mapName == "e3m8" )
				if ( Wads.CheckNumForFullName("maps/e4m1.wad") != -1 )
					nextMap = "wf_newgame_e4m1";
				else if ( Wads.CheckNumForFullName("maps/e5m1.wad") != -1 )
					nextMap = "wf_newgame_e5m1";
				else if ( Wads.CheckNumForFullName("maps/e6m1.wad") != -1 )
					nextMap = "wf_newgame_e6m1";
				else if ( Wads.CheckNumForFullName("maps/map01.wad") != -1 )
					nextMap = "wf_newgame_map01";
				else if ( Wads.CheckNumForFullName("maps/nv_map01.wad") != -1 )
					nextMap = "wf_newgame_nv_map01";
				else if ( Wads.CheckNumForFullName("maps/ml_map01.wad") != -1 )
					nextMap = "wf_newgame_ml_map01";
				else if ( Wads.CheckNumForFullName("maps/tn_map01.wad") != -1 )
					nextMap = "wf_newgame_tn_map01";
				else if ( Wads.CheckNumForFullName("maps/pl_map01.wad") != -1 )
					nextMap = "wf_newgame_pl_map01";
				else if ( Wads.CheckNumForFullName("maps/lr_map01.wad") != -1 )
					nextMap = "wf_newgame_lr_map01";
				else
					fullRunEnd = true;
			if ( mapName == "e4m8" )
				if ( Wads.CheckNumForFullName("maps/e5m1.wad") != -1 )
					nextMap = "wf_newgame_e5m1";
				else if ( Wads.CheckNumForFullName("maps/e6m1.wad") != -1 )
					nextMap = "wf_newgame_e6m1";
				else if ( Wads.CheckNumForFullName("maps/map01.wad") != -1 )
					nextMap = "wf_newgame_map01";
				else if ( Wads.CheckNumForFullName("maps/nv_map01.wad") != -1 )
					nextMap = "wf_newgame_nv_map01";
				else if ( Wads.CheckNumForFullName("maps/ml_map01.wad") != -1 )
					nextMap = "wf_newgame_ml_map01";
				else if ( Wads.CheckNumForFullName("maps/tn_map01.wad") != -1 )
					nextMap = "wf_newgame_tn_map01";
				else if ( Wads.CheckNumForFullName("maps/pl_map01.wad") != -1 )
					nextMap = "wf_newgame_pl_map01";
				else if ( Wads.CheckNumForFullName("maps/lr_map01.wad") != -1 )
					nextMap = "wf_newgame_lr_map01";
				else
					fullRunEnd = true;
			if ( mapName == "e5m8" )
				if ( Wads.CheckNumForFullName("maps/e6m1.wad") != -1 )
					nextMap = "wf_newgame_e6m1";
				else if ( Wads.CheckNumForFullName("maps/map01.wad") != -1 )
					nextMap = "wf_newgame_map01";
				else if ( Wads.CheckNumForFullName("maps/nv_map01.wad") != -1 )
					nextMap = "wf_newgame_nv_map01";
				else if ( Wads.CheckNumForFullName("maps/ml_map01.wad") != -1 )
					nextMap = "wf_newgame_ml_map01";
				else if ( Wads.CheckNumForFullName("maps/tn_map01.wad") != -1 )
					nextMap = "wf_newgame_tn_map01";
				else if ( Wads.CheckNumForFullName("maps/pl_map01.wad") != -1 )
					nextMap = "wf_newgame_pl_map01";
				else if ( Wads.CheckNumForFullName("maps/lr_map01.wad") != -1 )
					nextMap = "wf_newgame_lr_map01";
				else
					fullRunEnd = true;
			if ( mapName == "e6m8" )
				if ( Wads.CheckNumForFullName("maps/map01.wad") != -1 )
					nextMap = "wf_newgame_map01";
				else if ( Wads.CheckNumForFullName("maps/nv_map01.wad") != -1 )
					nextMap = "wf_newgame_nv_map01";
				else if ( Wads.CheckNumForFullName("maps/ml_map01.wad") != -1 )
					nextMap = "wf_newgame_ml_map01";
				else if ( Wads.CheckNumForFullName("maps/tn_map01.wad") != -1 )
					nextMap = "wf_newgame_tn_map01";
				else if ( Wads.CheckNumForFullName("maps/pl_map01.wad") != -1 )
					nextMap = "wf_newgame_pl_map01";
				else if ( Wads.CheckNumForFullName("maps/lr_map01.wad") != -1 )
					nextMap = "wf_newgame_lr_map01";
				else
					fullRunEnd = true;
			if ( mapName == "map30" )
				if ( Wads.CheckNumForFullName("maps/nv_map01.wad") != -1 )
					nextMap = "wf_newgame_nv_map01";
				else if ( Wads.CheckNumForFullName("maps/ml_map01.wad") != -1 )
					nextMap = "wf_newgame_ml_map01";
				else if ( Wads.CheckNumForFullName("maps/tn_map01.wad") != -1 )
					nextMap = "wf_newgame_tn_map01";
				else if ( Wads.CheckNumForFullName("maps/pl_map01.wad") != -1 )
					nextMap = "wf_newgame_pl_map01";
				else if ( Wads.CheckNumForFullName("maps/lr_map01.wad") != -1 )
					nextMap = "wf_newgame_lr_map01";
				else
					fullRunEnd = true;
			if ( mapName == "nv_map08" )
				if ( Wads.CheckNumForFullName("maps/ml_map01.wad") != -1 )
					nextMap = "wf_newgame_ml_map01";
				else if ( Wads.CheckNumForFullName("maps/tn_map01.wad") != -1 )
					nextMap = "wf_newgame_tn_map01";
				else if ( Wads.CheckNumForFullName("maps/pl_map01.wad") != -1 )
					nextMap = "wf_newgame_pl_map01";
				else if ( Wads.CheckNumForFullName("maps/lr_map01.wad") != -1 )
					nextMap = "wf_newgame_lr_map01";
				else
					fullRunEnd = true;
			if ( ( mapName == "ml_map20" && !rejects ) || mapName == "ml_map43" )
				if ( Wads.CheckNumForFullName("maps/tn_map01.wad") != -1 )
					nextMap = "wf_newgame_tn_map01";
				else if ( Wads.CheckNumForFullName("maps/pl_map01.wad") != -1 )
					nextMap = "wf_newgame_pl_map01";
				else if ( Wads.CheckNumForFullName("maps/lr_map01.wad") != -1 )
					nextMap = "wf_newgame_lr_map01";
				else
					fullRunEnd = true;
			if ( mapName == "tn_map30" )
				if ( Wads.CheckNumForFullName("maps/pl_map01.wad") != -1 )
					nextMap = "wf_newgame_pl_map01";
				else if ( Wads.CheckNumForFullName("maps/lr_map01.wad") != -1 )
					nextMap = "wf_newgame_lr_map01";
				else
					fullRunEnd = true;
			if ( mapName == "pl_map30" )
				if ( Wads.CheckNumForFullName("maps/lr_map01.wad") != -1 )
					nextMap = "wf_newgame_lr_map01";
				else
					fullRunEnd = true;
			if ( mapName == "lr_map07" )
				nextMap = "lr_map08";
			if ( mapName == "lr_map14" )
				fullRunEnd = true;
		}
	}
	
	void FullRunStory()
	{
		int fullRun = CVar.FindCVar("wf_fullrun").GetInt();
		let rejects = CVar.FindCVar("wf_map_mlr").GetBool();
		let titlePic = CVar.FindCVar("wf_compat_titlepics").GetBool();
		string mapName = Level.MapName.MakeLower();
		
		if ( mapName == "e1m8" )
		{
			Level.NextMap = "wf_story";
		}
		if ( mapName == "e2m8" )
		{
			Level.NextMap = "wf_story";
		}
		if ( mapName == "e3m8" )
		{
			Level.NextMap = "wf_story";
		}
		if ( mapName == "e4m8" )
		{
			Level.NextMap = "wf_story";
		}
		if ( mapName == "e5m8" )
		{
			Level.NextMap = "wf_story";
		}
		if ( mapName == "e6m8" )
		{
			Level.NextMap = "wf_story";
		}
		if ( mapName == "map30" )
		{
			Level.NextMap = "wf_story";
		}
		if ( ( mapName == "ml_map20" && !rejects ) || mapName == "ml_map43" )
		{
			// also needed for xaser order
			Level.NextMap = "wf_story";
		}
		if ( mapName == "nv_map08" )
		{
			Level.NextMap = "wf_story";
		}
		if ( mapName == "lr_map07" )
		{
			Level.NextMap = "wf_story";
		}
		if ( mapName == "lr_map14" )
		{
			Level.NextMap = "wf_story";
		}
		if ( mapName == "tn_map30" )
		{
			Level.NextMap = "wf_story";
		}
		if ( mapName == "pl_map30" )
		{
			Level.NextMap = "wf_story";
		}
	}
}
