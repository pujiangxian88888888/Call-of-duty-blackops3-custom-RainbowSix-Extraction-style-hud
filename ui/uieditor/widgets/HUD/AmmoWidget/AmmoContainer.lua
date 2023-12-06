---@diagnostic disable: undefined-global

require( "ui.uieditor.widgets.HUD.AmmoWidget.AmmoEquipment" )
require( "ui.uieditor.widgets.HUD.AmmoWidget.AmmoInfo" )
require( "ui.uieditor.widgets.HUD.ZM_AmmoWidget.ZmAmmo_BBGumMeterWidget" )

CoD.AmmoContainer = InheritFrom( LUI.UIElement )
CoD.AmmoContainer.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.AmmoContainer )
	self.id = "AmmoContainer"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 1280 )
	self:setTopBottom( true, false, 0, 720 )
	self.anyChildUsesUpdateState = true

   --废弃组件
	self.AmmoBGGlow = LUI.UIImage.new()
    self.AmmoBGGlow:setLeftRight( false, true, -237, -25.5 )
    self.AmmoBGGlow:setTopBottom( false, true, -96, -23 )
    self.AmmoBGGlow:setImage( RegisterImage( "blacktransparent" ) )
    self.AmmoBGGlow:setAlpha( 0.5 )
    self:addElement( self.AmmoBGGlow )

    --废弃组件
	self.AmmoBG = LUI.UIImage.new()
    self.AmmoBG:setLeftRight( false, true, -257, -45.5 )
    self.AmmoBG:setTopBottom( false, true, -96, -23 )
    self.AmmoBG:setImage( RegisterImage( "blacktransparent" ) )
	self.AmmoBG:setScale( 1.3 )
	self.AmmoBG:setAlpha( 0 )
    self:addElement( self.AmmoBG )

	self.AmmoInfo = CoD.AmmoInfo.new( menu, controller )
	self.AmmoInfo:setLeftRight( true, true, 0, 0 )
	self.AmmoInfo:setTopBottom( true, true, 0, 0 )
	self:addElement( self.AmmoInfo )

	self.WeaponName = LUI.UIText.new()
	self.WeaponName:setLeftRight( false, true, -635, -205 )
	self.WeaponName:setTopBottom( false, true, -35, -15 )
	self.WeaponName:setTTF( "fonts/Scout.ttf" )
	self.WeaponName:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_RIGHT )
	self.WeaponName:setScale( 0.8 )
	self.WeaponName:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentWeapon.weaponName" ), function ( modelRef )
		if Engine.GetModelValue( modelRef ) then
			self.WeaponName:setText( Engine.Localize( Engine.GetModelValue( modelRef ) ) )
		end
	end )
	self:addElement( self.WeaponName )

	self.AmmoEquipment = CoD.AmmoEquipment.new( menu, controller )
	self.AmmoEquipment:setLeftRight( true, true, 0, 0 )
	self.AmmoEquipment:setTopBottom( true, true, 0, 0 )
	self:addElement( self.AmmoEquipment )

	--[[
	self.AATName = LUI.UIImage.new()
	self.AATName:setLeftRight( false, true, -447, -416.5 )
	self.AATName:setTopBottom( false, true, -73, -36 )
	self.AATName:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
	self.AATName:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "CurrentWeapon.AATName" ), function ( modelRef )
		if Engine.GetModelValue( modelRef ) then
			if Engine.GetModelValue( modelRef ) == "t7_icon_zm_aat_blast_furnace" then
				self.AATName:setImage( RegisterImage( "ui_icon_zm_aat_blastfurnace" ) )
				self.AATName:setScale(1.5)

			elseif Engine.GetModelValue( modelRef ) == "t7_icon_zm_aat_dead_wire" then
				self.AATName:setImage( RegisterImage( "ui_icon_zm_aat_deadwire" ) )
				self.AATName:setScale(1.5)

			elseif Engine.GetModelValue( modelRef ) == "t7_icon_zm_aat_fire_works" then
				self.AATName:setImage( RegisterImage( "ui_icon_zm_aat_fireworks" ) )
				self.AATName:setScale(1.5)

			elseif Engine.GetModelValue( modelRef ) == "t7_icon_zm_aat_thunder_wall" then
				self.AATName:setImage( RegisterImage( "ui_icon_zm_aat_thunderwall" ) )
				self.AATName:setScale(1.5)

			elseif Engine.GetModelValue( modelRef ) == "t7_icon_zm_aat_turned" then
				self.AATName:setImage( RegisterImage( "ui_icon_zm_aat_turned" ) )
				self.AATName:setScale(1.5)

			else
				self.AATName:setImage( RegisterImage( "blacktransparent" ) )
			end
		end  
	end )
	self:addElement( self.AATName )
	]]

	self.AATName = LUI.UIText.new()
	self.AATName:setLeftRight( false, true, -635, -205 )
	self.AATName:setTopBottom( false, true, -85, -65 )
	self.AATName:setTTF( "fonts/Scout.ttf" )
	self.AATName:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_RIGHT )
	self.AATName:setScale( 0.8 )
	self.AATName:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "CurrentWeapon.aatIcon" ), function ( modelRef )
		if Engine.GetModelValue( modelRef ) then
			if Engine.GetModelValue( modelRef ) == "t7_icon_zm_aat_blast_furnace" then
				self.AATName:setText( Engine.Localize( "BLAST FURNACE" ) )
				

			elseif Engine.GetModelValue( modelRef ) == "t7_icon_zm_aat_dead_wire" then
				self.AATName:setText( Engine.Localize( "DEAD WIRE" ) )
				

			elseif Engine.GetModelValue( modelRef ) == "t7_icon_zm_aat_fire_works" then
				self.AATName:setText( Engine.Localize( "FIRE WORKS" ) )
				

			elseif Engine.GetModelValue( modelRef ) == "t7_icon_zm_aat_thunder_wall" then
				self.AATName:setText( Engine.Localize( "THUNDER WALL" ) )
				

			elseif Engine.GetModelValue( modelRef ) == "t7_icon_zm_aat_turned" then
				self.AATName:setText( Engine.Localize( "TURNED" ) )
				

			else
				self.AATName:setText( Engine.Localize( "" ) )
			end
		end  
	end )
	self:addElement( self.AATName )

	

	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 17 )

				self.AmmoBGGlow:completeAnimation()
				self.AmmoBGGlow:setAlpha( 0 )
				self.clipFinished( self.AmmoBGGlow, {} )

				self.AmmoBG:completeAnimation()
				self.AmmoBG:setAlpha( 0 )
				self.clipFinished( self.AmmoBG, {} )

				self.AmmoInfo:completeAnimation()
				self.AmmoInfo:setAlpha( 0 )
				self.clipFinished( self.AmmoInfo, {} )

				self.WeaponName:completeAnimation()
				self.WeaponName:setAlpha( 0 )
				self.clipFinished( self.WeaponName, {} )

				self.AmmoEquipment:completeAnimation()
				self.AmmoEquipment:setAlpha( 0 )
				self.clipFinished( self.AmmoEquipment, {} )

				self.AATName:completeAnimation()
				self.AATName:setAlpha( 0 )
				self.clipFinished( self.AATName, {} )
			end,
			HudStart = function ()
				self:setupElementClipCounter( 17 )

				local AmmoBGGlowHudStartTransition = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Linear )
					end
	
					element:setAlpha( 0.5 )
	
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end

				self.AmmoBGGlow:completeAnimation()
				self.AmmoBGGlow:setAlpha( 0 )
				AmmoBGGlowHudStartTransition( self.AmmoBGGlow, {} )

				local HudStartTransition = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Linear )
					end
	
					element:setAlpha( 1 )
	
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.AmmoBG:completeAnimation()
				self.AmmoBG:setAlpha( 0 )
				HudStartTransition( self.AmmoBG, {} )
				
				self.AmmoInfo:completeAnimation()
				self.AmmoInfo:setAlpha( 0 )
				HudStartTransition( self.AmmoInfo, {} )
				
				self.WeaponName:completeAnimation()
				self.WeaponName:setAlpha( 0 )
				HudStartTransition( self.WeaponName, {} )
				
				self.AmmoEquipment:completeAnimation()
				self.AmmoEquipment:setAlpha( 0 )
				HudStartTransition( self.AmmoEquipment, {} )
				
				self.AATName:completeAnimation()
				self.AATName:setAlpha( 0 )
				HudStartTransition( self.AATName, {} )
			end
		},
		HudStart = {
			DefaultClip = function ()
				self:setupElementClipCounter( 17 )

				self.AmmoBGGlow:completeAnimation()
				self.AmmoBGGlow:setAlpha( 0.5 )
				self.clipFinished( self.AmmoBGGlow, {} )

				self.AmmoBG:completeAnimation()
				self.AmmoBG:setAlpha( 1 )
				self.clipFinished( self.AmmoBG, {} )

				self.AmmoInfo:completeAnimation()
				self.AmmoInfo:setAlpha( 1 )
				self.clipFinished( self.AmmoInfo, {} )

				self.WeaponName:completeAnimation()
				self.WeaponName:setAlpha( 1 )
				self.clipFinished( self.WeaponName, {} )

				self.AmmoEquipment:completeAnimation()
				self.AmmoEquipment:setAlpha( 1 )
				self.clipFinished( self.AmmoEquipment, {} )

				self.AATName:completeAnimation()
				self.AATName:setAlpha( 1 )
				self.clipFinished( self.AATName, {} )
			end,
			DefaultState = function ()
				self:setupElementClipCounter( 17 )
				
				local DefaultStateTransition = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Linear )
					end
	
					element:setAlpha( 0 )
	
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end

				self.AmmoBGGlow:completeAnimation()
				self.AmmoBGGlow:setAlpha( 0.5 )
				DefaultStateTransition( self.AmmoBGGlow, {} )

				self.AmmoBG:completeAnimation()
				self.AmmoBG:setAlpha( 1 )
				DefaultStateTransition( self.AmmoBG, {} )

				self.AmmoInfo:completeAnimation()
				self.AmmoInfo:setAlpha( 1 )
				DefaultStateTransition( self.AmmoInfo, {} )

				self.WeaponName:completeAnimation()
				self.WeaponName:setAlpha( 1 )
				DefaultStateTransition( self.WeaponName, {} )

				self.AmmoEquipment:completeAnimation()
				self.AmmoEquipment:setAlpha( 1 )
				DefaultStateTransition( self.AmmoEquipment, {} )

				self.AATName:completeAnimation()
				self.AATName:setAlpha( 1 )
				DefaultStateTransition( self.AATName, {} )
			end
		}
	}

	self:mergeStateConditions( {
		{
			stateName = "HudStart",
			condition = function ( menu, element, event )
				if IsModelValueTrue( controller, "hudItems.playerSpawned" ) then
					if Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_HUD_VISIBLE )
					and Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_WEAPON_HUD_VISIBLE )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_HUD_HARDCORE )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_GAME_ENDED )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_KILLCAM )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_UI_ACTIVE )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IS_SCOPED )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_VEHICLE )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_EMP_ACTIVE ) then
						return true
					else
						return false
					end
				end
			end
		}
	} )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentWeapon.viewmodelWeaponName" ), function ( modelRef )
		menu:updateElementState( self, {
			name = "model_validation",
			menu = menu,
			modelValue = Engine.GetModelValue( modelRef ),
			modelName = "currentWeapon.viewmodelWeaponName"
		} )
	end )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.playerSpawned" ), function ( modelRef )
		menu:updateElementState( self, {
			name = "model_validation",
			menu = menu,
			modelValue = Engine.GetModelValue( modelRef ),
			modelName = "hudItems.playerSpawned"
		} )
	end )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_VISIBLE ), function ( modelRef )
		menu:updateElementState( self, {
			name = "model_validation",
			menu = menu,
			modelValue = Engine.GetModelValue( modelRef ),
			modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_VISIBLE
		} )
	end )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_WEAPON_HUD_VISIBLE ), function ( modelRef )
		menu:updateElementState( self, {
			name = "model_validation",
			menu = menu,
			modelValue = Engine.GetModelValue( modelRef ),
			modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_WEAPON_HUD_VISIBLE
		} )
	end )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_HARDCORE ), function ( modelRef )
		menu:updateElementState( self, {
			name = "model_validation",
			menu = menu,
			modelValue = Engine.GetModelValue( modelRef ),
			modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_HARDCORE
		} )
	end )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_GAME_ENDED ), function ( modelRef )
		menu:updateElementState( self, {
			name = "model_validation",
			menu = menu,
			modelValue = Engine.GetModelValue( modelRef ),
			modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_GAME_ENDED
		} )
	end )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM ), function ( modelRef )
		menu:updateElementState( self, {
			name = "model_validation",
			menu = menu,
			modelValue = Engine.GetModelValue( modelRef ),
			modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM
		} )
	end )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN ), function ( modelRef )
		menu:updateElementState( self, {
			name = "model_validation",
			menu = menu,
			modelValue = Engine.GetModelValue( modelRef ),
			modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN
		} )
	end )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_KILLCAM ), function ( modelRef )
		menu:updateElementState( self, {
			name = "model_validation",
			menu = menu,
			modelValue = Engine.GetModelValue( modelRef ),
			modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_KILLCAM
		} )
	end )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED ), function ( modelRef )
		menu:updateElementState( self, {
			name = "model_validation",
			menu = menu,
			modelValue = Engine.GetModelValue( modelRef ),
			modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED
		} )
	end )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_UI_ACTIVE ), function ( modelRef )
		menu:updateElementState( self, {
			name = "model_validation",
			menu = menu,
			modelValue = Engine.GetModelValue( modelRef ),
			modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_UI_ACTIVE
		} )
	end )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_SCOPED ), function ( modelRef )
		menu:updateElementState( self, {
			name = "model_validation",
			menu = menu,
			modelValue = Engine.GetModelValue( modelRef ),
			modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_SCOPED
		} )
	end )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_VEHICLE ), function ( modelRef )
		menu:updateElementState( self, {
			name = "model_validation",
			menu = menu,
			modelValue = Engine.GetModelValue( modelRef ),
			modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_VEHICLE
		} )
	end )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE ), function ( modelRef )
		menu:updateElementState( self, {
			name = "model_validation",
			menu = menu,
			modelValue = Engine.GetModelValue( modelRef ),
			modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE
		} )
	end )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN ), function ( modelRef )
		menu:updateElementState( self, {
			name = "model_validation",
			menu = menu,
			modelValue = Engine.GetModelValue( modelRef ),
			modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN
		} )
	end )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC ), function ( modelRef )
		menu:updateElementState( self, {
			name = "model_validation",
			menu = menu,
			modelValue = Engine.GetModelValue( modelRef ),
			modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC
		} )
	end )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_EMP_ACTIVE ), function ( modelRef )
		menu:updateElementState( self, {
			name = "model_validation",
			menu = menu,
			modelValue = Engine.GetModelValue( modelRef ),
			modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_EMP_ACTIVE
		} )
	end )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.AmmoBGGlow:close()
		element.AmmoBG:close()
		element.AmmoInfo:close()
		element.WeaponName:close()
		element.AmmoEquipment:close()
		element.AATName:close()

	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end