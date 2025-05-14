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
	
	// force texture replacement on all levels
	// this feature mostly exists for compatibility with doom 1 and final doom mods
	// these disable the regular texture replacements
	// each texture replacement can be toggled individually, in case a mod needs to replace some of them
	
	void DoTextureReplacementsAllDoom1()
	{
		if ( CVar.FindCVar("wf_compat_texswap_all_d1_00").GetBool() ) Level.ReplaceTextures("BIGDOOR7", "BIGDOR7A", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_d1_01").GetBool() ) Level.ReplaceTextures("BRNPOIS",  "BRNPOIS1", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_d1_02").GetBool() ) Level.ReplaceTextures("NUKEPOIS", "NUKPOIS1", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_d1_03").GetBool() ) Level.ReplaceTextures("SHAWN1",   "SHAWN1A",  TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_d1_04").GetBool() ) Level.ReplaceTextures("STEP1",    "STEP1A",   TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_d1_05").GetBool() ) Level.ReplaceTextures("STEP2",    "STEP2A",   TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_d1_06").GetBool() ) Level.ReplaceTextures("STEP3",    "STEP3A",   TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_d1_07").GetBool() ) Level.ReplaceTextures("STEP5",    "STEP5A",   TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_d1_08").GetBool() ) Level.ReplaceTextures("SW1BRN1",  "SW1BRN1A", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_d1_09").GetBool() ) Level.ReplaceTextures("SW1STARG", "SW1STARA", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_d1_10").GetBool() ) Level.ReplaceTextures("SW1STONE", "SW1STONA", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_d1_11").GetBool() ) Level.ReplaceTextures("SW1STON2", "SW1STONB", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_d1_12").GetBool() ) Level.ReplaceTextures("SW2BRN1",  "SW2BRN1A", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_d1_13").GetBool() ) Level.ReplaceTextures("SW2STARG", "SW2STARA", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_d1_14").GetBool() ) Level.ReplaceTextures("SW2STONE", "SW2STONA", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_d1_15").GetBool() ) Level.ReplaceTextures("SW2STON2", "SW2STONB", TexMan.NOT_FLAT);
		
		// override skies
		if ( CVar.FindCVar("wf_compat_texswap_all_d1_16").GetBool() )
		{
			Level.ReplaceTextures("SKY1", "DSKY1", TexMan.NOT_FLAT);
			if ( TexMan.GetName(Level.SkyTexture1) == "SKY1" )
				Level.ChangeSky(TexMan.CheckForTexture("DSKY1"), Level.SkyTexture2);
		}
		if ( CVar.FindCVar("wf_compat_texswap_all_d1_17").GetBool() )
		{
			Level.ReplaceTextures("SKY2", "DSKY2", TexMan.NOT_FLAT);
			if ( TexMan.GetName(Level.SkyTexture1) == "SKY2" )
				Level.ChangeSky(TexMan.CheckForTexture("DSKY2"), Level.SkyTexture2);
		}
		if ( CVar.FindCVar("wf_compat_texswap_all_d1_18").GetBool() )
		{
			Level.ReplaceTextures("SKY3", "DSKY3", TexMan.NOT_FLAT);
			if ( TexMan.GetName(Level.SkyTexture1) == "SKY3" )
				Level.ChangeSky(TexMan.CheckForTexture("DSKY3"), Level.SkyTexture2);
		}
	}
	
	void DoTextureReplacementsAllTnt()
	{
		if ( CVar.FindCVar("wf_compat_texswap_all_tn_00").GetBool() ) Level.ReplaceTextures("BLODGR1",  "BLODGRT1", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_tn_01").GetBool() ) Level.ReplaceTextures("BLODGR4",  "BLODGRT4", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_tn_05").GetBool() ) Level.ReplaceTextures("SLADRIP1", "SLADRPT1", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_tn_06").GetBool() ) Level.ReplaceTextures("SLADRIP3", "SLADRPT3", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_tn_07").GetBool() ) Level.ReplaceTextures("SW1GSTON", "SW1GSTNT", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_tn_08").GetBool() ) Level.ReplaceTextures("SW2GSTON", "SW2GSTNT", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_tn_09").GetBool() ) Level.ReplaceTextures("SW1SKULL", "SW1SKULT", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_tn_10").GetBool() ) Level.ReplaceTextures("SW2SKULL", "SW2SKULT", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_tn_11").GetBool() ) Level.ReplaceTextures("WFALL1",   "TWFALL1",  TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_tn_12").GetBool() ) Level.ReplaceTextures("WFALL4",   "TWFALL4",  TexMan.NOT_FLAT);
		
		// override skies
		if ( CVar.FindCVar("wf_compat_texswap_all_tn_02").GetBool() )
		{
			Level.ReplaceTextures("SKY1", "TSKY1", TexMan.NOT_FLAT);
			if ( TexMan.GetName(Level.SkyTexture1) == "SKY1" )
				Level.ChangeSky(TexMan.CheckForTexture("TSKY1"), Level.SkyTexture2);
		}
		if ( CVar.FindCVar("wf_compat_texswap_all_tn_03").GetBool() )
		{
			Level.ReplaceTextures("SKY2", "TSKY2", TexMan.NOT_FLAT);
			if ( TexMan.GetName(Level.SkyTexture1) == "SKY2" )
				Level.ChangeSky(TexMan.CheckForTexture("TSKY2"), Level.SkyTexture2);
		}
		if ( CVar.FindCVar("wf_compat_texswap_all_tn_04").GetBool() )
		{
			Level.ReplaceTextures("SKY3", "TSKY3", TexMan.NOT_FLAT);
			if ( TexMan.GetName(Level.SkyTexture1) == "SKY3" )
				Level.ChangeSky(TexMan.CheckForTexture("TSKY3"), Level.SkyTexture2);
		}
	}
	
	void DoTextureReplacementsAllPlutonia()
	{
		if ( CVar.FindCVar("wf_compat_texswap_all_pl_00").GetBool() ) Level.ReplaceTextures("DBRAIN1",  "PBRAIN1",  TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_pl_01").GetBool() ) Level.ReplaceTextures("DBRAIN4",  "PBRAIN4",  TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_pl_02").GetBool() ) Level.ReplaceTextures("FIREBLU1", "FIREPLU1", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_pl_03").GetBool() ) Level.ReplaceTextures("FIREBLU2", "FIREPLU2", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_pl_07").GetBool() ) Level.ReplaceTextures("SW1SKULL", "SW1SKULP", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_pl_08").GetBool() ) Level.ReplaceTextures("SW2SKULL", "SW2SKULP", TexMan.NOT_FLAT);
		
		// override skies
		if ( CVar.FindCVar("wf_compat_texswap_all_pl_04").GetBool() )
		{
			Level.ReplaceTextures("SKY1", "PSKY1", TexMan.NOT_FLAT);
			if ( TexMan.GetName(Level.SkyTexture1) == "SKY1" )
				Level.ChangeSky(TexMan.CheckForTexture("PSKY1"), Level.SkyTexture2);
		}
		if ( CVar.FindCVar("wf_compat_texswap_all_pl_05").GetBool() )
		{
			Level.ReplaceTextures("SKY2", "PSKY2", TexMan.NOT_FLAT);
			if ( TexMan.GetName(Level.SkyTexture1) == "SKY2" )
				Level.ChangeSky(TexMan.CheckForTexture("PSKY2"), Level.SkyTexture2);
		}
		if ( CVar.FindCVar("wf_compat_texswap_all_pl_06").GetBool() )
		{
			Level.ReplaceTextures("SKY3", "PSKY3", TexMan.NOT_FLAT);
			if ( TexMan.GetName(Level.SkyTexture1) == "SKY3" )
				Level.ChangeSky(TexMan.CheckForTexture("PSKY3"), Level.SkyTexture2);
		}
	}
	
	void DoTextureReplacementsAllId1()
	{
		if ( CVar.FindCVar("wf_compat_texswap_all_id1_00").GetBool() ) Level.ReplaceTextures("BLOOD1",   "XBLOOD1",  TexMan.NOT_WALL);
		if ( CVar.FindCVar("wf_compat_texswap_all_id1_01").GetBool() ) Level.ReplaceTextures("NUKAGE1",  "XNUKAGE1", TexMan.NOT_WALL);
		if ( CVar.FindCVar("wf_compat_texswap_all_id1_02").GetBool() ) Level.ReplaceTextures("BRNPOIS2", "BRNPOIS3", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_id1_03").GetBool() ) Level.ReplaceTextures("DOORSTOP", "DOORSTP1", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_id1_04").GetBool() ) Level.ReplaceTextures("LITERED2", "LITERED6", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_id1_05").GetBool() ) Level.ReplaceTextures("SW1BRN1",  "SW1BRN1A", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_id1_06").GetBool() ) Level.ReplaceTextures("SW1STARG", "SW1STARA", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_id1_07").GetBool() ) Level.ReplaceTextures("SW1STONE", "SW1STONA", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_id1_08").GetBool() ) Level.ReplaceTextures("SW1STON2", "SW1STONB", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_id1_09").GetBool() ) Level.ReplaceTextures("SW2BRN1",  "SW2BRN1A", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_id1_10").GetBool() ) Level.ReplaceTextures("SW2STARG", "SW2STARA", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_id1_11").GetBool() ) Level.ReplaceTextures("SW2STONE", "SW2STONA", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_id1_12").GetBool() ) Level.ReplaceTextures("SW2STON2", "SW2STONB", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_id1_13").GetBool() ) Level.ReplaceTextures("WFALL1",   "XWFALL1",  TexMan.NOT_FLAT);
	}
	
	void DoTextureReplacementsAllMlKlie()
	{
		// override sky
		if ( CVar.FindCVar("wf_compat_texswap_all_ml_00").GetBool() )
		{
			Level.ReplaceTextures("SKY1", "MSKY1", TexMan.NOT_FLAT);
			if ( TexMan.GetName(Level.SkyTexture1) == "SKY1" )
				Level.ChangeSky(TexMan.CheckForTexture("MSKY1"), Level.SkyTexture2);
		}
	}
	
	void DoTextureReplacementsAllMlAnderson()
	{
		// override sky
		if ( CVar.FindCVar("wf_compat_texswap_all_ml_01").GetBool() )
		{
			Level.ReplaceTextures("SKY1", "MSKY2", TexMan.NOT_FLAT);
			if ( TexMan.GetName(Level.SkyTexture1) == "SKY1" )
				Level.ChangeSky(TexMan.CheckForTexture("MSKY2"), Level.SkyTexture2);
		}
	}
	
	void DoTextureReplacementsAllMlFlynn()
	{
		// override sky
		if ( CVar.FindCVar("wf_compat_texswap_all_ml_02").GetBool() )
		{
			Level.ReplaceTextures("SKY1", "MSKY3", TexMan.NOT_FLAT);
			if ( TexMan.GetName(Level.SkyTexture1) == "SKY1" )
				Level.ChangeSky(TexMan.CheckForTexture("MSKY3"), Level.SkyTexture2);
		}
	}
	
	void DoTextureReplacementsAllMlrMines()
	{
		if ( CVar.FindCVar("wf_compat_texswap_all_mlr_00").GetBool() ) Level.ReplaceTextures("DBRAIN1" , "MBRAIN1" , TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_mlr_01").GetBool() ) Level.ReplaceTextures("DBRAIN2" , "MBRAIN2" , TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_mlr_02").GetBool() ) Level.ReplaceTextures("DBRAIN3" , "MBRAIN3" , TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_mlr_03").GetBool() ) Level.ReplaceTextures("DBRAIN4" , "MBRAIN4" , TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_mlr_04").GetBool() ) Level.ReplaceTextures("SW1COMP" , "SW1COMPM", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_mlr_05").GetBool() ) Level.ReplaceTextures("SW1STON1", "SW1STOND", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_mlr_06").GetBool() ) Level.ReplaceTextures("SW1STON2", "SW1STONF", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_mlr_07").GetBool() ) Level.ReplaceTextures("SW2COMP" , "SW2COMPM", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_mlr_08").GetBool() ) Level.ReplaceTextures("SW2STON1", "SW2STOND", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_mlr_09").GetBool() ) Level.ReplaceTextures("SW2STON2", "SW2STONF", TexMan.NOT_FLAT);
		
		// override sky
		if ( CVar.FindCVar("wf_compat_texswap_all_mlr_10").GetBool() )
		{
			Level.ReplaceTextures("SKY1", "MSKY4", TexMan.NOT_FLAT);
			if ( TexMan.GetName(Level.SkyTexture1) == "SKY1" )
				Level.ChangeSky(TexMan.CheckForTexture("MSKY4"), Level.SkyTexture2);
		}
	}
	
	void DoTextureReplacementsAllMlrAnomaly()
	{
		if ( CVar.FindCVar("wf_compat_texswap_all_mlr_11").GetBool() ) Level.ReplaceTextures("SW1STON2", "SW1STONC", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_mlr_12").GetBool() ) Level.ReplaceTextures("SW2STON2", "SW2STONC", TexMan.NOT_FLAT);
		
		// override sky
		if ( CVar.FindCVar("wf_compat_texswap_all_mlr_13").GetBool() )
		{
			Level.ReplaceTextures("SKY1", "MSKY5", TexMan.NOT_FLAT);
			if ( TexMan.GetName(Level.SkyTexture1) == "SKY1" )
				Level.ChangeSky(TexMan.CheckForTexture("MSKY5"), Level.SkyTexture2);
		}
	}
	
	void DoTextureReplacementsAllMlrFarside()
	{
		if ( CVar.FindCVar("wf_compat_texswap_all_mlr_14").GetBool() ) Level.ReplaceTextures("SW1BRIK" , "SW1BRIKM", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_mlr_15").GetBool() ) Level.ReplaceTextures("SW1STON2", "SW1STONG", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_mlr_16").GetBool() ) Level.ReplaceTextures("SW2BRIK" , "SW2BRIKM", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_mlr_17").GetBool() ) Level.ReplaceTextures("SW2STON2", "SW2STONG", TexMan.NOT_FLAT);
		
		// override sky
		if ( CVar.FindCVar("wf_compat_texswap_all_mlr_18").GetBool() )
		{
			Level.ReplaceTextures("SKY1", "MSKY6", TexMan.NOT_FLAT);
			if ( TexMan.GetName(Level.SkyTexture1) == "SKY1" )
				Level.ChangeSky(TexMan.CheckForTexture("MSKY6"), Level.SkyTexture2);
		}
	}
	
	void DoTextureReplacementsAllMlrTrouble()
	{
		if ( CVar.FindCVar("wf_compat_texswap_all_mlr_19").GetBool() ) Level.ReplaceTextures("SW1PIPE" , "SW1PIPEM", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_mlr_20").GetBool() ) Level.ReplaceTextures("SW1STON1", "SW1STONC", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_mlr_21").GetBool() ) Level.ReplaceTextures("SW1STON2", "SW1STONH", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_mlr_22").GetBool() ) Level.ReplaceTextures("SW1STON6", "SW1STONI", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_mlr_23").GetBool() ) Level.ReplaceTextures("SW1STONE", "SW1STONJ", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_mlr_24").GetBool() ) Level.ReplaceTextures("SW1VINE" , "SW1VINEM", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_mlr_25").GetBool() ) Level.ReplaceTextures("SW2PIPE" , "SW2PIPEM", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_mlr_26").GetBool() ) Level.ReplaceTextures("SW2STON1", "SW2STONC", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_mlr_27").GetBool() ) Level.ReplaceTextures("SW2STON2", "SW2STONH", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_mlr_28").GetBool() ) Level.ReplaceTextures("SW2STON6", "SW2STONI", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_mlr_29").GetBool() ) Level.ReplaceTextures("SW2STONE", "SW2STONJ", TexMan.NOT_FLAT);
		if ( CVar.FindCVar("wf_compat_texswap_all_mlr_30").GetBool() ) Level.ReplaceTextures("SW2VINE" , "SW2VINEM", TexMan.NOT_FLAT);
		
		// override sky
		if ( CVar.FindCVar("wf_compat_texswap_all_mlr_31").GetBool() )
		{
			Level.ReplaceTextures("SKY1", "MSKY5", TexMan.NOT_FLAT);
			if ( TexMan.GetName(Level.SkyTexture1) == "SKY1" )
				Level.ChangeSky(TexMan.CheckForTexture("MSKY5"), Level.SkyTexture2);
		}
	}
	
	void DoTextureReplacementsAllMlrUdtwid()
	{
		// override sky
		if ( CVar.FindCVar("wf_compat_texswap_all_mlr_32").GetBool() )
		{
			Level.ReplaceTextures("SKY4", "MSKY7", TexMan.NOT_FLAT);
			if ( TexMan.GetName(Level.SkyTexture1) == "SKY4" )
				Level.ChangeSky(TexMan.CheckForTexture("MSKY7"), Level.SkyTexture2);
		}
	}
}
