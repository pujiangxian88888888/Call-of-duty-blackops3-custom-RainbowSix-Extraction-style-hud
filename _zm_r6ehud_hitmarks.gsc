#using scripts\zm\_zm_spawner; 

#precache( "material", "r6e_hitmarker" );
#precache( "material", "r6e_hitmarker_death" );

function autoexec init()
{
	zm_spawner::register_zombie_damage_callback( &allow_hitmarkers ); 
	zm_spawner::register_zombie_death_event_callback( &allow_death_hitmarker ); 
}

function allow_hitmarkers( mod, hit_location, hit_origin, player, amount, weapon, direction_vec, tagName, modelName, partName, dFlags, inflictor, chargeLevel )
{
	//player PlayLocalSound( "nsz_hit_alert" ); 
	
	if( !isDefined(player.hud_damagefeedback) )
	{
		player.hud_damagefeedback = newdamageindicatorhudelem(player);

	player.hud_damagefeedback.alignX = "center";
	player.hud_damagefeedback.alignY = "center";
	player.hud_damagefeedback.horzAlign = "center";
	player.hud_damagefeedback.vertAlign = "center";

		player.hud_damagefeedback.alpha = 0;
		player.hud_damagefeedback.archived = true;
		player.hud_damagefeedback setShader( "r6e_hitmarker", 22, 22 );
	}
	
	player.hud_damagefeedback setShader( "r6e_hitmarker", 22, 22 );

		player.hud_damagefeedback.color = ( 1, 1, 1 );
	player.hud_damagefeedback.alpha = 1; 
	player.hud_damagefeedback fadeOverTime(1);
	player.hud_damagefeedback.alpha = 0; 
	
	return false; 
}

function allow_death_hitmarker( player )
{
	//player PlayLocalSound( "nsz_hit_alert" ); 
	
	if( !isDefined(player.hud_damagefeedback) )
	{
		player.hud_damagefeedback = newdamageindicatorhudelem(player);

	player.hud_damagefeedback.alignX = "center";
	player.hud_damagefeedback.alignY = "center";
	player.hud_damagefeedback.horzAlign = "center";
	player.hud_damagefeedback.vertAlign = "center";

		player.hud_damagefeedback.alpha = 0;
		player.hud_damagefeedback.archived = true;
		player.hud_damagefeedback setShader( "r6e_hitmarker_death", 22, 22 );
	}

	player.hud_damagefeedback setShader( "r6e_hitmarker_death", 22, 22 );
		player.hud_damagefeedback.color = ( 1, 1, 1 );
	player.hud_damagefeedback.alpha = 1; 
	player.hud_damagefeedback fadeOverTime(1);
	player.hud_damagefeedback.alpha = 0;
	return false; 
}