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

class WadFusionMapFixes : LevelPostProcessor
{
	protected void Apply(Name checksum, String mapname)
	{
		if ( CVar.FindCVar("wf_compat_xboxsecretexits").GetBool() )
		{
			switch (checksum)
			{
				case '3CB5FAE83B470A9ACCD9B9B2102447DF': // Doom E1M1
				{
					SetLineActivation(272, SPAC_Use);
					SetLineSpecial(272, Exit_Secret, 0);
					break;
				}
				case 'B49F7A6C519757D390D52667DB7D8793': // Ultimate Doom E1M1
				{
					SetLineActivation(268, SPAC_Use);
					SetLineSpecial(268, Exit_Secret, 0);
					break;
				}
				case 'AB24AE6E2CB13CBDD04600A4D37F9189': // Doom II MAP01
				{
					SetLineActivation(283, SPAC_Use);
					SetLineSpecial(283, Exit_Secret, 0);
					break;
				}
			}
		}
		
		if ( CVar.FindCVar("wf_compat_mapfixes").GetBool() )
		{
			switch (checksum)
			{
				// Extend gzdoom's level_compatibility.zs map33 fix to other versions of the map
				case '915409A89746D6BFD92C7956BE6A0A2D': // Doom II: BFG Edition MAP33
				case '9F0954A61E12088BB843AC9400445517': // Doom II: Xbox Edition MAP33
				case '6E40FC3C626FCA486651866574D5DBA7': // betray.wad MAP01
				{
					// Missing textures on sector with a Super Shotgun at map start.
					TextureID rock2 = TexMan.CheckForTexture("ROCK2", TexMan.Type_Wall);
					for(int i=0; i<4; i++)
					{
						SetWallTextureID(567+i, Line.front, Side.bottom, ROCK2);
						SetWallTextureID(567+i, Line.back, Side.top, ROCK2);
					}
					// Tags the linedefs on the teleporter at the end of the level so that
					// it's possible to leave the room near the yellow keycard door.
					for(int i=0; i<2; i++)
					{
						SetLineSpecial(400+i, Teleport, 0, 36);
						SetLineSpecial(559+i, Teleport, 0, 36);
					}
					break;
				}
				
				// Patch Final DOOM maps with fixes from their id Anthology / GOG / KEX versions
				// The tnt.wad MAP 31 key bug is already fixed in GZDoom
				
				case 'AE65B69D0CE7FA99F105861882D2DE87': // tnt.wad MAP10
				{
					// Remove duplicate secrets
					SetSectorSpecial(57, 0);
					SetSectorSpecial(58, 0);
					SetSectorSpecial(59, 0);
					SetSectorSpecial(61, 0);
					break;
				}
				
				case 'E387982974779DFE05DD83D7CEF42ABB': // plutonia.wad MAP12
				{
					// Add deathmatch spawns
					AddThing(11, (480, -1312, 0), 180);
					AddThing(11, (1184, -1312, 0), 0);
					AddThing(11, (-544, -1376, 0), 270);
					AddThing(11, (544, -1056, 0), 180);
					AddThing(11, (2336, -1568, 0), 180);
					AddThing(11, (864, -224, 0), 270);
					AddThing(11, (672, -1152, 0), 270);
					AddThing(11, (1024, -1152, 0), 270);
					break;
				}
				
				case '8B8361969FD8C24F2E0004306FDC4928': // plutonia.wad MAP23
				{
					// Add deathmatch spawns
					AddThing(11, (-160, 64, 0), 90);
					AddThing(11, (-160, 384, 0), 270);
					AddThing(11, (-768, 224, 0), 0);
					AddThing(11, (-704, 544, 0), 315);
					AddThing(11, ( 352, 608, 0), 225);
					AddThing(11, ( 416, -128, 0), 135);
					AddThing(11, (-704, -128, 0), 45);
					AddThing(11, ( 352, 224, 0), 180);
					break;
				}
			}
		}
	}
}
