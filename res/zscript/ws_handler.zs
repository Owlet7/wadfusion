//-----------------------------------------------------------------------------
//
// Copyright 2024 Owlet VII
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
			Level.ReplaceTextures("SKY1", "TSKY1", 0);			// different from doom1
			Level.ReplaceTextures("SKY2", "TSKY2", 0);			// different from doom1
			Level.ReplaceTextures("SKY3", "TSKY3", 0);			// different from doom1
			Level.ReplaceTextures("SW1GSTON", "SW1GSTNT", 0);	// different from doom2
			Level.ReplaceTextures("SW2GSTON", "SW2GSTNT", 0);	// different from doom2
			Level.ReplaceTextures("SW1SKULL", "SW1SKULT", 0);	// different from doom2
			Level.ReplaceTextures("SW2SKULL", "SW2SKULT", 0);	// different from doom2
			Level.ReplaceTextures("SLADRIP1", "SLADRPT1", 0);	// different from doom1
			Level.ReplaceTextures("SLADRIP3", "SLADRPT3", 0);	// different from doom1
			Level.ReplaceTextures("BLODGR1", "BLODGRT1", 0);	// different from doom1
			Level.ReplaceTextures("BLODGR4", "BLODGRT4", 0);	// different from doom1
			Level.ReplaceTextures("WFALL1", "TWFALL1", 0);		// different from plutonia
			Level.ReplaceTextures("WFALL4", "TWFALL4", 0);		// different from plutonia
		}
		else if ( mapPrefix == "pl_" )
		{
			Level.ReplaceTextures("DBRAIN1", "PBRAIN1", 0);		// different from doom2
			Level.ReplaceTextures("DBRAIN4", "PBRAIN4", 0);		// different from doom2
			Level.ReplaceTextures("FIREBLU1", "FIREPLU1", 0);	// different from doom2
			Level.ReplaceTextures("FIREBLU2", "FIREPLU2", 0);	// different from doom2
			Level.ReplaceTextures("SKY1", "PSKY1", 0);			// different from doom1
			Level.ReplaceTextures("SKY2", "PSKY2", 0);			// different from doom1
			Level.ReplaceTextures("SKY3", "PSKY3", 0);			// different from doom1
			Level.ReplaceTextures("SW1SKULL", "SW1SKULP", 0);	// different from doom2
			Level.ReplaceTextures("SW2SKULL", "SW2SKULP", 0);	// different from doom2
		}
	}
	
	void DoDoom1TextureReplacements()
	{
		// detect doom1 style map name
		String mapName = level.MapName.MakeLower();
		if ( mapName.Left(1) == "e" && mapName.Mid(2, 1) == "m" )
		{
			// replace doom1 textures that are different from doom2
			Level.ReplaceTextures("BRNPOIS", "BRNPOIS1", 0);
			Level.ReplaceTextures("NUKEPOIS", "NUKPOIS1", 0);
			Level.ReplaceTextures("BIGDOOR7", "BIGDOORA", 0);
			Level.ReplaceTextures("SHAWN1", "SHAWN1A", 0);
			Level.ReplaceTextures("STEP1", "STEP1A", 0);
			Level.ReplaceTextures("STEP2", "STEP2A", 0);
			Level.ReplaceTextures("STEP3", "STEP3A", 0);
			Level.ReplaceTextures("STEP5", "STEP5A", 0);
			Level.ReplaceTextures("SW1BRN1", "SW1BRN1A", 0);
			Level.ReplaceTextures("SW1STARG", "SW1STARA", 0);
			Level.ReplaceTextures("SW1STONE", "SW1STONA", 0);
			Level.ReplaceTextures("SW1STON2", "SW1STONB", 0);
			Level.ReplaceTextures("SW2BRN1", "SW2BRN1A", 0);
			Level.ReplaceTextures("SW2STARG", "SW2STARA", 0);
			Level.ReplaceTextures("SW2STONE", "SW2STONA", 0);
			Level.ReplaceTextures("SW2STON2", "SW2STONB", 0);
		}
	}
	
	void DoId1TextureReplacements()
	{
		// detect id1 or iddm1 style map name
		String mapPrefix = level.MapName.Left(3);
		mapPrefix = mapPrefix.MakeLower();
		if ( mapPrefix == "id_" || mapPrefix == "dm_" )
		{
			// replace id1 textures that are different from doom2
			Level.ReplaceTextures("BLOOD1", "XBLOOD1", 0);
			Level.ReplaceTextures("NUKAGE1", "XNUKAGE1", 0);
			Level.ReplaceTextures("BRNPOIS2", "BRNPOIS3", 0);
			Level.ReplaceTextures("DOORSTOP", "DOORSTP1", 0);
			Level.ReplaceTextures("LITERED2", "LITERED6", 0);
			Level.ReplaceTextures("WFALL1", "XWFALL1", 0);
			Level.ReplaceTextures("SW1BRN1", "SW1BRN1A", 0);
			Level.ReplaceTextures("SW1STARG", "SW1STARA", 0);
			Level.ReplaceTextures("SW1STONE", "SW1STONA", 0);
			Level.ReplaceTextures("SW1STON2", "SW1STONB", 0);
			Level.ReplaceTextures("SW2BRN1", "SW2BRN1A", 0);
			Level.ReplaceTextures("SW2STARG", "SW2STARA", 0);
			Level.ReplaceTextures("SW2STONE", "SW2STONA", 0);
			Level.ReplaceTextures("SW2STON2", "SW2STONB", 0);
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
	
	override void WorldLoaded(WorldEvent e)
	{
		if ( CVar.FindCVar("ws_finaldoom_texswap").GetBool() )
			DoFinalDoomTextureReplacements();
		if ( CVar.FindCVar("ws_d1_texswap").GetBool() )
			DoDoom1TextureReplacements();
		if ( CVar.FindCVar("ws_id1_texswap").GetBool() )
			DoId1TextureReplacements();
		if ( CVar.FindCVar("ws_d2sky_compat").GetBool() )
			DoDoom2SkyReplacements();
	}
	
	override void WorldThingSpawned(WorldEvent e)
	{
		// sigil 2 spider boss buff
		String mapName = level.MapName.MakeLower();
		if ( mapName.Left(3) == "e6m" )
		{
			if ( CVar.FindCVar("ws_sigil2_spiderboss").GetBool() && e.Thing )
			{
				if ( e.Thing.GetClassName() == "SpiderMastermind" )
				{
					e.Thing.Health = 9000;
				}
			}
		}
	}
}
