extends Node2D

var projectile = preload("res://src/game/projectile/Projectile.tscn")

var rng = RandomNumberGenerator.new()

var level = Global.weapon_level
var damage_base = level * 25
var damage_relative = 0.15
var attack_speed = Global.weapon_atk_speed
var w_crit_chance = Global.weapon_crit_chance
var w_crit_damage = Global.weapon_crit_damage

var projectiles = Global.weapon_projectiles
var diagonal_projectiles = true

var equipped_weapon = []

func _ready():
	print ("Instanced Weapon")
	load_equipped_weapon()
	rng.randomize()


func shoot(pos):
	var texture = $TextureLoader.get_texture("weapon", equipped_weapon[0].rarity, equipped_weapon[0].texture_no)
	var damage_actual
	
	if projectiles == 1:
		for n in projectiles:
			damage_actual = rng.randi_range((damage_base - (damage_base*damage_relative)), (damage_base + (damage_base*damage_relative)))
			
			var projectile_i = projectile.instantiate()
			projectile_i.get_node("Sprite2D").texture = texture
			projectile_i.p_crit_chance = w_crit_chance
			projectile_i.p_crit_damage = w_crit_damage
			projectile_i.set_damage(damage_actual)
			projectile_i.position.x = pos.position.x
			projectile_i.position.y = pos.position.y
			
			if n == 0:
				projectile_i.set_x_offset(0)
				
			add_child(projectile_i)
	elif projectiles == 2:
		for n in projectiles:
			damage_actual = rng.randi_range((damage_base - (damage_base*damage_relative)), (damage_base + (damage_base*damage_relative)))
			
			var projectile_i = projectile.instantiate()
			projectile_i.get_node("Sprite2D").texture = texture
			projectile_i.p_crit_chance = w_crit_chance
			projectile_i.p_crit_damage = w_crit_damage
			projectile_i.set_damage(damage_actual)
			projectile_i.position.x = pos.position.x
			projectile_i.position.y = pos.position.y
			
			if n == 0:
				projectile_i.set_x_offset(-0.5)
			elif n == 1:
				projectile_i.set_x_offset(0.5)
				
			add_child(projectile_i)
			
	elif projectiles == 3:
		for n in projectiles:
			damage_actual = rng.randi_range((damage_base - (damage_base*damage_relative)), (damage_base + (damage_base*damage_relative)))
			
			var projectile_i = projectile.instantiate()
			projectile_i.get_node("Sprite2D").texture = texture
			projectile_i.p_crit_chance = w_crit_chance
			projectile_i.p_crit_damage = w_crit_damage
			projectile_i.set_damage(damage_actual)
			projectile_i.position.x = pos.position.x
			projectile_i.position.y = pos.position.y
			
			if n == 0:
				projectile_i.set_x_offset(-0.75)
			elif n == 1:
				projectile_i.set_x_offset(0)
			elif n == 2:
				projectile_i.set_x_offset(0.75)

				
			add_child(projectile_i)
	elif projectiles == 4:
		for n in projectiles:
			damage_actual = rng.randi_range((damage_base - (damage_base*damage_relative)), (damage_base + (damage_base*damage_relative)))
			
			var projectile_i = projectile.instantiate()
			projectile_i.get_node("Sprite2D").texture = texture
			projectile_i.p_crit_chance = w_crit_chance
			projectile_i.p_crit_damage = w_crit_damage
			projectile_i.set_damage(damage_actual)
			projectile_i.position.x = pos.position.x
			projectile_i.position.y = pos.position.y
			
			if n == 0:
				projectile_i.set_x_offset(-0.9)
			elif n == 1:
				projectile_i.set_x_offset(-0.3)
			elif n == 2:
				projectile_i.set_x_offset(0.3)
			elif n == 3:
				projectile_i.set_x_offset(0.9)
				
			add_child(projectile_i)
	elif projectiles == 5:
		for n in projectiles:
			damage_actual = rng.randi_range((damage_base - (damage_base*damage_relative)), (damage_base + (damage_base*damage_relative)))
			
			var projectile_i = projectile.instantiate()
			projectile_i.get_node("Sprite2D").texture = texture
			projectile_i.p_crit_chance = w_crit_chance
			projectile_i.p_crit_damage = w_crit_damage
			projectile_i.set_damage(damage_actual)
			projectile_i.position.x = pos.position.x
			projectile_i.position.y = pos.position.y
			
			if n == 0:
				projectile_i.set_x_offset(-2)
			elif n == 1:
				projectile_i.set_x_offset(-1)
			elif n == 2:
				projectile_i.set_x_offset(0)
			elif n == 3:
				projectile_i.set_x_offset(1)
			elif n == 4:
				projectile_i.set_x_offset(2)
				
			add_child(projectile_i)


func spawn_projectile(pos):
	var damage_actual
	
	for n in projectiles:
		damage_actual = rng.randi_range((damage_base - (damage_base*damage_relative)), (damage_base + (damage_base*damage_relative)))
		
		var projectile_i = projectile.instantiate()
		projectile_i.p_crit_chance = w_crit_chance
		projectile_i.p_crit_damage = w_crit_damage
		projectile_i.set_damage(damage_actual)
		projectile_i.position.x = pos.position.x
		projectile_i.position.y = pos.position.y
		
		if n == 0:
			projectile_i.set_x_offset(-0.5)
		elif n == (projectiles - 1):
			projectile_i.set_x_offset(0.5)
		else:
			projectile_i.set_x_offset(0)
			
		add_child(projectile_i)
		
		
func load_equipped_weapon():
	var save_game = FileAccess.open("user://saveinventory.save", FileAccess.READ)
	if not save_game:
		return # Error! We don't have a save to load.

	while save_game.get_position() < save_game.get_length():
		var test_json_conv = JSON.new()
		test_json_conv.parse(save_game.get_line())
		var node_data = test_json_conv.get_data()

		if node_data.equipped == "weapon":
			equipped_weapon.append(node_data)
	
	save_game.close()
