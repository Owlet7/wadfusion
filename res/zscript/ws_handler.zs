
class WadSmooshHandler : EventHandler
{
    void DoFinalDoomTextureReplacements()
    {
        String mapPrefix = level.MapName.Left(3);
        mapPrefix = mapPrefix.MakeLower();
        if ( mapPrefix == "tn_" )
        {
            Level.ReplaceTextures("SKY1", "TSKY1", 0);        // different from doom1
            Level.ReplaceTextures("SKY2", "TSKY2", 0);        // different from doom1
            Level.ReplaceTextures("SKY3", "TSKY3", 0);        // different from doom1
            Level.ReplaceTextures("SW1GSTON", "SW1GSTNT", 0); // different from doom2
            Level.ReplaceTextures("SW2GSTON", "SW2GSTNT", 0); // different from doom2
            Level.ReplaceTextures("SW1SKULL", "SW1SKULT", 0); // different from doom2
            Level.ReplaceTextures("SW2SKULL", "SW2SKULT", 0); // different from doom2
            Level.ReplaceTextures("SLADRIP1", "SLADRPT1", 0); // different from doom1
            Level.ReplaceTextures("SLADRIP3", "SLADRPT3", 0); // different from doom1
            Level.ReplaceTextures("BLODGR1", "BLODGRT1", 0);  // different from doom1
            Level.ReplaceTextures("BLODGR4", "BLODGRT4", 0);  // different from doom1
            Level.ReplaceTextures("WFALL1", "TWFALL1", 0);    // different from plutonia
            Level.ReplaceTextures("WFALL4", "TWFALL4", 0);    // different from plutonia
        }
        else if ( mapPrefix == "pl_" )
        {
            Level.ReplaceTextures("DBRAIN1", "PBRAIN1", 0);   // different from doom2
            Level.ReplaceTextures("DBRAIN4", "PBRAIN4", 0);   // different from doom2
            Level.ReplaceTextures("FIREBLU1", "FIREPLU1", 0); // different from doom2
            Level.ReplaceTextures("FIREBLU2", "FIREPLU2", 0); // different from doom2
            Level.ReplaceTextures("SKY1", "PSKY1", 0);        // different from doom1
            Level.ReplaceTextures("SKY2", "PSKY2", 0);        // different from doom1
            Level.ReplaceTextures("SKY3", "PSKY3", 0);        // different from doom1
            Level.ReplaceTextures("SW1SKULL", "SW1SKULP", 0); // different from doom2
            Level.ReplaceTextures("SW2SKULL", "SW2SKULP", 0); // different from doom2
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
            if ( CVar.FindCVar("ws_s2_spiderboss").GetBool() && e.Thing )
            {
				if ( e.Thing.GetClassName() == "SpiderMastermind" )
				{
					e.Thing.Health = 9000;
				}
            }
        }
    }
}
