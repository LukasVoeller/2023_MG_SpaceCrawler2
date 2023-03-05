extends Node2D

var screen_size


func _ready():
	print ("Instanced Menu")
	screen_size = get_viewport_rect().size
	$Control.size = screen_size
	
	print(Global.damage_dealt_per_second_average)
	print(Global.damage_dealt_per_second_max)
	print(Global.damage_dealt_per_second)
	print(Global.damage_dealt_total)
	
	
	var device_width = get_viewport_rect().size.x
	var device_height = get_viewport_rect().size.y
	
	#$Menu.set_global_position(Vector2(device_width/2-$Menu.size.x/2, (device_height/2) - 200))
	#$PlayButton.set_global_position(Vector2(device_width/2-$PlayButton.size.x/2, (device_height/2) - 100))
	#$HangarButton.set_global_position(Vector2(device_width/2-$HangarButton.size.x/2, (device_height/2)))
	#$OptionsButton.set_global_position(Vector2(device_width/2-$OptionsButton.size.x/2, (device_height/2) + 100))
	#$ExitButton.set_global_position(Vector2(device_width/2-$ExitButton.size.x/2, (device_height/2) + 200))


func _on_PlayButton_pressed():
	get_tree().change_scene_to_file("res://src/menus/play/Play.tscn")


func _on_HangarButton_pressed():
	get_tree().change_scene_to_file("res://src/menus/hangar/Hangar.tscn")


func _on_ExitButton_pressed():
	get_tree().quit()


func _on_Menu_tree_exited():
	pass
	#print("Menu freed")


func _on_OptionsButton_pressed():
	get_tree().change_scene_to_file("res://src/menus/options/Options.tscn")


func _on_BackButton_pressed():
	get_tree().change_scene_to_file("res://src/main/Main.tscn")
