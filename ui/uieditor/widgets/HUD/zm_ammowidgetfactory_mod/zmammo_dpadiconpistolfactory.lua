-- =============================================================================== --
-- LUAC rebuild by HarryBo21
-- Last Edited : 24/07/2019
-- ui.uieditor.widgets.HUD.ZM_AmmoWidgetFactory.ZmAmmo_DpadIconPistolFactory
-- =============================================================================== --

require("ui.uieditor.widgets.HUD.ZM_FX.ZmFx_Spark1Img")

CoD.ZmAmmo_DpadIconPistolFactory = InheritFrom(LUI.UIElement)

local function PreLoadCallback(HudRef, InstanceRef)
end

local function PostLoadCallback(HudRef, HudRef, InstanceRef)
end

function CoD.ZmAmmo_DpadIconPistolFactory.new(HudRef, InstanceRef)
	local ZmAmmo_DpadIconPistolFactory = LUI.UIElement.new()
	
	if PreLoadCallback then
		PreLoadCallback(ZmAmmo_DpadIconPistolFactory, InstanceRef)
	end
	
	ZmAmmo_DpadIconPistolFactory:setClass(CoD.ZmAmmo_DpadIconPistolFactory)
	ZmAmmo_DpadIconPistolFactory.id = "ZmAmmo_DpadIconPistolFactory"
	ZmAmmo_DpadIconPistolFactory.soundSet = "HUD"
	ZmAmmo_DpadIconPistolFactory:setLeftRight(true, false, 0.000000, 32.000000)
	ZmAmmo_DpadIconPistolFactory:setTopBottom(true, false, 0.000000, 32.000000)
	
	ZmAmmo_DpadIconPistolFactory.DpadIconSword = LUI.UIImage.new()
	ZmAmmo_DpadIconPistolFactory.DpadIconSword:setLeftRight(true, false, -16.750000, 48.250000)
	ZmAmmo_DpadIconPistolFactory.DpadIconSword:setTopBottom(true, false, -15.750000, 49.250000)
	ZmAmmo_DpadIconPistolFactory.DpadIconSword:setAlpha(0.000000)
	ZmAmmo_DpadIconPistolFactory.DpadIconSword:setZoom(4.000000)
	ZmAmmo_DpadIconPistolFactory.DpadIconSword:setImage(RegisterImage("uie_t7_zm_derriese_hud_ammo_icon_gun"))
	ZmAmmo_DpadIconPistolFactory:addElement(ZmAmmo_DpadIconPistolFactory.DpadIconSword)
		
	ZmAmmo_DpadIconPistolFactory.ZmFxSpark1Img0 = CoD.ZmFx_Spark1Img.new(HudRef, InstanceRef)
	ZmAmmo_DpadIconPistolFactory.ZmFxSpark1Img0:setLeftRight(true, false, -33.940000, 46.720000)
	ZmAmmo_DpadIconPistolFactory.ZmFxSpark1Img0:setTopBottom(true, false, -77.440000, 40.560000)
	ZmAmmo_DpadIconPistolFactory.ZmFxSpark1Img0:setRGB(0.000000, 0.890000, 1.000000)
	ZmAmmo_DpadIconPistolFactory.ZmFxSpark1Img0:setAlpha(0.000000)
	ZmAmmo_DpadIconPistolFactory.ZmFxSpark1Img0:setYRot(180.000000)
	ZmAmmo_DpadIconPistolFactory.ZmFxSpark1Img0:setRFTMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	ZmAmmo_DpadIconPistolFactory.ZmFxSpark1Img0.Image00:setShaderVector(0.000000, 10.000000, 2.000000, 0.000000, 0.000000)
	ZmAmmo_DpadIconPistolFactory.ZmFxSpark1Img0.Image00:setShaderVector(1.000000, 30.000000, 0.000000, 0.000000, 0.000000)
	ZmAmmo_DpadIconPistolFactory:addElement(ZmAmmo_DpadIconPistolFactory.ZmFxSpark1Img0)
	
	ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady = LUI.UIImage.new()
	ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady:setLeftRight(true, false, -16.000000, 47.500000)
	ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady:setTopBottom(true, false, -14.500000, 48.000000)
	ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady:setImage(RegisterImage("uie_t7_zm_derriese_hud_ammo_icon_gun_ready"))
	ZmAmmo_DpadIconPistolFactory:addElement(ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady)
	
	ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady0 = LUI.UIImage.new()
	ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady0:setLeftRight(true, false, -15.630000, 46.720000)
	ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady0:setTopBottom(true, false, -14.350000, 48.000000)
	ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady0:setAlpha(0.000000)
	ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady0:setImage(RegisterImage("uie_t7_zm_derriese_hud_ammo_icon_gun_readyflash"))
	ZmAmmo_DpadIconPistolFactory:addElement(ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady0)
	
	ZmAmmo_DpadIconPistolFactory.Lightning = LUI.UIImage.new()
	ZmAmmo_DpadIconPistolFactory.Lightning:setLeftRight(true, false, -67.860000, 99.360000)
	ZmAmmo_DpadIconPistolFactory.Lightning:setTopBottom(true, false, -67.720000, 73.720000)
	ZmAmmo_DpadIconPistolFactory.Lightning:setAlpha(0.000000)
	ZmAmmo_DpadIconPistolFactory.Lightning:setImage(RegisterImage("uie_t7_zm_derriese_hud_notification_anim"))
	ZmAmmo_DpadIconPistolFactory.Lightning:setMaterial(LUI.UIImage.GetCachedMaterial("uie_flipbook"))
	ZmAmmo_DpadIconPistolFactory.Lightning:setShaderVector(0.000000, 28.000000, 0.000000, 0.000000, 0.000000)
	ZmAmmo_DpadIconPistolFactory.Lightning:setShaderVector(1.000000, 30.000000, 0.000000, 0.000000, 0.000000)
	ZmAmmo_DpadIconPistolFactory:addElement(ZmAmmo_DpadIconPistolFactory.Lightning)
	
	ZmAmmo_DpadIconPistolFactory.clipsPerState = 
	{
		DefaultState =
		{
			DefaultClip = function()
				ZmAmmo_DpadIconPistolFactory:setupElementClipCounter(5.000000)
				
				ZmAmmo_DpadIconPistolFactory.DpadIconSword:completeAnimation()
				ZmAmmo_DpadIconPistolFactory.DpadIconSword:setAlpha(0.000000)
				ZmAmmo_DpadIconPistolFactory.clipFinished(ZmAmmo_DpadIconPistolFactory.DpadIconSword, {})
				
				ZmAmmo_DpadIconPistolFactory.ZmFxSpark1Img0:completeAnimation()
				ZmAmmo_DpadIconPistolFactory.ZmFxSpark1Img0:setAlpha(0.000000)
				ZmAmmo_DpadIconPistolFactory.clipFinished(ZmAmmo_DpadIconPistolFactory.ZmFxSpark1Img0, {})
				
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady:completeAnimation()
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady:setAlpha(0.000000)
				ZmAmmo_DpadIconPistolFactory.clipFinished(ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady, {})
				
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady0:completeAnimation()
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady0:setAlpha(0.000000)
				ZmAmmo_DpadIconPistolFactory.clipFinished(ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady0, {})
				
				ZmAmmo_DpadIconPistolFactory.Lightning:completeAnimation()
				ZmAmmo_DpadIconPistolFactory.Lightning:setAlpha(0.000000)
				ZmAmmo_DpadIconPistolFactory.clipFinished(ZmAmmo_DpadIconPistolFactory.Lightning, {})
			end
		},
		Ready =
		{
			DefaultClip = function()
				ZmAmmo_DpadIconPistolFactory:setupElementClipCounter(4.000000)
				
				ZmAmmo_DpadIconPistolFactory.ZmFxSpark1Img0:completeAnimation()
				ZmAmmo_DpadIconPistolFactory.ZmFxSpark1Img0:setAlpha(0.820000)
				ZmAmmo_DpadIconPistolFactory.ZmFxSpark1Img0:beginAnimation("keyframe", 29.000000, false, false, CoD.TweenType.Linear)
				ZmAmmo_DpadIconPistolFactory.ZmFxSpark1Img0:setAlpha(1.000000)
				ZmAmmo_DpadIconPistolFactory.ZmFxSpark1Img0:registerEventHandler("transition_complete_keyframe", function(HudRef, EventRef)
					HudRef:beginAnimation("keyframe", 489.000000, false, false, CoD.TweenType.Linear)
					HudRef:setAlpha(0.800000)
					HudRef:registerEventHandler("transition_complete_keyframe", function(HudRef, EventRef)
						HudRef:beginAnimation("keyframe", 629.000000, false, false, CoD.TweenType.Linear)
						HudRef:setAlpha(0.000000)
						HudRef:registerEventHandler("transition_complete_keyframe", ZmAmmo_DpadIconPistolFactory.clipFinished)
					end)
				end)
				
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady:completeAnimation()
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady:setRGB(1.000000, 1.000000, 1.000000)
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady:setAlpha(0.000000)
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady:beginAnimation("keyframe", 119.000000, false, false, CoD.TweenType.Linear)
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady:setAlpha(1.000000)
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady:registerEventHandler("transition_complete_keyframe", function(HudRef, EventRef)
					ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady:beginAnimation("keyframe", 1080.000000, false, false, CoD.TweenType.Linear)
					ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady:setRGB(1.000000, 1.000000, 1.000000)
					ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady:setAlpha(1.000000)
					ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady:registerEventHandler("transition_complete_keyframe", ZmAmmo_DpadIconPistolFactory.clipFinished)
				end)
				
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady0:completeAnimation()
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady0:setAlpha(0.000000)
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady0:beginAnimation("keyframe", 280.000000, false, false, CoD.TweenType.Linear)
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady0:setAlpha(1.000000)
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady0:registerEventHandler("transition_complete_keyframe", function(HudRef, EventRef)
					HudRef:beginAnimation("keyframe", 289.000000, false, false, CoD.TweenType.Linear)
					HudRef:setAlpha(0.000000)
					HudRef:registerEventHandler("transition_complete_keyframe", function(HudRef, EventRef)
						HudRef:beginAnimation("keyframe", 290.000000, false, false, CoD.TweenType.Linear)
						HudRef:setAlpha(1.000000)
						HudRef:registerEventHandler("transition_complete_keyframe", function(HudRef, EventRef)
							HudRef:beginAnimation("keyframe", 289.000000, false, false, CoD.TweenType.Linear)
							HudRef:setAlpha(0.000000)
							HudRef:registerEventHandler("transition_complete_keyframe", ZmAmmo_DpadIconPistolFactory.clipFinished)
						end)
					end)
				end)
				
				ZmAmmo_DpadIconPistolFactory.Lightning:completeAnimation()
				ZmAmmo_DpadIconPistolFactory.Lightning:setAlpha(0.000000)
				ZmAmmo_DpadIconPistolFactory.Lightning:beginAnimation("keyframe", 119.000000, false, false, CoD.TweenType.Linear)
				ZmAmmo_DpadIconPistolFactory.Lightning:setAlpha(1.000000)
				ZmAmmo_DpadIconPistolFactory.Lightning:registerEventHandler("transition_complete_keyframe", function(HudRef, EventRef)
					HudRef:beginAnimation("keyframe", 519.000000, false, false, CoD.TweenType.Linear)
					HudRef:registerEventHandler("transition_complete_keyframe", function(HudRef, EventRef)
						HudRef:beginAnimation("keyframe", 409.000000, false, false, CoD.TweenType.Linear)
						HudRef:setAlpha(0.000000)
						HudRef:registerEventHandler("transition_complete_keyframe", ZmAmmo_DpadIconPistolFactory.clipFinished)
					end)
				end)
			end,
			InUse = function()
				ZmAmmo_DpadIconPistolFactory:setupElementClipCounter(2.000000)
				
				ZmAmmo_DpadIconPistolFactory.ZmFxSpark1Img0:completeAnimation()
				ZmAmmo_DpadIconPistolFactory.ZmFxSpark1Img0:setAlpha(0.000000)
				ZmAmmo_DpadIconPistolFactory.clipFinished(ZmAmmo_DpadIconPistolFactory.ZmFxSpark1Img0, {})
				
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady:completeAnimation()
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady:setAlpha(1.000000)
				ZmAmmo_DpadIconPistolFactory.clipFinished(ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady, {})
			end
		},
		Charge =
		{
			DefaultClip = function()
				ZmAmmo_DpadIconPistolFactory:setupElementClipCounter(4.000000)
				
				ZmAmmo_DpadIconPistolFactory.ZmFxSpark1Img0:completeAnimation()
				ZmAmmo_DpadIconPistolFactory.ZmFxSpark1Img0:setAlpha(0.000000)
				ZmAmmo_DpadIconPistolFactory.clipFinished(ZmAmmo_DpadIconPistolFactory.ZmFxSpark1Img0, {})
				
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady:completeAnimation()
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady:setRGB(1.000000, 1.000000, 1.000000)
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady:setAlpha(0.300000)
				ZmAmmo_DpadIconPistolFactory.clipFinished(ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady, {})
				
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady0:completeAnimation()
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady0:setAlpha(0.000000)
				ZmAmmo_DpadIconPistolFactory.clipFinished(ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady0, {})
				
				ZmAmmo_DpadIconPistolFactory.Lightning:completeAnimation()
				ZmAmmo_DpadIconPistolFactory.Lightning:setAlpha(0.000000)
				ZmAmmo_DpadIconPistolFactory.clipFinished(ZmAmmo_DpadIconPistolFactory.Lightning, {})
			end
		},
		InUse =
		{
			DefaultClip = function()
				ZmAmmo_DpadIconPistolFactory:setupElementClipCounter(4.000000)
				
				ZmAmmo_DpadIconPistolFactory.ZmFxSpark1Img0:completeAnimation()
				ZmAmmo_DpadIconPistolFactory.ZmFxSpark1Img0:setAlpha(0.000000)
				ZmAmmo_DpadIconPistolFactory.clipFinished(ZmAmmo_DpadIconPistolFactory.ZmFxSpark1Img0, {})
				
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady:completeAnimation()
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady:setRGB(1.000000, 1.000000, 1.000000)
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady:setAlpha(1.000000)
				ZmAmmo_DpadIconPistolFactory.clipFinished(ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady, {})
				
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady0:completeAnimation()
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady0:setAlpha(0.000000)
				ZmAmmo_DpadIconPistolFactory.clipFinished(ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady0, {})
				
				ZmAmmo_DpadIconPistolFactory.Lightning:completeAnimation()
				ZmAmmo_DpadIconPistolFactory.Lightning:setAlpha(0.000000)
				ZmAmmo_DpadIconPistolFactory.clipFinished(ZmAmmo_DpadIconPistolFactory.Lightning, {})
			end
		},
		Unavailable =
		{
			DefaultClip = function()
				ZmAmmo_DpadIconPistolFactory:setupElementClipCounter(4.000000)
				
				ZmAmmo_DpadIconPistolFactory.DpadIconSword:completeAnimation()
				ZmAmmo_DpadIconPistolFactory.DpadIconSword:setAlpha(1.000000)
				ZmAmmo_DpadIconPistolFactory.clipFinished(ZmAmmo_DpadIconPistolFactory.DpadIconSword, {})
				
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady:completeAnimation()
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady:setAlpha(0.000000)
				ZmAmmo_DpadIconPistolFactory.clipFinished(ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady, {})
				
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady0:completeAnimation()
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady0:setAlpha(0.000000)
				ZmAmmo_DpadIconPistolFactory.clipFinished(ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady0, {})
				
				ZmAmmo_DpadIconPistolFactory.Lightning:completeAnimation()
				ZmAmmo_DpadIconPistolFactory.Lightning:setAlpha(0.000000)
				ZmAmmo_DpadIconPistolFactory.clipFinished(ZmAmmo_DpadIconPistolFactory.Lightning, {})
			end
		},
		ElectricReady =
		{
			DefaultClip = function()
				ZmAmmo_DpadIconPistolFactory:setupElementClipCounter(4.000000)
				
				ZmAmmo_DpadIconPistolFactory.ZmFxSpark1Img0:completeAnimation()
				ZmAmmo_DpadIconPistolFactory.ZmFxSpark1Img0:setRGB(0.000000, 0.800000, 1.000000)
				ZmAmmo_DpadIconPistolFactory.ZmFxSpark1Img0:setAlpha(0.820000)
				ZmAmmo_DpadIconPistolFactory.ZmFxSpark1Img0:beginAnimation("keyframe", 29.000000, false, false, CoD.TweenType.Linear)
				ZmAmmo_DpadIconPistolFactory.ZmFxSpark1Img0:setAlpha(1.000000)
				ZmAmmo_DpadIconPistolFactory.ZmFxSpark1Img0:registerEventHandler("transition_complete_keyframe", function(HudRef, EventRef)
					HudRef:beginAnimation("keyframe", 489.000000, false, false, CoD.TweenType.Linear)
					HudRef:setAlpha(0.800000)
					HudRef:registerEventHandler("transition_complete_keyframe", function(HudRef, EventRef)
						HudRef:beginAnimation("keyframe", 629.000000, false, false, CoD.TweenType.Linear)
						HudRef:setRGB(0.000000, 0.800000, 1.000000)
						HudRef:setAlpha(0.000000)
						HudRef:registerEventHandler("transition_complete_keyframe", ZmAmmo_DpadIconPistolFactory.clipFinished)
					end)
				end)
				
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady:completeAnimation()
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady:setRGB(1.000000, 1.000000, 1.000000)
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady:setAlpha(0.000000)
				ZmAmmo_DpadIconPistolFactory.clipFinished(ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady, {})
				
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady0:completeAnimation()
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady0:setAlpha(0.000000)
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady0:beginAnimation("keyframe", 189.000000, false, false, CoD.TweenType.Linear)
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady0:setAlpha(1.000000)
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady0:registerEventHandler("transition_complete_keyframe", function(HudRef, EventRef)
					HudRef:beginAnimation("keyframe", 180.000000, false, false, CoD.TweenType.Linear)
					HudRef:setAlpha(0.280000)
					HudRef:registerEventHandler("transition_complete_keyframe", function(HudRef, EventRef)
						HudRef:beginAnimation("keyframe", 240.000000, false, false, CoD.TweenType.Linear)
						HudRef:setAlpha(1.000000)
						HudRef:registerEventHandler("transition_complete_keyframe", ZmAmmo_DpadIconPistolFactory.clipFinished)
					end)
				end)
				
				ZmAmmo_DpadIconPistolFactory.Lightning:completeAnimation()
				ZmAmmo_DpadIconPistolFactory.Lightning:setAlpha(0.000000)
				ZmAmmo_DpadIconPistolFactory.Lightning:beginAnimation("keyframe", 79.000000, false, false, CoD.TweenType.Linear)
				ZmAmmo_DpadIconPistolFactory.Lightning:setAlpha(1.000000)
				ZmAmmo_DpadIconPistolFactory.Lightning:registerEventHandler("transition_complete_keyframe", function(HudRef, EventRef)
					HudRef:beginAnimation("keyframe", 530.000000, false, false, CoD.TweenType.Linear)
					HudRef:registerEventHandler("transition_complete_keyframe", function(HudRef, EventRef)
						HudRef:beginAnimation("keyframe", 539.000000, false, false, CoD.TweenType.Linear)
						HudRef:setAlpha(0.000000)
						HudRef:registerEventHandler("transition_complete_keyframe", ZmAmmo_DpadIconPistolFactory.clipFinished)
					end)
				end)
			end,
			InUse = function()
				ZmAmmo_DpadIconPistolFactory:setupElementClipCounter(3.000000)
				
				ZmAmmo_DpadIconPistolFactory.ZmFxSpark1Img0:completeAnimation()
				ZmAmmo_DpadIconPistolFactory.ZmFxSpark1Img0:setAlpha(0.000000)
				ZmAmmo_DpadIconPistolFactory.clipFinished(ZmAmmo_DpadIconPistolFactory.ZmFxSpark1Img0, {})
				
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady:completeAnimation()
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady:setAlpha(0.000000)
				ZmAmmo_DpadIconPistolFactory.clipFinished(ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady, {})
				
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady0:completeAnimation()
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady0:setAlpha(1.000000)
				ZmAmmo_DpadIconPistolFactory.clipFinished(ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady0, {})
			end
		},
		ElectricCharge =
		{
			DefaultClip = function()
				ZmAmmo_DpadIconPistolFactory:setupElementClipCounter(4.000000)
				
				ZmAmmo_DpadIconPistolFactory.ZmFxSpark1Img0:completeAnimation()
				ZmAmmo_DpadIconPistolFactory.ZmFxSpark1Img0:setAlpha(0.000000)
				ZmAmmo_DpadIconPistolFactory.clipFinished(ZmAmmo_DpadIconPistolFactory.ZmFxSpark1Img0, {})
				
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady:completeAnimation()
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady:setRGB(1.000000, 0.460000, 0.000000)
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady:setAlpha(1.000000)
				ZmAmmo_DpadIconPistolFactory.clipFinished(ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady, {})
				
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady0:completeAnimation()
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady0:setRGB(0.000000, 0.970000, 1.000000)
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady0:setAlpha(1.000000)
				ZmAmmo_DpadIconPistolFactory.clipFinished(ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady0, {})
				
				ZmAmmo_DpadIconPistolFactory.Lightning:completeAnimation()
				ZmAmmo_DpadIconPistolFactory.Lightning:setAlpha(0.000000)
				ZmAmmo_DpadIconPistolFactory.clipFinished(ZmAmmo_DpadIconPistolFactory.Lightning, {})
			end
		},
		ElectricInUse =
		{
			DefaultClip = function()
				ZmAmmo_DpadIconPistolFactory:setupElementClipCounter(4.000000)
				
				ZmAmmo_DpadIconPistolFactory.ZmFxSpark1Img0:completeAnimation()
				ZmAmmo_DpadIconPistolFactory.ZmFxSpark1Img0:setAlpha(0.000000)
				ZmAmmo_DpadIconPistolFactory.clipFinished(ZmAmmo_DpadIconPistolFactory.ZmFxSpark1Img0, {})
				
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady:completeAnimation()
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady:setRGB(1.000000, 1.000000, 1.000000)
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady:setAlpha(0.000000)
				ZmAmmo_DpadIconPistolFactory.clipFinished(ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady, {})
				
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady0:completeAnimation()
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady0:setRGB(1.000000, 1.000000, 1.000000)
				ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady0:setAlpha(1.000000)
				ZmAmmo_DpadIconPistolFactory.clipFinished(ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady0, {})
				
				ZmAmmo_DpadIconPistolFactory.Lightning:completeAnimation()
				ZmAmmo_DpadIconPistolFactory.Lightning:setAlpha(0.000000)
				ZmAmmo_DpadIconPistolFactory.clipFinished(ZmAmmo_DpadIconPistolFactory.Lightning, {})
			end
		}
	}
	
	ZmAmmo_DpadIconPistolFactory:mergeStateConditions(
	{
		{
			stateName = "Ready",
			condition = function(HudRef, HudRef, InstanceRef)
				return IsModelValueEqualTo(InstanceRef, "zmhud.swordState", 2.000000)
			end
		},
		{
			stateName = "Charge",
			condition = function(HudRef, HudRef, InstanceRef)
				return IsModelValueEqualTo(InstanceRef, "zmhud.swordState", 1.000000)
			end
		},
		{
			stateName = "InUse",
			condition = function(HudRef, HudRef, InstanceRef)
				return IsModelValueEqualTo(InstanceRef, "zmhud.swordState", 3.000000)
			end
		},
		{
			stateName = "Unavailable",
			condition = function(HudRef, HudRef, InstanceRef)
				return IsModelValueEqualTo(InstanceRef, "zmhud.swordState", 4.000000)
			end
		},
		{
			stateName = "ElectricReady",
			condition = function(HudRef, HudRef, InstanceRef)
				return IsModelValueEqualTo(InstanceRef, "zmhud.swordState", 6.000000)
			end
		},
		{
			stateName = "ElectricCharge",
			condition = function(HudRef, HudRef, InstanceRef)
				return IsModelValueEqualTo(InstanceRef, "zmhud.swordState", 5.000000)
			end
		},
		{
			stateName = "ElectricInUse",
			condition = function(HudRef, HudRef, InstanceRef)
				return IsModelValueEqualTo(InstanceRef, "zmhud.swordState", 7.000000)
			end
		}
	})
	ZmAmmo_DpadIconPistolFactory:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "zmhud.swordState"), function(ModelRef)
		HudRef:updateElementState(ZmAmmo_DpadIconPistolFactory, {name = "model_validation", menu = HudRef, modelValue = Engine.GetModelValue(ModelRef), modelName = "zmhud.swordState"})
	end)
	
	local UpdateHeroIcon = function (ModelRef)
		local f10_local0 = Engine.GetModelValue(ModelRef)
		if f10_local0 == 0 then
			ZmAmmo_DpadIconPistolFactory.DpadIconSword:setImage(RegisterImage("uie_t7_zm_derriese_hud_ammo_icon_gun"))
			ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady:setImage(RegisterImage("uie_t7_zm_derriese_hud_ammo_icon_gun_ready"))
			ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady0:setImage(RegisterImage("uie_t7_zm_derriese_hud_ammo_icon_gun_readyflash"))
		elseif f10_local0 == 1 then
			ZmAmmo_DpadIconPistolFactory.DpadIconSword:setImage(RegisterImage("t7_hud_zm_hud_ammo_icon_spike"))
			ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady:setImage(RegisterImage("t7_hud_zm_hud_ammo_icon_spike_ready"))
			ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady0:setImage(RegisterImage("t7_hud_zm_hud_ammo_icon_spike_readyflash"))
		elseif f10_local0 == 2 then
			ZmAmmo_DpadIconPistolFactory.DpadIconSword:setImage(RegisterImage("t7_hud_zm_hud_ammo_icon_skull_weapon"))
			ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady:setImage(RegisterImage("t7_hud_zm_hud_ammo_icon_skull_weapon_ready"))
			ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady0:setImage(RegisterImage("t7_hud_zm_hud_ammo_icon_skull_weapon_readyflash"))
		elseif f10_local0 == 3 then
			ZmAmmo_DpadIconPistolFactory.DpadIconSword:setImage(RegisterImage("uie_t7_zm_dragon_gauntlet_ammo_icon_gun"))
			ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady:setImage(RegisterImage("uie_t7_zm_dragon_gauntlet_ammo_icon_gun_ready"))
			ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady0:setImage(RegisterImage("uie_t7_zm_dragon_gauntlet_ammo_icon_gun_readyflash"))
		elseif f10_local0 == 4 then
			ZmAmmo_DpadIconPistolFactory.DpadIconSword:setImage(RegisterImage("uie_t7_zm_hud_ammo_dpadicnswrd_weapon"))
			ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady:setImage(RegisterImage("uie_t7_zm_hud_ammo_dpadicnswrd_weapon_ready"))
			ZmAmmo_DpadIconPistolFactory.DpadIconSwordReady0:setImage(RegisterImage("uie_t7_zm_hud_ammo_dpadicnswrd_weapon_readyflash"))
		end
	end
	HudRef:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "hudItems.hero_weapon_icon"), UpdateHeroIcon)
	
	LUI.OverrideFunction_CallOriginalSecond(ZmAmmo_DpadIconPistolFactory, "close", function(HudRef)
		ZmFxSpark1Img0.ZmAmmoHologramSmallFactory:close()
	end)
	
	if PostLoadCallback then
        PostLoadCallback(ZmAmmo_DpadIconPistolFactory, HudRef, InstanceRef)
    end
	
	return ZmAmmo_DpadIconPistolFactory
end