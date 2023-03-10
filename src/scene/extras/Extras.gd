extends Node2D

var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	$Control.size = screen_size
	
	$Control/Ship1.play()
	$Control/Ship2.play()
	$Control/Ship3.play()
	$Control/Ship4.play()
	$Control/Ship5.play()
	$Control/Ship6.play()
	$Control/Ship7.play()
	$Control/Ship8.play()


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://src/scene/options/Options.tscn")
