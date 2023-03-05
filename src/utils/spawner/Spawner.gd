extends Node2D

const asteroid = preload("res://src/game/asteroid/Asteroid.tscn")
const marker = preload("res://src/utils/spawner/Marker.tscn")

var device_width
var device_height

var grid_size_x = 10
var grid_size_y = 12
var grid_spacing = 120

var spawner_width = grid_size_x * grid_spacing
var spawner_height = grid_size_y * grid_spacing

var grid_positions = []
var grid_markers = []

signal asteroid_spawned

func _ready():
	randomize()
	print("Instanced Spawner")
	device_width = get_viewport_rect().size.x
	device_height = get_viewport_rect().size.y
	$AsteroidTimer.wait_time = Global.asteroid_timer
	$AsteroidTimer.start()

	create_grid_positions()
	create_grid_markers()
	
	init_grid_positions()
	init_grid_marker()


func create_grid_positions():
	for x in grid_size_x:
		var marker_x = marker.instantiate()
		grid_positions.append([Marker2D.new()])
		
		for y in (grid_size_y-1):
			var marker_y = marker.instantiate()
			grid_positions[x].append(Marker2D.new())


func create_grid_markers():
	for x in grid_size_x:
		var marker_x = marker.instantiate()
		grid_markers.append([marker_x])
		add_child(marker_x)
		
		for y in (grid_size_y-1):
			var marker_y = marker.instantiate()
			grid_markers[x].append(marker_y)
			add_child(marker_y)


func init_grid_positions():
	for x in grid_size_x:
		for y in grid_size_y:
			grid_positions[x][y].position.x = ((x+1)*grid_spacing)
			grid_positions[x][y].position.y = ((y+1)*grid_spacing)


func init_grid_marker():
	for x in grid_size_x:
		for y in grid_size_y:
			grid_markers[x][y].get_node("ColorRect").position.x = grid_positions[x][y].position.x - 60 # - Markersize/2 so the asteroid spawns in the center
			grid_markers[x][y].get_node("ColorRect").position.y = grid_positions[x][y].position.y - 60 # - Markersize/2 so the asteroid spawns in the center
			grid_markers[x][y].get_node("CollisionShape2D").position.x = grid_positions[x][y].position.x
			grid_markers[x][y].get_node("CollisionShape2D").position.y = grid_positions[x][y].position.y


func spawn_asteroid():
	var rand_position_x = randi() % grid_size_x
	var rand_position_y = randi() % grid_size_y
	var velocity = Vector2(randf_range(Global.asteroid_velocity_x_min, Global.asteroid_velocity_x_max), randf_range(Global.asteroid_velocity_y_min, Global.asteroid_velocity_y_max))

	if grid_markers[rand_position_x][rand_position_y].overlapping_asteroids != 0:
		return
	else:
		var pos = grid_positions[rand_position_x][rand_position_y]
		var asteroid_i = asteroid.instantiate()
		asteroid_i.position.x = pos.position.x
		asteroid_i.position.y = pos.position.y
		asteroid_i.self_rotate = randf_range(-0.01, 0.01)
		asteroid_i.linear_velocity = velocity
		add_child(asteroid_i)
		emit_signal("asteroid_spawned", asteroid_i)


func _on_AsteroidTimer_timeout():
	spawn_asteroid()


#func print_grid():
#	var print_string = ""
#	for y in grid_size_y:
#		print_string += "\n"
#		for x in grid_size_x:
#			print_string += str("X:", x, "Y:", y, " Marker ")
#	print(print_string)














#func print_grid_positions():
#	var print_string = ""
#	for y in grid_size_y:
#		print_string += "\n"
#		for x in grid_size_x:
#			print_string += str(grid[x][y].position)
#	print(print_string)
#
#
#func spawn_asteroid():
#	var rand_position = grid[randi() % grid_size_x][randi() % grid_size_y]
#
#	var asteroid_i = asteroid.instantiate()
#	asteroid_i.position.x = rand_position.position.x
#	asteroid_i.position.y = rand_position.position.y
#
#	add_child(asteroid_i)
#
#
#func init_grid_positions():
#	for x in grid_size_x:
#		for y in grid_size_y:
#			grid[x][y].position.x = ((x+1)*grid_spacing)
#			grid[x][y].position.y = ((y+1)*grid_spacing)
#
#
#func create_grid_positions():
#	for x in grid_size_x:
#		grid.append([Marker2D.new()])
#		for y in grid_size_y:
#			grid[x].append(Marker2D.new())
#
#
#func spawn_marker():
#	for x in grid_size_x:
#		for y in grid_size_y:
#			var marker_i = marker.instantiate()
#			marker_i.get_node("ColorRect").position.x = grid[x][y].position.x
#			marker_i.get_node("ColorRect").position.y = grid[x][y].position.y
#
#			marker_i.get_node("CollisionShape2D").position.x = grid[x][y].position.x
#			marker_i.get_node("CollisionShape2D").position.y = grid[x][y].position.y
#			add_child(marker_i)
#
#
#func _on_AsteroidTimer_timeout():
#	spawn_asteroid()
