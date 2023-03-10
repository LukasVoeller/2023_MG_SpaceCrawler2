extends Node2D

const asteroid = preload("res://src/game/asteroid/Asteroid.tscn")

var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	$Control.size = screen_size
	
	$Spaceship/SpaceshipCollision.disabled = true
	
	
	spawn_asteroids()
	

func spawn_asteroids():
	var pos_1 = Vector2(100, 600)
	var asteroid_1 = asteroid.instantiate()
	asteroid_1.position.x = pos_1.x
	asteroid_1.position.y = pos_1.y
	asteroid_1.self_rotate = randf_range(-0.01, 0.01)
	asteroid_1.freeze_mode = RigidBody2D.FREEZE_MODE_STATIC
	asteroid_1.invincible = true
	asteroid_1.level = 1
	add_child(asteroid_1)

	var pos_2 = Vector2(screen_size.x/2, 600)
	var asteroid_2 = asteroid.instantiate()
	asteroid_2.position.x = pos_2.x
	asteroid_2.position.y = pos_2.y
	asteroid_2.self_rotate = randf_range(-0.01, 0.01)
	asteroid_2.freeze_mode = RigidBody2D.FREEZE_MODE_STATIC
	asteroid_2.invincible = true
	asteroid_2.level = 1
	add_child(asteroid_2)
	
	var pos_3 = Vector2(screen_size.x-100, 600)
	var asteroid_3 = asteroid.instantiate()
	asteroid_3.position.x = pos_3.x
	asteroid_3.position.y = pos_3.y
	asteroid_3.self_rotate = randf_range(-0.01, 0.01)
	asteroid_3.freeze_mode = RigidBody2D.FREEZE_MODE_STATIC
	asteroid_3.invincible = true
	asteroid_3.level = 1
	add_child(asteroid_3)


func _on_BackButton_pressed():
	get_tree().change_scene_to_file("res://src/scenes/play/Play.tscn")


func _on_PlusATKSPDButton_pressed():
	$Spaceship/WeaponTimer.wait_time *= 0.8


func _on_MinusATKSPDButton_pressed():
	$Spaceship/WeaponTimer.wait_time *= 1.2


func _on_PlusProjectileButton_pressed():
	$Spaceship/Weapon.projectiles += 1
	Global.weapon_projectiles += 1


func _on_MinusProjectileButton_pressed():
	$Spaceship/Weapon.projectiles -= 1
	Global.weapon_projectiles -= 1
