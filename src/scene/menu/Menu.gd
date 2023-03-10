extends Node2D

var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	$Control.size = screen_size
	
	print(Global.damage_dealt_per_second_average)
	print(Global.damage_dealt_per_second_max)
	print(Global.damage_dealt_per_second)
	print(Global.damage_dealt_total)
	
	var device_width = get_viewport_rect().size.x
	var device_height = get_viewport_rect().size.y


func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://src/scene/play/Play.tscn")


func _on_hangar_button_pressed():
	get_tree().change_scene_to_file("res://src/scene/hangar/Hangar.tscn")


func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://src/scene/options/Options.tscn")


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://src/scene/main/Main.tscn")


func _on_exit_button_pressed():
	get_tree().quit()
