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
	
	// replace conflicting textures based on which map is loaded
	
	void DoFinalDoomTextureReplacements()
	{
		string mapPrefix = Level.MapName.Left(3).MakeLower();
		if ( mapPrefix == "tn_" )
		{
			Level.ReplaceTextures("BLODGR1",  "BLODGRT1", TexMan.NOT_FLAT); // different from doom1
			Level.ReplaceTextures("BLODGR4",  "BLODGRT4", TexMan.NOT_FLAT); // different from doom1
			Level.ReplaceTextures("SKY1",     "TSKY1",    TexMan.NOT_FLAT); // different from doom1
			Level.ReplaceTextures("SKY2",     "TSKY2",    TexMan.NOT_FLAT); // different from doom1
			Level.ReplaceTextures("SKY3",     "TSKY3",    TexMan.NOT_FLAT); // different from doom1
			Level.ReplaceTextures("SLADRIP1", "SLADRPT1", TexMan.NOT_FLAT); // different from doom1
			Level.ReplaceTextures("SLADRIP3", "SLADRPT3", TexMan.NOT_FLAT); // different from doom1
			Level.ReplaceTextures("SW1GSTON", "SW1GSTNT", TexMan.NOT_FLAT); // different from doom2
			Level.ReplaceTextures("SW2GSTON", "SW2GSTNT", TexMan.NOT_FLAT); // different from doom2
			Level.ReplaceTextures("SW1SKULL", "SW1SKULT", TexMan.NOT_FLAT); // different from doom2
			Level.ReplaceTextures("SW2SKULL", "SW2SKULT", TexMan.NOT_FLAT); // different from doom2
			Level.ReplaceTextures("WFALL1",   "TWFALL1",  TexMan.NOT_FLAT); // different from plutonia
			Level.ReplaceTextures("WFALL4",   "TWFALL4",  TexMan.NOT_FLAT); // different from plutonia
		}
		else if ( mapPrefix == "pl_" )
		{
			Level.ReplaceTextures("DBRAIN1",  "PBRAIN1",  TexMan.NOT_FLAT); // different from doom2
			Level.ReplaceTextures("DBRAIN4",  "PBRAIN4",  TexMan.NOT_FLAT); // different from doom2
			Level.ReplaceTextures("FIREBLU1", "FIREPLU1", TexMan.NOT_FLAT); // different from doom2
			Level.ReplaceTextures("FIREBLU2", "FIREPLU2", TexMan.NOT_FLAT); // different from doom2
			Level.ReplaceTextures("SKY1",     "PSKY1",    TexMan.NOT_FLAT); // different from doom1
			Level.ReplaceTextures("SKY2",     "PSKY2",    TexMan.NOT_FLAT); // different from doom1
			Level.ReplaceTextures("SKY3",     "PSKY3",    TexMan.NOT_FLAT); // different from doom1
			Level.ReplaceTextures("SW1SKULL", "SW1SKULP", TexMan.NOT_FLAT); // different from doom2
			Level.ReplaceTextures("SW2SKULL", "SW2SKULP", TexMan.NOT_FLAT); // different from doom2
		}
	}
	
	void DoDoom1TextureReplacements()
	{
		// detect doom1 style map name
		string mapName = Level.MapName.MakeLower();
		if ( mapName.Left(1) == "e" && mapName.Mid(2, 1) == "m" )
		{
			// replace doom1 textures that are different from doom2
			Level.ReplaceTextures("BIGDOOR7", "BIGDOR7A", TexMan.NOT_FLAT);
			Level.ReplaceTextures("BRNPOIS",  "BRNPOIS1", TexMan.NOT_FLAT);
			Level.ReplaceTextures("NUKEPOIS", "NUKPOIS1", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SHAWN1",   "SHAWN1A",  TexMan.NOT_FLAT);
			Level.ReplaceTextures("STEP1",    "STEP1A",   TexMan.NOT_FLAT);
			Level.ReplaceTextures("STEP2",    "STEP2A",   TexMan.NOT_FLAT);
			Level.ReplaceTextures("STEP3",    "STEP3A",   TexMan.NOT_FLAT);
			Level.ReplaceTextures("STEP5",    "STEP5A",   TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW1BRN1",  "SW1BRN1A", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW1STARG", "SW1STARA", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW1STONE", "SW1STONA", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW1STON2", "SW1STONB", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW2BRN1",  "SW2BRN1A", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW2STARG", "SW2STARA", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW2STONE", "SW2STONA", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW2STON2", "SW2STONB", TexMan.NOT_FLAT);
		}
	}
	
	void DoId1TextureReplacements()
	{
		// detect id1 or iddm1 style map name
		string mapPrefix = Level.MapName.Left(3).MakeLower();
		if ( mapPrefix == "lr_" || mapPrefix == "dm_" )
		{
			// replace id1 textures that are different from doom2
			Level.ReplaceTextures("BLOOD1",   "XBLOOD1",  TexMan.NOT_WALL);
			Level.ReplaceTextures("NUKAGE1",  "XNUKAGE1", TexMan.NOT_WALL);
			Level.ReplaceTextures("BRNPOIS2", "BRNPOIS3", TexMan.NOT_FLAT);
			Level.ReplaceTextures("DOORSTOP", "DOORSTP1", TexMan.NOT_FLAT);
			Level.ReplaceTextures("LITERED2", "LITERED6", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW1BRN1",  "SW1BRN1A", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW1STARG", "SW1STARA", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW1STONE", "SW1STONA", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW1STON2", "SW1STONB", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW2BRN1",  "SW2BRN1A", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW2STARG", "SW2STARA", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW2STONE", "SW2STONA", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW2STON2", "SW2STONB", TexMan.NOT_FLAT);
			Level.ReplaceTextures("WFALL1",   "XWFALL1",  TexMan.NOT_FLAT); // different from plutonia
			Level.ReplaceTextures("SKY1",     "RSKY1",    TexMan.NOT_FLAT); // dm_map10 sets its sky texture to
			Level.ReplaceTextures("SKY2",     "RSKY2",    TexMan.NOT_FLAT); //    SKY1 with an MBF sky transfer
			Level.ReplaceTextures("SKY3",     "RSKY3",    TexMan.NOT_FLAT);
		}
	}
	
	void DoMasterLevelsTitanTextureReplacements()
	{
		string mapName = Level.MapName.MakeLower();
		if ( mapName == "ml_map29" )      // MINES.WAD
		{
			Level.ReplaceTextures("DBRAIN1",  "MBRAIN1",  TexMan.NOT_FLAT);
			Level.ReplaceTextures("DBRAIN2",  "MBRAIN2",  TexMan.NOT_FLAT);
			Level.ReplaceTextures("DBRAIN3",  "MBRAIN3",  TexMan.NOT_FLAT);
			Level.ReplaceTextures("DBRAIN4",  "MBRAIN4",  TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW1COMP",  "SW1COMPM", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW1STON1", "SW1STOND", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW1STON2", "SW1STONF", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW2COMP",  "SW2COMPM", TexMan.NOT_FLAT);
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
			Level.ReplaceTextures("SW1BRIK",  "SW1BRIKM", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW1STON2", "SW1STONG", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW2BRIK",  "SW2BRIKM", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW2STON2", "SW2STONG", TexMan.NOT_FLAT);
		}
		else if ( mapName == "ml_map32" ) // TROUBLE.WAD
		{
			Level.ReplaceTextures("SW1PIPE",  "SW1PIPEM", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW1STON1", "SW1STONC", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW1STON2", "SW1STONH", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW1STON6", "SW1STONI", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW1STONE", "SW1STONJ", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW1VINE",  "SW1VINEM", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW2PIPE",  "SW2PIPEM", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW2STON1", "SW2STONC", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW2STON2", "SW2STONH", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW2STON6", "SW2STONI", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW2STONE", "SW2STONJ", TexMan.NOT_FLAT);
			Level.ReplaceTextures("SW2VINE",  "SW2VINEM", TexMan.NOT_FLAT);
		}
	}
}
