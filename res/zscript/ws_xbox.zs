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

class XboxSecretExits : LevelPostProcessor
{
	protected void Apply(Name checksum, String mapname)
	{
		if ( CVar.FindCVar("ws_xbox_secret_exits").GetBool() )
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
		
		switch (checksum)
		{
			// extend gzdoom's level_compatibility.zs map33 fix to other versions of the map
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
		}
	}
}
