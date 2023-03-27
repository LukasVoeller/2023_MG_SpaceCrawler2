extends Node2D

const Spaceship = preload("res://src/game/spaceship/Spaceship.tscn")
const Asteroid = preload("res://src/game/asteroid/Asteroid.tscn")
const Powerup = preload("res://src/game/powerup/Powerup.tscn")
const Player = preload("res://src/game/player/Player.tscn")
const ItemWeapon = preload("res://src/game/item/weapon/ItemWeapon.tscn")
const ItemShield = preload("res://src/game/item/shield/ItemShield.tscn")
const ItemHands = preload("res://src/game/item/hands/ItemHands.tscn")
const ItemHead = preload("res://src/game/item/head/ItemHead.tscn")
const ItemChest = preload("res://src/game/item/chest/ItemChest.tscn")
const ItemFeet = preload("res://src/game/item/feet/ItemFeet.tscn")
const ExpText = preload("res://src/util/text/exp_text/ExpText.tscn")


var rng = RandomNumberGenerator.new()

var max_int = 9223372036854775807
var asteroid_counter = 0
var asteroid_clear_cap = 50
var clear_reward = 1000
var dps_timer_elapsed_time = 0

var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	$Control.size = screen_size
	
	process_mode = Node.PROCESS_MODE_ALWAYS
	rng.randomize()
	
	dps_timer_elapsed_time = 0
	Global.damage_dealt_per_second_average = 0
	Global.damage_dealt_per_second_max = 0
	Global.damage_dealt_per_second = 0
	Global.damage_dealt_total = 0
	
	asteroid_counter = 0	
	$DPSTimer.start()
	$UpdateSpawnrateTimer.start()
	#$PowerupTimer.start()
	
	# Handle coldstart
	var save_game = FileAccess.open("user://savegame.save", FileAccess.READ)
	if not save_game:
		print("COLDSTART")
		var spaceship = Spaceship.instantiate()
		var player = Player.instantiate()
		add_child(spaceship)
		add_child(player)
		connect_listeners()
		game_start()
	else:
		load_game()
		connect_listeners()
		game_start()
		$Control/SkillBar/ExpBar.value = $Spaceship.exp_current


func connect_listeners():
	$Spaceship.connect("hit",Callable(self,"_on_Spaceship_hit"))
	$Spaceship.connect("dead",Callable(self,"_on_Spaceship_dead"))
	$Spaceship.connect("hp_changed",Callable(self,"_on_Spaceship_hp_changed"))


func init_ui():
	$Control.z_index = 20
	
	$Spawner.position.y -= 1425
	$Spawner.position.x -= 25
	
	$Control/SkillBar/Level/Label.text = str($Spaceship.level)
	$Control/Gold/Label.text = dot_seperate($Player.credits)
	#$Control/DPSProgress/DPSText.text = str(Global.damage_dealt_per_second_average)
	$Control/SkillBar/HPBar/HPBarText.text = (str($Spaceship.hp_current) + " / " + str(Global.spaceship_hp_max))
	$Control/SkillBar/HPBar.max_value = Global.spaceship_hp_max
	$Control/SkillBar/HPBar.value = $Spaceship.hp_current
	$Control/SkillBar/ExpBar.max_value = $Spaceship.exp_max
	$Control/LevelProgress/ProgressBar.value = asteroid_counter
	$Control/LevelProgress/Min.text = str(asteroid_counter)
	$Control/LevelProgress/ProgressBar.max_value = asteroid_clear_cap
	$Control/LevelProgress/Max.text = str(asteroid_clear_cap)
	$Control/SkillBar/ExpBar.value = $Spaceship.exp_current
	$Control/SkillBar/Exp.text = str($Spaceship.exp_current) + " / " + str($Spaceship.exp_max)
	#$Control/YouDead.hide()


func game_start():
	init_ui()
	$PlayedTimer.start()
	$Spaceship.start($SpaceshipStartPosition.position)
	#$PowerupTimer.start()
	$Spawner/AsteroidTimer.start()
	
	
func scale_asteroid(asteroid, scale):
	asteroid.get_node("Sprite2D").scale.x *= scale
	asteroid.get_node("Sprite2D").scale.y *= scale
	asteroid.get_node("CollisionPolygon2D").scale.x *= scale
	asteroid.get_node("CollisionPolygon2D").scale.y *= scale
	asteroid.get_node("ExplosionAnimation").scale.x *= 2
	asteroid.get_node("ExplosionAnimation").scale.y *= 2


func _on_Spaceship_hp_changed():
	$Control/SkillBar/HPBar/HPBarText.text = (str($Spaceship.hp_current) + " / " + str(Global.spaceship_hp_max))
	$Control/SkillBar/HPBar.value = $Spaceship.hp_current


func _on_Spaceship_hit():
	pass


func _on_Asteroid_dead_by_shot(asteroid):
	asteroid_counter += 1
	
	var item_drop_chance = rng.randi_range(Global.item_chance_min, Global.item_chance_max)
	if item_drop_chance <= 10 && !asteroid.spawned_item:
		if asteroid.get_global_transform_with_canvas()[2].y > 400:
			#if asteroid.get_global_transform_with_canvas()[2].x > (screen_size.x - 50) && asteroid.get_global_transform_with_canvas()[2].x < 50:
			spawn_item(asteroid)
			asteroid.spawned_item = true
			
	var powerup_drop_chance = rng.randi_range(Global.powerup_chance_min, Global.powerup_chance_max)
	if powerup_drop_chance <= 10 && !asteroid.spawned_item:
		if asteroid.get_global_transform_with_canvas()[2].y > 400:
			#if asteroid.get_global_transform_with_canvas()[2].x > (screen_size.x - 50) && asteroid.get_global_transform_with_canvas()[2].x < 50:
			spawn_powerup(asteroid)
			asteroid.spawned_item = true

	$Control/LevelProgress/ProgressBar.value = asteroid_counter
	$Control/LevelProgress/Min.text = str(asteroid_counter)
	$Player.credits += asteroid.credits
	$Control/Gold/Label.text = dot_seperate($Player.credits)
	#$Control/LevelCreditsDPS.text = "C: " + dot_seperate($Player.credits)
	
	if asteroid_counter == asteroid_clear_cap:
		level_cleared()
	else:
		#asteroid.show_exp(asteroid.exp_give)
		
		if asteroid.level+4 <= $Spaceship.level:
			var exp = round(asteroid.exp_give * 0.6)
			$Spaceship.exp_current += exp
			$Control/ExpText.text = "+" + str(exp) + " EXP"
		elif asteroid.level+3 == $Spaceship.level:
			var exp = round(asteroid.exp_give * 0.7)
			$Spaceship.exp_current += exp
			$Control/ExpText.text = "+" + str(exp) + " EXP"
		elif asteroid.level+2 == $Spaceship.level:
			var exp = round(asteroid.exp_give * 0.8)
			$Spaceship.exp_current += exp
			$Control/ExpText.text = "+" + str(exp) + " EXP"
		elif asteroid.level+4 == $Spaceship.level:
			var exp = round(asteroid.exp_give * 0.9)
			$Spaceship.exp_current += exp
			$Control/ExpText.text = "+" + str(exp) + " EXP"
		elif asteroid.level == $Spaceship.level:
			var exp = round(asteroid.exp_give * 1)
			$Spaceship.exp_current += exp
			$Control/ExpText.text = "+" + str(exp) + " EXP"
		elif asteroid.level-1 == $Spaceship.level:
			var exp = round(asteroid.exp_give * 1.15)
			$Spaceship.exp_current += exp
			$Control/ExpText.text = "+" + str(exp) + " EXP"
		elif asteroid.level-2 == $Spaceship.level:
			var exp = round(asteroid.exp_give * 1.2)
			$Spaceship.exp_current += exp
			$Control/ExpText.text = "+" + str(exp) + " EXP"
		elif asteroid.level-3 == $Spaceship.level:
			var exp = round(asteroid.exp_give * 1.25)
			$Spaceship.exp_current += exp
			$Control/ExpText.text = "+" + str(exp) + " EXP"
		elif asteroid.level-3 > $Spaceship.level:
			var diff = asteroid.level - $Spaceship.level
			
			if diff >= 10 && diff < 20:
				var exp = round(asteroid.exp_give * 3)
				$Spaceship.exp_current += exp
				$Control/ExpText.text = "+" + str(exp) + " EXP"
			elif diff >= 20 && diff < 30:
				var exp = round(asteroid.exp_give * 4)
				$Spaceship.exp_current += exp
				$Control/ExpText.text = "+" + str(exp) + " EXP"
			elif diff >= 30 && diff < 40:
				var exp = round(asteroid.exp_give * 5)
				$Spaceship.exp_current += exp
				$Control/ExpText.text = "+" + str(exp) + " EXP"
			elif diff >= 40 && diff < 60:
				var exp = round(asteroid.exp_give * 7)
				$Spaceship.exp_current += exp
				$Control/ExpText.text = "+" + str(exp) + " EXP"

		
		$Control/SkillBar/ExpBar.value = $Spaceship.exp_current
		$Control/SkillBar/Exp.text = str($Spaceship.exp_current) + " / " + str($Spaceship.exp_max)
		
		if $Spaceship.exp_current >= $Spaceship.exp_max:
			show_level_up()
			$Spaceship.level_up()
			$Control/SkillBar/HPBar.value = $Spaceship.hp_current
			$Control/SkillBar/HPBar/HPBarText.text = (str($Spaceship.hp_current) + " / " + str(Global.spaceship_hp_max))
			$Control/SkillBar/ExpBar.max_value = $Spaceship.exp_max
			$Control/SkillBar/ExpBar.value = $Spaceship.exp_current
			$Control/SkillBar/Exp.text = str($Spaceship.exp_current) + " / " + str($Spaceship.exp_max)
			$Control/SkillBar/Level/Label.text = str($Spaceship.level)
			
			
	var asteroid_clear_cap_part = asteroid_clear_cap / 5
	
	if asteroid_counter == asteroid_clear_cap_part * 2:
		$Spawner/AsteroidTimer.wait_time = $Spawner/AsteroidTimer.wait_time / 2
	elif asteroid_counter == asteroid_clear_cap_part * 4:
		$Spawner/AsteroidTimer.wait_time = $Spawner/AsteroidTimer.wait_time / 2


func show_level_up():
	$Control/LevelUp.show()
	$LevelUpTimer.start()
	


func spawn_powerup(asteroid):
	var powerup_i = Powerup.instantiate()
	var powerup_spawn_location = asteroid.get_global_transform_with_canvas()
	powerup_i.position.x = powerup_spawn_location[2].x
	powerup_i.position.y = powerup_spawn_location[2].y
	powerup_i.linear_velocity = asteroid.linear_velocity
	add_child(powerup_i)


func spawn_item(asteroid):
	var rand_type = rng.randi_range(1, 6)
	var rand_rarity = rng.randi_range(Global.item_rarity_min, Global.item_rarity_max)
	var rand_level
	var item_spawn_location = asteroid.get_global_transform_with_canvas()
	
	if ($Spaceship.level - 5) >= 1 && ($Spaceship.level + 5) <= 100:
		rand_level = rng.randi_range($Spaceship.level - 5, $Spaceship.level + 5)
	else:
		rand_level = $Spaceship.level
	
	print("Span item with level: " , rand_level)
	
	#func init(item_name, rar, lvl, upgr, val, tex_no, equ, type):
	if rand_type == 1:
		var item_weapon = ItemWeapon.instantiate()
		item_weapon.init("No name", rand_rarity, rand_level, 5, 100, "", "inventory", "weapon")
		item_weapon.position.x = item_spawn_location[2].x
		item_weapon.position.y = item_spawn_location[2].y
		item_weapon.connect("collected",Callable($Player,"_on_Item_collected").bind(item_weapon))
		add_child(item_weapon)
	if rand_type == 2:
		var item_shield = ItemShield.instantiate()
		item_shield.init("No name", rand_rarity, rand_level, 0, 100, "", "inventory", "shield")
		item_shield.position.x = item_spawn_location[2].x
		item_shield.position.y = item_spawn_location[2].y
		item_shield.connect("collected",Callable($Player,"_on_Item_collected").bind(item_shield))
		add_child(item_shield)
	if rand_type == 3:
		var item_hands = ItemHands.instantiate()
		item_hands.init("No name", rand_rarity, rand_level, 0, 100, "", "inventory", "hands")
		item_hands.position.x = item_spawn_location[2].x
		item_hands.position.y = item_spawn_location[2].y
		item_hands.connect("collected",Callable($Player,"_on_Item_collected").bind(item_hands))
		add_child(item_hands)
	if rand_type == 4:
		var item_head = ItemHead.instantiate()
		item_head.init("No name", rand_rarity, rand_level, 0, 100, "", "inventory", "head")
		item_head.position.x = item_spawn_location[2].x
		item_head.position.y = item_spawn_location[2].y
		item_head.connect("collected",Callable($Player,"_on_Item_collected").bind(item_head))
		add_child(item_head)
	if rand_type == 5:
		var item_chest = ItemChest.instantiate()
		item_chest.init("No name", rand_rarity, rand_level, 0, 100, "", "inventory", "chest")
		item_chest.position.x = item_spawn_location[2].x
		item_chest.position.y = item_spawn_location[2].y
		item_chest.connect("collected",Callable($Player,"_on_Item_collected").bind(item_chest))
		add_child(item_chest)
	if rand_type == 6:
		var item_feet = ItemFeet.instantiate()
		item_feet.init("No name", rand_rarity, rand_level, 0, 100, "", "inventory", "feet")
		item_feet.position.x = item_spawn_location[2].x
		item_feet.position.y = item_spawn_location[2].y
		item_feet.connect("collected",Callable($Player,"_on_Item_collected").bind(item_feet))
		add_child(item_feet)


func _on_Spaceship_dead():
	$PlayedTimer.stop()
	if $Player.max_dps < Global.damage_dealt_per_second_max:
		$Player.max_dps = Global.damage_dealt_per_second_max
	#$Control/Abilities.hide()
	$DPSTimer.stop()
	#$PowerupTimer.stop()
	$Control/LevelFailed.show()
	$Spaceship.queue_free()
	$Control/Footer/PauseButton.disabled = true
	save_game()


func level_cleared():
	explode_all_asteroids()
	$Spaceship.game_paused = true
	$Control/Footer/PauseButton.disabled = true
	$Spaceship.level_cleard = true
	$Spawner/AsteroidTimer.stop()
	$PlayedTimer.stop()
	$DPSTimer.stop()
	if $Player.max_dps < Global.damage_dealt_per_second_max:
		$Player.max_dps = Global.damage_dealt_per_second_max
	
	await get_tree().create_timer(3).timeout
	$Control/LevelCleared.show()
	#$Control/SkillBar.hide()
	$Spaceship.queue_free()
	save_game()
	

func _on_Ability_1_pressed():
	pass
	print("1")
#	if $Spaceship.auto_shoot:
#		$Spaceship.auto_shoot = false
#	else:
#		$Spaceship.auto_shoot = true


func _on_Ability_2_pressed():
	pass
	print("2")
#	if $Spaceship.get_node("SpaceshipCollision").disabled:
#		$Spaceship.get_node("SpaceshipCollision").disabled = false
#	else:
#		$Spaceship.get_node("SpaceshipCollision").disabled = true


func _on_Ability_3_pressed():
	pass
	print("3")
#	$Spaceship.weapon.damage_base -= 5


func save_game():
	var save_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	
	print("SAVE GAME")
	#print(save_nodes)
	
	for node in save_nodes:
		# Check the node is an instanced scene so it can be instanced again during load.
		#if node.filename.is_empty():
		if not node:
			print("persistent node '%s' is not an instanced scene, skipped" % node.name)
			continue

		# Check the node has a save function.
		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue

		# Call the node's save function.
		var node_data = node.save()

		# Store the save dictionary as a new line in the save file.
		save_game.store_line(JSON.new().stringify(node_data))
	save_game.close()


func load_game():
	var save_game = FileAccess.open("user://savegame.save", FileAccess.READ)
	if not save_game:
		return # Error! We don't have a save to load.

	while save_game.get_position() < save_game.get_length():
		# Get the saved dictionary from the next line in the save file
		var test_json_conv = JSON.new()
		test_json_conv.parse(save_game.get_line())
		var node_data = test_json_conv.get_data()

		# Firstly, we need to create the object and add it to the tree and set its position.
		var new_object = load(node_data["filename"]).instantiate()
		add_child(new_object)
		#get_node(node_data["parent"]).add_child(new_object)
	
		print("LOAD GAME: ", new_object)
	
		# Now we set the remaining variables.
		for i in node_data.keys():
			if i == "filename" or i == "parent":
				continue
			new_object.set(i, node_data[i])

	save_game.close()


func _on_DPSTimer_timeout():		
	#$DPSProgress/DPSText.text = str(Global.damage_dealt_per_second)
	#$DPSProgress/DPSText.text = str(Global.damage_dealt_per_second_average)
	
	$Control/DPSMeter/DPS.text = str(dot_seperate(Global.damage_dealt_per_second))
	$Control/DPSMeter/DPSAvg.text = str(dot_seperate(Global.damage_dealt_per_second_average))
	$Control/DPSMeter/DpsMax.text = str(dot_seperate(Global.damage_dealt_per_second_max))
	
	dps_timer_elapsed_time += 1
	
	if  (max_int - Global.damage_dealt_per_second) <= Global.damage_dealt_total:
		print("INTEGER OVERFLOW!")
		Global.damage_dealt_total = 0
	else:
		Global.damage_dealt_total += Global.damage_dealt_per_second
		
	Global.damage_dealt_per_second = 0
	Global.damage_dealt_per_second_average = Global.damage_dealt_total / dps_timer_elapsed_time

	#$Control/DPSProgress.value = Global.damage_dealt_per_second_average


func _on_UpdateSpawnrateTimer_timeout():
	pass
	
	#print("Spantimer")
	
#	var new_wait_time = float(1 / (1 + pow((asteroid_counter/100), 2)))
#
#	if asteroid_counter > 0:
#		var dif_ast = asteroid_counter / 100.0
#		var sep_dif_ast = snapped(dif_ast, 0.01)
#		var pow_dif_ast = pow(sep_dif_ast, 2.0)
#		var result = 1.0 / (1.0 + pow_dif_ast)
#		var sep_result = snapped(result, 0.01)
#		$Spawner/AsteroidTimer.wait_time = sep_result - 0.5




func dot_seperate(number):
	var string = str(number)
	var mod = string.length() % 3
	var res = ""

	for i in range(0, string.length()):
		if i != 0 && i % 3 == mod:
			res += "."
		res += string[i]

	return res



func _on_PlayedTimer_timeout():
	Global.time_played += 1


func _on_pause_button_pressed():
	if $Player.max_dps < Global.damage_dealt_per_second_max:
		$Player.max_dps = Global.damage_dealt_per_second_max
		
	for child in $Spaceship/Weapon.get_children():
		if child is Projectile:
			child.game_paused = true

	get_tree().paused = true
	$PlayedTimer.stop()
	$Spaceship.hide()
	$Background.hide()
	$Background.get_node("StarTimer").stop()
	$Spaceship.get_node("SpaceshipSprite").stop()
	$Spaceship.movement_enabled = false
	$Spaceship.game_paused = true
	$Spaceship/WeaponTimer.stop()
	$Spawner/AsteroidTimer.stop()
	$DPSTimer.stop()
	$Control/Pause.show()
	save_game()


func _on_pause_resume_button_pressed():
	for child in $Spaceship/Weapon.get_children():
		if child is Projectile:
			child.game_paused = false
	
	get_tree().paused = false
	$PlayedTimer.start()
	$Spaceship.show()
	$Background.show()
	$Background.get_node("StarTimer").start()
	$Spaceship.get_node("SpaceshipSprite").play()
	$Spaceship.movement_enabled = true
	$Spaceship.game_paused = false
	$Spawner/AsteroidTimer.start()
	$DPSTimer.start()
	$Control/Pause.hide()


func explode_all_asteroids():
	var on_screen_asteroids = []
	
	for n in $Spawner.get_children():
		if n is Asteroid:
			on_screen_asteroids.append(n)
	
	while on_screen_asteroids.size() > 0:
		var rand_asteroid = rng.randi_range(0, on_screen_asteroids.size()-1)
		
		if (is_instance_valid(on_screen_asteroids[rand_asteroid])):
			on_screen_asteroids[rand_asteroid].explode()
		
		on_screen_asteroids.remove_at(rand_asteroid)
		await get_tree().create_timer(0.03).timeout


func _on_pause_menu_button_pressed():
	#save_game()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://src/scene/menu/Menu.tscn")



func _on_level_cleared_menu_button_pressed():
	get_tree().change_scene_to_file("res://src/scene/menu/Menu.tscn")


func _on_level_cleared_failed_button_pressed():
	get_tree().change_scene_to_file("res://src/scene/menu/Menu.tscn")


func _on_spawner_asteroid_spawned(asteroid):
	asteroid.connect("dead_by_shot", Callable(self,"_on_Asteroid_dead_by_shot").bind(asteroid))


func _on_level_up_timer_timeout():
	$Control/LevelUp.hide()
