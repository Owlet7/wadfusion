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

class WadFusionMapFixes : LevelPostProcessor
{
	protected void Apply(Name checksum, String mapname)
	{
		switch (checksum)
		{
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
