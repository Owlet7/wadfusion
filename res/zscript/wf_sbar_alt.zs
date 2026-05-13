//-----------------------------------------------------------------------------
//
// Copyright 2024-2026 Owlet VII
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
		let id1WeapSwap        = CVar.FindCVar("wf_compat_id24_weapons").GetInt() == 1;
		let id1WeapSwapAlways  = CVar.FindCVar("wf_compat_id24_weapons").GetInt() >= 2;
		
		let hudId24            = CVar.FindCVar("wf_hud_id24").GetBool();
		let hudSwapHealthArmor = CVar.FindCVar("wf_hud_swaphealtharmor").GetBool();
		
		int ultraWide = CVar.FindCVar("wf_hud_ultrawide").GetInt();
		if ( CVar.FindCVar("wf_hud_ultrawide_fullscreen").GetBool() && !CVar.FindCVar("vid_fullscreen").GetBool() )
			ultraWide = 0;
		
		let altHUDMugshot         = CVar.FindCVar("wf_hud_alt_mugshot").GetInt() >= 2;
		let altHUDMugshotReplace  = CVar.FindCVar("wf_hud_alt_mugshot").GetInt() == 1;
		let altHUDHealth          = CVar.FindCVar("wf_hud_alt_health").GetBool();
		let altHUDArmor           = CVar.FindCVar("wf_hud_alt_armor").GetBool();
		let altHUDAmmo            = CVar.FindCVar("wf_hud_alt_ammo").GetBool();
		let altHUDAmmoInv         = CVar.FindCVar("wf_hud_alt_ammoinv").GetBool();
		let altHUDPowerup         = CVar.FindCVar("wf_hud_alt_powerup").GetBool();
		let altHUDWeapInv         = CVar.FindCVar("wf_hud_alt_weapinv").GetBool();
		let altHUDKeys            = CVar.FindCVar("wf_hud_alt_keys").GetBool();
		let altHUDFrags           = CVar.FindCVar("wf_hud_alt_frags").GetBool();
		let altHUDStatsKills      = CVar.FindCVar("wf_hud_alt_stats_kills").GetInt() >= 1;
		let altHUDStatsKillsNotNm = CVar.FindCVar("wf_hud_alt_stats_kills").GetInt() == 1;
		let altHUDStatsItems      = CVar.FindCVar("wf_hud_alt_stats_items").GetBool();
		let altHUDStatsSecrets    = CVar.FindCVar("wf_hud_alt_stats_secrets").GetBool();
		let altHUDStatsIcons      = CVar.FindCVar("wf_hud_alt_stats_icons").GetBool();
		let altHUDInfoTime        = CVar.FindCVar("wf_hud_alt_info_time").GetBool();
		let altHUDInfoTotalTime   = CVar.FindCVar("wf_hud_alt_info_totaltime").GetBool();
		let altHUDInfoTimeMillis  = CVar.FindCVar("wf_hud_alt_info_timemillis").GetBool();
		let altHUDInfoMapName     = CVar.FindCVar("wf_hud_alt_info_mapname").GetBool();
		let altHUDInfoMapLabel    = CVar.FindCVar("wf_hud_alt_info_maplabel").GetBool();
		let altHUDInfoMapAuthor   = CVar.FindCVar("wf_hud_alt_info_mapauthor").GetBool();
		let altHUDInfoSkill       = CVar.FindCVar("wf_hud_alt_info_skill").GetBool();
		let altHUDInfoDontOffset  = CVar.FindCVar("wf_hud_alt_info_dontoffset").GetBool();
		
		double healthAlpha  = CVar.FindCVar("wf_hud_alt_alpha_health").GetFloat();
		double ammoAlpha    = CVar.FindCVar("wf_hud_alt_alpha_ammo").GetFloat();
		double ammoInvAlpha = CVar.FindCVar("wf_hud_alt_alpha_ammoinv").GetFloat();
		double powerupAlpha = CVar.FindCVar("wf_hud_alt_alpha_powerup").GetFloat();
		double weapInvAlpha = CVar.FindCVar("wf_hud_alt_alpha_weapinv").GetFloat();
		double keysAlpha    = CVar.FindCVar("wf_hud_alt_alpha_keys").GetFloat();
		double fragsAlpha   = CVar.FindCVar("wf_hud_alt_alpha_frags").GetFloat();
		double statsAlpha   = CVar.FindCVar("wf_hud_alt_alpha_stats").GetFloat();
		double infoAlpha    = CVar.FindCVar("wf_hud_alt_alpha_info").GetFloat();
		
		String mapName = Level.MapName.MakeLower();
		
		// Draw health
		int hudHealthYOffset = 0;
		
		if ( ( hudSwapHealthArmor || !altHUDHealth ) && altHUDArmor )
			hudHealthYOffset = 27;
		
		let hasBerserk = CPlayer.mo.FindInventory("PowerStrength");
		
		if ( altHUDHealth )
		{
			int health = CPlayer.Health;
			
			if ( !altHUDMugshotReplace )
				DrawImage(hasBerserk ? "PSTRA0" : "MEDIA0", (20 + ultraWide, -10 - hudHealthYOffset), DI_SCREEN_LEFT_BOTTOM, healthAlpha);
			else
				DrawTexture(GetMugShot(5), (3 + ultraWide, -35 - hudHealthYOffset), DI_ITEM_OFFSETS|DI_SCREEN_LEFT_BOTTOM, healthAlpha);
			
			DrawString(mHUDFont, FormatNumber(health, 1), (40 + ultraWide, -25 - hudHealthYOffset),
					   DI_SCREEN_LEFT_BOTTOM|DI_NOSHADOW, GetHealthColor(), healthAlpha);
		}
		
		// Draw armor
		if ( altHUDArmor )
		{
			let armor = CPlayer.mo.FindInventory("BasicArmor");
			
			if ( armor != null && armor.Amount > 0 )
			{
				DrawInventoryIcon(armor, (20 + ultraWide, -37 + hudHealthYOffset), DI_SCREEN_LEFT_BOTTOM, healthAlpha);
				DrawString(mHUDFont, FormatNumber(armor.Amount, 1), (40 + ultraWide, -52 + hudHealthYOffset),
						   DI_SCREEN_LEFT_BOTTOM|DI_NOSHADOW, GetArmorColor(), healthAlpha);
			}
		}
		
		// Draw mugshot
		if ( altHUDMugshot )
		{
			int hudMugshotXOffset = 0;
			
			if ( !altHUDHealth && !altHUDArmor )
				hudMugshotXOffset = 81;
			
			DrawTexture(GetMugShot(5), (84 - hudMugshotXOffset + ultraWide, -35), DI_ITEM_OFFSETS|DI_SCREEN_LEFT_BOTTOM, healthAlpha);
		}
		
		// Draw keys
		bool locks[6];
		
		for ( int i = 0; i < 6; i++ )
			locks[i] = CPlayer.mo.CheckKeys(i + 1, false, true);
		
		if ( !deathmatch && altHUDKeys )
		{
			Vector2 keyInvPos = (-84 - ultraWide, -25);
			int keyInvPosYIncrement = 8;
			
			String keyImage = "";
			
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
		
		// Draw weapon slots
		let hasIncinerator  = CPlayer.mo.FindInventory("ID24Incinerator");
		let hasPlasmaRifle  = CPlayer.mo.FindInventory("PlasmaRifle");
		let hasHeatwave     = CPlayer.mo.FindInventory("ID24CalamityBlade");
		let hasBfg9000      = CPlayer.mo.FindInventory("BFG9000");
		let isId1           = mapName.Left(3) == "lr_";
		
		if ( altHUDWeapInv )
		{
			Vector2 weapInvPos = (-3 - ultraWide, -8);
			int weapInvPosXIncrement = 5;
			
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
					
					let replacedSuperShotgun = Actor.GetReplacement("SuperShotgun")      != "SuperShotgun";
					let replacedIncinerator  = Actor.GetReplacement("ID24Incinerator")   != "ID24Incinerator";
					let replacedPlasmaRifle  = Actor.GetReplacement("PlasmaRifle")       != "PlasmaRifle";
					let replacedHeatwave     = Actor.GetReplacement("ID24CalamityBlade") != "ID24CalamityBlade";
					let replacedBfg9000      = Actor.GetReplacement("BFG9000")           != "BFG9000";
					
					let weapReady        = CPlayer.ReadyWeapon;
					let weapInvReady     = weapReady != null && getWeaponSlot == weapReady.GetClassName();
					let weapInvColor     = slotFistBerserk ? Font.CR_RED : ( weapInvReady ? Font.CR_GOLD : Font.CR_WHITE);
					let weapInvAlphaType = weapInvReady ? weapInvAlpha : weapInvAlpha * 0.2;
					
					let hasSuperShotgun = CPlayer.mo.FindInventory("SuperShotgun");
					let isDoom1         = mapName.Left(1) == "e" && mapName.Mid(2, 1) == "m";
					
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
		
		// Draw current ammo
		Vector2 ammoInvPos = (-4 - ultraWide, -21);
		
		Inventory ammotype1, ammotype2;
		[ammotype1, ammotype2] = GetCurrentAmmo();
		
		if ( altHUDAmmo )
		{
			int invY = -25;
			
			let showInvSel = !isInventoryBarVisible() && !Level.NoInventoryBar && CPlayer.mo.InvSel != null;
			
			if ( ammotype1 == null && ammotype2 == null && !showInvSel )
			{
				ammoInvPos.Y -= 10;
			}
			
			if ( ammotype1 != null )
			{
				DrawInventoryIcon(ammotype1, (-14 - ultraWide, -10), DI_SCREEN_RIGHT_BOTTOM, ammoAlpha);
				DrawString(mHUDFont, FormatNumber(ammotype1.Amount, 1), (-30 - ultraWide, -25),
						   DI_SCREEN_RIGHT_BOTTOM|DI_TEXT_ALIGN_RIGHT|DI_NOSHADOW, GetAmmoColor(0), ammoAlpha);
				invY -= 27;
				ammoInvPos.Y -= 27;
			}
			
			if ( ammotype2 != null && ammotype2 != ammotype1 )
			{
				DrawInventoryIcon(ammotype2, (-14 - ultraWide, invY + 15), DI_SCREEN_RIGHT_BOTTOM, ammoAlpha);
				DrawString(mHUDFont, FormatNumber(ammotype2.Amount, 1), (-30 - ultraWide, invY),
						   DI_SCREEN_RIGHT_BOTTOM|DI_TEXT_ALIGN_RIGHT|DI_NOSHADOW, GetAmmoColor(1), ammoAlpha);
				invY -= 27;
				ammoInvPos.Y -= 27;
			}
			
			if ( showInvSel )
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
		if ( altHUDAmmoInv )
		{
			int ammoInvPosYIncrement = 8;
			
			let hasBackpack = CPlayer.mo.FindInventory("Backpack");
			
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
			
			int clipAmount   = clip   != null ? clip.Amount   : 0;
			int shellAmount  = shell  != null ? shell.Amount  : 0;
			int rocketAmount = rocket != null ? rocket.Amount : 0;
			int cellAmount   = cell   != null ? cell.Amount   : 0;
			int fuelAmount   = fuel   != null ? fuel.Amount   : 0;
			
			String clipColor   = GetAmmoBarColor("Clip");
			String shellColor  = GetAmmoBarColor("Shell");
			String rocketColor = GetAmmoBarColor("RocketAmmo");
			String cellColor   = GetAmmoBarColor("Cell");
			String fuelColor   = GetAmmoBarColor("ID24Fuel");
			
			String clipAmountStr   = clipColor  ..String.Format("%03d", clipAmount);
			String shellAmountStr  = shellColor ..String.Format("%03d", shellAmount);
			String rocketAmountStr = rocketColor..String.Format("%03d", rocketAmount);
			String cellAmountStr   = cellColor  ..String.Format("%03d", cellAmount);
			String fuelAmountStr   = fuelColor  ..String.Format("%03d", fuelAmount);
			
			String backpackColor  = hasBackpack ? "\cf" : "\cj";
			String ammoBulletsStr = backpackColor..StringTable.Localize("$WF_HUD_AMMO_BULLETS");
			String ammoShellsStr  = backpackColor..StringTable.Localize("$WF_HUD_AMMO_SHELLS");
			String ammoRocketsStr = backpackColor..StringTable.Localize("$WF_HUD_AMMO_ROCKETS");
			String ammoCellsStr   = backpackColor..StringTable.Localize("$WF_HUD_AMMO_CELLS");
			String ammoFuelStr    = backpackColor..StringTable.Localize("$WF_HUD_AMMO_FUEL");
			
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
		if ( altHUDPowerup )
		{
			Vector2 powerupPos = (-18 - ultraWide, -4 + ammoInvPos.Y);
			int powerupPosYIncrement = 30;
			
			String arrayPowerup[4] = { "PowerInvisibility", "PowerInvulnerable", "PowerLightAmp", "PowerIronFeet" };
			String arrayPowerupImage[4] = { "PINSAHUD", "PINVAHUD", "PVISAHUD", "SUITA0" };
			
			int powerupTime = 0;
			int powerupColor = 0;
			
			for ( int i = 0; i < arrayPowerup.Size(); i++ )
			{
				let hasPowerup = Powerup(CPlayer.mo.FindInventory(arrayPowerup[i]));
				let hasInfrared = Powerup(CPlayer.mo.FindInventory("PowerLightAmp"));
				
				if ( hasPowerup != null )
				{
					powerupTime = int(Ceil(double(hasPowerup.EffectTics) / GameTicRate));
					powerupColor = powerupTime > 4 ? Font.CR_WHITE : Font.CR_DARKRED;
					DrawImage(arrayPowerupImage[i], powerupPos, DI_SCREEN_RIGHT_BOTTOM, powerupAlpha);
					DrawString(mConFont, FormatNumber(powerupTime, 1), (powerupPos.X, powerupPos.Y - 8),
							   DI_SCREEN_RIGHT_BOTTOM|DI_TEXT_ALIGN_CENTER, powerupColor, powerupAlpha);
					if ( i == 2 )
						powerupPos.Y += 12;
					powerupPos.Y -= powerupPosYIncrement;
				}
			}
		}
		
		// Draw stats
		if ( deathmatch && altHUDFrags )
		{
			DrawImage("M_SKULL2", (20 + ultraWide, -64), DI_SCREEN_LEFT_BOTTOM, fragsAlpha);
			DrawString(mHUDFont, FormatNumber(CPlayer.FragCount, 1), (40 + ultraWide, -79),
					   DI_SCREEN_LEFT_BOTTOM|DI_NOSHADOW, Font.CR_WHITE, fragsAlpha);
		}
		else if ( !deathmatch )
		{
			Vector2 statsPos = (4 + ultraWide, -72);
			int statsPosYIncrement = altHUDStatsIcons ? 12 : 9;
			
			if ( altHUDStatsSecrets )
			{
				int mapSectersFound = Level.Found_Secrets;
				int mapSectersTotal = Level.Total_Secrets;
				int mapSecretsColor = mapSectersFound == mapSectersTotal ? Font.CR_GOLD : Font.CR_GREEN;
				String secretsStr = StringTable.Localize("$WF_HUD_STATS_SECRETS");
				String mapSecrets = mapSectersFound.."/"..mapSectersTotal;
				if ( altHUDStatsIcons )
					DrawImage("SECRETS", (statsPos.X + 4, statsPos.Y + 8), DI_SCREEN_LEFT_BOTTOM, statsAlpha);
				else
					DrawString(mSmallFontMono, secretsStr..":", statsPos, DI_SCREEN_LEFT_BOTTOM, Font.CR_RED, statsAlpha);
				DrawString(mSmallFont, mapSecrets, (statsPos.X + 16, statsPos.Y), DI_SCREEN_LEFT_BOTTOM, mapSecretsColor, statsAlpha);
				statsPos.Y -= statsPosYIncrement;
			}
			
			if ( altHUDStatsItems )
			{
				int mapItemsFound = Level.Found_Items;
				int mapItemsTotal = Level.Total_Items;
				int mapItemsColor = mapItemsFound == mapItemsTotal ? Font.CR_GOLD : Font.CR_GREEN;
				String itemsStr = StringTable.Localize("$WF_HUD_STATS_ITEMS");
				String mapItems = mapItemsFound.."/"..mapItemsTotal;
				if ( altHUDStatsIcons )
					DrawImage("ITEMS", (statsPos.X + 4, statsPos.Y + 8), DI_SCREEN_LEFT_BOTTOM, statsAlpha);
				else
					DrawString(mSmallFontMono, itemsStr..":", statsPos, DI_SCREEN_LEFT_BOTTOM, Font.CR_RED, statsAlpha);
				DrawString(mSmallFont, mapItems, (statsPos.X + 16, statsPos.Y), DI_SCREEN_LEFT_BOTTOM, mapItemsColor, statsAlpha);
				statsPos.Y -= statsPosYIncrement;
			}
			
			if ( altHUDStatsKills )
			{
				if ( !altHUDStatsKillsNotNm || skill != 4 )
				{
					int mapMonstersKilled = Level.Killed_Monsters;
					int mapMonstersTotal = Level.Total_Monsters;
					int mapMonstersColor = mapMonstersKilled == mapMonstersTotal ? Font.CR_GOLD : Font.CR_GREEN;
					String monstersStr = StringTable.Localize("$WF_HUD_STATS_MONSTERS");
					String mapMonsters = mapMonstersKilled.."/"..mapMonstersTotal;
					if ( altHUDStatsIcons )
						DrawImage("KILLS", (statsPos.X + 4, statsPos.Y + 8), DI_SCREEN_LEFT_BOTTOM, statsAlpha);
					else
						DrawString(mSmallFontMono, monstersStr..":", statsPos, DI_SCREEN_LEFT_BOTTOM, Font.CR_RED, statsAlpha);
					DrawString(mSmallFont, mapMonsters, (statsPos.X + 16, statsPos.Y), DI_SCREEN_LEFT_BOTTOM, mapMonstersColor, statsAlpha);
					statsPos.Y -= statsPosYIncrement;
				}
			}
		}
		
		// Draw time
		int infoOffset = 0;
		
		if ( !altHUDInfoDontOffset )
			infoOffset = ultraWide;
		
		Vector2 infoPos = (-4 - infoOffset, 0);
		int infoPosYIncrement = 9;
		
		if ( altHUDInfoTime )
		{
			int timeTicks = Level.Time;
			int timeSeconds = Thinker.Tics2Seconds(timeTicks);
			int hours   =  timeSeconds / 3600;
			int minutes = (timeSeconds % 3600) / 60;
			int seconds =  timeSeconds % 60;
			int millis  = (timeTicks % GameTicRate) * 1000 / GameTicRate;
			String timeString = String.Format("%02i:%02i:%02i", hours, minutes, seconds);
			if ( altHUDInfoTimeMillis )
				timeString = String.Format(timeString..".%03i", millis);
			let mapParTime = ( timeSeconds < Level.ParTime ) && Level.ParTime > 0;
			int timeColor = mapParTime ? Font.CR_GOLD : Font.CR_WHITE;
			DrawString(mSmallFontMono, timeString, infoPos, DI_SCREEN_RIGHT_TOP|DI_TEXT_ALIGN_RIGHT, timeColor, infoAlpha);
			infoPos.Y += infoPosYIncrement;
		}
		
		// Draw total time
		if ( altHUDInfoTotalTime )
		{
			int timeTicks = Level.TotalTime;
			int timeSeconds = Thinker.Tics2Seconds(timeTicks);
			int hours   =  timeSeconds / 3600;
			int minutes = (timeSeconds % 3600) / 60;
			int seconds =  timeSeconds % 60;
			int millis  = (timeTicks % GameTicRate) * 1000 / GameTicRate;
			String timeString = String.Format("%02i:%02i:%02i", hours, minutes, seconds);
			if ( altHUDInfoTimeMillis )
				timeString = String.Format(timeString..".%03i", millis);
			DrawString(mSmallFontMono, timeString, infoPos, DI_SCREEN_RIGHT_TOP|DI_TEXT_ALIGN_RIGHT, Font.CR_WHITE, infoAlpha);
			infoPos.Y += infoPosYIncrement;
		}
		
		// Draw map name
		if ( altHUDInfoMapLabel && altHUDInfoMapName )
		{
			String mapFullName = Level.MapName..": \cj"..Level.LevelName;
			DrawString(mSmallFont, mapFullName, infoPos, DI_SCREEN_RIGHT_TOP|DI_TEXT_ALIGN_RIGHT, Font.CR_RED, infoAlpha);
		}
		else if ( altHUDInfoMapLabel )
			DrawString(mSmallFont, Level.MapName, infoPos, DI_SCREEN_RIGHT_TOP|DI_TEXT_ALIGN_RIGHT, Font.CR_RED, infoAlpha);
		else if ( altHUDInfoMapName )
			DrawString(mSmallFont, Level.LevelName, infoPos, DI_SCREEN_RIGHT_TOP|DI_TEXT_ALIGN_RIGHT, Font.CR_WHITE, infoAlpha);
		
		if ( altHUDInfoMapLabel || altHUDInfoMapName )
			infoPos.Y += infoPosYIncrement;
		
		// Draw map author name
		if ( altHUDInfoMapAuthor && Level.AuthorName != "" )
		{
			String mapAuthorName = StringTable.Localize(Level.AuthorName);
			DrawString(mSmallFont, mapAuthorName, infoPos, DI_SCREEN_RIGHT_TOP|DI_TEXT_ALIGN_RIGHT, Font.CR_WHITE, infoAlpha);
			infoPos.Y += infoPosYIncrement;
		}
		
		// Draw skill
		if ( !deathmatch && altHUDInfoSkill )
		{
			String skillStr = StringTable.Localize("$WF_HUD_STATS_SKILL");
			String skillName = "";
			
			let mlRejects = CVar.FindCVar("wf_map_mlr").GetBool();
			String mlMap = mapName.Mid(6);
			let mlCabalMap = mlMap == "19" || mlMap == "37" || mlMap == "38" ||
							 mlMap == "39" || mlMap == "20" || mlMap == "40" ||
							 mlMap == "18" || mlMap == "41" || mlMap == "42" ||
							 mlMap == "10" || mlMap == "43" || mlMap == "21";
			let isCabal = mlRejects && mapName.Left(6) == "ml_map" && mlCabalMap;
			
			switch ( skill )
			{
				case 0:
					skillName = StringTable.Localize("$SKILL_BABY");
					break;
				case 1:
					skillName = !isCabal ? StringTable.Localize("$SKILL_EASY") : StringTable.Localize("$SKILL_NORMAL");
					break;
				case 2:
					skillName = !isCabal ? StringTable.Localize("$SKILL_NORMAL") : StringTable.Localize("$SKILL_HARD");
					break;
				case 3:
					skillName = !isCabal ? StringTable.Localize("$SKILL_HARD") : StringTable.Localize("$WF_SKILL_CARNAGE");
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
	
	int GetHealthColor()
	{
		int healthColor = Font.CR_UNTRANSLATED;
		int health = CPlayer.Health;
		int maxHealth = CPlayer.mo.GetMaxHealth(true);
		
		healthColor =
			health > maxhealth * 2    ? Font.CR_PURPLE :
			health > maxhealth * 1.5  ? Font.CR_BLUE :
			health > maxhealth * 1    ? Font.CR_CYAN :
			health > maxhealth * 0.75 ? Font.CR_GREEN :
			health > maxhealth * 0.5  ? Font.CR_YELLOW :
			health > maxhealth * 0.25 ? Font.CR_ORANGE :
			health > maxhealth * 0    ? Font.CR_RED :
			Font.CR_BLACK;
		
		return healthColor;
	}
	
	int GetArmorColor()
	{
		int armorColor = Font.CR_UNTRANSLATED;
		let armor = CPlayer.mo.FindInventory("BasicArmor");
		
		armorColor =
			armor.Amount > 200 ? Font.CR_PURPLE :
			armor.Amount > 150 ? Font.CR_BLUE :
			armor.Amount > 100 ? Font.CR_CYAN :
			armor.Amount > 75  ? Font.CR_GREEN :
			armor.Amount > 50  ? Font.CR_YELLOW :
			armor.Amount > 25  ? Font.CR_ORANGE :
			armor.Amount > 0   ? Font.CR_RED :
			Font.CR_BLACK;
		
		return armorColor;
	}
	
	int GetAmmoColor(bool secondaryAmmo)
	{
		int ammoColor = Font.CR_UNTRANSLATED;
		Inventory ammoType1, ammoType2;
		[ammoType1, ammoType2] = GetCurrentAmmo();
		let currentAmmo = !secondaryAmmo ? ammoType1 : ammoType2;
		let hasBackpack = CPlayer.mo.FindInventory("Backpack");
		int ammoLow = currentAmmo.MaxAmount / ( hasBackpack ? 8 : 4 );
		
		ammoColor =
			currentAmmo.Amount == currentAmmo.MaxAmount ? Font.CR_YELLOW :
			currentAmmo.Amount >  ammoLow               ? Font.CR_WHITE :
			currentAmmo.Amount >  0                     ? Font.CR_RED :
			Font.CR_BLACK;
		
		return ammoColor;
	}
	
	String GetAmmoBarColor(Name ammoType)
	{
		String ammoBarColor = "\cl";
		if ( CPlayer.mo.FindInventory(ammoType) != null )
		{
			int ammoAmount, ammoAmountMax = 0;
			[ammoAmount, ammoAmountMax] = GetAmount(ammoType);
			let hasBackpack = CPlayer.mo.FindInventory("Backpack");
			int ammoLow = ammoAmountMax / ( hasBackpack ? 8 : 4 );
			
			ammoBarColor =
				ammoAmount == ammoAmountMax ? "\cf" :
				ammoAmount >  ammoLow       ? "\cj" :
				ammoAmount >  0             ? "\cg" :
				"\cm";
		}
		
		return ammoBarColor;
	}
}
