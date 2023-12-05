#using scripts\codescripts\struct;

#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

REGISTER_SYSTEM_EX( "zm_r6e_hud", &__init__, undefined, undefined )

function __init__()
{
    LuiLoad( "ui.uieditor.menus.hud.Hud_zm_factory" );
    LuiLoad( "ui.uieditor.widgets.HUD.PowerupsWidget.Powerups" );
 
    clientfield::register( "clientuimodel", "Health", VERSION_SHIP, GetMinBitCountForNum( 200 ), "int", undefined, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );
    clientfield::register( "clientuimodel", "hudItems.showDpadLeft_iw8", VERSION_SHIP, GetMinBitCountForNum( 3 ), "int", undefined, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );
    clientfield::register( "clientuimodel", "hudItems.dpadLeftAmmo", VERSION_SHIP, GetMinBitCountForNum( 66 ), "int", undefined, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );
    clientfield::register( "clientuimodel", "infinite_ammo_icon", VERSION_SHIP, 1 , "int", undefined, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );
    clientfield::register( "clientuimodel", "selfplayer_down_icon", VERSION_SHIP, 1 , "int", &_test, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );
}


function _test( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    SubtitlePrint( LocalClientNum, 2000, newval);
}
