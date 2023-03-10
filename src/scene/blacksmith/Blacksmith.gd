extends Node2D

var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	$Control.size = screen_size
