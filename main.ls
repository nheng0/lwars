global old_dist = null;
global old_enemy_cell = null;
global flees = 0;

function self_warmup()
{
	
}


function main()
{
	var TP = getTP();
	var MP = getMP();
	var me_cell = getCell();

	var enemy = getNearestEnemy();
	var enemy_cell = getCell(enemy);
	var dist = getCellDistance(me_cell, enemy_cell);
	if(flees == 0)
	{
		while(dist > 13 && MP)
		{
			moveToward(enemy,1);
			dist--;
			MP--;
		}
	}
	else
	{
		moveToward(enemy);
		dist--;
		MP--;		
	}
	
	if(dist < 8 && lineOfSight(me_cell, enemy_cell))
	{
		setWeapon(WEAPON_PISTOL);
		while(TP>0)
		{
			useWeapon(enemy);
			TP-=3;
		}
		if(!flees){
			moveAwayFrom(enemy);
		}
	}
	else if (dist < 11)
	{
		while(TP>0)
		{
			useChip(CHIP_SPARK, enemy);
			TP-=3;
		}
		if(!flees){
			moveAwayFrom(enemy);
		}
		setWeapon(WEAPON_PISTOL);
	}

	if(getTurn() > 1)
	{
		if(old_dist < dist || old_enemy_cell == enemy_cell)
		{
			flees = 1;
		}
		if(old_dist > dist && old_enemy_cell != enemy_cell)
		{
			flees = 0;
		}
	}
	debug(flees);
	old_dist = dist;
	old_enemy_cell = enemy_cell;
}

main();
