//-----------------------------------------------------------------------------
//
// Copyright 1993-2023 id Software, Randy Heit, Christoph Oelckers et.al.
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

extend class WadFusionStatusBar
{
	protected void WadFusionAlternateHUD()
	{
		String mapName = Level.MapName.MakeLower();
		let isDoom1 = mapName.Left(1) == "e" && mapName.Mid(2, 1) == "m";
		let isId1 = mapName.Left(3) == "lr_";
		let id1WeapSwap = CVar.FindCVar("wf_compat_id24_weapons").GetInt() == 1;
		let id1WeapSwapAlways = CVar.FindCVar("wf_compat_id24_weapons").GetInt() >= 2;
		let hudId24 = CVar.FindCVar("wf_hud_id24").GetBool();
		let hudSwapHealthArmor = CVar.FindCVar("wf_hud_swaphealtharmor").GetBool();
		
		let mlRejects = CVar.FindCVar("wf_map_mlr").GetBool();
		String mlMap = mapName.Mid(6);
		let mlCabalMap = mlMap == "19" || mlMap == "37" || mlMap == "38" ||
						 mlMap == "39" || mlMap == "20" || mlMap == "40" ||
						 mlMap == "18" || mlMap == "41" || mlMap == "42" ||
						 mlMap == "10" || mlMap == "43" || mlMap == "21";
		let isCabal = mlRejects && mapName.Left(6) == "ml_map" && mlCabalMap;
		
		int ultraWide = CVar.FindCVar("wf_hud_ultrawide").GetInt();
		if ( CVar.FindCVar("wf_hud_ultrawide_fullscreen").GetBool() && !CVar.FindCVar("vid_fullscreen").GetBool() )
			ultraWide = 0;
		
		int health    = CPlayer.Health;
		int maxHealth = CPlayer.mo.GetMaxHealth(true);
		let armor     = CPlayer.mo.FindInventory("BasicArmor");
		
		let hasBackpack = CPlayer.mo.FindInventory("Backpack");
		let hasBerserk  = CPlayer.mo.FindInventory("PowerStrength");
		
		let hasBlurSphere            = Powerup(CPlayer.mo.FindInventory("PowerInvisibility"));
		let hasInvulnerabilitySphere = Powerup(CPlayer.mo.FindInventory("PowerInvulnerable"));
		let hasInfrared              = Powerup(CPlayer.mo.FindInventory("PowerLightAmp"));
		let hasRadSuit               = Powerup(CPlayer.mo.FindInventory("PowerIronFeet"));
		
		let hasSuperShotgun = CPlayer.mo.FindInventory("SuperShotgun");
		let hasIncinerator  = CPlayer.mo.FindInventory("ID24Incinerator");
		let hasPlasmaRifle  = CPlayer.mo.FindInventory("PlasmaRifle");
		let hasHeatwave     = CPlayer.mo.FindInventory("ID24CalamityBlade");
		let hasBfg9000      = CPlayer.mo.FindInventory("BFG9000");
		
		let replacedSuperShotgun = Actor.GetReplacement("SuperShotgun")      != "SuperShotgun";
		let replacedIncinerator  = Actor.GetReplacement("ID24Incinerator")   != "ID24Incinerator";
		let replacedPlasmaRifle  = Actor.GetReplacement("PlasmaRifle")       != "PlasmaRifle";
		let replacedHeatwave     = Actor.GetReplacement("ID24CalamityBlade") != "ID24CalamityBlade";
		let replacedBfg9000      = Actor.GetReplacement("BFG9000")           != "BFG9000";
		
		let clip   = CPlayer.mo.FindInventory("Clip");
		let shell  = CPlayer.mo.FindInventory("Shell");
		let rocket = CPlayer.mo.FindInventory("RocketAmmo");
		let cell   = CPlayer.mo.FindInventory("Cell");
		let fuel   = CPlayer.mo.FindInventory("ID24Fuel");
		
		int clipLow   = 0;
		int shellLow  = 0;
		int rocketLow = 0;
		int cellLow   = 0;
		int fuelLow   = 0;
		
		if ( clip != null )
			clipLow = clip.MaxAmount / ( hasBackpack ? 8 : 4 );
		if ( shell != null )
			shellLow = shell.MaxAmount / ( hasBackpack ? 8 : 4 );
		if ( rocket != null )
			rocketLow = rocket.MaxAmount / ( hasBackpack ? 8 : 4 );
		if ( cell != null )
			cellLow = cell.MaxAmount / ( hasBackpack ? 8 : 4 );
		if ( fuel != null )
			fuelLow = fuel.MaxAmount / ( hasBackpack ? 8 : 4 );
		
		let altHudMugshot         = CVar.FindCVar("wf_hud_alt_mugshot").GetInt() >= 2;
		let altHudMugshotReplace  = CVar.FindCVar("wf_hud_alt_mugshot").GetInt() == 1;
		let altHudHealth          = CVar.FindCVar("wf_hud_alt_health").GetBool();
		let altHudArmor           = CVar.FindCVar("wf_hud_alt_armor").GetBool();
		let altHudAmmo            = CVar.FindCVar("wf_hud_alt_ammo").GetBool();
		let altHudAmmoInv         = CVar.FindCVar("wf_hud_alt_ammoinv").GetBool();
		let altHudPowerup         = CVar.FindCVar("wf_hud_alt_powerup").GetBool();
		let altHudWeapInv         = CVar.FindCVar("wf_hud_alt_weapinv").GetBool();
		let altHudKeys            = CVar.FindCVar("wf_hud_alt_keys").GetBool();
		let altHudFrags           = CVar.FindCVar("wf_hud_alt_frags").GetBool();
		int altHudStatsKills      = CVar.FindCVar("wf_hud_alt_stats_kills").GetInt() >= 1;
		int altHudStatsKillsNotNm = CVar.FindCVar("wf_hud_alt_stats_kills").GetInt() == 1;
		let altHudStatsItems      = CVar.FindCVar("wf_hud_alt_stats_items").GetBool();
		let altHudStatsSecrets    = CVar.FindCVar("wf_hud_alt_stats_secrets").GetBool();
		let altHudStatsIcons      = CVar.FindCVar("wf_hud_alt_stats_icons").GetBool();
		let altHudInfoTime        = CVar.FindCVar("wf_hud_alt_info_time").GetBool();
		let altHudInfoTotalTime   = CVar.FindCVar("wf_hud_alt_info_totaltime").GetBool();
		let altHudInfoTimeMillis  = CVar.FindCVar("wf_hud_alt_info_timemillis").GetBool();
		let altHudInfoMapName     = CVar.FindCVar("wf_hud_alt_info_mapname").GetBool();
		let altHudInfoMapLabel    = CVar.FindCVar("wf_hud_alt_info_maplabel").GetBool();
		let altHudInfoMapAuthor   = CVar.FindCVar("wf_hud_alt_info_mapauthor").GetBool();
		let altHudInfoSkill       = CVar.FindCVar("wf_hud_alt_info_skill").GetBool();
		let altHudInfoDontOffset  = CVar.FindCVar("wf_hud_alt_info_dontoffset").GetBool();
		
		double healthAlpha  = CVar.FindCVar("wf_hud_alt_alpha_health").GetFloat();
		double ammoAlpha    = CVar.FindCVar("wf_hud_alt_alpha_ammo").GetFloat();
		double ammoInvAlpha = CVar.FindCVar("wf_hud_alt_alpha_ammoinv").GetFloat();
		double powerupAlpha = CVar.FindCVar("wf_hud_alt_alpha_powerup").GetFloat();
		double weapInvAlpha = CVar.FindCVar("wf_hud_alt_alpha_weapinv").GetFloat();
		double keysAlpha    = CVar.FindCVar("wf_hud_alt_alpha_keys").GetFloat();
		double fragsAlpha   = CVar.FindCVar("wf_hud_alt_alpha_frags").GetFloat();
		double statsAlpha   = CVar.FindCVar("wf_hud_alt_alpha_stats").GetFloat();
		double infoAlpha    = CVar.FindCVar("wf_hud_alt_alpha_info").GetFloat();
		
		// Draw health
		int hudHealthYOffset = 0;
		int hudMugshotXOffset = 0;
		
		if ( ( hudSwapHealthArmor || !altHudHealth ) && altHudArmor )
			hudHealthYOffset = 27;
		
		if ( altHudHealth )
		{
			if ( !altHudMugshotReplace )
				DrawImage(hasBerserk ? "PSTRA0" : "MEDIA0", (20 + ultraWide, -10 - hudHealthYOffset), DI_SCREEN_LEFT_BOTTOM, healthAlpha);
			else
				DrawTexture(GetMugShot(5), (3 + ultraWide, -35 - hudHealthYOffset), DI_ITEM_OFFSETS|DI_SCREEN_LEFT_BOTTOM, healthAlpha);
			
			int healthColor =
				health > maxhealth * 2    ? Font.CR_PURPLE :
				health > maxhealth * 1.5  ? Font.CR_BLUE :
				health > maxhealth * 1    ? Font.CR_CYAN :
				health > maxhealth * 0.75 ? Font.CR_GREEN :
				health > maxhealth * 0.5  ? Font.CR_YELLOW :
				health > maxhealth * 0.25 ? Font.CR_ORANGE :
				health > maxhealth * 0    ? Font.CR_RED :
				Font.CR_BLACK;
			
			DrawString(mHUDFont, FormatNumber(health, 1), (40 + ultraWide, -25 - hudHealthYOffset),
					   DI_SCREEN_LEFT_BOTTOM|DI_NOSHADOW, healthColor, healthAlpha);
		}
		
		if ( !altHudHealth && !altHudArmor )
			hudMugshotXOffset = 81;
		
		if ( altHudMugshot )
			DrawTexture(GetMugShot(5), (84 - hudMugshotXOffset + ultraWide, -35), DI_ITEM_OFFSETS|DI_SCREEN_LEFT_BOTTOM, healthAlpha);
		
		// Draw armor
		if ( altHudArmor )
		{
			int armorColor =
				armor.Amount > 200 ? Font.CR_PURPLE :
				armor.Amount > 150 ? Font.CR_BLUE :
				armor.Amount > 100 ? Font.CR_CYAN :
				armor.Amount > 75  ? Font.CR_GREEN :
				armor.Amount > 50  ? Font.CR_YELLOW :
				armor.Amount > 25  ? Font.CR_ORANGE :
				Font.CR_RED;
			
			if ( armor != null && armor.Amount > 0 )
			{
				DrawInventoryIcon(armor, (20 + ultraWide, -37 + hudHealthYOffset), DI_SCREEN_LEFT_BOTTOM, healthAlpha);
				DrawString(mHUDFont, FormatNumber(armor.Amount, 1), (40 + ultraWide, -52 + hudHealthYOffset),
						   DI_SCREEN_LEFT_BOTTOM|DI_NOSHADOW, armorColor, healthAlpha);
			}
		}
		
		// Draw keys
		Vector2 keyInvPos = (-8 - ultraWide, -20);
		int keyInvPosYIncrement = 8;
		int ammoInvPosKeysOffset = 0;
		
		bool locks[6];
		bool hasKeys;
		String keyImage;
		
		for ( int i = 0; i < 6; i++ )
		{
			locks[i] = CPlayer.mo.CheckKeys(i + 1, false, true);
			if ( locks[i] && !hasKeys )
			{
				ammoInvPosKeysOffset += 13;
				hasKeys = true;
			}
		}
		
		if ( !deathmatch && altHudKeys )
		{
			// Blue key
			if ( locks[1] && locks[4] )
				keyImage = "STKEYS6";
			else if ( locks[1] )
				keyImage = "STKEYS0";
			else if ( locks[4] )
				keyImage = "STKEYS3";
			if ( locks[1] || locks[4] )
				DrawImage(keyImage, keyInvPos, DI_SCREEN_RIGHT_BOTTOM, keysAlpha);
			keyInvPos.Y += keyInvPosYIncrement;
			
			// Yellow key
			if ( locks[2] && locks[5] )
				keyImage = "STKEYS7";
			else if ( locks[2] )
				keyImage = "STKEYS1";
			else if ( locks[5] )
				keyImage = "STKEYS4";
			if ( locks[2] || locks[5] )
				DrawImage(keyImage, keyInvPos, DI_SCREEN_RIGHT_BOTTOM, keysAlpha);
			keyInvPos.Y += keyInvPosYIncrement;
			
			// Red key
			if ( locks[0] && locks[3] )
				keyImage = "STKEYS8";
			else if ( locks[0] )
				keyImage = "STKEYS2";
			else if ( locks[3] )
				keyImage = "STKEYS5";
			if ( locks[0] || locks[3] )
				DrawImage(keyImage, keyInvPos, DI_SCREEN_RIGHT_BOTTOM, keysAlpha);
		}
		
		// Draw current ammo
		Inventory ammotype1, ammotype2;
		[ammotype1, ammotype2] = GetCurrentAmmo();
		
		Vector2 ammoInvPos = (-4 - ultraWide, -48);
		int ammoInvPosYIncrement = 8;
		
		if ( altHudAmmo )
		{
			int ammoType1Low = 0;
			int ammoType2Low = 0;
			
			if ( ammotype1 != null )
				ammoType1Low = ammotype1.MaxAmount / ( hasBackpack ? 8 : 4 );
			if ( ammotype2 != null )
				ammoType2Low = ammotype2.MaxAmount / ( hasBackpack ? 8 : 4 );
			
			int invY = -25;
			if ( ammotype1 != null )
			{
				DrawInventoryIcon(ammotype1, (-14 - ammoInvPosKeysOffset - ultraWide, -10), DI_SCREEN_RIGHT_BOTTOM, ammoAlpha);
				DrawString(mHUDFont, FormatNumber(ammotype1.Amount, 1), (-30 - ammoInvPosKeysOffset - ultraWide, -25),
						   DI_SCREEN_RIGHT_BOTTOM|DI_TEXT_ALIGN_RIGHT|DI_NOSHADOW,
						   ammotype1.Amount > 0 ? ( ammotype1.Amount > ammoType1Low ? Font.CR_WHITE : Font.CR_RED ) : Font.CR_BLACK, ammoAlpha);
				invY -= 27;
			}
			
			if ( ammotype2 != null && ammotype2 != ammotype1 )
			{
				DrawInventoryIcon(ammotype2, (-14 - ammoInvPosKeysOffset - ultraWide, invY + 15), DI_SCREEN_RIGHT_BOTTOM, ammoAlpha);
				DrawString(mHUDFont, FormatNumber(ammotype2.Amount, 1), (-30 - ammoInvPosKeysOffset - ultraWide, invY),
						   DI_SCREEN_RIGHT_BOTTOM|DI_TEXT_ALIGN_RIGHT|DI_NOSHADOW,
						   ammotype2.Amount > 0 ? ( ammotype2.Amount > ammoType2Low ? Font.CR_WHITE : Font.CR_RED ) : Font.CR_BLACK, ammoAlpha);
				invY -= 27;
				ammoInvPos.Y -= 27;
			}
			
			if ( !isInventoryBarVisible() && !Level.NoInventoryBar && CPlayer.mo.InvSel != null )
			{
				DrawInventoryIcon(CPlayer.mo.InvSel, (-14 - ultraWide, invY + 15), DI_DIMDEPLETED|DI_SCREEN_RIGHT_BOTTOM, ammoAlpha);
				DrawString(mHUDFont, FormatNumber(CPlayer.mo.InvSel.Amount, 1), (-30 - ultraWide, invY),
						   DI_SCREEN_RIGHT_BOTTOM|DI_TEXT_ALIGN_RIGHT|DI_NOSHADOW, Font.CR_WHITE, ammoAlpha);
				ammoInvPos.Y -= 27;
			}
			
			if ( isInventoryBarVisible() )
				DrawInventoryBar(diparms, (0, 0), 7, DI_SCREEN_CENTER_BOTTOM, HX_SHADOW);
		}
		
		// Draw ammo pool
		if ( altHudAmmoInv )
		{
			String backpackColor  = hasBackpack ? "\cf" : "\cj";
			String ammoBulletsStr = backpackColor..StringTable.Localize("$WF_HUD_AMMO_BULLETS");
			String ammoShellsStr  = backpackColor..StringTable.Localize("$WF_HUD_AMMO_SHELLS");
			String ammoRocketsStr = backpackColor..StringTable.Localize("$WF_HUD_AMMO_ROCKETS");
			String ammoCellsStr   = backpackColor..StringTable.Localize("$WF_HUD_AMMO_CELLS");
			String ammoFuelStr    = backpackColor..StringTable.Localize("$WF_HUD_AMMO_FUEL");
			
			int clipAmount   = clip   != null ? clip.Amount   : 0;
			int shellAmount  = shell  != null ? shell.Amount  : 0;
			int rocketAmount = rocket != null ? rocket.Amount : 0;
			int cellAmount   = cell   != null ? cell.Amount   : 0;
			int fuelAmount   = fuel   != null ? fuel.Amount   : 0;
			
			String clipColor   = clipAmount   > 0 ? ( clipAmount   > clipLow   ? "\cj" : "\cg" ) : "\cm";
			String shellColor  = shellAmount  > 0 ? ( shellAmount  > shellLow  ? "\cj" : "\cg" ) : "\cm";
			String rocketColor = rocketAmount > 0 ? ( rocketAmount > rocketLow ? "\cj" : "\cg" ) : "\cm";
			String cellColor   = cellAmount   > 0 ? ( cellAmount   > cellLow   ? "\cj" : "\cg" ) : "\cm";
			String fuelColor   = fuelAmount   > 0 ? ( fuelAmount   > fuelLow   ? "\cj" : "\cg" ) : "\cm";
			
			String clipAmountStr   = clipColor  ..String.Format("%03d", clipAmount);
			String shellAmountStr  = shellColor ..String.Format("%03d", shellAmount);
			String rocketAmountStr = rocketColor..String.Format("%03d", rocketAmount);
			String cellAmountStr   = cellColor  ..String.Format("%03d", cellAmount);
			String fuelAmountStr   = fuelColor  ..String.Format("%03d", fuelAmount);
			
			String ammoClipInv   = ammoBulletsStr.." "..clipAmountStr;
			String ammoShellInv  = ammoShellsStr .." "..shellAmountStr;
			String ammoRocketInv = ammoRocketsStr.." "..rocketAmountStr;
			String ammoCellInv   = ammoCellsStr  .." "..cellAmountStr;
			String ammoFuelInv   = ammoFuelStr   .." "..fuelAmountStr;
			
			if ( fuel != null && ammotype1 != fuel )
			{
				if ( ( isId1 && id1WeapSwap ) || ( hasIncinerator || hasHeatwave ) || hudId24 || id1WeapSwapAlways )
				{
					DrawString(mConFont, ammoFuelInv, ammoInvPos, DI_SCREEN_RIGHT_BOTTOM|DI_TEXT_ALIGN_RIGHT, Font.CR_WHITE, ammoInvAlpha);
					ammoInvPos.Y -= ammoInvPosYIncrement;
				}
			}
			
			if ( cell != null && ammotype1 != cell )
			{
				if ( !( isId1 && id1WeapSwap ) || ( hasPlasmaRifle || hasBfg9000 ) || hudId24 )
				{
					if ( !( id1WeapSwapAlways && !( hasPlasmaRifle || hasBfg9000 ) ) )
					{
						DrawString(mConFont, ammoCellInv, ammoInvPos, DI_SCREEN_RIGHT_BOTTOM|DI_TEXT_ALIGN_RIGHT, Font.CR_WHITE, ammoInvAlpha);
						ammoInvPos.Y -= ammoInvPosYIncrement;
					}
				}
			}
			
			if ( rocket != null && ammotype1 != rocket )
			{
				DrawString(mConFont, ammoRocketInv, ammoInvPos, DI_SCREEN_RIGHT_BOTTOM|DI_TEXT_ALIGN_RIGHT, Font.CR_WHITE, ammoInvAlpha);
				ammoInvPos.Y -= ammoInvPosYIncrement;
			}
			
			if ( shell != null && ammotype1 != shell )
			{
				DrawString(mConFont, ammoShellInv, ammoInvPos, DI_SCREEN_RIGHT_BOTTOM|DI_TEXT_ALIGN_RIGHT, Font.CR_WHITE, ammoInvAlpha);
				ammoInvPos.Y -= ammoInvPosYIncrement;
			}
			
			if ( clip != null && ammotype1 != clip )
			{
				DrawString(mConFont, ammoClipInv, ammoInvPos, DI_SCREEN_RIGHT_BOTTOM|DI_TEXT_ALIGN_RIGHT, Font.CR_WHITE, ammoInvAlpha);
				ammoInvPos.Y -= ammoInvPosYIncrement;
			}
		}
		
		// Draw powerups
		Vector2 powerupPos = (-18 - ultraWide, -4 + ammoInvPos.Y);
		int powerupPosYIncrement = 30;
		int powerupCount = 0;
		
		if ( altHudPowerup )
		{
			if ( hasBlurSphere != null )
			{
				int blurSphereTime = int(Ceil(double(hasBlurSphere.EffectTics) / GameTicRate));
				DrawImage("PINSAHUD", powerupPos, DI_SCREEN_RIGHT_BOTTOM, powerupAlpha);
				DrawString(mConFont, FormatNumber(blurSphereTime, 1), (powerupPos.X, powerupPos.Y - 8),
						   DI_SCREEN_RIGHT_BOTTOM|DI_TEXT_ALIGN_CENTER,
						   blurSphereTime > 4 ? Font.CR_WHITE : Font.CR_DARKRED, powerupAlpha);
				powerupPos.Y -= powerupPosYIncrement;
				powerupCount++;
			}
			
			if ( hasInvulnerabilitySphere != null )
			{
				int invulnerabilitySphereTime = int(Ceil(double(hasInvulnerabilitySphere.EffectTics) / GameTicRate));
				DrawImage("PINVAHUD", powerupPos, DI_SCREEN_RIGHT_BOTTOM, powerupAlpha);
				DrawString(mConFont, FormatNumber(invulnerabilitySphereTime, 1), (powerupPos.X, powerupPos.Y - 8),
						   DI_SCREEN_RIGHT_BOTTOM|DI_TEXT_ALIGN_CENTER,
						   invulnerabilitySphereTime > 4 ? Font.CR_WHITE : Font.CR_DARKRED, powerupAlpha);
				powerupPos.Y -= powerupPosYIncrement;
				powerupCount++;
			}
			
			if ( hasInfrared != null )
			{
				int infraredTime = int(Ceil(double(hasInfrared.EffectTics) / GameTicRate));
				DrawImage("PVISAHUD", powerupPos, DI_SCREEN_RIGHT_BOTTOM, powerupAlpha);
				DrawString(mConFont, FormatNumber(infraredTime, 1), (powerupPos.X, powerupPos.Y - 8),
						   DI_SCREEN_RIGHT_BOTTOM|DI_TEXT_ALIGN_CENTER,
						   infraredTime > 4 ? Font.CR_WHITE : Font.CR_DARKRED, powerupAlpha);
				powerupPos.Y -= powerupPosYIncrement;
				powerupCount++;
			}
			
			if ( hasRadSuit != null )
			{
				int radSuitTime = int(Ceil(double(hasRadSuit.EffectTics) / GameTicRate));
				if ( hasInfrared )
					powerupPos.Y += 12;
				DrawImage("SUITA0", powerupPos, DI_SCREEN_RIGHT_BOTTOM, powerupAlpha);
				DrawString(mConFont, FormatNumber(radSuitTime, 1), (powerupPos.X, powerupPos.Y - 8),
						   DI_SCREEN_RIGHT_BOTTOM|DI_TEXT_ALIGN_CENTER,
						   radSuitTime > 4 ? Font.CR_WHITE : Font.CR_DARKRED, powerupAlpha);
				powerupPos.Y -= powerupPosYIncrement;
				powerupCount++;
			}
		}
		
		// Draw weapon slots
		Vector2 weapInvPos = (-17 - ammoInvPosKeysOffset - ultraWide, -8);
		int weapInvPosXIncrement = 5;
		
		if ( altHudWeapInv )
		{
			for ( int i = 10; i > 0; i-- )
			{
				int slot = i;
				
				if ( i == 10 )
					slot = 0;
				
				String slotStr = String.Format("%d", slot);
				
				for ( int j = CPlayer.Weapons.SlotSize(slot); j >= 0; j-- )
				{
					let getWeaponSlot      = CPlayer.Weapons.GetWeapon(slot, j);
					let slotFistBerserk    = getWeaponSlot == "Fist" && hasBerserk;
					let slotSuperShotgun   = getWeaponSlot == "SuperShotgun";
					let slotIncinerator    = getWeaponSlot == "ID24Incinerator";
					let slotPlasmaRifle    = getWeaponSlot == "PlasmaRifle";
					let slotHeatwave       = getWeaponSlot == "ID24CalamityBlade";
					let slotBfg9000        = getWeaponSlot == "BFG9000";
					let weaponSlotReplaced = getWeaponSlot != null && Actor.GetReplacee(getWeaponSlot) != getWeaponSlot;
					
					let weapReady        = CPlayer.ReadyWeapon;
					let weapInvReady     = weapReady != null && getWeaponSlot == weapReady.GetClassName();
					let weapInvColor     = slotFistBerserk ? Font.CR_RED : ( weapInvReady ? Font.CR_GOLD : Font.CR_WHITE);
					let weapInvAlphaType = weapInvReady ? weapInvAlpha : weapInvAlpha * 0.2;
					
					if ( CPlayer.mo.FindInventory(getWeaponSlot) )
						DrawString(mIndexFont, slotStr, weapInvPos, DI_SCREEN_RIGHT_BOTTOM, weapInvColor, weapInvAlphaType);
					
					if ( j > 0 && !weaponSlotReplaced )
						weapInvPos.X -= weapInvPosXIncrement;
					
					if ( slotSuperShotgun && ( isDoom1 && !hasSuperShotgun ) && !replacedSuperShotgun )
						weapInvPos.X += weapInvPosXIncrement;
					
					if ( !hudId24 )
					{
						if ( ( slotIncinerator && ( !isId1 && !hasIncinerator ) && !replacedIncinerator ) ||
							 ( slotPlasmaRifle && ( isId1 && !hasPlasmaRifle ) && !replacedPlasmaRifle ) ||
							 ( slotHeatwave && ( !isId1 && !hasHeatwave ) && !replacedHeatwave ) ||
							 ( slotBfg9000 && ( isId1 && !hasBfg9000 ) && !replacedBfg9000 ) )
						{
							weapInvPos.X += weapInvPosXIncrement;
						}
					}
				}
			}
		}
		
		// Draw stats
		Vector2 statsPos = (4 + ultraWide, -72);
		int statsPosYIncrement = altHudStatsIcons ? 12 : 9;
		
		if ( deathmatch && altHudFrags )
		{
			DrawImage("M_SKULL2", (20 + ultraWide, -64), DI_SCREEN_LEFT_BOTTOM, fragsAlpha);
			DrawString(mHUDFont, FormatNumber(CPlayer.FragCount, 1), (40 + ultraWide, -79),
					   DI_SCREEN_LEFT_BOTTOM|DI_NOSHADOW, Font.CR_WHITE, fragsAlpha);
		}
		else if ( !deathmatch )
		{
			if ( altHudStatsSecrets )
			{
				int mapSectersFound = Level.Found_Secrets;
				int mapSectersTotal = Level.Total_Secrets;
				String secretsStr = StringTable.Localize("$WF_HUD_STATS_SECRETS");
				String mapSecrets = mapSectersFound.."/"..mapSectersTotal;
				let mapSecrets100 = mapSectersFound == mapSectersTotal;
				if ( altHudStatsIcons )
					DrawImage("SECRETS", (statsPos.X + 4, statsPos.Y + 8), DI_SCREEN_LEFT_BOTTOM, statsAlpha);
				else
					DrawString(mSmallFontMono, secretsStr..":", statsPos, DI_SCREEN_LEFT_BOTTOM, Font.CR_RED, statsAlpha);
				DrawString(mSmallFont, mapSecrets, (statsPos.X + 16, statsPos.Y),
						   DI_SCREEN_LEFT_BOTTOM, mapSecrets100 ? Font.CR_GOLD : Font.CR_GREEN, statsAlpha);
				statsPos.Y -= statsPosYIncrement;
			}
			
			if ( altHudStatsItems )
			{
				int mapItemsFound = Level.Found_Items;
				int mapItemsTotal = Level.Total_Items;
				String itemsStr = StringTable.Localize("$WF_HUD_STATS_ITEMS");
				String mapItems = mapItemsFound.."/"..mapItemsTotal;
				let mapItems100 = mapItemsFound == mapItemsTotal;
				if ( altHudStatsIcons )
					DrawImage("ITEMS", (statsPos.X + 4, statsPos.Y + 8), DI_SCREEN_LEFT_BOTTOM, statsAlpha);
				else
					DrawString(mSmallFontMono, itemsStr..":", statsPos, DI_SCREEN_LEFT_BOTTOM, Font.CR_RED, statsAlpha);
				DrawString(mSmallFont, mapItems, (statsPos.X + 16, statsPos.Y),
						   DI_SCREEN_LEFT_BOTTOM, mapItems100 ? Font.CR_GOLD : Font.CR_GREEN, statsAlpha);
				statsPos.Y -= statsPosYIncrement;
			}
			
			if ( altHudStatsKills )
			{
				if ( !altHudStatsKillsNotNm || skill != 4 )
				{
					int mapMonstersKilled = Level.Killed_Monsters;
					int mapMonstersTotal = Level.Total_Monsters;
					String monstersStr = StringTable.Localize("$WF_HUD_STATS_MONSTERS");
					String mapMonsters = mapMonstersKilled.."/"..mapMonstersTotal;
					let mapMonsters100 = mapMonstersKilled == mapMonstersTotal;
					if ( altHudStatsIcons )
						DrawImage("KILLS", (statsPos.X + 4, statsPos.Y + 8), DI_SCREEN_LEFT_BOTTOM, statsAlpha);
					else
						DrawString(mSmallFontMono, monstersStr..":", statsPos, DI_SCREEN_LEFT_BOTTOM, Font.CR_RED, statsAlpha);
					DrawString(mSmallFont, mapMonsters, (statsPos.X + 16, statsPos.Y),
							   DI_SCREEN_LEFT_BOTTOM, mapMonsters100 ? Font.CR_GOLD : Font.CR_GREEN, statsAlpha);
					statsPos.Y -= statsPosYIncrement;
				}
			}
		}
		
		// Draw time
		int infoOffset = 0;
		
		if ( !altHudInfoDontOffset )
			infoOffset = ultraWide;
		
		Vector2 infoPos = (-4 - infoOffset, 0);
		int infoPosYIncrement = 9;
		
		if ( altHudInfoTime )
		{
			int timeTicks = Level.Time;
			int timeSeconds = Thinker.Tics2Seconds(timeTicks);
			int hours   =  timeSeconds / 3600;
			int minutes = (timeSeconds % 3600) / 60;
			int seconds =  timeSeconds % 60;
			int millis  = (timeTicks % GameTicRate) * 1000 / GameTicRate;
			String timeString = String.Format("%02i:%02i:%02i", hours, minutes, seconds);
			String timeMillisString = String.Format(timeString..".%03i", millis);
			let mapParTime = ( timeSeconds < Level.ParTime ) && Level.ParTime > 0;
			DrawString(mSmallFontMono, altHudInfoTimeMillis ? timeMillisString : timeString, infoPos,
					   DI_SCREEN_RIGHT_TOP|DI_TEXT_ALIGN_RIGHT, mapParTime ? Font.CR_GOLD : Font.CR_WHITE, infoAlpha);
			infoPos.Y += infoPosYIncrement;
		}
		
		// Draw total time
		if ( altHudInfoTotalTime )
		{
			int timeTicks = Level.TotalTime;
			int timeSeconds = Thinker.Tics2Seconds(timeTicks);
			int hours   =  timeSeconds / 3600;
			int minutes = (timeSeconds % 3600) / 60;
			int seconds =  timeSeconds % 60;
			int millis  = (timeTicks % GameTicRate) * 1000 / GameTicRate;
			String timeString = String.Format("%02i:%02i:%02i", hours, minutes, seconds);
			String timeMillisString = String.Format(timeString..".%03i", millis);
			DrawString(mSmallFontMono, altHudInfoTimeMillis ? timeMillisString : timeString, infoPos,
					   DI_SCREEN_RIGHT_TOP|DI_TEXT_ALIGN_RIGHT, Font.CR_WHITE, infoAlpha);
			infoPos.Y += infoPosYIncrement;
		}
		
		// Draw map name
		if ( altHudInfoMapLabel && altHudInfoMapName )
		{
			String mapFullName = Level.MapName..": \cj"..Level.LevelName;
			DrawString(mSmallFont, mapFullName, infoPos, DI_SCREEN_RIGHT_TOP|DI_TEXT_ALIGN_RIGHT, Font.CR_RED, infoAlpha);
		}
		else if ( altHudInfoMapLabel )
			DrawString(mSmallFont, Level.MapName, infoPos, DI_SCREEN_RIGHT_TOP|DI_TEXT_ALIGN_RIGHT, Font.CR_RED, infoAlpha);
		else if ( altHudInfoMapName )
			DrawString(mSmallFont, Level.LevelName, infoPos, DI_SCREEN_RIGHT_TOP|DI_TEXT_ALIGN_RIGHT, Font.CR_WHITE, infoAlpha);
		
		if ( altHudInfoMapLabel || altHudInfoMapName )
			infoPos.Y += infoPosYIncrement;
		
		// Draw map author name
		if ( altHudInfoMapAuthor )
		{
			String mapAuthorName = StringTable.Localize(Level.AuthorName);
			DrawString(mSmallFont, mapAuthorName, infoPos, DI_SCREEN_RIGHT_TOP|DI_TEXT_ALIGN_RIGHT, Font.CR_WHITE, infoAlpha);
			infoPos.Y += infoPosYIncrement;
		}
		
		// Draw skill
		if ( !deathmatch && altHudInfoSkill )
		{
			String skillStr = StringTable.Localize("$WF_HUD_STATS_SKILL");
			String skillName = "";
			
			switch ( skill )
			{
				case 0:
					skillName = StringTable.Localize("$SKILL_BABY");
					break;
				case 1:
					skillName = isCabal ? StringTable.Localize("$SKILL_NORMAL") : StringTable.Localize("$SKILL_EASY");
					break;
				case 2:
					skillName = isCabal ? StringTable.Localize("$SKILL_HARD") : StringTable.Localize("$SKILL_NORMAL");
					break;
				case 3:
					skillName = isCabal ? StringTable.Localize("$WF_SKILL_CARNAGE") : StringTable.Localize("$SKILL_HARD");
					break;
				case 4:
					skillName = StringTable.Localize("$SKILL_NIGHTMARE");
					break;
				default:
					skillName = String.Format("%s %i", skillStr, skill);
					break;
			}
			
			DrawString(mSmallFont, skillName, infoPos, DI_SCREEN_RIGHT_TOP|DI_TEXT_ALIGN_RIGHT, Font.CR_WHITE, infoAlpha);
			infoPos.Y += infoPosYIncrement;
		}
	}
}
