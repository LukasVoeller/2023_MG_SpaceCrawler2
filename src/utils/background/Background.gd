extends Node2D

const star_scene = preload("res://src/utils/star/Star.tscn")

var screen_size


func _ready():
	screen_size = get_viewport_rect().size
	
	$StarPath.curve.clear_points()
	$StarPath.curve.add_point(Vector2(0,0))
	$StarPath.curve.add_point(Vector2(screen_size.x, 0))
	
	$StarTimer.start()


func spawn_star():
	var star = star_scene.instantiate()
	var star_spawn_location = get_node("StarPath/StarSpawnLocation")
	star_spawn_location.progress = randi()
	star.position = star_spawn_location.position
	add_child(star)


func _on_StarTimer_timeout():
	spawn_star()
