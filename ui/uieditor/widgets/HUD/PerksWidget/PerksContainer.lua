---@diagnostic disable: undefined-global
require( "ui.uieditor.widgets.HUD.ZM_Perks.PerkListItemFactory" )

local perksImages = {
	additional_primary_weapon = "ui_icon_perks_mulekick",
	dead_shot =                 "ui_icon_perks_deadshot",
	doubletap2 =                "ui_icon_perks_doubletap",
	juggernaut =                "ui_icon_perks_jugg",
	marathon =                  "ui_icon_perks_staminup",
	quick_revive =              "ui_icon_perks_revive",
	sleight_of_hand =           "ui_icon_perks_speedcola",
	widows_wine =               "ui_icon_perks_spider",
	electric_cherry =           "ui_icon_perks_cherry",
	phdflopper  =               "ui_icon_perks_phd",
	berserker   =               "ui_icon_perks_berserker"
}

local GetPerkFromList = function ( perksList, perkCF )
	if perksList ~= nil then
		for index = 1, #perksList, 1 do
			if perksList[index].properties.key == perkCF then
				return index
			end
		end
	end

	return nil
end

local GetPerkFromStatus = function ( perksList, perkCF, perkStatusModel )
	if perksList ~= nil then
		for index = 1, #perksList, 1 do
			if perksList[index].properties.key == perkCF and perksList[index].models.status ~= perkStatusModel then
				return index
			end
		end
	end

	return -1
end

local PerksListUpdate = function ( element, controller )
    local PopulateCenterPerkWidget = function ( perkData, perkIdx )
        local parent = element:getParent()

        if not parent then
            return
        end
        
        local perkIdxModel = Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.centerPerks." .. perkIdx )

        if not perkData then
            -- Clear this icon
            parent.PerkListCenter["perk" .. perkIdx].key = nil

            Engine.SetModelValue( Engine.GetModel( perkIdxModel, "image" ), "blacktransparent" )
            Engine.SetModelValue( Engine.GetModel( perkIdxModel, "newPerk" ), false )
            Engine.SetModelValue( Engine.GetModel( perkIdxModel, "status" ), 0 )
        else
            -- Gained a perk!
            parent.PerkListCenter["perk" .. perkIdx].key = perkData.properties.key

            for key,value in pairs( perkData.models ) do
                Engine.SetModelValue( Engine.GetModel( perkIdxModel, key ), value )
            end
        end
    end

	if not element.perksList then
		element.perksList = {}

        for index=1, 4 do
            local perkIdxModel = Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.centerPerks." .. index )

            Engine.SetModelValue( Engine.GetModel( perkIdxModel, "image" ), "blacktransparent" )
            Engine.SetModelValue( Engine.GetModel( perkIdxModel, "newPerk" ), false )
            Engine.SetModelValue( Engine.GetModel( perkIdxModel, "status" ), 0 )
        end
	end

	local tableUpdated = false

	for perkCF, perkImage in pairs( perksImages ) do
		local perkModelValue = Engine.GetModelValue( Engine.GetModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.perks" ), perkCF ) )

		if perkModelValue ~= nil and perkModelValue > 0 then
			if not GetPerkFromList( element.perksList, perkCF ) then
				table.insert( element.perksList, {
					models = {
						image = perkImage,
						status = perkModelValue,
						newPerk = false
					},
					properties = {
						key = perkCF
					}
				} )

				tableUpdated = true
			end

			if GetPerkFromStatus( element.perksList, perkCF, perkModelValue ) > 0 then
				element.perksList[GetPerkFromStatus( element.perksList, perkCF, perkModelValue )].models.status = perkModelValue

				Engine.SetModelValue( Engine.GetModel( Engine.GetModel( Engine.GetModelForController( controller ), "ZMPerksFactory" ), tostring( GetPerkFromStatus( element.perksList, perkCF, perkModelValue ) ) .. ".status" ), perkModelValue )
			end
		else
			if GetPerkFromList( element.perksList, perkCF ) then
                local parent = element:getParent()

                if not parent then
                    return
                end

                local perkIdx = GetPerkFromList( element.perksList, perkCF )      
                local perkData = element.perksList[perkIdx]      

                table.remove( element.perksList, perkIdx )
                
                if perkIdx <= 4 then
                    local affectedCenterContainer = parent.PerkListCenter["perk" .. perkIdx]
                    local key = affectedCenterContainer.key
                    affectedCenterContainer.key = nil

                    Engine.SetModelValue( Engine.GetModel( affectedCenterContainer:getModel(), "image" ), "blacktransparent" )
                    Engine.SetModelValue( Engine.GetModel( affectedCenterContainer:getModel(), "newPerk" ), false )
                    Engine.SetModelValue( Engine.GetModel( affectedCenterContainer:getModel(), "status" ), 0 )
                
                    for index=perkIdx, 4 do
                        local currentPerk = parent.PerkListCenter["perk" .. index]
                        local nextPerk = parent.PerkListCenter["perk" .. ( index + 1 )]

                        if nextPerk then
                            currentPerk.key = nextPerk.key
                            Engine.SetModelValue( Engine.GetModel( currentPerk:getModel(), "image" ), Engine.GetModelValue( Engine.GetModel( nextPerk:getModel(), "image" ) ) )
                            Engine.SetModelValue( Engine.GetModel( currentPerk:getModel(), "newPerk" ), Engine.GetModelValue( Engine.GetModel( nextPerk:getModel(), "newPerk" ) ) )
                            Engine.SetModelValue( Engine.GetModel( currentPerk:getModel(), "status" ), Engine.GetModelValue( Engine.GetModel( nextPerk:getModel(), "status" ) ) )
                        else
                            currentPerk.key = nil
                            Engine.SetModelValue( Engine.GetModel( currentPerk:getModel(), "image" ), "blacktransparent" )
                            Engine.SetModelValue( Engine.GetModel( currentPerk:getModel(), "newPerk" ), false )
                            Engine.SetModelValue( Engine.GetModel( currentPerk:getModel(), "status" ), 0 )
                        end
                    end
                end

				tableUpdated = true
			end
		end
	end    

	if tableUpdated then
		for index = 1, #element.perksList, 1 do
			element.perksList[index].models.newPerk = ( index == #element.perksList and not element.perksList[index].properties.ignoreme )

            if index <= 4 then
                local perkData = element.perksList[index]
                if not perkData.properties.ignoreme then
                    PopulateCenterPerkWidget( perkData, index )

                    element.perksList[index] = {
                        models = {
							image = "blacktransparent",
							status = 0,
							newPerk = false
						},
                        properties = {
							ignoreme = true,
							key=perkData.properties.key
						},
                    }
                end
            end
		end

		return true
	else
		for index = 1, #element.perksList, 1 do
            Engine.SetModelValue( Engine.GetModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.perks" ), element.perksList[index].properties.key ), element.perksList[index].models.status )
		end
	
		return false
	end
end

DataSources.ZMPerksFactory = DataSourceHelpers.ListSetup( "ZMPerksFactory", function ( controller, element )
	PerksListUpdate( element, controller )
	return element.perksList
end, true )

local PreLoadFunc = function ( self, controller )
	for perkCF, perkImage in pairs( perksImages ) do
		self:subscribeToModel( Engine.CreateModel( Engine.CreateModel( Engine.GetModelForController( controller ), "hudItems.perks" ), perkCF ), function ( modelRef )
			if PerksListUpdate( self.PerkList, controller ) then
				self.PerkList:updateDataSource()
			end
		end, false )
	end
end

CoD.PerksContainer = InheritFrom( LUI.UIElement )
CoD.PerksContainer.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.PerksContainer )
	self.id = "PerksContainer"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 1280 )
	self:setTopBottom( true, false, 0, 720 )
	self.anyChildUsesUpdateState = true

	self.PerkListBG = LUI.UIImage.new()
	self.PerkListBG:setLeftRight( false, false, -119.5, 119.5 )
	self.PerkListBG:setTopBottom( false, true, -69, -33 )
	self.PerkListBG:setImage( RegisterImage( "blacktransparent" ) )
	self:addElement( self.PerkListBG )

	self.PerkListCenter = LUI.UIHorizontalList.new()
	self.PerkListCenter:setLeftRight( true, false,420, 450 )  --增大参数，组件向右移动
	self.PerkListCenter:setTopBottom( false, true, 20, -105 )
	self:addElement( self.PerkListCenter )

    for index = 1, 4 do
        local perkIdxModel = Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.centerPerks." .. index )
		
        if not perkIdxModel then
            perkIdxModel = Engine.CreateModel( Engine.GetModelForController( controller ), "hudItems.centerPerks." .. index )
            
            local imageModel = Engine.GetModel( perkIdxModel, "image" )
            local statusModel = Engine.GetModel( perkIdxModel, "status" )
            local newPerkModel = Engine.GetModel( perkIdxModel, "newPerk" )

            if not imageModel or not statusModel or not newPerkModel then
                local imageModel = Engine.CreateModel( perkIdxModel, "image" )
                local statusModel = Engine.CreateModel( perkIdxModel, "status" )
                local newPerkModel = Engine.CreateModel( perkIdxModel, "newPerk" )
            end

            Engine.SetModelValue( imageModel, "blacktransparent" )
            Engine.SetModelValue( statusModel, 0 )
            Engine.SetModelValue( newPerkModel, false )        
        end

        local newPerkElement = CoD.PerkListItemFactory.new( menu, controller )
        newPerkElement:setModel( perkIdxModel, controller ) -- setModel will make it so we can use linkToElementModel() and get the correct data from it on the perk item widget
        newPerkElement:setLeftRight( false, false, -18, 18 + 6.5 )
        newPerkElement:setTopBottom( false, false, -18, 18 )
        self.PerkListCenter["perk" .. index] = newPerkElement
        self.PerkListCenter:addElement( newPerkElement )
    end

	self.PerkList = LUI.UIList.new( menu, controller, 3.5, 0, nil, false, false, 0, 0, false, false )
	self.PerkList:makeFocusable()
	self.PerkList:setLeftRight( true, false, 587.5 - 155, 621 )
	self.PerkList:setTopBottom( false, true, -58, -24.5 )
	self.PerkList:setWidgetType( CoD.PerkListItemFactory )
	self.PerkList:setHorizontalCount( 10 )
	self:addElement( self.PerkList )

    -- Set datasource after element is added so parent will always be defined during the data source init / update
	self.PerkList:setDataSource( "ZMPerksFactory" )

	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 3 )

				self.PerkListBG:completeAnimation()
				self.PerkListBG:setAlpha( 1 )
				self.clipFinished( self.PerkListBG, {} )

				self.PerkListCenter:completeAnimation()
				self.PerkListCenter:setAlpha( 1 )
				self.clipFinished( self.PerkListCenter, {} )

				self.PerkList:completeAnimation()
				self.PerkList:setAlpha( 1 )
				self.clipFinished( self.PerkList, {} )
			end,
			Hidden = function ()
				self:setupElementClipCounter( 3 )

				local HiddenTransition = function ( element, event )
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

				self.PerkListBG:completeAnimation()
				self.PerkListBG:setAlpha( 1 )
				HiddenTransition( self.PerkListBG, {} )

				self.PerkListCenter:completeAnimation()
				self.PerkListCenter:setAlpha( 1 )
				HiddenTransition( self.PerkListCenter, {} )
				
				self.PerkList:completeAnimation()
				self.PerkList:setAlpha( 1 )
				HiddenTransition( self.PerkList, {} )
			end
		},
		Hidden = {
			DefaultClip = function ()
				self:setupElementClipCounter( 3 )

				self.PerkListBG:completeAnimation()
				self.PerkListBG:setAlpha( 0 )
				self.clipFinished( self.PerkListBG, {} )

				self.PerkListCenter:completeAnimation()
				self.PerkListCenter:setAlpha( 0 )
				self.clipFinished( self.PerkListCenter, {} )

				self.PerkList:completeAnimation()
				self.PerkList:setAlpha( 0 )
				self.clipFinished( self.PerkList, {} )
			end,
			DefaultState = function ()
				self:setupElementClipCounter( 3 )
				
				local DefaultStateTransition = function ( element, event )
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

				self.PerkListBG:completeAnimation()
				self.PerkListBG:setAlpha( 0 )
				DefaultStateTransition( self.PerkListBG, {} )

				self.PerkListCenter:completeAnimation()
				self.PerkListCenter:setAlpha( 0 )
				DefaultStateTransition( self.PerkListCenter, {} )

				self.PerkList:completeAnimation()
				self.PerkList:setAlpha( 0 )
				DefaultStateTransition( self.PerkList, {} )
			end
		}
	}

	self:mergeStateConditions( {
		{
			stateName = "Hidden",
			condition = function ( menu, element, event )
				if not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_AMMO_COUNTER_HIDE )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_EMP_ACTIVE )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_GAME_ENDED )
				and Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_HUD_VISIBLE )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_VEHICLE )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IS_PLAYER_IN_AFTERLIFE )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IS_SCOPED )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_UI_ACTIVE ) then
					return false
				else
					return true
				end
			end
		}
	} )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_AMMO_COUNTER_HIDE ), function ( modelRef )
		menu:updateElementState( self, {
			name = "model_validation",
			menu = menu,
			modelValue = Engine.GetModelValue( modelRef ),
			modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_AMMO_COUNTER_HIDE
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
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM ), function ( modelRef )
		menu:updateElementState( self, {
			name = "model_validation",
			menu = menu,
			modelValue = Engine.GetModelValue( modelRef ),
			modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM
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
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_GAME_ENDED ), function ( modelRef )
		menu:updateElementState( self, {
			name = "model_validation",
			menu = menu,
			modelValue = Engine.GetModelValue( modelRef ),
			modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_GAME_ENDED
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
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE ), function ( modelRef )
		menu:updateElementState( self, {
			name = "model_validation",
			menu = menu,
			modelValue = Engine.GetModelValue( modelRef ),
			modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE
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
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_VEHICLE ), function ( modelRef )
		menu:updateElementState( self, {
			name = "model_validation",
			menu = menu,
			modelValue = Engine.GetModelValue( modelRef ),
			modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_VEHICLE
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
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_PLAYER_IN_AFTERLIFE ), function ( modelRef )
		menu:updateElementState( self, {
			name = "model_validation",
			menu = menu,
			modelValue = Engine.GetModelValue( modelRef ),
			modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_PLAYER_IN_AFTERLIFE
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
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN ), function ( modelRef )
		menu:updateElementState( self, {
			name = "model_validation",
			menu = menu,
			modelValue = Engine.GetModelValue( modelRef ),
			modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN
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

	self.PerkList.id = "PerkList"

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.PerkListBG:close()
		element.PerkListCenter:close()
		element.PerkList:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end
