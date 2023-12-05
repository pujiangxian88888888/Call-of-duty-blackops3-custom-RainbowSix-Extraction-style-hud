CoD.PowerUps = {}
CoD.PowerUps.IconSize = 48
CoD.PowerUps.UpgradeIconSize = 36
CoD.PowerUps.Spacing = 8
CoD.PowerUps.STATE_OFF = 0
CoD.PowerUps.STATE_ON = 1
CoD.PowerUps.STATE_FLASHING_OFF = 2
CoD.PowerUps.STATE_FLASHING_ON = 3
CoD.PowerUps.FLASHING_STAGE_DURATION = 500
CoD.PowerUps.MOVING_DURATION = 500

CoD.PowerUps.UpGradeIconColorRed = {
	r = 1,
	g = 0,
	b = 0
}

CoD.PowerUps.ClientFieldNames = {
	{
		clientFieldName = "powerup_instant_kill",
		material = RegisterMaterial( "ui_icon_hud_zb_power_up_insta_kill" )
	},
	{
		clientFieldName = "powerup_double_points",
		material = RegisterMaterial( "ui_icon_hud_zb_power_up_double_points" ),
		z_material = RegisterMaterial( "specialty_doublepoints_zombies_blue" )
	},
	{
		clientFieldName = "powerup_fire_sale",
		material = RegisterMaterial( "ui_icon_hud_zb_power_up_firesale" )
	},
	{
		clientFieldName = "powerup_bon_fire",
		material = RegisterMaterial( "ui_icon_hud_zb_bonfiresale" )
	},
	{
		clientFieldName = "powerup_mini_gun",
		material = RegisterMaterial( "ui_icon_hud_zb_power_up_deathmachine" )
	},
	{
		clientFieldName = "powerup_zombie_blood",
		material = RegisterMaterial( "ui_icon_hud_zb_escape_blood_power_up" )
	}
}

CoD.PowerUps.UpgradeClientFieldNames = {
	{
		clientFieldName = "powerup_instant_kill_ug",
		material = RegisterMaterial( "specialty_instakill_zombies" ),
		color = CoD.PowerUps.UpGradeIconColorRed
	}
}

LUI.createMenu.PowerUpsArea = function ( controller )
	local self = CoD.Menu.NewSafeAreaFromState( "PowerUpsArea", controller )
	self:setOwner( controller )

	self.scaleContainer = CoD.SplitscreenScaler.new( nil, CoD.Zombie.SplitscreenMultiplier )
	self.scaleContainer:setLeftRight( false, false, 0, 0 )
	self.scaleContainer:setTopBottom( false, true, 0, 0 )
	self:addElement( self.scaleContainer )
	
	local powerUp = nil

	self.powerUps = {}

	for index = 1, #CoD.PowerUps.ClientFieldNames, 1 do
		powerUp = LUI.UIElement.new()
		powerUp:setLeftRight( false, false, -CoD.PowerUps.IconSize * 0.5, CoD.PowerUps.IconSize * 0.5 )
		powerUp:setTopBottom( false, true, -CoD.PowerUps.IconSize + CoD.PowerUps.UpgradeIconSize + 10 - 25 -82, -25 -82 )
		powerUp:setScale( 0.9 )
		
		powerUp:registerEventHandler( "transition_complete_off_fade_out", CoD.PowerUps.PowerUpIcon_UpdatePosition )
		
		powerUp.powerUpIcon = LUI.UIImage.new()
		powerUp.powerUpIcon:setLeftRight( true, true, 0, 0 )
		powerUp.powerUpIcon:setTopBottom( false, true, -CoD.PowerUps.IconSize, 0 )
		powerUp.powerUpIcon:setAlpha( 0 )
		powerUp:addElement( powerUp.powerUpIcon )
		
		powerUp.upgradePowerUpIcon = LUI.UIImage.new()
		powerUp.upgradePowerUpIcon:setLeftRight( false, false, -CoD.PowerUps.UpgradeIconSize / 2, CoD.PowerUps.UpgradeIconSize / 2 )
		powerUp.upgradePowerUpIcon:setTopBottom( true, false, 0, CoD.PowerUps.UpgradeIconSize )
		powerUp.upgradePowerUpIcon:setAlpha( 0 )
		powerUp:addElement( powerUp.upgradePowerUpIcon )
		
		powerUp.powerupId = nil

		self.scaleContainer:addElement( powerUp )

		self.powerUps[index] = powerUp

		self:registerEventHandler( CoD.PowerUps.ClientFieldNames[index].clientFieldName, CoD.PowerUps.Update )
		self:registerEventHandler( CoD.PowerUps.ClientFieldNames[index].clientFieldName .. "_ug", CoD.PowerUps.UpgradeUpdate )
	end

	self.activePowerUpCount = 0

	local UpdateVisibility = function ()
		CoD.PowerUps.UpdateVisibility( self, controller )
	end

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_VISIBLE ), UpdateVisibility )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_PLAYER_IN_AFTERLIFE ), UpdateVisibility )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_EMP_ACTIVE ), UpdateVisibility )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_UI_ACTIVE ), UpdateVisibility )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SPECTATING_CLIENT ), UpdateVisibility )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN ), UpdateVisibility )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_VEHICLE ), UpdateVisibility )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE ), UpdateVisibility )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC ), UpdateVisibility )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_SCOPED ), UpdateVisibility )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED ), UpdateVisibility )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM ), UpdateVisibility )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN ), UpdateVisibility )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_GAME_ENDED ), UpdateVisibility )

	self:registerEventHandler( "powerups_update_position", CoD.PowerUps.UpdatePosition )

	self.visible = true

	return self
end

CoD.PowerUps.UpdateVisibility = function ( self, controller )
	if Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_HUD_VISIBLE )
	and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IS_PLAYER_IN_AFTERLIFE )
	and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_EMP_ACTIVE )
	and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM )
	and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN )
	and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_UI_ACTIVE ) 
	and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_KILLCAM )
	and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN )
	and (not CoD.IsShoutcaster( controller ) or CoD.ShoutcasterProfileVarBool( controller, "shoutcaster_teamscore" ))
	and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE )
	and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC )
	and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IS_SCOPED )
	and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_VEHICLE )
	and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED )
	and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_GAME_ENDED ) then
		if not self.visible then
			self:setAlpha( 1 )

			self.visible = true
		end
	elseif self.visible then
		self:setAlpha( 0 )

		self.visible = nil
	end
end

CoD.PowerUps.Update = function ( element, event )
	CoD.PowerUps.UpdateState( element, event )
	CoD.PowerUps.UpdatePosition( element, event )
end

CoD.PowerUps.UpdateState = function ( element, event )
	local powerUp = nil

	local PowerUpIndex = CoD.PowerUps.GetExistingPowerUpIndex( element, event.name )

	if PowerUpIndex ~= nil then
		powerUp = element.powerUps[PowerUpIndex]

		if event.newValue == CoD.PowerUps.STATE_ON then
			powerUp.powerUpId = event.name
			powerUp.powerUpIcon:setImage( CoD.PowerUps.GetMaterial( element, event.controller, event.name ) )
			powerUp.powerUpIcon:setAlpha( 1 )
		elseif event.newValue == CoD.PowerUps.STATE_OFF then
			powerUp.powerUpIcon:beginAnimation( "off_fade_out", CoD.PowerUps.FLASHING_STAGE_DURATION )
			powerUp.powerUpIcon:setAlpha( 0 )
			powerUp.upgradePowerUpIcon:beginAnimation( "off_fade_out", CoD.PowerUps.FLASHING_STAGE_DURATION )
			powerUp.upgradePowerUpIcon:setAlpha( 0 )
			powerUp.powerUpId = nil
			element.activePowerUpCount = element.activePowerUpCount - 1
		elseif event.newValue == CoD.PowerUps.STATE_FLASHING_OFF then
			powerUp.powerUpIcon:beginAnimation( "fade_out", CoD.PowerUps.FLASHING_STAGE_DURATION )
			powerUp.powerUpIcon:setAlpha( 0 )
		elseif event.newValue == CoD.PowerUps.STATE_FLASHING_ON then
			powerUp.powerUpIcon:beginAnimation( "fade_in", CoD.PowerUps.FLASHING_STAGE_DURATION )
			powerUp.powerUpIcon:setAlpha( 1 )
		end
	elseif event.newValue == CoD.PowerUps.STATE_ON or event.newValue == CoD.PowerUps.STATE_FLASHING_ON then
		local FirstPowerUpIndex = CoD.PowerUps.GetFirstAvailablePowerUpIndex( element )

		if FirstPowerUpIndex ~= nil then
			powerUp = element.powerUps[FirstPowerUpIndex]
			powerUp.powerUpId = event.name
			powerUp.powerUpIcon:setImage( CoD.PowerUps.GetMaterial( element, event.controller, event.name ) )
			powerUp.powerUpIcon:setAlpha( 1 )
			element.activePowerUpCount = element.activePowerUpCount + 1
		end
	end
end

CoD.PowerUps.UpgradeUpdate = function ( element, event )
	CoD.PowerUps.UpgradeUpdateState( element, event )
end

CoD.PowerUps.UpgradeUpdateState = function ( element, event )
	local upgradePowerUpIcon = nil

	local PowerUpIndex = CoD.PowerUps.GetExistingPowerUpIndex( element, string.sub( event.name, 0, -4 ) )

	if PowerUpIndex ~= nil then
		upgradePowerUpIcon = element.powerUps[PowerUpIndex].upgradePowerUpIcon

		if event.newValue == CoD.PowerUps.STATE_ON then
			upgradePowerUpIcon:setImage( CoD.PowerUps.GetUpgradeMaterial( element, event.name ) )
			upgradePowerUpIcon:setAlpha( 1 )
			CoD.PowerUps.SetUpgradeColor( upgradePowerUpIcon, event.name )
		elseif event.newValue == CoD.PowerUps.STATE_OFF then
			upgradePowerUpIcon:beginAnimation( "off_fade_out", CoD.PowerUps.FLASHING_STAGE_DURATION )
			upgradePowerUpIcon:setAlpha( 0 )
		elseif event.newValue == CoD.PowerUps.STATE_FLASHING_OFF then
			upgradePowerUpIcon:beginAnimation( "fade_out", CoD.PowerUps.FLASHING_STAGE_DURATION )
			upgradePowerUpIcon:setAlpha( 0 )
		elseif event.newValue == CoD.PowerUps.STATE_FLASHING_ON then
			upgradePowerUpIcon:beginAnimation( "fade_in", CoD.PowerUps.FLASHING_STAGE_DURATION )
			upgradePowerUpIcon:setAlpha( 1 )
		end
	end
end

CoD.PowerUps.GetMaterial = function ( element, controller, name )
	local material = nil

	for index = 1, #CoD.PowerUps.ClientFieldNames, 1 do
		if CoD.PowerUps.ClientFieldNames[index].clientFieldName == name then
			material = CoD.PowerUps.ClientFieldNames[index].material
			break
		end
	end

	return material
end

CoD.PowerUps.GetUpgradeMaterial = function ( element, name )
	local material = nil

	for index = 1, #CoD.PowerUps.UpgradeClientFieldNames, 1 do
		if CoD.PowerUps.UpgradeClientFieldNames[index].clientFieldName == name then
			material = CoD.PowerUps.UpgradeClientFieldNames[index].material
			break
		end
	end

	return material
end

CoD.PowerUps.SetUpgradeColor = function ( upgradePowerUpIcon, name )
	for index = 1, #CoD.PowerUps.UpgradeClientFieldNames, 1 do
		if CoD.PowerUps.UpgradeClientFieldNames[index].clientFieldName == name then
			if CoD.PowerUps.UpgradeClientFieldNames[index].color then
				upgradePowerUpIcon:setRGB(
					CoD.PowerUps.UpgradeClientFieldNames[index].color.r,
					CoD.PowerUps.UpgradeClientFieldNames[index].color.g,
					CoD.PowerUps.UpgradeClientFieldNames[index].color.b )
				break
			end
		end
	end
end

CoD.PowerUps.GetExistingPowerUpIndex = function ( element, name )
	for index = 1, #CoD.PowerUps.ClientFieldNames, 1 do
		if element.powerUps[index].powerUpId == name then
			return index
		end
	end

	return nil
end

CoD.PowerUps.GetFirstAvailablePowerUpIndex = function ( element )
	for index = 1, #CoD.PowerUps.ClientFieldNames, 1 do
		if not element.powerUps[index].powerUpId then
			return index
		end
	end

	return nil
end

CoD.PowerUps.PowerUpIcon_UpdatePosition = function ( element, event )
	if event.interrupted ~= true then
		element:dispatchEventToParent( {
			name = "powerups_update_position"
		} )
	end
end

CoD.PowerUps.UpdatePosition = function ( element, event )
	local powerUp = nil
	local leftOffset = 0
	local rightOffset = 0
	local activePowerUps = nil

	for index = 1, #CoD.PowerUps.ClientFieldNames, 1 do
		powerUp = element.powerUps[index]
		if powerUp.powerUpId ~= nil then
			if not activePowerUps then
				leftOffset = - ( CoD.PowerUps.IconSize * 0.5 * element.activePowerUpCount + CoD.PowerUps.Spacing * 0.5 * ( element.activePowerUpCount - 1 ) )
			else
				leftOffset = activePowerUps + CoD.PowerUps.IconSize + CoD.PowerUps.Spacing
			end

			rightOffset = leftOffset + CoD.PowerUps.IconSize
			powerUp:beginAnimation( "move", CoD.PowerUps.MOVING_DURATION )
			powerUp:setLeftRight( false, false, leftOffset, rightOffset )
			activePowerUps = leftOffset
		end
	end
end
