--玩家本人左下角hud
---@diagnostic disable: undefined-global
require( "ui.uieditor.widgets.ZMInventoryStalingrad.GameTimeGroup" )

local PreLoadFunc = function ( self, controller )
	Engine.CreateModel( Engine.GetModelForController( controller ), "_zone_name" )
end

CoD.SelfScore = InheritFrom( LUI.UIElement )
CoD.SelfScore.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.SelfScore )
	self.id = "SelfScore"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 1280 )
	self:setTopBottom( true, false, 0, 720 )
	self.anyChildUsesUpdateState = true

	--右上角区域名称文本
	self.ZoneText = LUI.UIText.new()
	self.ZoneText:setLeftRight( true, false, 20, 0 )
	self.ZoneText:setTopBottom( true, false, 64, 84 ) 
	self.ZoneText:setText( Engine.Localize( "" ) )
	self.ZoneText:setTTF( "fonts/Erbaum_Bold.ttf" )
	self.ZoneText:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_LEFT )
	self.ZoneText:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "zone_name" ), function ( modelRef )
		if Engine.GetModelValue( modelRef ) then
			if Engine.GetModelValue( modelRef ) == "none" then
				self.ZoneText:setText( Engine.Localize( "Unknown" ) )
			else
				self.ZoneText:setText( Engine.Localize( Engine.GetModelValue( modelRef ) ) )
			end
		end
	end )
	self:addElement( self.ZoneText )

	--玩家本人的左下hud背景
	--弃用
	self.ScoreBG = LUI.UIImage.new()
	self.ScoreBG:setLeftRight( true, false, 20, 280 )
	self.ScoreBG:setTopBottom( false, true, -120, -20 )
	self.ScoreBG:setImage( RegisterImage( "blacktransparent" ) )
	self.ScoreBG:setYRot( 180 )
	self:addElement( self.ScoreBG )

	
	self.PlayerIconBG = LUI.UIImage.new()
	self.PlayerIconBG:setLeftRight( true, false, 20, 104 )
	self.PlayerIconBG:setTopBottom( false, true, -120, -28 )
	self.PlayerIconBG:setImage( RegisterImage( "ui_icon_player_icon_bg" ) )
	--self.ScoreBG:setYRot( 180 )
	self:addElement( self.PlayerIconBG )
	
	--玩家本人的角色图片
	self.PortraitImage = LUI.UIImage.new()
	self.PortraitImage:setLeftRight( true, false, 10, 118 )
	self.PortraitImage:setTopBottom( false, true, -125, -13 )
	self.PortraitImage:setImage( RegisterImage( "blacktransparent" ) )
	self.PortraitImage:setScale( 0.7 )
	self.PortraitImage:linkToElementModel( self, "zombiePlayerIcon", true, function ( modelRef )
		if Engine.GetModelValue( modelRef ) then
			if Engine.GetModelValue( modelRef ) == "uie_t7_zm_hud_score_char1" then
				self.PortraitImage:setImage( RegisterImage( "ui_icon_hero_portrait_draft_sakuya" ) )

			elseif Engine.GetModelValue( modelRef ) == "uie_t7_zm_hud_score_char2" then
				self.PortraitImage:setImage( RegisterImage( "ui_icon_hero_portrait_draft_marisa" ) )

			elseif Engine.GetModelValue( modelRef ) == "uie_t7_zm_hud_score_char3" then
				self.PortraitImage:setImage( RegisterImage( "ui_icon_hero_portrait_draft_reisen" ) )

			elseif Engine.GetModelValue( modelRef ) == "uie_t7_zm_hud_score_char4" then
				self.PortraitImage:setImage( RegisterImage( "ui_icon_hero_portrait_draft_reimu" ) )

			else
				self.PortraitImage:setImage( RegisterImage( "blacktransparent" ) )
			end
		end
	end )
	self:addElement( self.PortraitImage )

	--玩家本人倒地后在角色图片上显示一个标记
	self.SelfPlayerDownIcon = LUI.UIImage.new()
	self.SelfPlayerDownIcon:setLeftRight( true, false, 20, 104 )
	self.SelfPlayerDownIcon:setTopBottom( false, true, -120, -28 )
	--self.SelfPlayerDownIcon:setImage( RegisterImage( "ui_icon_selfplayer_down" ) )
	self.SelfPlayerDownIcon:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ) , "selfplayer_down_icon" ), function ( modelRef ) 
		if Engine.GetModelValue( ModelRef ) then
			if Engine.GetModelValue( modelRef ) == 1 then
				self.SelfPlayerDownIcon:setImage( RegisterImage( "ui_icon_selfplayer_down" ) )
			else
				self.SelfPlayerDownIcon:setImage( RegisterImage( "blacktransparent" ) )
			end
		end
	end )
	self:addElement( self.SelfPlayerDownIcon )

	--玩家本人的金钱文本
	self.ScoreText = LUI.UIText.new()
	self.ScoreText:setLeftRight( true, false, 119, 265 )
	self.ScoreText:setTopBottom( false, true, -70.5, -40.5 )
	self.ScoreText:setTTF( "fonts/Erbaum_Bold.ttf" )
	self.ScoreText:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_LEFT )
	self.ScoreText:setScale( 1.2 )
	self.ScoreText:linkToElementModel( self, "clientNum", true, function ( modelRef )
		if Engine.GetModelValue( modelRef ) then
			self.ScoreText:setRGB( ZombieClientScoreboardColor( Engine.GetModelValue( modelRef ) ) )
		end
	end )
	self.ScoreText:linkToElementModel( self, "playerScore", true, function ( modelRef )
		if Engine.GetModelValue( modelRef ) then
			self.ScoreText:setText( Engine.Localize( Engine.GetModelValue( modelRef ) ) )
		end
	end )
	self:addElement( self.ScoreText )

	--玩家血条背景
	self.HealthBarBG = LUI.UIImage.new()
	self.HealthBarBG:setLeftRight( true, false, 102.5, 362.5 )
	self.HealthBarBG:setTopBottom( false, true, -48, -24 )
	self.HealthBarBG:setImage( RegisterImage( "ui_icon_health_bar_bg" ) )
	--self.ScoreBG:setYRot( 180 )
	self:addElement( self.HealthBarBG )

	--玩家血条
	self.HealthBar = LUI.UIImage.new()
	self.HealthBar:setLeftRight( true, false, 104.5, 356.5 )
	self.HealthBar:setTopBottom( false, true, -41.5, -29.5 )
	self.HealthBar:setImage( RegisterImage( "ui_icon_health_bar" ) )
	self.HealthBar:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
	self.HealthBar:setShaderVector( 1, 0, 0, 0, 0 )
	self.HealthBar:setShaderVector( 2, 1, 0, 0, 0 )
	self.HealthBar:setShaderVector( 3, 0, 0, 0, 0 )
	self.HealthBar:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "Health" ), function ( modelRef )
		if Engine.GetModelValue( modelRef ) then
			if Engine.GetModelValue( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.perks.juggernaut" ) ) ~= nil then
				if Engine.GetModelValue( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.perks.juggernaut" ) ) > 0 then
					self.HealthBar:beginAnimation( "keyframe", 400, false, false, CoD.TweenType.Linear )

					if Engine.GetModelValue( modelRef ) <= 200 / 3 then
						self.HealthBar:setRGB( 1, 0, 0 )
					else
						self.HealthBar:setRGB( 1, 1, 1 )
					end

					self.HealthBar:setShaderVector( 0, AdjustStartEnd( 0, 1,
						CoD.GetVectorComponentFromString( Engine.GetModelValue( modelRef ) / 200, 1 ),
						CoD.GetVectorComponentFromString( Engine.GetModelValue( modelRef ) / 200, 2 ),
						CoD.GetVectorComponentFromString( Engine.GetModelValue( modelRef ) / 200, 3 ),
						CoD.GetVectorComponentFromString( Engine.GetModelValue( modelRef ) / 200, 4 ) )
					)
				else
					self.HealthBar:beginAnimation( "keyframe", 400, false, false, CoD.TweenType.Linear )
					
					if Engine.GetModelValue( modelRef ) <= 100 / 3 then
						self.HealthBar:setRGB( 1, 0, 0 )
					else
						self.HealthBar:setRGB( 1, 1, 1 )
					end

					self.HealthBar:setShaderVector( 0, AdjustStartEnd( 0, 1,
						CoD.GetVectorComponentFromString( Engine.GetModelValue( modelRef ) / 100, 1 ),
						CoD.GetVectorComponentFromString( Engine.GetModelValue( modelRef ) / 100, 2 ),
						CoD.GetVectorComponentFromString( Engine.GetModelValue( modelRef ) / 100, 3 ),
						CoD.GetVectorComponentFromString( Engine.GetModelValue( modelRef ) / 100, 4 ) )
					)
				end
			end
		end
	end )
	self:addElement( self.HealthBar )

	--玩家血量数字
	self.HealthText = LUI.UIText.new()
	self.HealthText:setLeftRight( true, false, 365, 415)
	self.HealthText:setTopBottom( false, true, -50, -20 )
	self.HealthText:setTTF( "fonts/Erbaum_Bold.ttf" )
	self.HealthText:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_LEFT )
	self.HealthText:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "Health" ), function ( modelRef )
		if Engine.GetModelValue( modelRef ) then
			self.HealthText:setText( Engine.Localize( Engine.GetModelValue( modelRef ) ) )
		end
	end )
	self:addElement( self.HealthText )

	--左上角计时器
	self.GameTimeGroup = CoD.GameTimeGroup.new( menu, controller )
	self.GameTimeGroup:setLeftRight( true, false, 185, 227.5 )
	self.GameTimeGroup:setTopBottom( true, false, 35, 55 )
	self.GameTimeGroup:setScale( 0.5 )
	self.GameTimeGroup:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_RIGHT )
	self.GameTimeGroup.CurrentClockTime.FEButtonPanelShaderContainer:setScale( 0 )
	self.GameTimeGroup.CurrentClockTime.Backing:setScale( 0 )
	self.GameTimeGroup.CurrentClockTime.BackPanel:setScale( 0 )
	self.GameTimeGroup.CurrentClockTime.TimeElasped:setScale( 0 )
	self.GameTimeGroup.CurrentClockTime.GameTimer:setTTF( "fonts/Erbaum_Bold.ttf" )
	--self.GameTimeGroup.CurrentClockTime.GameTimer:setRGB( 0.9, 0.9, 0.9 )
	self.GameTimeGroup.CurrentClockTime.HighlightFrame:setScale( 0 )
	self.GameTimeGroup.SurviveTime:setScale( 0 )
	self.GameTimeGroup.Last5RoundTime:setScale( 0 )
	self.GameTimeGroup.QuestTime:setScale( 0 )
	self:addElement( self.GameTimeGroup )

	--左上角虚线
	self.DotLine = LUI.UIImage.new()
	self.DotLine:setLeftRight( true, false, -80, 370)
	self.DotLine:setTopBottom( true, false, 65, 101)
	self.DotLine:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_LEFT )
	self.DotLine:setImage( RegisterImage( "ui_icon_lefttop_dotline" ) )
	--self.DotLine:setAlpha( 0.6 )
	self.DotLine:setScale( 0.6 )
	self:addElement( self.DotLine )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.ZoneText:close()
		element.ScoreBG:close()
		element.PlayerIconBG:close()
		element.PortraitImage:close()
		element.SelfPlayerDownIcon:close()
		element.ScoreText:close()
		element.HealthBarBG:close()
		element.HealthBar:close()
		element.HealthText:close()
		element.GameTimeGroup:close()
		element.DotLine:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end
