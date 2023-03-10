extends Node2D

var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	$Control.size = screen_size
	
	var save_game = FileAccess.open("user://saveinventory.save", FileAccess.READ)
	if not save_game:
		init_starting_items()

# For Coldstart handle
func init_starting_items():
	var inventory = []
	var save_game = FileAccess.open("user://saveinventory.save", FileAccess.WRITE)
	
	inventory.append({
		"equipped":"weapon",
		"item_name":"No name",
		"level":1,"rarity":1,
		"texture_no":"1",
		"type":"weapon",
		"upgrade":0,
		"value":100
	})
	
	for i in inventory.size():
		var data = inventory[i]
		save_game.store_line(JSON.new().stringify(data))
	save_game.close()


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://src/scene/menu/Menu.tscn")


func _on_exit_button_pressed():
	get_tree().quit()
