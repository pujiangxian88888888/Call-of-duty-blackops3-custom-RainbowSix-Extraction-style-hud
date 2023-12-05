#using scripts\codescripts\struct;

#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\compass;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\util_shared;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#insert scripts\zm\_zm_utility.gsh;

#using scripts\zm\_load;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using scripts\zm\_zm_zonemgr;
#using scripts\zm\_zm_spawner;

#using scripts\shared\ai\zombie_utility;

//Perks
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_pack_a_punch;
#using scripts\zm\_zm_pack_a_punch_util;
#using scripts\zm\_zm_perk_additionalprimaryweapon;
#using scripts\zm\_zm_perk_doubletap2;
#using scripts\zm\_zm_perk_deadshot;
#using scripts\zm\_zm_perk_juggernaut;
#using scripts\zm\_zm_perk_quick_revive;
#using scripts\zm\_zm_perk_sleight_of_hand;
#using scripts\zm\_zm_perk_staminup;
#using scripts\zm\perks\_zm_perk_phdflopper;
#using scripts\zm\perks\_zm_perk_berserker;


#using scripts\zm\_hb21_zm_hero_weapon;


//Powerups
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_powerup_double_points;
#using scripts\zm\_zm_powerup_carpenter;
#using scripts\zm\_zm_powerup_fire_sale;
#using scripts\zm\_zm_powerup_free_perk;
#using scripts\zm\_zm_powerup_full_ammo;
#using scripts\zm\_zm_powerup_insta_kill;
#using scripts\zm\_zm_powerup_nuke;
//#using scripts\zm\_zm_powerup_weapon_minigun;

//Traps
#using scripts\zm\_zm_trap_electric;

#using scripts\zm\zm_usermap;

#using scripts\Sphynx\craftables\_zm_craft_zombie_shield;

#using scripts\Sphynx\_zm_sphynx_util;

#using scripts\zm\_zm_r6ehud_hitmarks;

#using scripts\zm\_zm_r6e_hud;

#using scripts\Sphynx\_zm_commands;
#using scripts\Sphynx\_zm_name_checker;

#using scripts\zm\zm_low_health_warning;

//#using scripts\zm\_zm_weap_luna_dial;

//*****************************************************************************
// MAIN
//*****************************************************************************

function main()
{
	zm_usermap::main();

	custom_add_weapons();

	//Setup the levels Zombie Zone Volumes
	level.zones = [];
	level.zone_manager_init_func =&usermap_test_zone_init;
	init_zones[0] = "start_zone";
	level thread zm_zonemgr::manage_zones( init_zones );

	level.pathdist_type = PATHDIST_ORIGINAL;

	level.default_laststandpistol = GetWeapon( "iw8_m19" );
	level.default_solo_laststandpistol = GetWeapon( "iw8_m19_up" );
	level.laststandpistol = level.default_laststandpistol;
	level.start_weapon = Getweapon( "iw8_r90_up" );

	zm_perks::perk_machine_removal( "specialty_additionalprimaryweapon" );
	level._custom_perks = Array::remove_index(level._custom_perks, "specialty_additionalprimaryweapon", 1);

	level.player_starting_points=500000;
    level.next_dog_round=9999;
    //level.pack_a_punch_camo_index=136; //永久冻土

	//level thread low_health_warning();
	zm_sphynx_util::black_ops_4_carpenter();
	zm_sphynx_util::black_ops_4_ammo();

	level thread turn_on_power();
	level thread give_perk();
	//level thread dp12_pap_double_points_init();

}

function usermap_test_zone_init()
{
	level flag::init( "always_on" );
	level flag::set( "always_on" );
}	

function custom_add_weapons()
{
	zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_manor_levelcommon.csv", 1);
}

function dev_debug_print( text )
{
	IPrintLnBold( "DEV LOG:"+ text );
}

function setTriggerBasicInfo( HintString )
{
	self setHintString( HintString );
	self setCursorHint( "HINT_NOICON" );
}

function getPlayerCurrentZoneName()
{
	if( isdefined( GetEnt( self zm_utility::get_current_zone(), "targetname" ) ) && isdefined( GetEnt( self zm_utility::get_current_zone(), "targetname" ).script_string ) )
	{
		return GetEnt( self zm_utility::get_current_zone(), "targetname" ).script_string;
	}
	return undefined;
}

function turn_on_power()
{
	level waittill( "initial_blackscreen_passed" );
	level flag::clear( "power_off" );
	level flag::set( "power_on" );
}

function give_perk()
{
	perkTrigger = GetEnt( "perk_trig", "targetname" );
	perkTrigger setTriggerBasicInfo( "Hold ^3[{+activate}]^7 for all perks" );
	perkTrigger waittill( "trigger", player );
	player zm_sphynx_util::give_all_perks();
	perkTrigger delete();
}


/*function dp12_pap_double_points_init()
{
	zm_spawner::register_zombie_damage_callback( &dp12_pap_hit_zombie );
	zm_spawner::register_zombie_death_event_callback( &dp12_pap_kill_zombie );
}

function dp12_pap_hit_zombie( attacker )
{
	if( ( self.damagemod === "MOD_PISTOL_BULLET" || self.damagemod === "MOD_HEADSHOT" ) && attacker GetCurrentWeapon() == GetWeapon( "iw8_r90_up" ) ) 
	{
		self.attacker.score += 10;
	}
	return -1;
}

function dp12_pap_kill_zombie( attacker, shitloc )
{
	if( !zm_powerups::is_insta_kill_active())
	{
		if( ( self.damagemod === "MOD_PISTOL_BULLET" || self.damagemod === "MOD_HEADSHOT" ) && attacker GetCurrentWeapon() == GetWeapon( "iw8_r90_up" ) ) 
		{
			self.attacker.score += 100;
			
			if( isdefined( shitloc ) )
			{
				switch ( shitloc )
				{
					case "head":    self.attacker.score += 100; break;
					case "helmet":  self.attacker.score += 100; break;
 
					default: self.attacker.score += 50;
				}
			}
			
		}
	}
	
	return -1;	
}
*/

	