extends Node2D

var screen_size

var equipped = []

const ItemDisplay = preload("res://src/game/item/_display/ItemDisplay.tscn")

var slots_equ = ["weapon", "shield", "hands", "head", "chest", "feet"]

func _ready():
	print("Stages instanced")
	screen_size = get_viewport_rect().size
	$Control.size = screen_size
	
	var device_width = get_viewport_rect().size.x
	var device_height = get_viewport_rect().size.y
	
	load_equipped()
	fill_equipped()
	
	#$Stage_1.set_global_position(Vector2(device_width/2-$Stage_1.size.x/2, (device_height/2) - 200))
	#$Stage_2.set_global_position(Vector2(device_width/2-$Stage_2.size.x/2, (device_height/2) - 100))
	#$Stage_3.set_global_position(Vector2(device_width/2-$Stage_3.size.x/2, (device_height/2) + 0))
	#$Stage_4.set_global_position(Vector2(device_width/2-$Stage_4.size.x/2, (device_height/2) + 100))


func _on_BackButton_pressed():
	get_tree().change_scene_to_file("res://src/menus/menu/Menu.tscn")


func _on_Earlygame_pressed():
	Global.asteroid_level = 2
	#Global.asteroid_timer = 0.5
	Global.weapon_atk_speed = 0.3
	Global.weapon_projectiles = 1
	Global.weapon_level = 1
	Global.spaceship_hp_max = 100
	get_tree().change_scene_to_file("res://src/game/gameloop/Gameloop.tscn")


func _on_Midgame_pressed():
	Global.asteroid_level = 50
	#Global.asteroid_timer = 0.5
	Global.weapon_atk_speed = 0.3
	Global.weapon_projectiles = 3
	Global.weapon_level = 20
	Global.spaceship_hp_max = 1000
	get_tree().change_scene_to_file("res://src/game/gameloop/Gameloop.tscn")


func _on_Endgame_pressed():
	Global.asteroid_level = 98
	#Global.asteroid_timer = 0.2
	Global.weapon_atk_speed = 0.1
	Global.weapon_projectiles = 5
	Global.weapon_level = 5
	Global.spaceship_hp_max = 10000
	get_tree().change_scene_to_file("res://src/game/gameloop/Gameloop.tscn")
	

func _on_Testscene_pressed():
	get_tree().change_scene_to_file("res://src/menus/testscene/TestScene.tscn")


func _on_PlanetSearch_pressed():
	get_tree().change_scene_to_file("res://src/menus/searchplanet/SearchPlanet.tscn")


func load_equipped():
	var save_game = FileAccess.open("user://saveinventory.save", FileAccess.READ)
	if not save_game.file_exists("user://saveinventory.save"):
		return # Error! We don't have a save to load.

	while save_game.get_position() < save_game.get_length():
		var test_json_conv = JSON.new()
		test_json_conv.parse(save_game.get_line())
		var node_data = test_json_conv.get_data()

		if slots_equ.has(node_data.equipped):
			equipped.append(node_data)
	
	save_game.close()
	
	
func fill_equipped():
	var item_display = null
	
	for n in equipped.size():
		if equipped[n].equipped == "weapon":
			item_display = ItemDisplay.instantiate()
			item_display.init(
				equipped[n].item_name,
				equipped[n].rarity,
				equipped[n].level,
				equipped[n].upgrade,
				equipped[n].value,
				equipped[n].texture_no,
				equipped[n].equipped,
				equipped[n].type
			)
			item_display.position = Vector2(8, 8)
			$Control/InfoBar/Slot1.add_child(item_display)
		elif equipped[n].equipped == "shield":
			item_display = ItemDisplay.instantiate()
			item_display.init(
				equipped[n].item_name,
				equipped[n].rarity,
				equipped[n].level,
				equipped[n].upgrade,
				equipped[n].value,
				equipped[n].texture_no,
				equipped[n].equipped,
				equipped[n].type
			)
			item_display.position = Vector2(8, 8)
			$Control/ItemBarTop/Slot2.add_child(item_display)
