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

// WadFusion Alt HUD todo:
// fuzzy mugshot when blur sphere is active
// negative health option (LowerHealthCap)
// weapon carousel

extend class WadFusionStatusBar
{
	protected void WadFusionAlternateHUD()
	{
		String mapName = Level.MapName.MakeLower();
		let isId1 = mapName.Left(3) == "lr_";
		let id1WeapSwap = CVar.FindCVar("wf_compat_id24_weapons").GetInt() == 1;
		let id1WeapSwapAlways = CVar.FindCVar("wf_compat_id24_weapons").GetInt() >= 2;
		let hudId24 = CVar.FindCVar("wf_hud_id24").GetBool();
		let hudSwapHealthArmor = CVar.FindCVar("wf_hud_swaphealtharmor").GetBool();
		
		int ultraWide = CVar.FindCVar("wf_hud_ultrawide").GetInt();
		if ( CVar.FindCVar("wf_hud_ultrawide_fullscreen").GetBool() && !CVar.FindCVar("vid_fullscreen").GetBool() )
			ultraWide = 0;
		
		int health    = CPlayer.health;
		int maxHealth = CPlayer.mo.GetMaxHealth(true);
		let armor     = CPlayer.mo.FindInventory("BasicArmor");
		
		let clip   = CPlayer.mo.FindInventory("Clip");
		let shell  = CPlayer.mo.FindInventory("Shell");
		let rocket = CPlayer.mo.FindInventory("RocketAmmo");
		let cell   = CPlayer.mo.FindInventory("Cell");
		let fuel   = CPlayer.mo.FindInventory("ID24Fuel");
		
		int clipLow   = 50;
		int shellLow  = 12;
		int rocketLow = 12;
		int cellLow   = 75;
		int fuelLow   = 37;
		
		let readyFist           = CPlayer.ReadyWeapon && CPlayer.ReadyWeapon.GetClassName() == "Fist";
		let readyChainsaw       = CPlayer.ReadyWeapon && CPlayer.ReadyWeapon.GetClassName() == "Chainsaw";
		let readyPistol         = CPlayer.ReadyWeapon && CPlayer.ReadyWeapon.GetClassName() == "Pistol";
		let readyShotgun        = CPlayer.ReadyWeapon && CPlayer.ReadyWeapon.GetClassName() == "Shotgun";
		let readySuperShotgun   = CPlayer.ReadyWeapon && CPlayer.ReadyWeapon.GetClassName() == "SuperShotgun";
		let readyChaingun       = CPlayer.ReadyWeapon && CPlayer.ReadyWeapon.GetClassName() == "Chaingun";
		let readyRocketLauncher = CPlayer.ReadyWeapon && CPlayer.ReadyWeapon.GetClassName() == "RocketLauncher";
		let readyIncinerator    = CPlayer.ReadyWeapon && CPlayer.ReadyWeapon.GetClassName() == "ID24Incinerator";
		let readyPlasmaRifle    = CPlayer.ReadyWeapon && CPlayer.ReadyWeapon.GetClassName() == "PlasmaRifle";
		let readyHeatwave       = CPlayer.ReadyWeapon && CPlayer.ReadyWeapon.GetClassName() == "ID24CalamityBlade";
		let readyBfg9000        = CPlayer.ReadyWeapon && CPlayer.ReadyWeapon.GetClassName() == "BFG9000";
		
		let hasFist           = CPlayer.mo.FindInventory("Fist");
		let hasChainsaw       = CPlayer.mo.FindInventory("Chainsaw");
		let hasPistol         = CPlayer.mo.FindInventory("Pistol");
		let hasShotgun        = CPlayer.mo.FindInventory("Shotgun");
		let hasSuperShotgun   = CPlayer.mo.FindInventory("SuperShotgun");
		let hasChaingun       = CPlayer.mo.FindInventory("Chaingun");
		let hasRocketLauncher = CPlayer.mo.FindInventory("RocketLauncher");
		let hasIncinerator    = CPlayer.mo.FindInventory("ID24Incinerator");
		let hasPlasmaRifle    = CPlayer.mo.FindInventory("PlasmaRifle");
		let hasHeatwave       = CPlayer.mo.FindInventory("ID24CalamityBlade");
		let hasBfg9000        = CPlayer.mo.FindInventory("BFG9000");
		
		let hasBlueCard    = CPlayer.mo.FindInventory("BlueCard");
		let hasBlueSkull   = CPlayer.mo.FindInventory("BlueSkull");
		let hasYellowCard  = CPlayer.mo.FindInventory("YellowCard");
		let hasYellowSkull = CPlayer.mo.FindInventory("YellowSkull");
		let hasRedCard     = CPlayer.mo.FindInventory("RedCard");
		let hasRedSkull    = CPlayer.mo.FindInventory("RedSkull");
		
		let hasBackpack = CPlayer.mo.FindInventory("Backpack");
		let hasBerserk  = CPlayer.mo.FindInventory("PowerStrength");
		
		let hasBlurSphere            = Powerup(CPlayer.mo.FindInventory("PowerInvisibility"));
		let hasInvulnerabilitySphere = Powerup(CPlayer.mo.FindInventory("PowerInvulnerable"));
		let hasInfrared              = Powerup(CPlayer.mo.FindInventory("PowerLightAmp"));
		let hasRadSuit               = Powerup(CPlayer.mo.FindInventory("PowerIronFeet"));
		
		let altHudMugshot         = CVar.FindCVar("wf_hud_alt_mugshot").GetBool();
		let altHudHealth          = CVar.FindCVar("wf_hud_alt_health").GetBool();
		let altHudArmor           = CVar.FindCVar("wf_hud_alt_armor").GetBool();
		let altHudAmmo            = CVar.FindCVar("wf_hud_alt_ammo").GetBool();
		let altHudAmmoInv         = CVar.FindCVar("wf_hud_alt_ammoinv").GetBool();
		let altHudPowerup         = CVar.FindCVar("wf_hud_alt_powerup").GetBool();
		let altHudWeapInv         = CVar.FindCVar("wf_hud_alt_weapinv").GetBool();
		let altHudKeys            = CVar.FindCVar("wf_hud_alt_keys").GetBool();
		let altHudFrags           = CVar.FindCVar("wf_hud_alt_frags").GetBool();
		let altHudStatsIcons      = CVar.FindCVar("wf_hud_alt_stats_icons").GetBool();
		int altHudStatsKills      = CVar.FindCVar("wf_hud_alt_stats_kills").GetInt();
		let altHudStatsItems      = CVar.FindCVar("wf_hud_alt_stats_items").GetBool();
		let altHudStatsSecrets    = CVar.FindCVar("wf_hud_alt_stats_secrets").GetBool();
		let altHudStatsTime       = CVar.FindCVar("wf_hud_alt_stats_time").GetBool();
		let altHudStatsTotalTime  = CVar.FindCVar("wf_hud_alt_stats_totaltime").GetBool();
		let altHudStatsTimeMillis = CVar.FindCVar("wf_hud_alt_stats_timemillis").GetBool();
		let altHudStatsMapName    = CVar.FindCVar("wf_hud_alt_stats_mapname").GetBool();
		let altHudStatsMapLabel   = CVar.FindCVar("wf_hud_alt_stats_maplabel").GetBool();
		
		double healthAlpha          = CVar.FindCVar("wf_hud_alt_alpha_health").GetFloat();
		double ammoAlpha            = CVar.FindCVar("wf_hud_alt_alpha_ammo").GetFloat();
		double ammoInvAlpha         = CVar.FindCVar("wf_hud_alt_alpha_ammoinv").GetFloat();
		double powerupAlpha         = CVar.FindCVar("wf_hud_alt_alpha_powerup").GetFloat();
		double weapInvAlpha         = CVar.FindCVar("wf_hud_alt_alpha_weapinv").GetFloat();
		double weapInvInactiveAlpha = CVar.FindCVar("wf_hud_alt_alpha_weapinvinactive").GetFloat();
		double keysAlpha            = CVar.FindCVar("wf_hud_alt_alpha_keys").GetFloat();
		double fragsAlpha           = CVar.FindCVar("wf_hud_alt_alpha_frags").GetFloat();
		double statsAlpha           = CVar.FindCVar("wf_hud_alt_alpha_stats").GetFloat();
		double timeAlpha            = CVar.FindCVar("wf_hud_alt_alpha_stats_time").GetFloat();
		double mapNameAlpha         = CVar.FindCVar("wf_hud_alt_alpha_stats_mapname").GetFloat();
		
		// Draw health
		int hudHealthOffset;
		if ( hudSwapHealthArmor || !altHudHealth )
			hudHealthOffset = 27;
			
		if ( !altHudArmor )
			hudHealthOffset = 0;
		
		if ( altHudHealth )
		{
			if ( !altHudMugshot )
				DrawImage(hasBerserk ? "PSTRA0" : "MEDIA0", (20 + ultraWide, -10 - hudHealthOffset),
						DI_SCREEN_LEFT_BOTTOM, healthAlpha);
			else
				DrawTexture(GetMugShot(5), (3 + ultraWide, -35 - hudHealthOffset),
							DI_ITEM_OFFSETS|DI_SCREEN_LEFT_BOTTOM, healthAlpha);
			
			int healthColor =
				health > maxhealth * 2    ? Font.CR_PURPLE :
				health > maxhealth * 1.5  ? Font.CR_BLUE :
				health > maxhealth * 1    ? Font.CR_CYAN :
				health > maxhealth * 0.75 ? Font.CR_GREEN :
				health > maxhealth * 0.5  ? Font.CR_YELLOW :
				health > maxhealth * 0.25 ? Font.CR_ORANGE :
				health > maxhealth * 0    ? Font.CR_RED :
				Font.CR_BLACK;
			
			DrawString(mHUDFont, FormatNumber(health, 1), (40 + ultraWide, -25 - hudHealthOffset),
					DI_SCREEN_LEFT_BOTTOM|DI_NOSHADOW, healthColor, healthAlpha);
		}
		
		// Draw armor
		if ( altHudArmor )
		{
			int armorColor=
				armor.Amount > 200 ? Font.CR_PURPLE :
				armor.Amount > 150 ? Font.CR_BLUE :
				armor.Amount > 100 ? Font.CR_CYAN :
				armor.Amount > 75  ? Font.CR_GREEN :
				armor.Amount > 50  ? Font.CR_YELLOW :
				armor.Amount > 25  ? Font.CR_ORANGE :
				Font.CR_RED;
			
			if ( armor != null && armor.Amount > 0 )
			{
				DrawInventoryIcon(armor, (20 + ultraWide, -37 + hudHealthOffset), DI_SCREEN_LEFT_BOTTOM, healthAlpha);
				DrawString(mHUDFont, FormatNumber(armor.Amount, 1), (40 + ultraWide, -52 + hudHealthOffset),
						DI_SCREEN_LEFT_BOTTOM|DI_NOSHADOW, armorColor, healthAlpha);
			}
		}
		
		// Draw current ammo
		Inventory ammotype1, ammotype2;
		[ammotype1, ammotype2] = GetCurrentAmmo();
		
		Vector2 ammoInvPos = (-4 - ultraWide, -48);
		int ammoInvPosYIncrement = 8;
		
		if ( altHudAmmo )
		{
			
			int ammoType1Low;
			int ammoType2Low;
			if ( hasBackpack )
			{
				if ( ammotype1 != null )
					ammoType1Low = ammotype1.MaxAmount / 8;
				if ( ammotype2 != null )
					ammoType2Low = ammotype2.MaxAmount / 8;
			}
			else
			{
				if ( ammotype1 != null )
					ammoType1Low = ammotype1.MaxAmount / 4;
				if ( ammotype2 != null )
					ammoType2Low = ammotype2.MaxAmount / 4;
			}
			
			int invY = -25;
			if ( ammotype1 != null )
			{
				DrawInventoryIcon(ammotype1, (-14 - ultraWide, -10), DI_SCREEN_RIGHT_BOTTOM, ammoAlpha);
				DrawString(mHUDFont, FormatNumber(ammotype1.Amount, 1), (-30 - ultraWide, -25),
						DI_SCREEN_RIGHT_BOTTOM|DI_TEXT_ALIGN_RIGHT|DI_NOSHADOW,
						ammotype1.Amount > ammoType1Low ? Font.CR_WHITE : Font.CR_RED, ammoAlpha);
				invY -= 27;
			}
			
			if ( ammotype2 != null && ammotype2 != ammotype1 )
			{
				DrawInventoryIcon(ammotype2, (-14 - ultraWide, invY + 15), DI_SCREEN_RIGHT_BOTTOM, ammoAlpha);
				DrawString(mHUDFont, FormatNumber(ammotype2.Amount, 1), (-30 - ultraWide, invY),
						DI_SCREEN_RIGHT_BOTTOM|DI_TEXT_ALIGN_RIGHT|DI_NOSHADOW,
						ammotype2.Amount > ammoType2Low ? Font.CR_WHITE : Font.CR_RED, ammoAlpha);
				invY -= 27;
				ammoInvPos.Y -= 27;
			}
			
			if ( !isInventoryBarVisible() && !Level.NoInventoryBar && CPlayer.mo.InvSel != null )
			{
				DrawInventoryIcon(CPlayer.mo.InvSel, (-14 - ultraWide, invY + 15),
								DI_DIMDEPLETED|DI_SCREEN_RIGHT_BOTTOM, ammoAlpha);
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
			if ( fuel != null && ammotype1 != fuel )
			{
				if ( ( isId1 && id1WeapSwap ) || ( hasIncinerator || hasHeatwave ) || hudId24 || id1WeapSwapAlways )
				{
					DrawString(mConFont, "fuel", (ammoInvPos.X - 31, ammoInvPos.Y),
							DI_SCREEN_RIGHT_BOTTOM|DI_TEXT_ALIGN_RIGHT,
							hasBackpack ? Font.CR_GOLD : Font.CR_WHITE, ammoInvAlpha);
					DrawString(mConFont, FormatNumber(fuel.Amount, 3, 0, 3), ammoInvPos,
							DI_SCREEN_RIGHT_BOTTOM|DI_TEXT_ALIGN_RIGHT,
							fuel.Amount > fuelLow ? Font.CR_WHITE : Font.CR_RED, ammoInvAlpha);
					if ( fuel.Amount <= 0 )
						DrawString(mConFont, "000", ammoInvPos,
								DI_SCREEN_RIGHT_BOTTOM|DI_TEXT_ALIGN_RIGHT, Font.CR_BLACK, ammoInvAlpha);
					ammoInvPos.Y -= ammoInvPosYIncrement;
				}
			}
			
			if ( cell != null && ammotype1 != cell )
			{
				if ( !( isId1 && id1WeapSwap ) || ( hasPlasmaRifle || hasBfg9000 ) || hudId24 )
				{
					if ( !( id1WeapSwapAlways && !( hasPlasmaRifle || hasBfg9000 ) ) )
					{
						DrawString(mConFont, "cell", (ammoInvPos.X - 31, ammoInvPos.Y),
								DI_SCREEN_RIGHT_BOTTOM|DI_TEXT_ALIGN_RIGHT,
								hasBackpack ? Font.CR_GOLD : Font.CR_WHITE, ammoInvAlpha);
						DrawString(mConFont, FormatNumber(cell.Amount, 3, 0, 3), ammoInvPos,
								DI_SCREEN_RIGHT_BOTTOM|DI_TEXT_ALIGN_RIGHT,
								cell.Amount > cellLow ? Font.CR_WHITE : Font.CR_RED, ammoInvAlpha);
						if ( cell.Amount <= 0 )
							DrawString(mConFont, "000", ammoInvPos,
									DI_SCREEN_RIGHT_BOTTOM|DI_TEXT_ALIGN_RIGHT, Font.CR_BLACK, ammoInvAlpha);
						ammoInvPos.Y -= ammoInvPosYIncrement;
					}
				}
			}
			
			if ( rocket != null && ammotype1 != rocket )
			{
				DrawString(mConFont, "rckt", (ammoInvPos.X - 31, ammoInvPos.Y),
						DI_SCREEN_RIGHT_BOTTOM|DI_TEXT_ALIGN_RIGHT,
						hasBackpack ? Font.CR_GOLD : Font.CR_WHITE, ammoInvAlpha);
				DrawString(mConFont, FormatNumber(rocket.Amount, 3, 0, 3), ammoInvPos,
						DI_SCREEN_RIGHT_BOTTOM|DI_TEXT_ALIGN_RIGHT,
						rocket.Amount > rocketLow ? Font.CR_WHITE : Font.CR_RED, ammoInvAlpha);
				if ( rocket.Amount <= 0 )
					DrawString(mConFont, "000", ammoInvPos,
							DI_SCREEN_RIGHT_BOTTOM|DI_TEXT_ALIGN_RIGHT, Font.CR_BLACK, ammoInvAlpha);
				ammoInvPos.Y -= ammoInvPosYIncrement;
			}
			
			if ( shell != null && ammotype1 != shell )
			{
				DrawString(mConFont, "shel", (ammoInvPos.X - 31, ammoInvPos.Y),
						DI_SCREEN_RIGHT_BOTTOM|DI_TEXT_ALIGN_RIGHT,
						hasBackpack ? Font.CR_GOLD : Font.CR_WHITE, ammoInvAlpha);
				DrawString(mConFont, FormatNumber(shell.Amount, 3, 0, 3), ammoInvPos,
						DI_SCREEN_RIGHT_BOTTOM|DI_TEXT_ALIGN_RIGHT,
						shell.Amount > shellLow ? Font.CR_WHITE : Font.CR_RED, ammoInvAlpha);
				if ( shell.Amount <= 0 )
					DrawString(mConFont, "000", ammoInvPos,
							DI_SCREEN_RIGHT_BOTTOM|DI_TEXT_ALIGN_RIGHT, Font.CR_BLACK, ammoInvAlpha);
				ammoInvPos.Y -= ammoInvPosYIncrement;
			}
			
			if ( clip != null && ammotype1 != clip )
			{
				DrawString(mConFont, "bull", (ammoInvPos.X - 31, ammoInvPos.Y),
						DI_SCREEN_RIGHT_BOTTOM|DI_TEXT_ALIGN_RIGHT,
						hasBackpack ? Font.CR_GOLD : Font.CR_WHITE, ammoInvAlpha);
				DrawString(mConFont, FormatNumber(clip.Amount, 3, 0, 3), ammoInvPos,
						DI_SCREEN_RIGHT_BOTTOM|DI_TEXT_ALIGN_RIGHT,
						clip.Amount > clipLow ? Font.CR_WHITE : Font.CR_RED, ammoInvAlpha);
				if ( clip.Amount <= 0 )
					DrawString(mConFont, "000", ammoInvPos,
							DI_SCREEN_RIGHT_BOTTOM|DI_TEXT_ALIGN_RIGHT, Font.CR_BLACK, ammoInvAlpha);
				ammoInvPos.Y -= ammoInvPosYIncrement;
			}
		}
		
		// Draw powerups
		Vector2 powerupPos = (-18 - ultraWide, -4 + ammoInvPos.Y);
		int powerupPosYIncrement = 30;
		int powerupCount;
		
		if ( altHudPowerup )
		{
			if ( hasBlurSphere != null )
			{
				int blurSphereTime = int(Ceil(double(hasBlurSphere.EffectTics) / GameTicRate));
				DrawImage("PINSAHUD", powerupPos, DI_SCREEN_RIGHT_BOTTOM, powerupAlpha);
				DrawString(mConFont, FormatNumber(blurSphereTime, 1), (powerupPos.X, powerupPos.Y - 8),
						DI_SCREEN_RIGHT_BOTTOM|DI_TEXT_ALIGN_CENTER, Font.CR_WHITE, powerupAlpha);
				powerupPos.Y -= powerupPosYIncrement;
				powerupCount++;
			}
			
			if ( hasInvulnerabilitySphere != null )
			{
				int invulnerabilitySphereTime = int(Ceil(double(hasInvulnerabilitySphere.EffectTics) / GameTicRate));
				DrawImage("PINVAHUD", powerupPos, DI_SCREEN_RIGHT_BOTTOM, powerupAlpha);
				DrawString(mConFont, FormatNumber(invulnerabilitySphereTime, 1), (powerupPos.X, powerupPos.Y - 8),
						DI_SCREEN_RIGHT_BOTTOM|DI_TEXT_ALIGN_CENTER, Font.CR_WHITE, powerupAlpha);
				powerupPos.Y -= powerupPosYIncrement;
				powerupCount++;
			}
			
			if ( hasInfrared != null )
			{
				int infraredTime = int(Ceil(double(hasInfrared.EffectTics) / GameTicRate));
				DrawImage("PVISAHUD", powerupPos, DI_SCREEN_RIGHT_BOTTOM, powerupAlpha);
				DrawString(mConFont, FormatNumber(infraredTime, 1), (powerupPos.X, powerupPos.Y - 8),
						DI_SCREEN_RIGHT_BOTTOM|DI_TEXT_ALIGN_CENTER, Font.CR_WHITE, powerupAlpha);
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
						DI_SCREEN_RIGHT_BOTTOM|DI_TEXT_ALIGN_CENTER, Font.CR_WHITE, powerupAlpha);
				powerupPos.Y -= powerupPosYIncrement;
				powerupCount++;
			}
		}
		
		// Draw weapon slots
		Vector2 weapInvPos = (-72 - ultraWide, -8);
		int weapInvPosXIncrement = 5;
		
		if ( altHudWeapInv )
		{
			if ( readyFist )
				DrawString(mIndexFont, "1", weapInvPos, DI_SCREEN_RIGHT_BOTTOM,
						hasBerserk ? Font.CR_RED : Font.CR_GOLD, weapInvAlpha);
			else if ( hasFist )
				DrawString(mIndexFont, "1", weapInvPos, DI_SCREEN_RIGHT_BOTTOM,
						hasBerserk ? Font.CR_RED : Font.CR_WHITE, weapInvInactiveAlpha);
			
			weapInvPos.X += weapInvPosXIncrement;
			if ( readyChainsaw )
				DrawString(mIndexFont, "1", weapInvPos, DI_SCREEN_RIGHT_BOTTOM, Font.CR_GOLD, weapInvAlpha);
			else if ( hasChainsaw )
				DrawString(mIndexFont, "1", weapInvPos, DI_SCREEN_RIGHT_BOTTOM, Font.CR_WHITE, weapInvInactiveAlpha);
			
			weapInvPos.X += weapInvPosXIncrement;
			if ( readyPistol )
				DrawString(mIndexFont, "2", weapInvPos, DI_SCREEN_RIGHT_BOTTOM, Font.CR_GOLD, weapInvAlpha);
			else if ( hasPistol )
				DrawString(mIndexFont, "2", weapInvPos, DI_SCREEN_RIGHT_BOTTOM, Font.CR_WHITE, weapInvInactiveAlpha);
			
			weapInvPos.X += weapInvPosXIncrement;
			if ( readyShotgun )
				DrawString(mIndexFont, "3", weapInvPos, DI_SCREEN_RIGHT_BOTTOM, Font.CR_GOLD, weapInvAlpha);
			else if ( hasShotgun )
				DrawString(mIndexFont, "3", weapInvPos, DI_SCREEN_RIGHT_BOTTOM, Font.CR_WHITE, weapInvInactiveAlpha);
			
			if ( !( mapName.Left(1) == "e" && mapName.Mid(2, 1) == "m" && !hasSuperShotgun ) )
				weapInvPos.X += weapInvPosXIncrement;
			
			if ( readySuperShotgun )
				DrawString(mIndexFont, "3", weapInvPos, DI_SCREEN_RIGHT_BOTTOM, Font.CR_GOLD, weapInvAlpha);
			else if ( hasSuperShotgun )
				DrawString(mIndexFont, "3", weapInvPos, DI_SCREEN_RIGHT_BOTTOM, Font.CR_WHITE, weapInvInactiveAlpha);
			
			weapInvPos.X += weapInvPosXIncrement;
			if ( readyChaingun )
				DrawString(mIndexFont, "4", weapInvPos, DI_SCREEN_RIGHT_BOTTOM, Font.CR_GOLD, weapInvAlpha);
			else if ( hasChaingun )
				DrawString(mIndexFont, "4", weapInvPos, DI_SCREEN_RIGHT_BOTTOM, Font.CR_WHITE, weapInvInactiveAlpha);
			
			weapInvPos.X += weapInvPosXIncrement;
			if ( readyRocketLauncher )
				DrawString(mIndexFont, "5", weapInvPos, DI_SCREEN_RIGHT_BOTTOM, Font.CR_GOLD, weapInvAlpha);
			else if ( hasRocketLauncher )
				DrawString(mIndexFont, "5", weapInvPos, DI_SCREEN_RIGHT_BOTTOM, Font.CR_WHITE, weapInvInactiveAlpha);
			
			weapInvPos.X += weapInvPosXIncrement;
			if ( readyIncinerator )
				DrawString(mIndexFont, "6", weapInvPos, DI_SCREEN_RIGHT_BOTTOM, Font.CR_GOLD, weapInvAlpha);
			else if ( hasIncinerator )
				DrawString(mIndexFont, "6", weapInvPos, DI_SCREEN_RIGHT_BOTTOM, Font.CR_WHITE, weapInvInactiveAlpha);
			
			if ( ( hasPlasmaRifle || hasBfg9000 ) && ( hasIncinerator || hasHeatwave ) )
				weapInvPos.X += weapInvPosXIncrement;
			
			if ( readyPlasmaRifle )
				DrawString(mIndexFont, "6", weapInvPos, DI_SCREEN_RIGHT_BOTTOM, Font.CR_GOLD, weapInvAlpha);
			else if ( hasPlasmaRifle )
				DrawString(mIndexFont, "6", weapInvPos, DI_SCREEN_RIGHT_BOTTOM, Font.CR_WHITE, weapInvInactiveAlpha);
			
			weapInvPos.X += weapInvPosXIncrement;
			if ( readyHeatwave )
				DrawString(mIndexFont, "7", weapInvPos, DI_SCREEN_RIGHT_BOTTOM, Font.CR_GOLD, weapInvAlpha);
			else if ( hasHeatwave )
				DrawString(mIndexFont, "7", weapInvPos, DI_SCREEN_RIGHT_BOTTOM, Font.CR_WHITE, weapInvInactiveAlpha);
			
			if ( hasIncinerator || hasHeatwave )
				weapInvPos.X += weapInvPosXIncrement;
			
			if ( readyBfg9000 )
				DrawString(mIndexFont, "7", weapInvPos, DI_SCREEN_RIGHT_BOTTOM, Font.CR_GOLD, weapInvAlpha);
			else if ( hasBfg9000 )
				DrawString(mIndexFont, "7", weapInvPos, DI_SCREEN_RIGHT_BOTTOM, Font.CR_WHITE, weapInvInactiveAlpha);
		}
		
		// Draw keys
		Vector2 keyInvPos = (-83 - ultraWide, -20);
		int keyInvPosYIncrement = 8;
		
		if ( !deathmatch && altHudKeys )
		{
			if ( hasBlueCard && hasBlueSkull )
				DrawImage("STKEYS6", keyInvPos, DI_SCREEN_RIGHT_BOTTOM, keysAlpha);
			else if ( hasBlueSkull )
				DrawImage("STKEYS3", keyInvPos, DI_SCREEN_RIGHT_BOTTOM, keysAlpha);
			else if ( hasBlueCard )
				DrawImage("STKEYS0", keyInvPos, DI_SCREEN_RIGHT_BOTTOM, keysAlpha);
			
			keyInvPos.Y += keyInvPosYIncrement;
			if ( hasYellowCard && hasYellowSkull )
				DrawImage("STKEYS7", keyInvPos, DI_SCREEN_RIGHT_BOTTOM, keysAlpha);
			else if ( hasYellowSkull )
				DrawImage("STKEYS4", keyInvPos, DI_SCREEN_RIGHT_BOTTOM, keysAlpha);
			else if ( hasYellowCard )
				DrawImage("STKEYS1", keyInvPos, DI_SCREEN_RIGHT_BOTTOM, keysAlpha);
			
			keyInvPos.Y += keyInvPosYIncrement;
			if ( hasRedCard && hasRedSkull )
				DrawImage("STKEYS8", keyInvPos, DI_SCREEN_RIGHT_BOTTOM, keysAlpha);
			else if ( hasRedSkull )
				DrawImage("STKEYS5", keyInvPos, DI_SCREEN_RIGHT_BOTTOM, keysAlpha);
			else if ( hasRedCard )
				DrawImage("STKEYS2", keyInvPos, DI_SCREEN_RIGHT_BOTTOM, keysAlpha);
		}
		
		// Draw stats
		Vector2 statsPos = (4 + ultraWide, -72);
		int statsPosYIncrement;
		if ( altHudStatsIcons )
			statsPosYIncrement = 12;
		else
			statsPosYIncrement = 9;
		
		if ( deathmatch && altHudFrags )
		{
			DrawImage("M_SKULL1", (20 + ultraWide, -64), DI_SCREEN_LEFT_BOTTOM, fragsAlpha);
			DrawString(mHUDFont, FormatNumber(CPlayer.FragCount, 1), (40 + ultraWide, -79),
					DI_SCREEN_LEFT_BOTTOM|DI_NOSHADOW, Font.CR_WHITE, fragsAlpha);
		}
		else if ( !deathmatch )
		{
			if ( altHudStatsSecrets )
			{
				int mapSectersFound = Level.Found_Secrets;
				int mapSectersTotal = Level.Total_Secrets;
				String mapSecrets = mapSectersFound.."/"..mapSectersTotal;
				if ( altHudStatsIcons )
					DrawImage("SECRETS", (statsPos.X + 4, statsPos.Y + 8),
							DI_SCREEN_LEFT_BOTTOM, statsAlpha);
				else
					DrawString(mSmallFont, "S:", statsPos,
							DI_SCREEN_LEFT_BOTTOM, Font.CR_RED, statsAlpha);
				if ( mapSectersFound == mapSectersTotal )
					DrawString(mSmallFont, mapSecrets, (statsPos.X + 16, statsPos.Y),
							DI_SCREEN_LEFT_BOTTOM, Font.CR_GOLD, statsAlpha);
				else
					DrawString(mSmallFont, mapSecrets, (statsPos.X + 16, statsPos.Y),
							DI_SCREEN_LEFT_BOTTOM, Font.CR_GREEN, statsAlpha);
				statsPos.Y -= statsPosYIncrement;
			}
			
			if ( altHudStatsItems )
			{
				int mapItemsFound = Level.Found_Items;
				int mapItemsTotal = Level.Total_Items;
				String mapItems = mapItemsFound.."/"..mapItemsTotal;
				if ( altHudStatsIcons )
					DrawImage("ITEMS", (statsPos.X + 4, statsPos.Y + 8),
							DI_SCREEN_LEFT_BOTTOM, statsAlpha);
				else
					DrawString(mSmallFont, "I:", statsPos,
							DI_SCREEN_LEFT_BOTTOM, Font.CR_RED, statsAlpha);
				if ( mapItemsFound == mapItemsTotal )
					DrawString(mSmallFont, mapItems, (statsPos.X + 16, statsPos.Y),
							DI_SCREEN_LEFT_BOTTOM, Font.CR_GOLD, statsAlpha);
				else
					DrawString(mSmallFont, mapItems, (statsPos.X + 16, statsPos.Y),
							DI_SCREEN_LEFT_BOTTOM, Font.CR_GREEN, statsAlpha);
				statsPos.Y -= statsPosYIncrement;
			}
			
			if ( altHudStatsKills >= 1 )
			{
				if ( altHudStatsKills != 1 || skill != 4 )
				{
					int mapMonstersFound = Level.Killed_Monsters;
					int mapMonstersTotal = Level.Total_Monsters;
					String mapMonsters = mapMonstersFound.."/"..mapMonstersTotal;
					if ( altHudStatsIcons )
						DrawImage("KILLS", (statsPos.X + 4, statsPos.Y + 8),
								DI_SCREEN_LEFT_BOTTOM, statsAlpha);
					else
						DrawString(mSmallFont, "K:", statsPos,
								DI_SCREEN_LEFT_BOTTOM, Font.CR_RED, statsAlpha);
					if ( mapMonstersFound == mapMonstersTotal )
						DrawString(mSmallFont, mapMonsters, (statsPos.X + 16, statsPos.Y),
								DI_SCREEN_LEFT_BOTTOM, Font.CR_GOLD, statsAlpha);
					else
						DrawString(mSmallFont, mapMonsters, (statsPos.X + 16, statsPos.Y),
								DI_SCREEN_LEFT_BOTTOM, Font.CR_GREEN, statsAlpha);
				statsPos.Y -= statsPosYIncrement;
				}
			}
		}
		
		// Draw time
		Vector2 timePos = (-4 - ultraWide, 0);
		int timePosYIncrement = 9;
		
		if ( altHudStatsTime )
		{
			int timeTicks = Level.Time;
			int timeSeconds = Thinker.Tics2Seconds(timeTicks);
			int hours   =  timeSeconds / 3600;
			int minutes = (timeSeconds % 3600) / 60;
			int seconds =  timeSeconds % 60;
			int millis  = (timeTicks % GameTicRate) * 1000 / GameTicRate;
			String timeString = String.Format("%02i:%02i:%02i", hours, minutes, seconds);
			String timeMillisString = String.Format(timeString..".%03i", millis);
			DrawString(mSmallFont, altHudStatsTimeMillis ? timeMillisString : timeString, timePos,
					DI_SCREEN_RIGHT_TOP|DI_TEXT_ALIGN_RIGHT, Font.CR_WHITE, timeAlpha);
			timePos.Y += timePosYIncrement;
		}
		
		// Draw total time
		if ( altHudStatsTotalTime )
		{
			int timeTicks = Level.TotalTime;
			int timeSeconds = Thinker.Tics2Seconds(timeTicks);
			int hours   =  timeSeconds / 3600;
			int minutes = (timeSeconds % 3600) / 60;
			int seconds =  timeSeconds % 60;
			int millis  = (timeTicks % GameTicRate) * 1000 / GameTicRate;
			String timeString = String.Format("%02i:%02i:%02i", hours, minutes, seconds);
			String timeMillisString = String.Format(timeString..".%03i", millis);
			DrawString(mSmallFont, altHudStatsTimeMillis ? timeMillisString : timeString, timePos,
					DI_SCREEN_RIGHT_TOP|DI_TEXT_ALIGN_RIGHT, Font.CR_WHITE, timeAlpha);
			timePos.Y += timePosYIncrement;
		}
		
		// Draw map name
		String mapFullName = Level.MapName..": "..Level.LevelName;
		if ( altHudStatsMapLabel && altHudStatsMapName )
		{
			DrawString(mSmallFont, mapFullName, timePos,
					DI_SCREEN_RIGHT_TOP|DI_TEXT_ALIGN_RIGHT, Font.CR_RED, mapNameAlpha);
		}
		else if ( altHudStatsMapLabel )
		{
			DrawString(mSmallFont, Level.MapName, timePos,
					DI_SCREEN_RIGHT_TOP|DI_TEXT_ALIGN_RIGHT, Font.CR_RED, mapNameAlpha);
		}
		else if ( altHudStatsMapName )
		{
			DrawString(mSmallFont, Level.LevelName, timePos,
					DI_SCREEN_RIGHT_TOP|DI_TEXT_ALIGN_RIGHT, Font.CR_RED, mapNameAlpha);
		}
		timePos.Y += timePosYIncrement;
	}
}
