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

// everything here is a gross hack
extend class WadFusionStaticHandler
{
	void MasterLevelsStory()
	{
		string mapName = Level.MapName.MakeLower();
		string mapSuffix = mapName.Mid(15, 2);
		
		if ( mapName.Left(15) == "wf_story_ml_map" )
		{
			
			if ( mapSuffix != "29" && mapSuffix != "30" &&
					mapSuffix != "31" && mapSuffix != "32" &&
					mapSuffix != "16" && mapSuffix != "17" &&
					mapSuffix != "33" && mapSuffix != "19" )
			{
				if ( mapSuffix == "34" )
				{
					intermission = "MasterLevels_Map34";
					nextMap = "ml_map34";
				}
				if ( mapSuffix == "11" )
				{
					intermission = "MasterLevels_Map11";
					nextMap = "ml_map11";
				}
				if ( mapSuffix == "12" )
				{
					intermission = "MasterLevels_Map12";
					nextMap = "ml_map12";
				}
				if ( mapSuffix == "13" )
				{
					intermission = "MasterLevels_Map13";
					nextMap = "ml_map13";
				}
				if ( mapSuffix == "15" )
				{
					intermission = "MasterLevels_Map15";
					nextMap = "ml_map15";
				}
				if ( mapSuffix == "37" )
				{
					intermission = "MasterLevels_Map37";
					nextMap = "ml_map37";
				}
				if ( mapSuffix == "38" )
				{
					intermission = "MasterLevels_Map38";
					nextMap = "ml_map38";
				}
				if ( mapSuffix == "20" )
				{
					intermission = "MasterLevels_Map20";
					nextMap = "ml_map20";
				}
				if ( mapSuffix == "18" )
				{
					intermission = "MasterLevels_Map18";
					nextMap = "ml_map18";
				}
				if ( mapSuffix == "41" )
				{
					intermission = "MasterLevels_Map41";
					nextMap = "ml_map41";
				}
				if ( mapSuffix == "42" )
				{
					intermission = "MasterLevels_Map42";
					nextMap = "ml_map42";
				}
				if ( mapSuffix == "10" )
				{
					intermission = "MasterLevels_Map10";
					nextMap = "ml_map10";
				}
				if ( mapSuffix == "43" )
				{
					intermission = "MasterLevels_Map43";
					nextMap = "ml_map43";
				}
				
				StoryStartIntermission(); // wf_story.zs
				if ( Level.MapTime >= 1 )
					Level.ChangeLevel(nextMap, 0, CHANGELEVEL_NOINTERMISSION);
			}
			else
			{
				// maps that need pistol starts
				if ( mapSuffix == "29" )
				{
					intermission = "MasterLevels_Map29";
					nextMap = "ml_map29";
				}
				if ( mapSuffix == "30" )
				{
					intermission = "MasterLevels_Map30";
					nextMap = "ml_map30";
				}
				if ( mapSuffix == "31" )
				{
					intermission = "MasterLevels_Map31";
					nextMap = "ml_map31";
				}
				if ( mapSuffix == "32" )
				{
					intermission = "MasterLevels_Map32";
					nextMap = "ml_map32";
				}
				if ( mapSuffix == "16" )
				{
					intermission = "MasterLevels_Map16";
					nextMap = "ml_map16";
				}
				if ( mapSuffix == "17" )
				{
					intermission = "MasterLevels_Map17";
					nextMap = "ml_map17";
				}
				if ( mapSuffix == "33" )
				{
					intermission = "MasterLevels_Map33";
					nextMap = "ml_map33";
				}
				if ( mapSuffix == "19" )
				{
					intermission = "MasterLevels_Map19";
					nextMap = "ml_map19";
				}
				
				StoryStartIntermission(); // wf_story.zs
				if ( Level.MapTime >= 1 )
					Level.ChangeLevel(nextMap, 0, CHANGELEVEL_RESETINVENTORY|CHANGELEVEL_RESETHEALTH|CHANGELEVEL_NOINTERMISSION);
			}
		}
	}
}
