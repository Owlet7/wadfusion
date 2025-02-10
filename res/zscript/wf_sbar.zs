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

class WadFusionStatusBar : BaseStatusBar
{
	HUDFont mHUDFont;
	HUDFont mIndexFont;
	HUDFont mAmountFont;
	InventoryBarState diparms;
	HUDFont mConFont;
	HUDFont mSmallFont;
	
	
	override void Init()
	{
		Super.Init();
		SetSize(32, 320, 200);

		// Create the font used for the fullscreen HUD
		Font fnt = "HUDFONT_DOOM";
		mHUDFont = HUDFont.Create(fnt, fnt.GetCharWidth("0"), Mono_CellLeft, 1, 1);
		fnt = "INDEXFONT_DOOM";
		mIndexFont = HUDFont.Create(fnt, fnt.GetCharWidth("0"), Mono_CellLeft);
		mAmountFont = HUDFont.Create("INDEXFONT");
		diparms = InventoryBarState.Create();
		fnt = "CONFONT";
		mConFont = HUDFont.Create(fnt, fnt.GetCharWidth("0"), Mono_CellCenter);
		fnt = "SMALLFONT";
		mSmallFont = HUDFont.Create(fnt, fnt.GetCharWidth("0"), Mono_CellCenter);
	}

	override void Draw (int state, double TicFrac)
	{
		Super.Draw (state, TicFrac);

		if (state == HUD_StatusBar)
		{
			BeginStatusBar();
			DrawMainBar (TicFrac);
		}
		else if (state == HUD_Fullscreen)
		{
			BeginHUD();
			DrawFullScreenStuff ();
		}
	}

	protected void DrawMainBar (double TicFrac)
	{
		String mapName = level.MapName.MakeLower();
		let isId1 = mapName.Left(3) == "lr_";
		let id1WeapSwap = CVar.FindCVar("wf_id1_weapswap").GetInt() == 1;
		let id1WeapSwapAlways = CVar.FindCVar("wf_id1_weapswap").GetInt() >= 2;
		
		if ( ( isId1 && id1WeapSwap ) || id1WeapSwapAlways )
			DrawImage("STBRFUEL", (-128, 168), DI_ITEM_OFFSETS);
		else
			DrawImage("STBAR", (0, 168), DI_ITEM_OFFSETS);
		DrawImage("STTPRCNT", (90, 171), DI_ITEM_OFFSETS);
		DrawImage("STTPRCNT", (221, 171), DI_ITEM_OFFSETS);
		
		Inventory a1 = GetCurrentAmmo();
		if (a1 != null) DrawString(mHUDFont, FormatNumber(a1.Amount, 3), (44, 171), DI_TEXT_ALIGN_RIGHT|DI_NOSHADOW);
		DrawString(mHUDFont, FormatNumber(CPlayer.health, 3), (90, 171), DI_TEXT_ALIGN_RIGHT|DI_NOSHADOW);
		DrawString(mHUDFont, FormatNumber(GetArmorAmount(), 3), (221, 171), DI_TEXT_ALIGN_RIGHT|DI_NOSHADOW);

		DrawBarKeys();
		DrawBarAmmo();
		
		if (deathmatch || teamplay)
		{
			DrawString(mHUDFont, FormatNumber(CPlayer.FragCount, 3), (138, 171), DI_TEXT_ALIGN_RIGHT);
		}
		else
		{
			DrawBarWeapons();
		}
		
		if (multiplayer)
		{
			DrawImage("STFBANY", (143, 168), DI_ITEM_OFFSETS|DI_TRANSLATABLE);
		}
		
		if (CPlayer.mo.InvSel != null && !Level.NoInventoryBar)
		{
			DrawInventoryIcon(CPlayer.mo.InvSel, (160, 198), DI_DIMDEPLETED);
			if (CPlayer.mo.InvSel.Amount > 1)
			{
				DrawString(mAmountFont, FormatNumber(CPlayer.mo.InvSel.Amount), (175, 198-mIndexFont.mFont.GetHeight()), DI_TEXT_ALIGN_RIGHT, Font.CR_GOLD);
			}
		}
		else
		{
			DrawTexture(GetMugShot(5), (143, 168), DI_ITEM_OFFSETS);
		}
		if (isInventoryBarVisible())
		{
			DrawInventoryBar(diparms, (48, 169), 7, DI_ITEM_LEFT_TOP);
		}
		
	}
	
	protected virtual void DrawBarKeys()
	{
		bool locks[6];
		String image;
		for(int i = 0; i < 6; i++) locks[i] = CPlayer.mo.CheckKeys(i + 1, false, true);
		// key 1
		if (locks[1] && locks[4]) image = "STKEYS6";
		else if (locks[1]) image = "STKEYS0";
		else if (locks[4]) image = "STKEYS3";
		DrawImage(image, (239, 171), DI_ITEM_OFFSETS);
		// key 2
		if (locks[2] && locks[5]) image = "STKEYS7";
		else if (locks[2]) image = "STKEYS1";
		else if (locks[5]) image = "STKEYS4";
		else image = "";
		DrawImage(image, (239, 181), DI_ITEM_OFFSETS);
		// key 3
		if (locks[0] && locks[3]) image = "STKEYS8";
		else if (locks[0]) image = "STKEYS2";
		else if (locks[3]) image = "STKEYS5";
		else image = "";
		DrawImage(image, (239, 191), DI_ITEM_OFFSETS);
	}
	
	protected virtual void DrawBarAmmo()
	{
		String mapName = level.MapName.MakeLower();
		let isId1 = mapName.Left(3) == "lr_";
		let id1WeapSwap = CVar.FindCVar("wf_id1_weapswap").GetInt() == 1;
		let id1WeapSwapAlways = CVar.FindCVar("wf_id1_weapswap").GetInt() >= 2;
		let cell = CPlayer.mo.FindInventory("Cell");
		let fuel = CPlayer.mo.FindInventory("ID24Fuel");
		let hasPlasmaRifle = CPlayer.mo.FindInventory("PlasmaRifle");
		let hasBfg9000 = CPlayer.mo.FindInventory("BFG9000");
		let hasIncinerator = CPlayer.mo.FindInventory("ID24Incinerator");
		let hasHeatwave = CPlayer.mo.FindInventory("ID24CalamityBlade");
		
		// Only show id24 style ammo if the player has both cell and fuel ammo, or if wf_hud_id24 is true
		if ( CVar.FindCVar("wf_hud_id24").GetBool() ||
			( isId1 && id1WeapSwap && cell != null && ( hasPlasmaRifle || hasBfg9000 ) ) ||
			( isId1 && !id1WeapSwap && fuel != null && ( hasIncinerator || hasHeatwave ) ) ||
			( !isId1 && id1WeapSwapAlways && cell != null && ( hasPlasmaRifle || hasBfg9000 ) ) ||
			( !isId1 && !id1WeapSwapAlways && fuel != null && ( hasIncinerator || hasHeatwave ) ) )
		{
			DrawImage("STAMMO24", (249, 168), DI_ITEM_OFFSETS);
			int amt1, maxamt;
			[amt1, maxamt] = GetAmount("Clip");
			DrawString(mIndexFont, FormatNumber(amt1, 3), (288, 169), DI_TEXT_ALIGN_RIGHT);
			DrawString(mIndexFont, FormatNumber(maxamt, 3), (314, 169), DI_TEXT_ALIGN_RIGHT);
			
			[amt1, maxamt] = GetAmount("Shell");
			DrawString(mIndexFont, FormatNumber(amt1, 3), (288, 175), DI_TEXT_ALIGN_RIGHT);
			DrawString(mIndexFont, FormatNumber(maxamt, 3), (314, 175), DI_TEXT_ALIGN_RIGHT);
			
			[amt1, maxamt] = GetAmount("RocketAmmo");
			DrawString(mIndexFont, FormatNumber(amt1, 3), (288, 181), DI_TEXT_ALIGN_RIGHT);
			DrawString(mIndexFont, FormatNumber(maxamt, 3), (314, 181), DI_TEXT_ALIGN_RIGHT);
			
			[amt1, maxamt] = GetAmount("Cell");
			DrawString(mIndexFont, FormatNumber(amt1, 3), (288, 187), DI_TEXT_ALIGN_RIGHT);
			DrawString(mIndexFont, FormatNumber(maxamt, 3), (314, 187), DI_TEXT_ALIGN_RIGHT);
			
			[amt1, maxamt] = GetAmount("ID24Fuel");
			DrawString(mIndexFont, FormatNumber(amt1, 3), (288, 193), DI_TEXT_ALIGN_RIGHT);
			DrawString(mIndexFont, FormatNumber(maxamt, 3), (314, 193), DI_TEXT_ALIGN_RIGHT);
		}
		else
		{
			int amt1, maxamt;
			[amt1, maxamt] = GetAmount("Clip");
			DrawString(mIndexFont, FormatNumber(amt1, 3), (288, 173), DI_TEXT_ALIGN_RIGHT);
			DrawString(mIndexFont, FormatNumber(maxamt, 3), (314, 173), DI_TEXT_ALIGN_RIGHT);
			
			[amt1, maxamt] = GetAmount("Shell");
			DrawString(mIndexFont, FormatNumber(amt1, 3), (288, 179), DI_TEXT_ALIGN_RIGHT);
			DrawString(mIndexFont, FormatNumber(maxamt, 3), (314, 179), DI_TEXT_ALIGN_RIGHT);
			
			[amt1, maxamt] = GetAmount("RocketAmmo");
			DrawString(mIndexFont, FormatNumber(amt1, 3), (288, 185), DI_TEXT_ALIGN_RIGHT);
			DrawString(mIndexFont, FormatNumber(maxamt, 3), (314, 185), DI_TEXT_ALIGN_RIGHT);
			
			if ( ( isId1 && id1WeapSwap ) || id1WeapSwapAlways )
			{
				[amt1, maxamt] = GetAmount("ID24Fuel");
				DrawString(mIndexFont, FormatNumber(amt1, 3), (288, 191), DI_TEXT_ALIGN_RIGHT);
				DrawString(mIndexFont, FormatNumber(maxamt, 3), (314, 191), DI_TEXT_ALIGN_RIGHT);
			}
			else
			{
				[amt1, maxamt] = GetAmount("Cell");
				DrawString(mIndexFont, FormatNumber(amt1, 3), (288, 191), DI_TEXT_ALIGN_RIGHT);
				DrawString(mIndexFont, FormatNumber(maxamt, 3), (314, 191), DI_TEXT_ALIGN_RIGHT);
			}
		}
	}
	
	protected virtual void DrawBarWeapons()
	{
		DrawImage("STARMS", (104, 168), DI_ITEM_OFFSETS);
		DrawImage(CPlayer.HasWeaponsInSlot(2)? "STYSNUM2" : "STGNUM2", (111, 172), DI_ITEM_OFFSETS);
		DrawImage(CPlayer.HasWeaponsInSlot(3)? "STYSNUM3" : "STGNUM3", (123, 172), DI_ITEM_OFFSETS);
		DrawImage(CPlayer.HasWeaponsInSlot(4)? "STYSNUM4" : "STGNUM4", (135, 172), DI_ITEM_OFFSETS);
		DrawImage(CPlayer.HasWeaponsInSlot(5)? "STYSNUM5" : "STGNUM5", (111, 182), DI_ITEM_OFFSETS);
		DrawImage(CPlayer.HasWeaponsInSlot(6)? "STYSNUM6" : "STGNUM6", (123, 182), DI_ITEM_OFFSETS);
		DrawImage(CPlayer.HasWeaponsInSlot(7)? "STYSNUM7" : "STGNUM7", (135, 182), DI_ITEM_OFFSETS);
	}

	protected void DrawFullScreenStuff ()
	{
		String mapName = Level.MapName.MakeLower();
		let isId1 = mapName.Left(3) == "lr_";
		let id1WeapSwap = CVar.FindCVar("wf_id1_weapswap").GetInt() == 1;
		let id1WeapSwapAlways = CVar.FindCVar("wf_id1_weapswap").GetInt() >= 2;
		
		let hudSwapHealthArmor = CVar.FindCVar("wf_hud_swaphealtharmor").GetFloat();
		int ultraWide = CVar.FindCVar("wf_hud_ultrawide").GetInt();
		let altHud = CVar.FindCVar("wf_hud_alt").GetFloat();
		
		if ( CVar.FindCVar("wf_hud_ultrawide_fullscreen").GetBool() && !CVar.FindCVar("vid_fullscreen").GetBool() )
			ultraWide = 0;
		
		// Draw original fullscreen HUD
		if ( !altHud )
		{
			Vector2 iconbox = (40, 20);
			// Draw health
			int hudHealthOffset;
			if ( hudSwapHealthArmor )
					hudHealthOffset = 20;
			
			let berserk = CPlayer.mo.FindInventory("PowerStrength");
			DrawImage(berserk? "PSTRA0" : "MEDIA0", (20 + ultraWide, -2 - hudHealthOffset));
			DrawString(mHUDFont, FormatNumber(CPlayer.health, 3), (44 + ultraWide, -20 - hudHealthOffset));
			
			// Draw armor
			let armor = CPlayer.mo.FindInventory("BasicArmor");
			if (armor != null && armor.Amount > 0)
			{
				DrawInventoryIcon(armor, (20 + ultraWide, -22 + hudHealthOffset));
				DrawString(mHUDFont, FormatNumber(armor.Amount, 3), (44 + ultraWide, -40 + hudHealthOffset));
			}
			
			// Draw inventory
			Inventory ammotype1, ammotype2;
			[ammotype1, ammotype2] = GetCurrentAmmo();
			int invY = -20;
			if (ammotype1 != null)
			{
				DrawInventoryIcon(ammotype1, (-14 - ultraWide, -4));
				DrawString(mHUDFont, FormatNumber(ammotype1.Amount, 3), (-30 - ultraWide, -20), DI_TEXT_ALIGN_RIGHT);
				invY -= 20;
			}
			if (ammotype2 != null && ammotype2 != ammotype1)
			{
				DrawInventoryIcon(ammotype2, (-14 - ultraWide, invY + 17));
				DrawString(mHUDFont, FormatNumber(ammotype2.Amount, 3), (-30 - ultraWide, invY), DI_TEXT_ALIGN_RIGHT);
				invY -= 20;
			}
			if (!isInventoryBarVisible() && !Level.NoInventoryBar && CPlayer.mo.InvSel != null)
			{
				DrawInventoryIcon(CPlayer.mo.InvSel, (-14 - ultraWide, invY + 17), DI_DIMDEPLETED);
				DrawString(mHUDFont, FormatNumber(CPlayer.mo.InvSel.Amount, 3), (-30 - ultraWide, invY), DI_TEXT_ALIGN_RIGHT);
			}
			
			if (deathmatch)
				DrawString(mHUDFont, FormatNumber(CPlayer.FragCount, 3), (-3 - ultraWide, 1), DI_TEXT_ALIGN_RIGHT, Font.CR_GOLD);
			else
				DrawFullscreenKeys();
			
			if (isInventoryBarVisible())
				DrawInventoryBar(diparms, (0, 0), 7, DI_SCREEN_CENTER_BOTTOM, HX_SHADOW);
		}
		// Draw alternate fullscreen HUD
		else
		{
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
			
			let fist           = CPlayer.ReadyWeapon && CPlayer.ReadyWeapon.GetClassName() == "Fist";
			let chainsaw       = CPlayer.ReadyWeapon && CPlayer.ReadyWeapon.GetClassName() == "Chainsaw";
			let pistol         = CPlayer.ReadyWeapon && CPlayer.ReadyWeapon.GetClassName() == "Pistol";
			let shotgun        = CPlayer.ReadyWeapon && CPlayer.ReadyWeapon.GetClassName() == "Shotgun";
			let superShotgun   = CPlayer.ReadyWeapon && CPlayer.ReadyWeapon.GetClassName() == "SuperShotgun";
			let chaingun       = CPlayer.ReadyWeapon && CPlayer.ReadyWeapon.GetClassName() == "Chaingun";
			let rocketLauncher = CPlayer.ReadyWeapon && CPlayer.ReadyWeapon.GetClassName() == "RocketLauncher";
			let incinerator    = CPlayer.ReadyWeapon && CPlayer.ReadyWeapon.GetClassName() == "ID24Incinerator";
			let plasmaRifle    = CPlayer.ReadyWeapon && CPlayer.ReadyWeapon.GetClassName() == "PlasmaRifle";
			let heatwave       = CPlayer.ReadyWeapon && CPlayer.ReadyWeapon.GetClassName() == "ID24CalamityBlade";
			let bfg9000        = CPlayer.ReadyWeapon && CPlayer.ReadyWeapon.GetClassName() == "BFG9000";
			
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
			
			let blurSphere            = Powerup(CPlayer.mo.FindInventory("PowerInvisibility"));
			let invulnerabilitySphere = Powerup(CPlayer.mo.FindInventory("PowerInvulnerable"));
			let infrared              = Powerup(CPlayer.mo.FindInventory("PowerLightAmp"));
			let radSuit               = Powerup(CPlayer.mo.FindInventory("PowerIronFeet"));
			
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
						ammoType1Low = (ammotype1.MaxAmount * 0.25) / 2;
					if ( ammotype2 != null )
						ammoType2Low = (ammotype2.MaxAmount * 0.25) / 2;
				}
				else
				{
					if ( ammotype1 != null )
						ammoType1Low = ammotype1.MaxAmount * 0.25;
					if ( ammotype2 != null )
						ammoType2Low = ammotype2.MaxAmount * 0.25;
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
					if ( ( isId1 && id1WeapSwap ) || ( hasIncinerator || hasHeatwave ) ||
						id1WeapSwapAlways || CVar.FindCVar("wf_hud_id24").GetBool() )
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
					if ( !( isId1 && id1WeapSwap ) || ( hasPlasmaRifle || hasBfg9000 ) ||
						CVar.FindCVar("wf_hud_id24").GetBool() )
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
						DrawString(mSmallFont, mapMonsters, (statsPos.X + 16, statsPos.Y),
								   DI_SCREEN_LEFT_BOTTOM, Font.CR_GREEN, statsAlpha);
					statsPos.Y -= statsPosYIncrement;
					}
				}
			}
			
			// Draw powerups
			Vector2 powerupPos = (-18 - ultraWide, -4 + ammoInvPos.Y);
			int powerupPosYIncrement = 30;
			int powerupCount;
			
			if ( altHudPowerup )
			{
				if ( blurSphere != null )
				{
					int blurSphereTime = int(Ceil(double(blurSphere.EffectTics) / GameTicRate));
					DrawImage("PINSA0", powerupPos, DI_SCREEN_RIGHT_BOTTOM, powerupAlpha);
					DrawString(mConFont, FormatNumber(blurSphereTime, 1), (powerupPos.X, powerupPos.Y - 8),
							   DI_SCREEN_RIGHT_BOTTOM|DI_TEXT_ALIGN_CENTER, Font.CR_WHITE, powerupAlpha);
					powerupPos.Y -= powerupPosYIncrement;
					powerupCount++;
				}
				
				if ( invulnerabilitySphere != null )
				{
					int invulnerabilitySphereTime = int(Ceil(double(invulnerabilitySphere.EffectTics) / GameTicRate));
					DrawImage("PINVA0", powerupPos, DI_SCREEN_RIGHT_BOTTOM, powerupAlpha);
					DrawString(mConFont, FormatNumber(invulnerabilitySphereTime, 1), (powerupPos.X, powerupPos.Y - 8),
							   DI_SCREEN_RIGHT_BOTTOM|DI_TEXT_ALIGN_CENTER, Font.CR_WHITE, powerupAlpha);
					powerupPos.Y -= powerupPosYIncrement;
					powerupCount++;
				}
				
				if ( infrared != null )
				{
					int infraredTime = int(Ceil(double(infrared.EffectTics) / GameTicRate));
					DrawImage("PVISA0", powerupPos, DI_SCREEN_RIGHT_BOTTOM, powerupAlpha);
					DrawString(mConFont, FormatNumber(infraredTime, 1), (powerupPos.X, powerupPos.Y - 8),
							   DI_SCREEN_RIGHT_BOTTOM|DI_TEXT_ALIGN_CENTER, Font.CR_WHITE, powerupAlpha);
					powerupPos.Y -= powerupPosYIncrement;
					powerupCount++;
				}
				
				if (radSuit != null)
				{
					int radSuitTime = int(Ceil(double(radSuit.EffectTics) / GameTicRate));
					if ( infrared )
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
				if ( fist )
					DrawString(mIndexFont, "1", weapInvPos, DI_SCREEN_RIGHT_BOTTOM,
							   hasBerserk ? Font.CR_RED : Font.CR_GOLD, weapInvAlpha);
				else if ( hasFist )
					DrawString(mIndexFont, "1", weapInvPos, DI_SCREEN_RIGHT_BOTTOM,
							   hasBerserk ? Font.CR_RED : Font.CR_WHITE, weapInvInactiveAlpha);
				
				weapInvPos.X += weapInvPosXIncrement;
				if ( chainsaw )
					DrawString(mIndexFont, "1", weapInvPos, DI_SCREEN_RIGHT_BOTTOM, Font.CR_GOLD, weapInvAlpha);
				else if ( hasChainsaw )
					DrawString(mIndexFont, "1", weapInvPos, DI_SCREEN_RIGHT_BOTTOM, Font.CR_WHITE, weapInvInactiveAlpha);
				
				weapInvPos.X += weapInvPosXIncrement;
				if ( pistol )
					DrawString(mIndexFont, "2", weapInvPos, DI_SCREEN_RIGHT_BOTTOM, Font.CR_GOLD, weapInvAlpha);
				else if ( hasPistol )
					DrawString(mIndexFont, "2", weapInvPos, DI_SCREEN_RIGHT_BOTTOM, Font.CR_WHITE, weapInvInactiveAlpha);
				
				weapInvPos.X += weapInvPosXIncrement;
				if ( shotgun )
					DrawString(mIndexFont, "3", weapInvPos, DI_SCREEN_RIGHT_BOTTOM, Font.CR_GOLD, weapInvAlpha);
				else if ( hasShotgun )
					DrawString(mIndexFont, "3", weapInvPos, DI_SCREEN_RIGHT_BOTTOM, Font.CR_WHITE, weapInvInactiveAlpha);
				
				if ( !( mapName.Left(1) == "e" && mapName.Mid(2, 1) == "m" && !hasSuperShotgun ) )
					weapInvPos.X += weapInvPosXIncrement;
				
				if ( superShotgun )
					DrawString(mIndexFont, "3", weapInvPos, DI_SCREEN_RIGHT_BOTTOM, Font.CR_GOLD, weapInvAlpha);
				else if ( hasSuperShotgun )
					DrawString(mIndexFont, "3", weapInvPos, DI_SCREEN_RIGHT_BOTTOM, Font.CR_WHITE, weapInvInactiveAlpha);
				
				weapInvPos.X += weapInvPosXIncrement;
				if ( chaingun )
					DrawString(mIndexFont, "4", weapInvPos, DI_SCREEN_RIGHT_BOTTOM, Font.CR_GOLD, weapInvAlpha);
				else if ( hasChaingun )
					DrawString(mIndexFont, "4", weapInvPos, DI_SCREEN_RIGHT_BOTTOM, Font.CR_WHITE, weapInvInactiveAlpha);
				
				weapInvPos.X += weapInvPosXIncrement;
				if ( rocketLauncher )
					DrawString(mIndexFont, "5", weapInvPos, DI_SCREEN_RIGHT_BOTTOM, Font.CR_GOLD, weapInvAlpha);
				else if ( hasRocketLauncher )
					DrawString(mIndexFont, "5", weapInvPos, DI_SCREEN_RIGHT_BOTTOM, Font.CR_WHITE, weapInvInactiveAlpha);
				
				weapInvPos.X += weapInvPosXIncrement;
				if ( incinerator )
					DrawString(mIndexFont, "6", weapInvPos, DI_SCREEN_RIGHT_BOTTOM, Font.CR_GOLD, weapInvAlpha);
				else if ( hasIncinerator )
					DrawString(mIndexFont, "6", weapInvPos, DI_SCREEN_RIGHT_BOTTOM, Font.CR_WHITE, weapInvInactiveAlpha);
				
				if ( ( hasPlasmaRifle || hasBfg9000 ) && ( hasIncinerator || hasHeatwave ) )
					weapInvPos.X += weapInvPosXIncrement;
				
				if ( plasmaRifle )
					DrawString(mIndexFont, "6", weapInvPos, DI_SCREEN_RIGHT_BOTTOM, Font.CR_GOLD, weapInvAlpha);
				else if ( hasPlasmaRifle )
					DrawString(mIndexFont, "6", weapInvPos, DI_SCREEN_RIGHT_BOTTOM, Font.CR_WHITE, weapInvInactiveAlpha);
				
				weapInvPos.X += weapInvPosXIncrement;
				if ( heatwave )
					DrawString(mIndexFont, "7", weapInvPos, DI_SCREEN_RIGHT_BOTTOM, Font.CR_GOLD, weapInvAlpha);
				else if ( hasHeatwave )
					DrawString(mIndexFont, "7", weapInvPos, DI_SCREEN_RIGHT_BOTTOM, Font.CR_WHITE, weapInvInactiveAlpha);
				
				if ( hasIncinerator || hasHeatwave )
					weapInvPos.X += weapInvPosXIncrement;
				
				if ( bfg9000 )
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
	
	protected virtual void DrawFullscreenKeys()
	{
		// Draw the keys. This does not use a special draw function like SBARINFO because the specifics will be different for each mod
		// so it's easier to copy or reimplement the following piece of code instead of trying to write a complicated all-encompassing solution.
		int ultraWide = CVar.FindCVar("wf_hud_ultrawide").GetInt();
		if ( CVar.FindCVar("wf_hud_ultrawide_fullscreen").GetBool() && !CVar.FindCVar("vid_fullscreen").GetBool() )
			ultraWide = 0;
		
		Vector2 keypos = (-10 - ultraWide, 2);
		int rowc = 0;
		double roww = 0;
		for(let i = CPlayer.mo.Inv; i != null; i = i.Inv)
		{
			if (i is "Key" && i.Icon.IsValid())
			{
				DrawTexture(i.Icon, keypos, DI_SCREEN_RIGHT_TOP|DI_ITEM_LEFT_TOP);
				Vector2 size = TexMan.GetScaledSize(i.Icon);
				keypos.Y += size.Y + 2;
				roww = max(roww, size.X);
				if (++rowc == 3)
				{
					keypos.Y = 2;
					keypos.X -= roww + 2;
					roww = 0;
					rowc = 0;
				}
			}
		}
	}
}
