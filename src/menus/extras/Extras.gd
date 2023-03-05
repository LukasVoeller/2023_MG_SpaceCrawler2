extends Node2D

var screen_size


# Called when the node enters the scene tree for the first time.
func _ready():
	print("Instanced Extras")
	screen_size = get_viewport_rect().size
	$Control.size = screen_size
	
	$Ship1.play()
	$Ship2.play()
	$Ship3.play()
	$Ship4.play()
	$Ship5.play()
	$Ship6.play()
	$Ship7.play()
	$Ship8.play()
	
	$Ship1.scale *= 1.5
	$Ship2.scale *= 1.5
	$Ship3.scale *= 1.5
	$Ship4.scale *= 1.5
	$Ship5.scale *= 1.5
	$Ship6.scale *= 1.5
	$Ship7.scale *= 1.5
	$Ship8.scale *= 1.5



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BackButton_pressed():
	get_tree().change_scene_to_file("res://src/menus/options/Options.tscn")
