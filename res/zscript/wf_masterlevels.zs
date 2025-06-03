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

extend class WadFusionHandler
{
	void AddMasterLevelsRejects()
	{
		let rejects = CVar.FindCVar("wf_map_mlr").GetBool();
		let rejectsStory = CVar.FindCVar("wf_map_mlr_story").GetBool();
		string mapName = Level.MapName.MakeLower();
		
		if ( mapName == "ml_map06" )
		{
			if ( rejects )
				Level.NextMap = "ml_map08";
			else
				Level.NextMap = "ml_map07";
		}
		if ( mapName == "ml_map09" )
		{
			if ( rejects )
				Level.NextMap = "ml_map22";
			else
				Level.NextMap = "ml_map10";
		}
		if ( mapName == "ml_map07" )
		{
			if ( rejects )
			{
				if ( rejectsStory )
					Level.NextMap = "wf_story_ml_map29";
				else
					Level.NextMap = "ml_map29";
			}
			else
				Level.NextMap = "ml_map08";
		}
		if ( mapName == "ml_map17" )
		{
			if ( rejects )
			{
				if ( rejectsStory )
					Level.NextMap = "wf_story_ml_map33";
				else
					Level.NextMap = "ml_map33";
			}
			else
				Level.NextMap = "ml_map18";
		}
		if ( mapName == "ml_map15" )
		{
			if ( rejects )
				Level.NextMap = "ml_map35";
			else
				Level.NextMap = "ml_map16";
		}
		if ( mapName == "ml_map19" )
		{
			if ( rejects )
			{
				if ( rejectsStory )
					Level.NextMap = "wf_story_ml_map37";
				else
					Level.NextMap = "ml_map37";
			}
			else
				Level.NextMap = "ml_map20";
		}
		if ( mapName == "ml_map20" )
		{
			if ( rejects )
				Level.NextMap = "ml_map40";
			else
				Level.NextMap = "wf_story";
		}
		if ( mapName == "ml_map18" || mapName == "ml_map21" )
		{
			if ( rejects )
			{
				if ( rejectsStory )
					Level.NextMap = "wf_story_ml_map41";
				else
					Level.NextMap = "ml_map41";
			}
			else
				Level.NextMap = "ml_map19";
		}
		if ( mapName == "ml_map10" )
		{
			if ( rejects )
				if ( rejectsStory )
					Level.NextMap = "wf_story_ml_map43";
				else
					Level.NextMap = "ml_map43";
			else
				Level.NextMap = "ml_map11";
		}
		
		if ( mapName == "ml_map29" )
		{
			if ( rejectsStory )
				Level.NextMap = "wf_story_ml_map30";
			else
				Level.NextMap = "ml_map30";
		}
		if ( mapName == "ml_map30" )
		{
			if ( rejectsStory )
				Level.NextMap = "wf_story_ml_map31";
			else
				Level.NextMap = "ml_map31";
		}
		if ( mapName == "ml_map31" )
		{
			if ( rejectsStory )
				Level.NextMap = "wf_story_ml_map32";
			else
				Level.NextMap = "ml_map32";
		}
		if ( mapName == "ml_map32" )
		{
			if ( rejectsStory )
				Level.NextMap = "wf_story_ml_map16";
			else
				Level.NextMap = "ml_map16";
		}
		if ( mapName == "ml_map16" )
		{
			if ( rejects && rejectsStory )
				Level.NextMap = "wf_story_ml_map17";
			else
				Level.NextMap = "ml_map17";
		}
		if ( mapName == "ml_map33" )
		{
			if ( rejectsStory )
				Level.NextMap = "wf_story_ml_map34";
			else
				Level.NextMap = "ml_map34";
		}
		if ( mapName == "ml_map34" )
		{
			if ( rejectsStory )
				Level.NextMap = "wf_story_ml_map11";
			else
				Level.NextMap = "ml_map11";
		}
		if ( mapName == "ml_map11" )
		{
			if ( rejects && rejectsStory )
				Level.NextMap = "wf_story_ml_map12";
			else
				Level.NextMap = "ml_map12";
		}
		if ( mapName == "ml_map12" )
		{
			if ( rejects && rejectsStory )
				Level.NextMap = "wf_story_ml_map13";
			else
				Level.NextMap = "ml_map13";
		}
		if ( mapName == "ml_map14" )
		{
			if ( rejects && rejectsStory )
				Level.NextMap = "wf_story_ml_map15";
			else
				Level.NextMap = "ml_map15";
		}
		if ( mapName == "ml_map36" )
		{
			if ( rejectsStory )
				Level.NextMap = "wf_story_ml_map19";
			else
				Level.NextMap = "ml_map19";
		}
		if ( mapName == "ml_map37" )
		{
			if ( rejectsStory )
				Level.NextMap = "wf_story_ml_map38";
			else
				Level.NextMap = "ml_map38";
		}
		if ( mapName == "ml_map39" )
		{
			if ( rejectsStory )
				Level.NextMap = "wf_story_ml_map20";
			else
				Level.NextMap = "ml_map20";
		}
		if ( mapName == "ml_map40" )
		{
			if ( rejectsStory )
				Level.NextMap = "wf_story_ml_map18";
			else
				Level.NextMap = "ml_map18";
		}
		if ( mapName == "ml_map41" )
		{
			if ( rejectsStory )
				Level.NextMap = "wf_story_ml_map42";
			else
				Level.NextMap = "ml_map42";
		}
		if ( mapName == "ml_map42" )
		{
			if ( rejectsStory )
				Level.NextMap = "wf_story_ml_map10";
			else
				Level.NextMap = "ml_map10";
		}
	}
}
