extends Node2D

var screen_size


func _ready():
	print ("Instanced Main")
	screen_size = get_viewport_rect().size
	$Control.size = screen_size
	
	var save_game = FileAccess.open("user://saveinventory.save", FileAccess.READ)
	if not save_game:
		init_starting_items()
	#$Lemware.set_global_position(Vector2(25, (device_height - 50)))
	#$SpaceCrawler2.set_global_position(Vector2(device_width/2-$SpaceCrawler2.size.x/2, (device_height/2 - 250)))
	#$PlayButton.set_global_position(Vector2(device_width/2-$PlayButton.size.x/2, (device_height/2)))
	#$ExitButton.set_global_position(Vector2(device_width/2-$PlayButton.size.x/2, (device_height/2) + 100))


func _on_PlayButton_pressed():
	get_tree().change_scene_to_file("res://src/menus/menu/Menu.tscn")


func _on_ExitButton_pressed():
	get_tree().quit()


# For Coldstart handle
func init_starting_items():
	var inventory = []
	var save_game = FileAccess.open("user://saveinventory.save", FileAccess.WRITE)
	
	inventory.append({
		"equipped":"weapon",
		"item_name":"No name",
		"level":1,"rarity":1,
		"texture_no":"1_1",
		"type":"weapon",
		"upgrade":0,
		"value":100
	})
	
	for i in inventory.size():
		var data = inventory[i]
		save_game.store_line(JSON.new().stringify(data))
	save_game.close()
