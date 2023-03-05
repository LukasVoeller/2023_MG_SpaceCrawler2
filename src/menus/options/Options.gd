extends Node2D

var screen_size

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print("Instanced Options")
	screen_size = get_viewport_rect().size
	$Control.size = screen_size


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass





func _on_SettingsButton_pressed():
	pass # Replace with function body.


func _on_ExtrasButton_pressed():
	get_tree().change_scene_to_file("res://src/menus/extras/Extras.tscn")
	

func _on_DeleteSavegameButton_pressed():
	pass
#	var dir = Directory.new()
#	dir.remove("user://savegame.save")
#	dir.remove("user://saveinventory.save")
	

func _on_BackButton_pressed():
	get_tree().change_scene_to_file("res://src/menus/menu/Menu.tscn")


func _on_CreditsButton_pressed():
	get_tree().change_scene_to_file("res://src/menus/credits/Credits.tscn")
