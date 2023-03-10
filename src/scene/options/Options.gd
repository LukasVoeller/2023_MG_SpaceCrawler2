extends Node2D

var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	$Control.size = screen_size


func _on_settings_button_pressed():
	pass # Replace with function body.


func _on_extras_button_pressed():
	get_tree().change_scene_to_file("res://src/scenes/extras/Extras.tscn")


func _on_credits_button_pressed():
	get_tree().change_scene_to_file("res://src/scenes/credits/Credits.tscn")


func _on_delete_savegame_button_pressed():
	pass
#	var dir = Directory.new()
#	dir.remove("user://savegame.save")
#	dir.remove("user://saveinventory.save")


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://src/scenes/menu/Menu.tscn")
