extends Node2D

var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	$Control.size = screen_size
	
	# Handle coldstart
	var save_player = FileAccess.open("user://player.save", FileAccess.READ)
	if not save_player:
		init_save_player()
	
	var save_spaceship = FileAccess.open("user://spaceship.save", FileAccess.READ)
	if not save_spaceship:
		init_save_spaceship()
	
	var save_game = FileAccess.open("user://saveinventory.save", FileAccess.READ)
	if not save_game:
		init_save_inventory()


func init_save_player():
	var save_game = FileAccess.open("user://player.save", FileAccess.WRITE)
	var data = {
		"filename" : "res://src/game/player/Player.tscn",
		"credits" : 0,
		"max_dps" : 0,
	}
	save_game.store_line(JSON.new().stringify(data))
	save_game.close()
	
	
func init_save_spaceship():
	var save_game = FileAccess.open("user://spaceship.save", FileAccess.WRITE)
	var data = {
		"filename" : "res://src/game/spaceship/Spaceship.tscn",
		"level" : 1,
		"exp_max" : 19,
		"exp_current" : 0,
		"hp_max" : 100,
		"upgraded" : false
	}
	save_game.store_line(JSON.new().stringify(data))
	save_game.close()

# For Coldstart handle
func init_save_inventory():
	var inventory = []
	var save_game = FileAccess.open("user://saveinventory.save", FileAccess.WRITE)
	
	var weapon_stats = {
		"primary_stat_first": 25,
		"primary_stat_second": 0.5,
		
		"secondary_stat_first": 5,
		"secondary_stat_second": 20,
		"secondary_stat_third": 0,
		
		"socket_1": 0,
		"socket_2": 0,
	}
	
	var shield_stats = {
		"primary_stat_first": 100,
		"primary_stat_second": 10,
		
		"secondary_stat_first": 0,
		"secondary_stat_second": 0,
		"secondary_stat_third": 0,
		
		"socket_1": 0,
		"socket_2": 0,
	}
	
	var armor_stats = {
		"primary_stat_first": 100,
		"primary_stat_second": 10,
		
		"secondary_stat_first": 0,
		"secondary_stat_second": 0,
		"secondary_stat_third": 0,
		
		"socket_1": 0,
		"socket_2": 0,
	}
	
	inventory.append({
		"equipped": "weapon",
		"item_name": "Decapitation Blade",
		"level": 1, 
		"rarity": 1,
		"texture_no": "1",
		"type": "weapon",
		"upgrade": 0,
		"value": 100,
		"stats": weapon_stats
	})
	
	inventory.append({
		"equipped": "shield",
		"item_name": "Skinny Woodplank",
		"level": 1, 
		"rarity": 1,
		"texture_no": "T1-1",
		"type": "shield",
		"upgrade": 0,
		"value": 100,
		"stats": shield_stats
	})
	
	inventory.append({
		"equipped": "chest",
		"item_name": "Leather Chest",
		"level": 1, 
		"rarity": 1,
		"texture_no": "T1-1",
		"type": "chest",
		"upgrade": 0,
		"value": 100,
		"stats": armor_stats
	})
	
	inventory.append({
		"equipped": "feet",
		"item_name": "Leather Boots",
		"level": 1, 
		"rarity": 1,
		"texture_no": "T1-1",
		"type": "feet",
		"upgrade": 0,
		"value": 100,
		"stats": armor_stats
	})
	
	inventory.append({
		"equipped": "hands",
		"item_name": "Leather Gloves",
		"level": 1, 
		"rarity": 1,
		"texture_no": "T1-1",
		"type": "hands",
		"upgrade": 0,
		"value": 100,
		"stats": armor_stats
	})
	
	inventory.append({
		"equipped": "head",
		"item_name": "Leather Cap",
		"level": 1, 
		"rarity": 1,
		"texture_no": "T1-1",
		"type": "head",
		"upgrade": 0,
		"value": 100,
		"stats": armor_stats
	})
	
	for i in inventory.size():
		var data = inventory[i]
		save_game.store_line(JSON.new().stringify(data))
	save_game.close()


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://src/scene/menu/Menu.tscn")


func _on_exit_button_pressed():
	get_tree().quit()
