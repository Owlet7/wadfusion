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

class WadFusionHandler : EventHandler
{
	override void WorldLoaded(WorldEvent e)
	{
		int texSwapAll = CVar.FindCVar("wf_compat_texswap_all").GetInt();
		
		// wf_textswap.zs
		// replace conflicting textures based on which map is loaded
		if ( CVar.FindCVar("wf_compat_texswap_fd").GetBool() && texSwapAll <= 0 )
			DoFinalDoomTextureReplacements();
		if ( CVar.FindCVar("wf_compat_texswap_d1").GetBool() && texSwapAll <= 0 )
			DoDoom1TextureReplacements();
		if ( CVar.FindCVar("wf_compat_texswap_id1").GetBool() && texSwapAll <= 0 )
			DoId1TextureReplacements();
		if ( CVar.FindCVar("wf_compat_texswap_ml").GetBool() && texSwapAll <= 0 )
			DoMasterLevelsTitanTextureReplacements();
		
		// wf_textswap_d2sky.zs
		// check if the given sky is the level's current sky,
		// see if that is being overriden, and if so change it
		if ( CVar.FindCVar("wf_compat_texswap_d2sky").GetBool() )
			DoDoom2SkyReplacements();
		
		// wf_textswap_all.zs
		// force texture replacement on all levels
		// this feature mostly exists for compatibility with doom 1 and final doom mods
		// these disable the regular texture replacements
		// each texture replacement can be toggled individually, in case a mod needs to replace some of them
		switch (texSwapAll)
		{
			case 1:
				DoTextureReplacementsAllDoom1();
				break;
			case 2:
				DoTextureReplacementsAllTnt();
				break;
			case 3:
				DoTextureReplacementsAllPlutonia();
				break;
			case 4:
				DoTextureReplacementsAllId1();
				break;
		}
		
		if ( CVar.FindCVar("wf_compat_changemusic").GetBool() )
		{
			// wf_music_sigil.zs
			// Sigil's map music should be left undefined in MAPINFO,
			// that way the music playback gets initiated by the script,
			// without potentially playing the wrong music for one tick
			PlaySigilMusic();
		}
	}
	
	override void WorldUnloaded(WorldEvent e)
	{
		if ( CVar.FindCVar("wf_compat_changemusic").GetBool() )
		{
			// wf_music_sigil.zs
			// Sigil's InterMusic should be defined as something invalid in MAPINFO,
			// that way the music playback gets initiated by the script
			// when the map unloads and enters the intermission screen,
			// without potentially playing the wrong music for one tick
			PlaySigilInterMusic();
		}
	}
	
	override void WorldTick()
	{
		// replace e1m8 or e1m4 with the maps that Romero authored
		// as a warm-up exercise for the cancelled game Blackroom
		if ( CVar.FindCVar("wf_compat_nextmap").GetBool() )
		{
			DoBlackroomMapReplacements();
		}
	}
	
	override void CheckReplacement (ReplaceEvent e)
	{
		// replace plasmarifle and bfg9000 with incinerator and calamity blade, respectively
		int id24WeapSwap = CVar.FindCVar("wf_compat_id24_weapons").GetInt();
		string mapPrefix = Level.MapName.Left(3).MakeLower();
		if ( ( id24WeapSwap == 1 && mapPrefix == "lr_" ) || id24WeapSwap >= 2 )
		{
			DoId24WeaponReplacements(e);
		}
	}
	
	override void WorldThingSpawned(WorldEvent e)
	{
		// increase the spiderdemon's health from 3000 to 9000 in Sigil 2
		if ( CVar.FindCVar("wf_compat_sigil2spiderboss").GetBool() )
		{
			DoSigil2SpiderBossBuff(e);
		}
		
		// override gzdoom's transparency render style for id24 actors
		if ( CVar.FindCVar("wf_id24trans").GetBool() )
		{
			DoId24ActorTransparency(e);
		}
		
		// don't count spawned enemies e.g. icon of sin summons
		if ( CVar.FindCVar("wf_compat_killcountfix").GetBool() )
		{
			if ( Level.MapTime > 0 )
				RevertKillCounter(e);
		}
	}
	
	override void WorldThingRevived(WorldEvent e)
	{
		// don't count revived enemies
		if ( CVar.FindCVar("wf_compat_killcountfix").GetBool() )
			RevertKillCounter(e);
	}
	
	void DoSigil2SpiderBossBuff(WorldEvent e)
	{
		string mapPrefix = Level.MapName.Left(3).MakeLower();
		if ( mapPrefix == "e6m" )
		{
			if ( SpiderMastermind(e.Thing) != null )
				SpiderMastermind(e.Thing).Health = 9000;
		}
	}
	
	void DoId24ActorTransparency(WorldEvent e)
	{
		if ( ID24IncineratorFlame(e.Thing) != null )
		{
			ID24IncineratorFlame(e.Thing).A_SetRenderStyle(0.5, STYLE_Translucent);
			ID24IncineratorFlame(e.Thing).bZDOOMTRANS = false;
		}
		if ( ID24IncineratorProjectile(e.Thing) != null )
		{
			ID24IncineratorProjectile(e.Thing).A_SetRenderStyle(0.5, STYLE_Translucent);
			ID24IncineratorProjectile(e.Thing).bZDOOMTRANS = false;
		}
	}
	
	void DoId24WeaponReplacements(ReplaceEvent e)
	{
		if ( Level.MapTime == 0 )
		{
			if ( e.Replacee is "PlasmaRifle" )
				e.Replacement = "ID24Incinerator";
			if ( e.Replacee is "BFG9000" )
				e.Replacement = "ID24CalamityBlade";
			if ( e.Replacee is "Cell" )
				e.Replacement = "ID24Fuel";
			if ( e.Replacee is "CellPack" )
				e.Replacement = "ID24FuelTank";
		}
	}
	
	void DoBlackroomMapReplacements()
	{
		string mapName = Level.MapName.MakeLower();
		if ( mapName == "e1m7" )
		{
			if ( CVar.FindCVar("wf_map_e1m8b").GetBool() )
				Level.NextMap = "e1m8b";
			else
				Level.NextMap = "e1m8";
		}
		if ( mapName == "e1m3" || mapName == "e1m9" )
		{
			if ( CVar.FindCVar("wf_map_e1m4b").GetBool() )
				Level.NextMap = "e1m4b";
			else
				Level.NextMap = "e1m4";
		}
	}
	
	void RevertKillCounter(WorldEvent e)
	{
		if ( e.Thing && e.Thing.bCountKill )
		{
			e.Thing.bCountKill = false;
			Level.Total_Monsters -= 1;			
		}
	}
}
