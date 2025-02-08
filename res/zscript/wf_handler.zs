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

//
// This code is derived from WadSmoosh 1.41, which is covered by the following permissions:
//
//------------------------------------------------------------------------------------------
//
// The MIT License (MIT)
// 
// Copyright (c) 2016-2023 JP LeBreton
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
//------------------------------------------------------------------------------------------
//

class WadFusionHandler : EventHandler
{
	void DoFinalDoomTextureReplacements()
	{
		String mapPrefix = level.MapName.Left(3);
		mapPrefix = mapPrefix.MakeLower();
		if ( mapPrefix == "tn_" )
		{
			Level.ReplaceTextures("BLODGR1", "BLODGRT1", TexMan.NOT_FLAT);	// different from doom1
			Level.ReplaceTextures("BLODGR4", "BLODGRT4", TexMan.NOT_FLAT);	// different from doom1
			Level.ReplaceTextures("SKY1", "TSKY1", TexMan.NOT_FLAT);		// different from doom1
			Level.ReplaceTextures("SKY2", "TSKY2", TexMan.NOT_FLAT);		// different from doom1
			Level.ReplaceTextures("SKY3", "TSKY3", TexMan.NOT_FLAT);		// different from doom1
			Level.ReplaceTextures("SLADRIP1", "SLADRPT1", TexMan.NOT_FLAT);	// different from doom1
			Level.ReplaceTextures("SLADRIP3", "SLADRPT3", TexMan.NOT_FLAT);	// different from doom1
			Level.ReplaceTextures("SW1GSTON", "SW1GSTNT", TexMan.NOT_FLAT);	// different from doom2
			Level.ReplaceTextures("SW2GSTON", "SW2GSTNT", TexMan.NOT_FLAT);	// different from doom2
			Level.ReplaceTextures("SW1SKULL", "SW1SKULT", TexMan.NOT_FLAT);	// different from doom2
			Level.ReplaceTextures("SW2SKULL", "SW2SKULT", TexMan.NOT_FLAT);	// different from doom2
			Level.ReplaceTextures("WFALL1", "TWFALL1", TexMan.NOT_FLAT);	// different from plutonia
			Level.ReplaceTextures("WFALL4", "TWFALL4", TexMan.NOT_FLAT);	// different from plutonia
		}
		else if ( mapPrefix == "pl_" )
		{
			Level.ReplaceTextures("DBRAIN1", "PBRAIN1", TexMan.NOT_FLAT);	// different from doom2
			Level.ReplaceTextures("DBRAIN4", "PBRAIN4", TexMan.NOT_FLAT);	// different from doom2
			Level.ReplaceTextures("FIREBLU1", "FIREPLU1", TexMan.NOT_FLAT);	// different from doom2
			Level.ReplaceTextures("FIREBLU2", "FIREPLU2", TexMan.NOT_FLAT);	// different from doom2
			Level.ReplaceTextures("SKY1", "PSKY1", TexMan.NOT_FLAT);		// different from doom1
			Level.ReplaceTextures("SKY2", "PSKY2", TexMan.NOT_FLAT);		// different from doom1
			Level.ReplaceTextures("SKY3", "PSKY3", TexMan.NOT_FLAT);		// different from doom1
			Level.ReplaceTextures("SW1SKULL", "SW1SKULP", TexMan.NOT_FLAT);	// different from doom2
			Level.ReplaceTextures("SW2SKULL", "SW2SKULP", TexMan.NOT_FLAT);	// different from doom2
		}
	}
	
	void DoDoom1TextureReplacements()
	{
		// detect doom1 style map name
		String mapName = level.MapName.MakeLower();
		if ( mapName.Left(1) == "e" && mapName.Mid(2, 1) == "m" )
		{
			// replace doom1 textures that are different from doom2
			Level.ReplaceTextures("BIGDOOR7", "BIGDOR7A", TexMan.NOT_FLAT);
			Level.ReplaceTextures("BRNPOIS", "BRNPOIS1", TexMan.NOT_FLAT);
			Level.ReplaceTextures("NUKEPOIS", "NUKPOIS1", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SHAWN1", "SHAWN1A", TexMan.NOT_FLAT);
			Level.ReplaceTextures("STEP1", "STEP1A", TexMan.NOT_FLAT);
			Level.ReplaceTextures("STEP2", "STEP2A", TexMan.NOT_FLAT);
			Level.ReplaceTextures("STEP3", "STEP3A", TexMan.NOT_FLAT);
			Level.ReplaceTextures("STEP5", "STEP5A", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW1BRN1", "SW1BRN1A", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW1STARG", "SW1STARA", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW1STONE", "SW1STONA", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW1STON2", "SW1STONB", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW2BRN1", "SW2BRN1A", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW2STARG", "SW2STARA", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW2STONE", "SW2STONA", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW2STON2", "SW2STONB", TexMan.NOT_FLAT);
		}
	}
	
	void DoId1TextureReplacements()
	{
		// detect id1 or iddm1 style map name
		String mapPrefix = level.MapName.Left(3);
		mapPrefix = mapPrefix.MakeLower();
		if ( mapPrefix == "lr_" || mapPrefix == "dm_" )
		{
			// replace id1 textures that are different from doom2
			Level.ReplaceTextures("BLOOD1", "XBLOOD1", TexMan.NOT_WALL);
			Level.ReplaceTextures("NUKAGE1", "XNUKAGE1", TexMan.NOT_WALL);
			Level.ReplaceTextures("BRNPOIS2", "BRNPOIS3", TexMan.NOT_FLAT);
			Level.ReplaceTextures("DOORSTOP", "DOORSTP1", TexMan.NOT_FLAT);
			Level.ReplaceTextures("LITERED2", "LITERED6", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW1BRN1", "SW1BRN1A", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW1STARG", "SW1STARA", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW1STONE", "SW1STONA", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW1STON2", "SW1STONB", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW2BRN1", "SW2BRN1A", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW2STARG", "SW2STARA", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW2STONE", "SW2STONA", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW2STON2", "SW2STONB", TexMan.NOT_FLAT);
			Level.ReplaceTextures("WFALL1", "XWFALL1", TexMan.NOT_FLAT);	// different from plutonia
		}
	}
	
	void DoMasterLevelsTitanTextureReplacements()
	{
		String mapName = level.MapName.MakeLower();
		if ( mapName == "ml_map29" )      // MINES.WAD
		{
			Level.ReplaceTextures("DBRAIN1", "MBRAIN1", TexMan.NOT_FLAT);
			Level.ReplaceTextures("DBRAIN2", "MBRAIN2", TexMan.NOT_FLAT);
			Level.ReplaceTextures("DBRAIN3", "MBRAIN3", TexMan.NOT_FLAT);
			Level.ReplaceTextures("DBRAIN4", "MBRAIN4", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW1COMP", "SW1COMPM", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW1STON1", "SW1STOND", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW1STON2", "SW1STONF", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW2COMP", "SW2COMPM", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW2STON1", "SW2STOND", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW2STON2", "SW2STONF", TexMan.NOT_FLAT);
		}
		else if ( mapName == "ml_map30" ) // ANOMALY.WAD
		{
			Level.ReplaceTextures("SW1STON2", "SW1STONC", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW2STON2", "SW2STONC", TexMan.NOT_FLAT);
		}
		else if ( mapName == "ml_map31" ) // FARSIDE.WAD
		{
			Level.ReplaceTextures("SW1BRIK", "SW1BRIKM", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW1STON2", "SW1STONG", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW2BRIK", "SW2BRIKM", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW2STON2", "SW2STONG", TexMan.NOT_FLAT);
		}
		else if ( mapName == "ml_map32" ) // TROUBLE.WAD
		{
			Level.ReplaceTextures("SW1PIPE", "SW1PIPEM", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW1STON1", "SW1STONC", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW1STON2", "SW1STONH", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW1STON6", "SW1STONI", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW1STONE", "SW1STONJ", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW1VINE", "SW1VINEM", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW2PIPE", "SW2PIPEM", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW2STON1", "SW2STONC", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW2STON2", "SW2STONH", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW2STON6", "SW2STONI", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW2STONE", "SW2STONJ", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW2VINE", "SW2VINEM", TexMan.NOT_FLAT);
		}
	}
	
	// check if the given sky is the level's current sky, see if that is
	// being overriden, and if so change it. return whether this happened.
	bool CheckSkyOverriden(String skyName, String possibleTrueSkyName)
	{
		String sky1Name = TexMan.GetName(level.skytexture1);
		if ( skyName != sky1Name )
			return false;
		int flags = TexMan.ReturnFirst; // default = TexMan.TryAny
		TextureID skyA = TexMan.CheckForTexture(possibleTrueSkyName, TexMan.Type_Any, flags);
		TextureID skyB = TexMan.CheckForTexture(possibleTrueSkyName, TexMan.Type_Override, flags);
		if ( skyA == skyB )
			return false;
		// use skyA as sky2 if it's the same as sky1, otherwise don't touch it
		TextureID skyA2 = (level.skytexture1 == level.skytexture2) ? skyA : level.skytexture2;
		level.ChangeSky(skyA, skyA2);
		return true;
	}
	
	void DoDoom2SkyReplacements()
	{
		if ( CheckSkyOverriden("RSKY1", "SKY1") )
			return;
		else if ( CheckSkyOverriden("RSKY2", "SKY2") )
			return;
		CheckSkyOverriden("RSKY3", "SKY3");
	}
	
	// force texture substitutions on all levels
	// this feature mostly exists for compatibility with final doom mods
	// these disable the regular texture substitutions
	// each texture substitution can be toggled individually, in case a mod needs to replace some of them
	void DoTextureReplacementsAll()
	{
		int texSwapAll = CVar.FindCVar("wf_texswap_all").GetInt();
		// doom1
		if ( texSwapAll == 1 )
		{
			if ( CVar.FindCVar("wf_texswap_d1_00").GetBool() ) Level.ReplaceTextures("BIGDOOR7", "BIGDOR7A", TexMan.NOT_FLAT);
			if ( CVar.FindCVar("wf_texswap_d1_01").GetBool() ) Level.ReplaceTextures("BRNPOIS", "BRNPOIS1", TexMan.NOT_FLAT);
			if ( CVar.FindCVar("wf_texswap_d1_02").GetBool() ) Level.ReplaceTextures("NUKEPOIS", "NUKPOIS1", TexMan.NOT_FLAT);
			if ( CVar.FindCVar("wf_texswap_d1_03").GetBool() ) Level.ReplaceTextures("SHAWN1", "SHAWN1A", TexMan.NOT_FLAT);
			if ( CVar.FindCVar("wf_texswap_d1_04").GetBool() ) Level.ReplaceTextures("STEP1", "STEP1A", TexMan.NOT_FLAT);
			if ( CVar.FindCVar("wf_texswap_d1_05").GetBool() ) Level.ReplaceTextures("STEP2", "STEP2A", TexMan.NOT_FLAT);
			if ( CVar.FindCVar("wf_texswap_d1_06").GetBool() ) Level.ReplaceTextures("STEP3", "STEP3A", TexMan.NOT_FLAT);
			if ( CVar.FindCVar("wf_texswap_d1_07").GetBool() ) Level.ReplaceTextures("STEP5", "STEP5A", TexMan.NOT_FLAT);
			if ( CVar.FindCVar("wf_texswap_d1_08").GetBool() ) Level.ReplaceTextures("SW1BRN1", "SW1BRN1A", TexMan.NOT_FLAT);
			if ( CVar.FindCVar("wf_texswap_d1_09").GetBool() ) Level.ReplaceTextures("SW1STARG", "SW1STARA", TexMan.NOT_FLAT);
			if ( CVar.FindCVar("wf_texswap_d1_10").GetBool() ) Level.ReplaceTextures("SW1STONE", "SW1STONA", TexMan.NOT_FLAT);
			if ( CVar.FindCVar("wf_texswap_d1_11").GetBool() ) Level.ReplaceTextures("SW1STON2", "SW1STONB", TexMan.NOT_FLAT);
			if ( CVar.FindCVar("wf_texswap_d1_12").GetBool() ) Level.ReplaceTextures("SW2BRN1", "SW2BRN1A", TexMan.NOT_FLAT);
			if ( CVar.FindCVar("wf_texswap_d1_13").GetBool() ) Level.ReplaceTextures("SW2STARG", "SW2STARA", TexMan.NOT_FLAT);
			if ( CVar.FindCVar("wf_texswap_d1_14").GetBool() ) Level.ReplaceTextures("SW2STONE", "SW2STONA", TexMan.NOT_FLAT);
			if ( CVar.FindCVar("wf_texswap_d1_15").GetBool() ) Level.ReplaceTextures("SW2STON2", "SW2STONB", TexMan.NOT_FLAT);
		}
		// tnt
		else if ( texSwapAll == 2 )
		{
			if ( CVar.FindCVar("wf_texswap_tn_00").GetBool() ) Level.ReplaceTextures("BLODGR1", "BLODGRT1", TexMan.NOT_FLAT);
			if ( CVar.FindCVar("wf_texswap_tn_01").GetBool() ) Level.ReplaceTextures("BLODGR4", "BLODGRT4", TexMan.NOT_FLAT);
			if ( CVar.FindCVar("wf_texswap_tn_05").GetBool() ) Level.ReplaceTextures("SLADRIP1", "SLADRPT1", TexMan.NOT_FLAT);
			if ( CVar.FindCVar("wf_texswap_tn_06").GetBool() ) Level.ReplaceTextures("SLADRIP3", "SLADRPT3", TexMan.NOT_FLAT);
			if ( CVar.FindCVar("wf_texswap_tn_07").GetBool() ) Level.ReplaceTextures("SW1GSTON", "SW1GSTNT", TexMan.NOT_FLAT);
			if ( CVar.FindCVar("wf_texswap_tn_08").GetBool() ) Level.ReplaceTextures("SW2GSTON", "SW2GSTNT", TexMan.NOT_FLAT);
			if ( CVar.FindCVar("wf_texswap_tn_09").GetBool() ) Level.ReplaceTextures("SW1SKULL", "SW1SKULT", TexMan.NOT_FLAT);
			if ( CVar.FindCVar("wf_texswap_tn_10").GetBool() ) Level.ReplaceTextures("SW2SKULL", "SW2SKULT", TexMan.NOT_FLAT);
			if ( CVar.FindCVar("wf_texswap_tn_11").GetBool() ) Level.ReplaceTextures("WFALL1", "TWFALL1", TexMan.NOT_FLAT);
			if ( CVar.FindCVar("wf_texswap_tn_12").GetBool() ) Level.ReplaceTextures("WFALL4", "TWFALL4", TexMan.NOT_FLAT);
			
			// override skies
			if ( CVar.FindCVar("wf_texswap_tn_02").GetBool() )
			{
				Level.ReplaceTextures("SKY1", "TSKY1", TexMan.NOT_FLAT);
				if ( TexMan.GetName(level.skytexture1) == "SKY1" || TexMan.GetName(level.skytexture1) == "RSKY1" )
				{
					TextureID sky2 = level.skytexture2;
					level.ChangeSky(TexMan.CheckForTexture("TSKY1"), sky2);
				}
			}
			if ( CVar.FindCVar("wf_texswap_tn_03").GetBool() )
			{
				Level.ReplaceTextures("SKY2", "TSKY2", TexMan.NOT_FLAT);
				if ( TexMan.GetName(level.skytexture1) == "SKY2" || TexMan.GetName(level.skytexture1) == "RSKY2" )
				{
					TextureID sky2 = level.skytexture2;
					level.ChangeSky(TexMan.CheckForTexture("TSKY2"), sky2);
				}
			}
			if ( CVar.FindCVar("wf_texswap_tn_04").GetBool() )
			{
				Level.ReplaceTextures("SKY3", "TSKY3", TexMan.NOT_FLAT);
				if ( TexMan.GetName(level.skytexture1) == "SKY3" || TexMan.GetName(level.skytexture1) == "RSKY3" )
				{
					TextureID sky2 = level.skytexture2;
					level.ChangeSky(TexMan.CheckForTexture("TSKY3"), sky2);
				}
			}
		}
		// plutonia
		else if ( texSwapAll == 3 )
		{
			if ( CVar.FindCVar("wf_texswap_pl_00").GetBool() ) Level.ReplaceTextures("DBRAIN1", "PBRAIN1", TexMan.NOT_FLAT);
			if ( CVar.FindCVar("wf_texswap_pl_01").GetBool() ) Level.ReplaceTextures("DBRAIN4", "PBRAIN4", TexMan.NOT_FLAT);
			if ( CVar.FindCVar("wf_texswap_pl_02").GetBool() ) Level.ReplaceTextures("FIREBLU1", "FIREPLU1", TexMan.NOT_FLAT);
			if ( CVar.FindCVar("wf_texswap_pl_03").GetBool() ) Level.ReplaceTextures("FIREBLU2", "FIREPLU2", TexMan.NOT_FLAT);
			if ( CVar.FindCVar("wf_texswap_pl_07").GetBool() ) Level.ReplaceTextures("SW1SKULL", "SW1SKULP", TexMan.NOT_FLAT);
			if ( CVar.FindCVar("wf_texswap_pl_08").GetBool() ) Level.ReplaceTextures("SW2SKULL", "SW2SKULP", TexMan.NOT_FLAT);
			
			// override skies
			if ( CVar.FindCVar("wf_texswap_pl_04").GetBool() )
			{
				Level.ReplaceTextures("SKY1", "PSKY1", TexMan.NOT_FLAT);
				if ( TexMan.GetName(level.skytexture1) == "SKY1" || TexMan.GetName(level.skytexture1) == "RSKY1" )
				{
					TextureID sky2 = level.skytexture2;
					level.ChangeSky(TexMan.CheckForTexture("PSKY1"), sky2);
				}
			}
			if ( CVar.FindCVar("wf_texswap_pl_05").GetBool() )
			{
				Level.ReplaceTextures("SKY2", "PSKY2", TexMan.NOT_FLAT);
				if ( TexMan.GetName(level.skytexture1) == "SKY2" || TexMan.GetName(level.skytexture1) == "RSKY2" )
				{
					TextureID sky2 = level.skytexture2;
					level.ChangeSky(TexMan.CheckForTexture("PSKY2"), sky2);
				}
			}
			if ( CVar.FindCVar("wf_texswap_pl_06").GetBool() )
			{
				Level.ReplaceTextures("SKY3", "PSKY3", TexMan.NOT_FLAT);
				if ( TexMan.GetName(level.skytexture1) == "SKY3" || TexMan.GetName(level.skytexture1) == "RSKY3" )
				{
					TextureID sky2 = level.skytexture2;
					level.ChangeSky(TexMan.CheckForTexture("PSKY3"), sky2);
				}
			}
		}
		// id1
		else if ( texSwapAll == 4 )
		{
			if ( CVar.FindCVar("wf_texswap_id1_00").GetBool() ) Level.ReplaceTextures("BLOOD1", "XBLOOD1", TexMan.NOT_WALL);
			if ( CVar.FindCVar("wf_texswap_id1_01").GetBool() ) Level.ReplaceTextures("NUKAGE1", "XNUKAGE1", TexMan.NOT_WALL);
			if ( CVar.FindCVar("wf_texswap_id1_02").GetBool() ) Level.ReplaceTextures("BRNPOIS2", "BRNPOIS3", TexMan.NOT_FLAT);
			if ( CVar.FindCVar("wf_texswap_id1_03").GetBool() ) Level.ReplaceTextures("DOORSTOP", "DOORSTP1", TexMan.NOT_FLAT);
			if ( CVar.FindCVar("wf_texswap_id1_04").GetBool() ) Level.ReplaceTextures("LITERED2", "LITERED6", TexMan.NOT_FLAT);
			if ( CVar.FindCVar("wf_texswap_id1_05").GetBool() ) Level.ReplaceTextures("SW1BRN1", "SW1BRN1A", TexMan.NOT_FLAT);
			if ( CVar.FindCVar("wf_texswap_id1_06").GetBool() ) Level.ReplaceTextures("SW1STARG", "SW1STARA", TexMan.NOT_FLAT);
			if ( CVar.FindCVar("wf_texswap_id1_07").GetBool() ) Level.ReplaceTextures("SW1STONE", "SW1STONA", TexMan.NOT_FLAT);
			if ( CVar.FindCVar("wf_texswap_id1_08").GetBool() ) Level.ReplaceTextures("SW1STON2", "SW1STONB", TexMan.NOT_FLAT);
			if ( CVar.FindCVar("wf_texswap_id1_09").GetBool() ) Level.ReplaceTextures("SW2BRN1", "SW2BRN1A", TexMan.NOT_FLAT);
			if ( CVar.FindCVar("wf_texswap_id1_10").GetBool() ) Level.ReplaceTextures("SW2STARG", "SW2STARA", TexMan.NOT_FLAT);
			if ( CVar.FindCVar("wf_texswap_id1_11").GetBool() ) Level.ReplaceTextures("SW2STONE", "SW2STONA", TexMan.NOT_FLAT);
			if ( CVar.FindCVar("wf_texswap_id1_12").GetBool() ) Level.ReplaceTextures("SW2STON2", "SW2STONB", TexMan.NOT_FLAT);
			if ( CVar.FindCVar("wf_texswap_id1_13").GetBool() ) Level.ReplaceTextures("WFALL1", "XWFALL1", TexMan.NOT_FLAT);
		}
	}
	
	override void WorldLoaded(WorldEvent e)
	{
		bool texSwapAll = CVar.FindCVar("wf_texswap_all").GetInt();
		if ( CVar.FindCVar("wf_finaldoom_texswap").GetBool() && !texSwapAll )
			DoFinalDoomTextureReplacements();
		if ( CVar.FindCVar("wf_d1_texswap").GetBool() && !texSwapAll )
			DoDoom1TextureReplacements();
		if ( CVar.FindCVar("wf_id1_texswap").GetBool() && !texSwapAll )
			DoId1TextureReplacements();
		if ( CVar.FindCVar("wf_masterlevels_texswap").GetBool() && !texSwapAll )
			DoMasterLevelsTitanTextureReplacements();
		if ( CVar.FindCVar("wf_d2sky_compat").GetBool() )
			DoDoom2SkyReplacements();
		if ( texSwapAll )
			DoTextureReplacementsAll();
	}
	
	override void WorldTick()
	{
		// replace e1m8 or e1m4 with the maps that Romero authored
		// as a warm-up exercise for the cancelled game Blackroom
		String mapName = level.MapName.MakeLower();
		// only if compatibility option isn't off
		if ( CVar.FindCVar("wf_nextmap").GetBool() )
		{
			if ( mapName == "e1m7" )
			{
				if ( !CVar.FindCVar("wf_blackroomswap_e1m8b").GetBool() )
					level.NextMap = "e1m8";
				else
					level.NextMap = "e1m8b";
			}
			if ( mapName == "e1m3" || mapName == "e1m9" )
			{
				if ( !CVar.FindCVar("wf_blackroomswap_e1m4b").GetBool() )
					level.NextMap = "e1m4";
				else
					level.NextMap = "e1m4b";
			}
		}
	}
	
	override void CheckReplacement (ReplaceEvent e)
	{
		// replace plasmarifle and bfg9000 with incinerator and calamity blade, respectively
		int weapSwap = CVar.FindCVar("wf_id1_weapswap").GetInt();
		string mapName = level.MapName.MakeLower();
		if ( ( weapSwap == 1 && mapName.Left(3) == "lr_" ) || weapSwap >= 2 )
		{
			if ( Level.MapTime == 0 )
			{
				if (e.Replacee is "PlasmaRifle")
					e.Replacement = "ID24Incinerator";
				if (e.Replacee is "BFG9000")
					e.Replacement = "ID24CalamityBlade";
				if (e.Replacee is "Cell")
					e.Replacement = "ID24Fuel";
				if (e.Replacee is "CellPack")
					e.Replacement = "ID24FuelTank";
			}
		}
	}
	
	override void WorldThingSpawned(WorldEvent e)
	{
		// sigil 2 spider boss buff
		String mapName = level.MapName.MakeLower();
		if ( mapName.Left(3) == "e6m" )
		{
			if ( CVar.FindCVar("wf_sigil2_spiderboss").GetBool() && e.Thing )
			{
				if ( e.Thing.GetClassName() == "SpiderMastermind" )
				{
					e.Thing.Health = 9000;
				}
			}
		}
		
		// don't count spawned enemies e.g. icon of sin summons
		if ( CVar.FindCVar("wf_killcountfix").GetBool() )
		{
			if (Level.MapTime > 0)
				RevertKillCounter(e);
		}
	}
	
	// don't count revived enemies
	override void WorldThingRevived(WorldEvent e)
	{
		if ( CVar.FindCVar("wf_killcountfix").GetBool() )
			RevertKillCounter(e);
	}
	
	// https://forum.zdoom.org/viewtopic.php?t=78533
	private void RevertKillCounter(WorldEvent e)
	{
		if (e.Thing.bCountKill)
		{
			e.Thing.bCountKill = false;
			Level.Total_Monsters -= 1;			
		}
	}
}
