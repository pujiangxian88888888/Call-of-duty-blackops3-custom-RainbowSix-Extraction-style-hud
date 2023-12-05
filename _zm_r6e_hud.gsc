#using scripts\codescripts\struct;

#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;

#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_utility;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#insert scripts\zm\_zm_utility.gsh;

#precache( "lui_menu_data", "zone_name" );

REGISTER_SYSTEM_EX( "zm_r6e_hud", &__init__, &__main__, undefined )

function __init__()
{
    clientfield::register( "clientuimodel", "Health", VERSION_SHIP, GetMinBitCountForNum( 200 ), "int" );
	clientfield::register( "clientuimodel", "hudItems.showDpadLeft_iw8", VERSION_SHIP, GetMinBitCountForNum( 3 ), "int" );
	clientfield::register( "clientuimodel", "hudItems.dpadLeftAmmo", VERSION_SHIP, GetMinBitCountForNum( 66 ), "int" );
	clientfield::register( "clientuimodel", "infinite_ammo_icon", VERSION_SHIP, 1 , "int" );
	clientfield::register( "clientuimodel", "selfplayer_down_icon", VERSION_SHIP, 1 , "int" );
	
}
function __main__()
{
    callback::on_spawned( &on_player_spawned );
}

function on_player_spawned()
{
	self thread player_health_monitor();
	self thread zone_name_monitor();
	self thread underbarreal_monitor();
	self thread infinite_ammo_monitor();
	self thread selfplayer_down_monitor();
	//thread test();
	
}

function player_health_monitor()
{
    self endon( "bled_out" );
    self endon( "disconnect" );
    self endon( "spawned_player" );
    
	while( true )
	{
		if( isdefined( self ) )
		{
			if( zm_utility::is_player_valid( self ) )
			{
				if( !IS_EQUAL( self clientfield::get_player_uimodel( "Health" ), self.health ) )
					self clientfield::set_player_uimodel( "Health", self.health );
			}
			else
			{
				if( !IS_EQUAL( self clientfield::get_player_uimodel( "Health" ), 0 ) )
					self clientfield::set_player_uimodel( "Health", 0 );
			}
		}

		WAIT_SERVER_FRAME;
	}
}

function zone_name_monitor()
{
    self endon( "bled_out" );
    self endon( "disconnect" );
    self endon( "spawned_player" );

	self waittill( "weapon_change_complete" ); // Wait until the player has a weapon before we begin the loop

	while( true )
	{
		if( isdefined( self ) )
		{
			if( isdefined( GetEnt( self zm_utility::get_current_zone(), "targetname" ).script_string ) )
			{
				if( !IS_EQUAL( self GetControllerUIModelValue( "zone_name" ), GetEnt( self zm_utility::get_current_zone(), "targetname" ).script_string ) )
					self SetControllerUIModelValue( "zone_name", GetEnt( self zm_utility::get_current_zone(), "targetname" ).script_string );
			}
			else
			{
				if( !IS_EQUAL( self GetControllerUIModelValue( "zone_name" ), "none" ) )
					self SetControllerUIModelValue( "zone_name", "none" );
			}
		}

		WAIT_SERVER_FRAME;
	}
}

function underbarreal_monitor()
{
	self endon( "bled_out" );
	self endon( "disconnect" );
	self endon( "spawned_player" );

	while( true )
	{
		//self waittill("weapon_give", weapon);

		//当前玩家只持有一把带下挂的武器
		//scar-h
		if( ( self HasWeapon( GetWeapon( "iw8_scar17s_up" ), true) && !self HasWeapon( GetWeapon( "iw8_ak47_up" ), true) && !self HasWeapon( GetWeapon( "iw8_fal_up" ), true) ) )
		{
			self clientfield::set_player_uimodel("hudItems.showDpadLeft_iw8", 1);
			ammocount = self GetAmmoCount( GetWeapon( "iw8_scar17s_launcher" ) );
			self clientfield::set_player_uimodel("hudItems.dpadLeftAmmo", ammocount);
		}
		//ak47
		else if( ( self HasWeapon( GetWeapon( "iw8_ak47_up" ), true) && !self HasWeapon( GetWeapon( "iw8_scar17s_up" ), true) && !self HasWeapon( GetWeapon( "iw8_fal_up" ), true) ) )
		{
			self clientfield::set_player_uimodel("hudItems.showDpadLeft_iw8", 2);
			ammocount = self GetAmmoCount( GetWeapon( "iw8_ak47_launcher" ) );
			self clientfield::set_player_uimodel("hudItems.dpadLeftAmmo", ammocount);
		} 
		//fal
		else if( ( self HasWeapon( GetWeapon( "iw8_fal_up" ), true) && !self HasWeapon( GetWeapon( "iw8_scar17s_up" ), true) && !self HasWeapon( GetWeapon( "iw8_ak47_up" ), true) ) )
		{
			self clientfield::set_player_uimodel("hudItems.showDpadLeft_iw8", 3);
			ammocount = self GetAmmoCount( GetWeapon( "iw8_fal_shotty" ) );
			self clientfield::set_player_uimodel("hudItems.dpadLeftAmmo", ammocount);
		}
		//当前玩家持有两把下挂武器
		else if( (self HasWeapon( GetWeapon( "iw8_fal_up" ), true) && self HasWeapon( GetWeapon( "iw8_scar17s_up" ) ) ) || (self HasWeapon( GetWeapon( "iw8_ak47_up" ), true) && self HasWeapon( GetWeapon( "iw8_scar17s_up" ) ) ) || (self HasWeapon( GetWeapon( "iw8_fal_up" ), true) && self HasWeapon( GetWeapon( "iw8_ak47_up" ) ) ) )
		{
			if( self GetCurrentWeapon() == GetWeapon( "iw8_fal_up" ) || self GetCurrentWeapon() == GetWeapon( "iw8_fal_shotty" ) )
			{
				self clientfield::set_player_uimodel("hudItems.showDpadLeft_iw8", 3);
				ammocount = self GetAmmoCount( GetWeapon( "iw8_fal_shotty" ) );
				self clientfield::set_player_uimodel("hudItems.dpadLeftAmmo", ammocount);
			}
			else if( self GetCurrentWeapon() == GetWeapon( "iw8_scar17s_up" ) || self GetCurrentWeapon() == GetWeapon( "iw8_scar17s_launcher" ) )
			{
				self clientfield::set_player_uimodel("hudItems.showDpadLeft_iw8", 1);
				ammocount = self GetAmmoCount( GetWeapon( "iw8_scar17s_launcher" ) );
				self clientfield::set_player_uimodel("hudItems.dpadLeftAmmo", ammocount);
			}
			else if( self GetCurrentWeapon() == GetWeapon( "iw8_ak47_up" ) || self GetCurrentWeapon() == GetWeapon( "iw8_ak47_launcher" ) )
			{
				self clientfield::set_player_uimodel("hudItems.showDpadLeft_iw8", 2);
				ammocount = self GetAmmoCount( GetWeapon( "iw8_ak47_launcher" ) );
				self clientfield::set_player_uimodel("hudItems.dpadLeftAmmo", ammocount);
			}
		}
		//当前玩家没有带下挂的武器
		else
		{
			self clientfield::set_player_uimodel("hudItems.showDpadLeft_iw8", 0);
			self clientfield::set_player_uimodel("hudItems.dpadLeftAmmo", 0);
		}

		WAIT_SERVER_FRAME;
	} 

}

function infinite_ammo_monitor()
{
	self endon( "bled_out" );
	self endon( "disconnect" );
	self endon( "spawned_player" );

	while( true )
	{
		if(self GetCurrentWeapon() == GetWeapon( "minigun" ) )
		{
			self clientfield::set_player_uimodel( "infinite_ammo_icon", 1 );
		}
		else
		{
			self clientfield::set_player_uimodel( "infinite_ammo_icon", 0 );
		}
		WAIT_SERVER_FRAME;
	}
}

function selfplayer_down_monitor()
{
	self endon( "bled_out" );
	self endon( "disconnect" );
	self endon( "spawned_player" );

	while( true )
	{
		if( self laststand::player_is_in_laststand() )
		{
			self clientfield::set_player_uimodel( "selfplayer_down_icon", 1 );
		}
		else
		{
			self clientfield::set_player_uimodel( "selfplayer_down_icon", 0 );
		}	
		WAIT_SERVER_FRAME;
	}
}

/*
function test()
{
	ModVar( "underBarrel", "" );
	for(;;)
	{
		dVar = GetDvarInt( "underBarrel", 9);
		if( dVar != 9 )
		{
			IPrintLnBold( dVar );
			SetDvar( "underBarrel", 9 );
		}
		wait 0.05;
	}
}
*/
