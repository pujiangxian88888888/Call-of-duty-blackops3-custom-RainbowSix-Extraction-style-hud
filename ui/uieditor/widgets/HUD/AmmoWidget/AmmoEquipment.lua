---@diagnostic disable: undefined-global
CoD.AmmoEquipment = InheritFrom( LUI.UIElement )
CoD.AmmoEquipment.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.AmmoEquipment )
	self.id = "AmmoEquipment"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 1280 )
	self:setTopBottom( true, false, 0, 720 )
	self.anyChildUsesUpdateState = true

	--TODO:对所有的装备：玩家未持有不显示图标，玩家持有但当前数量为0设置alpha为0.6
	--致命装备的图标
	self.LethalImage = LUI.UIImage.new()
	self.LethalImage:setLeftRight( false, true, -257, -182 )
	--左右：两个参数同时下降，对象往左移动
	self.LethalImage:setTopBottom( false, true, -95, -7.5 )
	--上下：两个参数同时下降，对象往上移动
	self.LethalImage:setImage( RegisterImage( "blacktransparent" ) )
	self.LethalImage:setScale( 0.3 )
		
	self.LethalImage:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentPrimaryOffhand.primaryOffhand" ), function ( modelRef )
		if Engine.GetModelValue( modelRef ) then
			if Engine.GetModelValue( modelRef ) == "uie_t7_zm_hud_inv_icnlthl" then
				self.LethalImage:setImage( RegisterImage( "ui_icon_frag" ) )
			elseif Engine.GetModelValue( modelRef ) == "uie_t7_zm_hud_inv_widowswine" then
				self.LethalImage:setImage( RegisterImage( "ui_icon_semtex" ) )
			else
				self.LethalImage:setImage( RegisterImage( Engine.GetModelValue( modelRef ) ) )
			end
		end
	end )

	self:addElement( self.LethalImage )

	--致命装备按键字母背景图标
	self.LethalPromptBG = LUI.UIImage.new()
	self.LethalPromptBG:setLeftRight( false, true, -237, -201 )
	self.LethalPromptBG:setTopBottom( false, true, -43, -7 )
	self.LethalPromptBG:setImage( RegisterImage( "ui_icon_key_prompt_bg" ) )
	self.LethalPromptBG:setScale( 0.65 )
	self:addElement( self.LethalPromptBG )

	
	--致命装备的按键文本
	self.LethalPromptText = LUI.UIText.new()
	self.LethalPromptText:setLeftRight( false, true, -317.3, -120.3 )
	self.LethalPromptText:setTopBottom( false, true, -33, -15.5 )
	self.LethalPromptText:setTTF( "fonts/Scout.ttf" ) 
	self.LethalPromptText:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
	self.LethalPromptText:setRGB( 0.5, 0.5, 0.5 )
	self:addElement( self.LethalPromptText )

	self.LethalPromptTimer = LUI.UITimer.newElementTimer( 0, false, function ( timerEvent )
		if Engine.LastInput_Gamepad() then
			self.LethalPromptText:setScale( 0.5 )
			self.LethalPromptText:setText( Engine.Localize( "[{+frag}]" ) )
		else
			self.LethalPromptText:setScale( 0.8 )
			self.LethalPromptText:setText( Engine.Localize( "[{+frag}]" ) )

			if string.match( Engine.GetKeyBindingLocalizedString( controller, "+frag" ), "UNBOUND" ) then
				self.LethalPromptText:setText( Engine.Localize( "" ) )
			end
				
			if string.match( Engine.GetKeyBindingLocalizedString( controller, "+frag" ), "%s" ) then
				if string.len( Engine.GetKeyBindingLocalizedString( controller, "+frag" ):match("^(.-)%s") ) > 1 then
					if string.len( Engine.GetKeyBindingLocalizedString( controller, "+frag" ):reverse():match("^(.-)%s") ) > 1 then
						self.LethalPromptText:setText( Engine.Localize( "" ) )--如果玩家在此处绑定了两个键或者是鼠标中键，导致返回字符串太长，就直接不显示文本
						 												      --后续战术装备，地雷，专家武器等等按键文本同理
					else
						self.LethalPromptText:setText( Engine.Localize( Engine.GetKeyBindingLocalizedString( controller, "+frag" ):reverse():match("^(.-)%s") ) )
					end
				else
					self.LethalPromptText:setText( Engine.Localize( Engine.GetKeyBindingLocalizedString( controller, "+frag" ):match("^(.-)%s") ) )
				end
			end
		end
	end )
	self:addElement( self.LethalPromptTimer )

	--致命装备的数量文本
	self.LethalCountText = LUI.UIText.new()
	self.LethalCountText:setLeftRight( false, true, -228, -208.5 )
	self.LethalCountText:setTopBottom( false, true, -85.5, -73 )
	self.LethalCountText:setText( Engine.Localize( "0" ) )
	self.LethalCountText:setTTF( "fonts/Scout.ttf" )
	self.LethalCountText:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
	self.LethalCountText:setRGB( 0.7, 0.7, 0.7 )
	self.LethalCountText:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentPrimaryOffhand.primaryOffhandCount" ), function ( modelRef )
		if Engine.GetModelValue( modelRef ) then
			self.LethalCountText:setText( Engine.Localize( Engine.GetModelValue( modelRef ) ) )
			if Engine.GetModelValue( modelRef ) == 0 then
				self.LethalImage:setAlpha( 0.6 )
			else
				self.LethalImage:setAlpha( 1 )
			end
		end
	end )
	self:addElement( self.LethalCountText )

	--战术装备的图标
	self.TacticalImage = LUI.UIImage.new()
	self.TacticalImage:setLeftRight( false, true, -212, -168.5 )
	self.TacticalImage:setTopBottom( false, true, -86.5, -18 )
	self.TacticalImage:setImage( RegisterImage( "blacktransparent" ) )
	self.TacticalImage:setScale( 0.45 )
	self.TacticalImage:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "CurrentSecondaryOffhand.secondaryOffhand" ), function ( modelRef )
		if Engine.GetModelValue( modelRef ) then
			if Engine.GetModelValue( modelRef ) == "hud_cymbal_monkey_bo3" then
				self.TacticalImage:setImage( RegisterImage( "ui_icon_monkeybomb" ) )
			else
				self.TacticalImage:setImage( RegisterImage( Engine.GetModelValue( modelRef ) ) )
			end
		end
	end )
	self:addElement( self.TacticalImage )

	--战术装备按键字母背景
	self.TacticalPromptBG = LUI.UIImage.new()
	self.TacticalPromptBG:setLeftRight( false, true, -207, -171 )
	self.TacticalPromptBG:setTopBottom( false, true, -43, -7 )
	self.TacticalPromptBG:setImage( RegisterImage( "ui_icon_key_prompt_bg" ) )
	self.TacticalPromptBG:setScale( 0.65 )
	self:addElement( self.TacticalPromptBG )

	--战术装备的按键文本
	self.TacticalPromptText = LUI.UIText.new()
	self.TacticalPromptText:setLeftRight( false, true, -286.5, -89.5)
	self.TacticalPromptText:setTopBottom( false, true, -33, -15.5 )
	self.TacticalPromptText:setTTF( "fonts/Scout.ttf" )
	self.TacticalPromptText:setRGB( 0.5, 0.5, 0.5 )
	--self.TacticalPromptText:setScale( 0.8 )
	self.TacticalPromptText:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
	self:addElement( self.TacticalPromptText )

	self.TacticalPromptTimer = LUI.UITimer.newElementTimer( 0, false, function ( timerEvent )
		if Engine.LastInput_Gamepad() then
			self.TacticalPromptText:setScale( 0.5 )
			self.TacticalPromptText:setText( Engine.Localize( "[{+smoke}]" ) )
		else
			self.TacticalPromptText:setScale( 0.8 )
			self.TacticalPromptText:setText( Engine.Localize( "[{+smoke}]" ) )

			if string.match( Engine.GetKeyBindingLocalizedString( controller, "+smoke" ), "UNBOUND" ) then
				self.TacticalPromptText:setText( Engine.Localize( "" ) )
			end
				
			if string.match( Engine.GetKeyBindingLocalizedString( controller, "+smoke" ), "%s" ) then
				if string.len( Engine.GetKeyBindingLocalizedString( controller, "+smoke" ):match("^(.-)%s") ) > 1 then
					if string.len( Engine.GetKeyBindingLocalizedString( controller, "+smoke" ):reverse():match("^(.-)%s") ) > 1 then
						self.TacticalPromptText:setText( Engine.Localize( "" ) ) 
					else
						self.TacticalPromptText:setText( Engine.Localize( Engine.GetKeyBindingLocalizedString( controller, "+smoke" ):reverse():match("^(.-)%s") ) )
					end
				else
					self.TacticalPromptText:setText( Engine.Localize( Engine.GetKeyBindingLocalizedString( controller, "+smoke" ):match("^(.-)%s") ) )
				end
			end
		end
	end )
	self:addElement( self.TacticalPromptTimer )

	--战术装备的数量文本
	self.TacticalCountText = LUI.UIText.new()
	self.TacticalCountText:setLeftRight( false, true, -197, -177.5 )
	self.TacticalCountText:setTopBottom( false, true, -85.5, -73 )
	self.TacticalCountText:setText( Engine.Localize( "0" ) )
	self.TacticalCountText:setTTF( "fonts/Scout.ttf" )
	self.TacticalCountText:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
	--self.TacticalCountText:setScale( 1.2 )
	self.TacticalCountText:setRGB( 0.7, 0.7, 0.7 )
	self.TacticalCountText:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentSecondaryOffhand.secondaryOffhandCount" ), function ( modelRef )
		if Engine.GetModelValue( modelRef ) then
			self.TacticalCountText:setText( Engine.Localize( Engine.GetModelValue( modelRef ) ) )
			if Engine.GetModelValue( modelRef ) == 0 then
				self.TacticalImage:setAlpha( 0.6 )
			else
				self.TacticalImage:setAlpha( 1 )
			end	
		end
	end )
	self:addElement( self.TacticalCountText )

	--专家武器图标背景
	self.SpecialBG = LUI.UIImage.new()
	self.SpecialBG:setLeftRight( false, true, -102, -32 )
	self.SpecialBG:setTopBottom( false, true, -215.5, -145.5 )
	self.SpecialBG:setImage( RegisterImage( "ui_icon_hero_weapon_bg" ) )
	self.SpecialBG:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
	--self.SpecialBG:setScale(0.8)
	self.SpecialBG:setAlpha(0.8)
	self:addElement( self.SpecialBG )
	
	--专家武器图标
	self.SpecialImage = LUI.UIImage.new()
	self.SpecialImage:setLeftRight( false, true, -92, -38.5 )
	self.SpecialImage:setTopBottom( false, true, -215.5, -162 )
	self.SpecialImage:setImage( RegisterImage( "blacktransparent" ) )
	self.SpecialImage:setScale( 1.5 )
	--self.SpecialImage:setScale( 0.5 )
	self:addElement( self.SpecialImage )

	local HeroIcon = function(ModelRef)
		local HeroWeapon = Engine.GetModelValue(ModelRef)
		if HeroWeapon == 0 then --歼灭者
			self.SpecialImage:setImage(RegisterImage( "uie_t7_zm_derriese_hud_ammo_icon_gun" ) )
		elseif HeroWeapon == 1 then --重力尖刺
			self.SpecialImage:setImage(RegisterImage("t7_hud_zm_hud_ammo_icon_spike"))
		elseif HeroWeapon == 2 then --雷神颅骨
			self.SpecialImage:setImage(RegisterImage("t7_hud_zm_hud_ammo_icon_skull_weapon"))
		elseif HeroWeapon == 3 then --幼龙
			self.SpecialImage:setImage(RegisterImage("uie_t7_zm_dragon_gauntlet_ammo_icon_gun"))
		elseif HeroWeapon == 4 then --守护者之剑
			self.SpecialImage:setImage(RegisterImage("uie_t7_zm_hud_ammo_dpadicnswrd_weapon"))
		else
			self.SpecialImage:setImage(RegisterImage("blacktransparent"))
		end
	end	
	menu:subscribeToModel(Engine.GetModel(Engine.GetModelForController(controller), "hudItems.hero_weapon_icon"), HeroIcon)

	--专家武器按键背景
	self.SpecialPromptTextBG = LUI.UIImage.new()
	self.SpecialPromptTextBG:setLeftRight( false, true, -81.5, -45.5 )
	self.SpecialPromptTextBG:setTopBottom( false, true, -149, -113 )
	self.SpecialPromptTextBG:setImage( RegisterImage( "ui_icon_key_prompt_bg") )
	self.SpecialPromptTextBG:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
	self.SpecialPromptTextBG:setScale( 0.65 )
	self:addElement( self.SpecialPromptTextBG )

	
	
	--专家武器按键文本
	self.SpecialPromptText = LUI.UIText.new()
	self.SpecialPromptText:setLeftRight( false, true, -140.4, 6.6 )
	self.SpecialPromptText:setTopBottom( false, true, -143.3, -125.8 )
	self.SpecialPromptText:setTTF( "fonts/Scout.ttf" )
	self.SpecialPromptText:setRGB( 0.5, 0.5, 0.5 )
	self.SpecialPromptText:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
	self:addElement( self.SpecialPromptText )

	self.SpecialPromptTimer = LUI.UITimer.newElementTimer( 0, false, function ( timerEvent )
		if Engine.LastInput_Gamepad() then
			self.SpecialPromptText:setScale( 0.5 )
			self.SpecialPromptText:setText( Engine.Localize( "[{+smoke}] + [{+frag}]" ) )
		else
			self.SpecialPromptText:setScale( 0.8 )
			self.SpecialPromptText:setText( Engine.Localize( "[{+weaphero}]" ) )

			if string.match( Engine.GetKeyBindingLocalizedString( controller, "+weaphero" ), "UNBOUND" ) then
				self.SpecialPromptText:setText( Engine.Localize( "" ) )
			end
				
			if string.match( Engine.GetKeyBindingLocalizedString( controller, "+weaphero" ), "%s" ) then
				if string.len( Engine.GetKeyBindingLocalizedString( controller, "+weaphero" ):match("^(.-)%s") ) > 1 then
					if string.len( Engine.GetKeyBindingLocalizedString( controller, "+weaphero" ):reverse():match("^(.-)%s") ) > 1 then
						self.SpecialPromptText:setText( Engine.Localize( "" ) )
					else
						self.SpecialPromptText:setText( Engine.Localize( Engine.GetKeyBindingLocalizedString( controller, "+weaphero" ):reverse():match("^(.-)%s") ) )
					end
				else
					self.SpecialPromptText:setText( Engine.Localize( Engine.GetKeyBindingLocalizedString( controller, "+weaphero" ):match("^(.-)%s") ) )
				end
			end
		end
	end )
	self:addElement( self.SpecialPromptTimer )

	--专家武器充能进度条
	self.SpecialMeter = LUI.UIImage.new()
	self.SpecialMeter:setLeftRight( false, true, -102, -32 )
	self.SpecialMeter:setTopBottom( false, true, -215.5, -145.5 )
	self.SpecialMeter:setImage( RegisterImage( "t8_hud_hero_weapon_progress" ) )
	self.SpecialMeter:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_clock_normal" ) )
	--self.SpecialMeter:setZRot( 90 )
	self.SpecialMeter:setShaderVector( 0, 1, 0, 0, 0 )
	self.SpecialMeter:setShaderVector( 1, 0.5, 0, 0, 0 )
	self.SpecialMeter:setShaderVector( 2, 0.5, 0, 0, 0 )
	self.SpecialMeter:setShaderVector( 3, 0, 0, 0, 0 )
	self.SpecialMeter:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "zmhud.swordEnergy" ), function ( modelRef )
		if Engine.GetModelValue( modelRef ) then
			self.SpecialMeter:setShaderVector( 0, AdjustStartEnd( 0, 1,
				CoD.GetVectorComponentFromString( Engine.GetModelValue( modelRef ), 1 ),
				CoD.GetVectorComponentFromString( Engine.GetModelValue( modelRef ), 2 ),
				CoD.GetVectorComponentFromString( Engine.GetModelValue( modelRef ), 3 ),
				CoD.GetVectorComponentFromString( Engine.GetModelValue( modelRef ), 4 ) )
			)
		end
	end )
	self:addElement( self.SpecialMeter )

	--地雷图标
	--TODO:要求在玩家没有购买地雷时，不显示图标，购买了地雷且数量不为0，显示图标不透明度为1，购买了地雷且数量为0，显示图标不透明度为0.6
	self.DpadIconMine = LUI.UIImage.new()
	self.DpadIconMine:setLeftRight( false, true, -115, -87 )
	self.DpadIconMine:setTopBottom( false, true, -60.5, -37 )
	self.DpadIconMine:setImage( RegisterImage( "blacktransparent" ) )
	self.DpadIconMine:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.actionSlot3ammo" ), function ( modelRef )
		if Engine.GetModelValue( modelRef ) then
			self.DpadIconMine:setImage( RegisterImage( "ui_icon_tripmine" ) )
		else
			self.DpadIconMine:setImage( RegisterImage( "blacktransparent" ) )
		end
	end )
	self:addElement( self.DpadIconMine )

	--地雷数量文本
	self.DpadIconMineCountText = LUI.UIText.new()
	self.DpadIconMineCountText:setLeftRight( false, true, -111, -91.5 )
	self.DpadIconMineCountText:setTopBottom( false, true, -85.5, -73 )
	self.DpadIconMineCountText:setText( Engine.Localize( "0" ) )
	self.DpadIconMineCountText:setTTF( "fonts/Scout.ttf" )
	self.DpadIconMineCountText:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
	--self.DpadIconMineCountText:setScale( 1.2 )
	self.DpadIconMineCountText:setRGB( 0.7, 0.7, 0.7 )
	self.DpadIconMineCountText:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.actionSlot3ammo" ), function ( modelRef )
		if Engine.GetModelValue( modelRef ) then
			if Engine.GetModelValue( modelRef ) > 0 then
				self.DpadIconMineCountText:setText( Engine.Localize( Engine.GetModelValue( modelRef ) ) )
				self.DpadIconMine:setAlpha(1)
			else
				self.DpadIconMineCountText:setText( Engine.Localize( "0" ) )
				self.DpadIconMine:setAlpha( 0.6 )
			end
		end
	end )
	self:addElement( self.DpadIconMineCountText )

	--地雷按键字母背景
	self.DpadIconMinePromptBG = LUI.UIImage.new()
	self.DpadIconMinePromptBG:setLeftRight( false, true, -122, -86 )
	self.DpadIconMinePromptBG:setTopBottom( false, true, -43, -7 )
	self.DpadIconMinePromptBG:setImage( RegisterImage( "ui_icon_key_prompt_bg" ) )
	self.DpadIconMinePromptBG:setScale( 0.65 )
	self:addElement( self.DpadIconMinePromptBG )

	--地雷按键文本
	self.DpadIconMinePromptText = LUI.UIText.new()
	self.DpadIconMinePromptText:setLeftRight(false,true, -202, -5) 
	self.DpadIconMinePromptText:setTopBottom(false,true, -33, -15.5)
	self.DpadIconMinePromptText:setTTF( "fonts/Scout.ttf" )
	self.DpadIconMinePromptText:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
	self.DpadIconMinePromptText:setText( "[{+actionslot 4}]" )
	self.DpadIconMinePromptText:setScale( 0.8 )
	self.DpadIconMinePromptText:setRGB( 0.5, 0.5, 0.5 )
	self:addElement( self.DpadIconMinePromptText )

	self.ShieldImage = LUI.UIImage.new()
	self.ShieldImage:setLeftRight( false, true, -162, -108.5 )
	self.ShieldImage:setTopBottom( false, true, -77, -23 )
	self.ShieldImage:setImage( RegisterImage( "blacktransparent" ) )
	self.ShieldImage:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.showDpadDown" ), function ( modelRef )
		if Engine.GetModelValue( modelRef ) == 1 then
			self.ShieldImage:setImage( RegisterImage( "ui_icon_riotshield" ) )
			self.ShieldImage:setScale(0.5)
		else
			self.ShieldImage:setImage( RegisterImage( "blacktransparent" ) )
		end
	end )
	self:addElement( self.ShieldImage )

	self.ShieldMeter = LUI.UIImage.new()
	self.ShieldMeter:setLeftRight( false, true, -155, -91.5 )
	self.ShieldMeter:setTopBottom( false, true, -60, -43 )
	self.ShieldMeter:setImage( RegisterImage( "blacktransparent" ) )
	self.ShieldMeter:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
	self.ShieldMeter:setShaderVector( 1, 0, 0, 0, 0 )
	self.ShieldMeter:setShaderVector( 2, 1, 0, 0, 0 )
	self.ShieldMeter:setShaderVector( 3, 0, 0, 0, 0 )
	self.ShieldMeter:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.showDpadDown" ), function ( modelRef )
		if Engine.GetModelValue( modelRef ) == 1 then
			self.ShieldMeter:setImage( RegisterImage( "ui_icon_riotshield_health_bar" ) )
			self.ShieldMeter:setZRot( 90 )
			self.ShieldMeter:setScale( 0.6 )
		else
			self.ShieldMeter:setImage( RegisterImage( "blacktransparent" ) )
		end
	end )
	self.ShieldMeter:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "ZMInventory.shield_health" ), function ( modelRef )
		if Engine.GetModelValue( modelRef ) then
			self.ShieldMeter:beginAnimation( "keyframe", 400, false, false, CoD.TweenType.Linear )

			self.ShieldMeter:setShaderVector( 0, AdjustStartEnd( 0, 1,
				CoD.GetVectorComponentFromString( Engine.GetModelValue( modelRef ), 1 ),
				CoD.GetVectorComponentFromString( Engine.GetModelValue( modelRef ), 2 ),
				CoD.GetVectorComponentFromString( Engine.GetModelValue( modelRef ), 3 ),
				CoD.GetVectorComponentFromString( Engine.GetModelValue( modelRef ), 4 ) )
			)
		end
	end )
	self:addElement( self.ShieldMeter )

	--盾牌按键字母背景
	self.ShieldPromptBG = LUI.UIImage.new()
	self.ShieldPromptBG:setLeftRight( false, true, -148, -112 )
	self.ShieldPromptBG:setTopBottom( false, true, -43, -7 )
	self.ShieldPromptBG:setImage( RegisterImage( "ui_icon_key_prompt_bg" ) )
	self.ShieldPromptBG:setScale( 0.65 )
	self:addElement( self.ShieldPromptBG )

	--盾牌按键文本
	self.ShieldPrompt = LUI.UIText.new()
	self.ShieldPrompt:setLeftRight( false, true, -234, -37 )
	self.ShieldPrompt:setTopBottom( false, true, -33, -15.5 )
	self.ShieldPrompt:setTTF( "fonts/Scout.ttf" )
	self.ShieldPrompt:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
	self.ShieldPrompt:setText( "[{+actionslot 2}]"  )
	self.ShieldPrompt:setScale( 0.8 )
	self.ShieldPrompt:setRGB( 0.5, 0.5, 0.5 )
	self:addElement( self.ShieldPrompt )

	--下挂装备图标 
	self.DpadIconUnderBRIcon =LUI.UIImage.new()
	self.DpadIconUnderBRIcon:setLeftRight( false, true, -100, -72 )
	self.DpadIconUnderBRIcon:setTopBottom( false, true, -160.5, -137 )
	self.DpadIconUnderBRIcon:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
	self.DpadIconUnderBRIcon:setImage( RegisterImage( "blacktransparent" ) )
	self.DpadIconUnderBRIcon:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ) , "hudItems.showDpadLeft_iw8" ), function ( modelRef )
		local underBarrel = Engine.GetModelValue( modelRef )
		if underBarrel then
			Engine.SetDvar( "underBarrel", tonumber( underBarrel ) )
			
			if      tonumber( underBarrel ) == 0 then
				self.DpadIconUnderBRIcon:setImage(RegisterImage("blacktransparent")) 
				self.DpadIconUnderBRIcon:setAlpha( 0 )
			elseif  tonumber( underBarrel ) == 1 then --scar-h
				self.DpadIconUnderBRIcon:setImage(RegisterImage("ui_icon_semtex")) 
			elseif  tonumber( underBarrel ) == 2 then --ak47
				self.DpadIconUnderBRIcon:setImage(RegisterImage("ui_icon_semtex")) 
			elseif  tonumber( underBarrel ) == 3 then --fal
				self.DpadIconUnderBRIcon:setImage(RegisterImage("ui_icon_semtex")) 
			else				
				self.DpadIconUnderBRIcon:setImage(RegisterImage("blacktransparent"))
			end
		else
			self.DpadIconUnderBRIcon:setImage(RegisterImage("blacktransparent"))
		end	
	end )
	
	self:addElement(self.DpadIconUnderBRIcon)

	--下挂装备数量文本
	self.DpadIconUnderBRCountText = LUI.UIText.new()
	self.DpadIconUnderBRCountText:setLeftRight( false, true, -78, -58.5 )
	self.DpadIconUnderBRCountText:setTopBottom( false, true, -85.5, -73 )
	self.DpadIconUnderBRCountText:setText( Engine.Localize( "0" ) )
	self.DpadIconUnderBRCountText:setTTF( "fonts/Scout.ttf" )
	self.DpadIconUnderBRCountText:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
	--self.DpadIconUnderBRCountText:setScale( 1.2 )
	self.DpadIconUnderBRCountText:setRGB( 0.7, 0.7, 0.7 )
	self.DpadIconUnderBRCountText:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ) , "hudItems.dpadLeftAmmo" ), function ( modelRef ) 
		if Engine.GetModelValue( modelRef ) then
			if Engine.GetModelValue( modelRef ) > 0 then
				self.DpadIconUnderBRCountText:setText( Engine.Localize( Engine.GetModelValue( modelRef ) ) )
			else
				self.DpadIconUnderBRCountText:setText( Engine.Localize( "0" ) )
			end
		end
	end )
	self:addElement(self.DpadIconUnderBRCountText)

	--下挂按键字母背景
	self.DpadIconUnderBRPromptBG = LUI.UIImage.new()
	self.DpadIconUnderBRPromptBG:setLeftRight( false, true, -90, -54 )
	self.DpadIconUnderBRPromptBG:setTopBottom( false, true, -43, -7 )
	self.DpadIconUnderBRPromptBG:setImage( RegisterImage( "ui_icon_key_prompt_bg" ) )
	self.DpadIconUnderBRPromptBG:setScale( 0.65 )
	self:addElement( self.DpadIconUnderBRPromptBG )

	--下挂装备按键文本
	self.DpadIconUnderBRPromptText = LUI.UIText.new()
	self.DpadIconUnderBRPromptText:setLeftRight( false, true, -169, 28 )
	self.DpadIconUnderBRPromptText:setTopBottom( false, true, -33, -15.5 )
	self.DpadIconUnderBRPromptText:setTTF( "fonts/Scout.ttf" )
	self.DpadIconUnderBRPromptText:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
	self.DpadIconUnderBRPromptText:setText( "[{+actionslot 3}]" )
	self.DpadIconUnderBRPromptText:setScale( 0.8 )
	self.DpadIconUnderBRPromptText:setRGB( 0.5, 0.5, 0.5 )
	self:addElement( self.DpadIconUnderBRPromptText )

	--持有死亡机器时，弹药栏显示无限弹药
	--如果后续添加无限弹药的power-up，在此更改CF
	self.InfiniteAmmoIcon = LUI.UIImage.new()
	self.InfiniteAmmoIcon:setLeftRight( false, true, -393, -201 )
    self.InfiniteAmmoIcon:setTopBottom( false, true, -102, -6 )
	self.InfiniteAmmoIcon:setImage( RegisterImage( "ui_icon_infinite_ammo" ) )
	self.InfiniteAmmoIcon:setScale( 0.35 )
	self.InfiniteAmmoIcon:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ) , "infinite_ammo_icon" ), function ( modelRef ) 
		if Engine.GetModelValue( ModelRef ) then
			if Engine.GetModelValue( modelRef ) == 1 then
				self.InfiniteAmmoIcon:setAlpha( 1 )
			else
				self.InfiniteAmmoIcon:setAlpha( 0 )
			end
		end
	end )
	self:addElement( self.InfiniteAmmoIcon )


	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.LethalImage:close()
		element.LethalPromptBG:close()
		element.LethalPromptText:close()
		element.LethalPromptTimer:close()
		element.LethalCountText:close()

		element.TacticalImage:close()
		element.TacticalPromptBG:close()
		element.TacticalPromptText:close()
		element.TacticalPromptTimer:close()
		element.TacticalCountText:close()
		
		element.SpecialBG:close()
		element.SpecialImage:close()
		element.SpecialPromptTextBG:close()
		element.SpecialPromptText:close()
		element.SpecialPromptTimer:close()
		element.SpecialMeter:close()
		
		element.DpadIconMine:close()
		element.DpadIconMinePromptBG:close()
		element.DpadIconMineCountText:close()
		element.DpadIconMinePromptText:close()
		
		element.ShieldImage:close()
		element.ShieldMeter:close()
		element.ShieldPromptBG:close()
		element.ShieldPrompt:close()

		element.DpadIconUnderBRIcon:close()
		element.DpadIconUnderBRCountText:close()
		element.DpadIconUnderBRPromptBG:close()
		element.DpadIconUnderBRPromptText:close()

		element.InfiniteAmmoIcon:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end
