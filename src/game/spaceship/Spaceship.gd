extends Area2D

class_name Spaceship

signal hit
signal dead
signal hp_changed

var device_width
var device_height

var level = 1
var exp_max = 19
var exp_current = 0
var hp_max = Global.spaceship_hp_max
var hp_current = hp_max
var upgraded = false
var auto_shoot = false

var is_dragging = false
var movement_enabled = true

var weapon

var input_is_pressed = false
var input_is_pressed_and_dragging = false
var game_paused = false
var level_cleard = false


func _ready():
	print ("Instanced Spaceship")
	
	device_width = get_viewport_rect().size.x
	device_height = get_viewport_rect().size.y
	
	weapon = preload("res://src/game/weapon/Weapon.tscn").instantiate()
	$WeaponTimer.wait_time = weapon.attack_speed
	if auto_shoot:
		$WeaponTimer.start()
	add_child(weapon)
	
	device_width = get_viewport_rect().size.x
	device_height = get_viewport_rect().size.y
	
	if upgraded:
		$SpaceshipSprite.animation = "spaceship_upgr_center"
	else:
		$SpaceshipSprite.animation = "spaceship_center"
	
	$SpaceshipSprite.play()
	$ExplosionAnimation.animation = "explosion2"
	$ExplosionAnimation.hide()


func start(pos):
	position = pos
	$SpaceshipSprite.show()
	$SpaceshipCollision.disabled = Global.spaceship_collision_disabled
	
	$SpaceshipSprite.global_position = pos
	$SpaceshipCollision.global_position = pos
	$ExplosionAnimation.global_position = pos
	$WeaponPos.global_position = pos	
	show()


# Weapon Timer min 0.1 wait time
func shoot():
	weapon.shoot($WeaponPos)


func take_damage(body):
	if (hp_current - body.damage) > 0:
		hp_current -= body.damage
		emit_signal("hp_changed")
	else:
		hp_current = 0
		emit_signal("hp_changed")
		emit_signal("dead")
		play_spaceship_explosion_animation()


func play_spaceship_explosion_animation():
	$SpaceshipSprite.hide()
	$ExplosionAnimation.show()
	$ExplosionAnimation.play()
	
	
func level_up():
	print("Level up!")
	level += 1
	exp_max = next_level(level + 1)
	exp_current = 0
	hp_current = Global.spaceship_hp_max


func next_level(level):
	return round( (( 285 * level ) * pow(level, 2) - ( 285 * level ) * level) / 60 )


# TODO: Optimize
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			input_is_pressed = true
			if !game_paused && !auto_shoot:
				#shoot()
				$WeaponTimer.start()
		else:
			input_is_pressed = false
			if !auto_shoot:
				$WeaponTimer.stop()
			if upgraded:
				$SpaceshipSprite.animation = "spaceship_upgr_center"
			else:
				$SpaceshipSprite.animation = "spaceship_center"
			
	if event is InputEventMouseMotion:
		if input_is_pressed:
			input_is_pressed_and_dragging = true
		else:
			input_is_pressed_and_dragging = false

	if movement_enabled:
		if input_is_pressed_and_dragging && event is InputEventMouseMotion:
			if event.relative.x < 0:
				if upgraded:
					$SpaceshipSprite.animation = "spaceship_upgr_left"
				else:
					$SpaceshipSprite.animation = "spaceship_left"
			elif event.relative.x > 0:
				if upgraded:
					$SpaceshipSprite.animation = "spaceship_upgr_right"
				else:
					$SpaceshipSprite.animation = "spaceship_right"
			
			$SpaceshipSprite.global_position += event.relative
			$SpaceshipCollision.global_position += event.relative
			$WeaponPos.position += event.relative
			
			if hp_current > 0:
				$ExplosionAnimation.global_position = $SpaceshipSprite.global_position
			
			# Boundary Control
			if $SpaceshipSprite.global_position.x <= 0:
				$SpaceshipSprite.global_position.x = 1
				$SpaceshipCollision.global_position.x = 1
				$WeaponPos.global_position.x = 1
			if $SpaceshipSprite.global_position.x >= device_width:
				$SpaceshipSprite.global_position.x = device_width - 1
				$SpaceshipCollision.global_position.x = device_width - 1
				$WeaponPos.global_position.x = device_width - 1
			if $SpaceshipSprite.global_position.y <= 0:
				$SpaceshipSprite.global_position.y = 1
				$SpaceshipCollision.global_position.y = 1
				$WeaponPos.global_position.y = 1
			if $SpaceshipSprite.global_position.y >= device_height:
				$SpaceshipSprite.global_position.y = device_height -1
				$SpaceshipCollision.global_position.y = device_height -1
				$WeaponPos.global_position.y = device_height -1


# Collision
func _on_Player_body_entered(body):
	if body is Asteroid and not level_cleard:
		print("Spaceship HP: ", hp_current, "Asteroid DMG: ", body.damage)
		if (hp_current - body.damage) > 0:
			self.take_damage(body)
			body.take_spaceship_damage(body.hp)
			emit_signal("hit")
		else:	# Fatal hit
			$SpaceshipCollision.set_deferred("disabled", true)
			self.take_damage(body)
			body.take_spaceship_damage(body.hp)
			emit_signal("hit")
	
	elif body is Powerup:
		if body.type == "hp_lesser":
			var hp_to_add = hp_max * 0.25
			
			if (hp_current + hp_to_add) < hp_max:
				hp_current += hp_to_add
				emit_signal("hp_changed")
			elif (hp_current + hp_to_add) >= hp_max:
				hp_current = hp_max
				emit_signal("hp_changed")
				
			body.use()
		if body.type == "projectile_lesser":
			if $Weapon.projectiles < 5:
				$Weapon.projectiles += 1
				body.use()
			else:
				body.use()
		if body.type == "atkspeed_lesser":
			if $WeaponBoostTimer.is_stopped():				
				$WeaponTimer.wait_time = $WeaponTimer.wait_time * 0.75
				$WeaponBoostTimer.start()
				body.use()
			else:
				body.use()
		if body.type == "atkspeed_greater":
			if $WeaponBoostTimer.is_stopped():				
				$WeaponTimer.wait_time = $WeaponTimer.wait_time * 0.5
				$WeaponBoostTimer.start()
				body.use()
			else:
				body.use()
		if body.type == "atkdmg_lesser":
			$Weapon.damage_base += $Weapon.damage_base * 0.10
			body.use()
		if body.type == "critdmg_lesser":
			pass
			
	elif body is ItemWeapon or body is ItemShield or body is ItemHands or body is ItemHead or body is ItemChest or body is ItemFeet:
		print("Item collision")
		body.collect()
			

func _on_ExplosionAnimation_animation_finished():
	self.queue_free()
	
	
func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"level" : level,
		"exp_max" : exp_max,
		"exp_current" : exp_current,
		"hp_max" : hp_max,
		"upgraded" : upgraded
	}
	return save_dict


func _on_Spaceship_tree_exited():
	print("Spaceship freed")


func _on_WeaponTimer_timeout():
	if not game_paused:
		shoot()


func _on_weapon_boost_timer_timeout():
	$WeaponTimer.wait_time = weapon.attack_speed
	
	
# Booster
#Global.star_size_min = 0.5
#Global.star_size_max = 3
#Global.star_speed_min = 4000
#Global.star_speed_max = 6000
#Global.asteroid_velocity_y_min = 
#Global.asteroid_velocity_y_max = 500
