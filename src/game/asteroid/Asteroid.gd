extends RigidBody2D

class_name Asteroid

signal dead_by_shot
signal dead_by_playercollision

const damage_text = preload("res://src/util/text/damage_text/DamageText.tscn")
const exp_text = preload("res://src/util/text/exp_text/ExpText.tscn")
const hit_particles = preload("res://src/util/particle/AsteroidHitParticles.tscn")

var asteroid_tex_1 = preload("res://assets/asteroids/asteroid_01.png")
var asteroid_tex_2 = preload("res://assets/asteroids/asteroid_02.png")
var asteroid_tex_3 = preload("res://assets/asteroids/asteroid_03.png")

var rng = RandomNumberGenerator.new()

var level_base = Global.asteroid_level
var level = set_level()

var hp_base = level * 20
var hp_relative = 0.25
var hp_max
var hp

var damage_base = level * 10
var damage_relative = 0.15
var damage

var exp_give_base = level * 10
var exp_give_relative = 0.15
var exp_give

var credits_base = level * 1
var credits_relative = 0.15
var credits

var self_rotate = 0
var overlaps_marker = false
var invincible = false
var spawned_powerup = false
var spawned_item = false
var alive = true


func _ready():
	rng.randomize()
	
	var asteroid_tex_rng = rng.randi_range(1, 3)
	if asteroid_tex_rng == 1:
		$Sprite2D.set_texture(asteroid_tex_1)
	elif asteroid_tex_rng == 2:
		$Sprite2D.set_texture(asteroid_tex_2)
	elif asteroid_tex_rng == 3:
		$Sprite2D.set_texture(asteroid_tex_3)
		
		
	var asteroid_size_rng = rng.randi_range(1, 3)
	if asteroid_size_rng == 1:
		$Sprite2D.scale = $Sprite2D.scale * 1
		$CollisionShape2D.scale = $CollisionShape2D.scale * 1
		
		$ExplosionAnimation.scale = $ExplosionAnimation.scale * 1
		$VisibleOnScreenNotifier2D.scale = $VisibleOnScreenNotifier2D.scale * 1
		
		$VisibleOnScreenNotifier2D.position.x = -64
		$VisibleOnScreenNotifier2D.position.y = -64
	elif asteroid_size_rng == 2:
		$Control.position.y += 16
		$Control.position.x += 16
		$Control/ProgressBar.size.x = 64
		
		$Sprite2D.scale = $Sprite2D.scale * 0.75
		$CollisionShape2D.scale = $CollisionShape2D.scale * 0.75
		
		$ExplosionAnimation.scale = $ExplosionAnimation.scale * 0.75
		$VisibleOnScreenNotifier2D.scale = $VisibleOnScreenNotifier2D.scale * 0.75
		
		$VisibleOnScreenNotifier2D.position.x = -48
		$VisibleOnScreenNotifier2D.position.y = -48
	elif asteroid_size_rng == 3:	
		$Control.position.y += 32
		$Control.position.x += 32
		$Control/ProgressBar.size.x = 32
		
		$Sprite2D.scale = $Sprite2D.scale * 0.5
		$CollisionShape2D.scale = $CollisionShape2D.scale * 0.5
		
		$ExplosionAnimation.scale = $ExplosionAnimation.scale * 0.5
		$VisibleOnScreenNotifier2D.scale = $VisibleOnScreenNotifier2D.scale * 0.5
		
		$VisibleOnScreenNotifier2D.position.x = -32
		$VisibleOnScreenNotifier2D.position.y = -32
	
	hp = calc_relative(hp_base, hp_relative)
	hp_max = hp
	damage = calc_relative(damage_base, damage_relative)
	exp_give = calc_relative(exp_give_base, exp_give_relative)
	credits = calc_relative(credits_base, credits_relative)
	
	$ExplosionAnimation.animation = "explosion_2"
	$ExplosionAnimation.hide()
	
	$Control/ProgressBar.max_value = hp
	$Control/ProgressBar.value = hp


func calc_relative(base, relative):
	var minimun = base - base*relative
	var maximum = base + base*relative
	return rng.randi_range(minimun, maximum)

# TODO: Parameter
func set_level():
	rng.randomize()
	if level_base == 1:
		return rng.randi_range(level_base, level_base+1)
	else:
		return rng.randi_range(level_base-1, level_base+1)


func _process(delta):
	if hp > 0:
		$Sprite2D.rotation += self_rotate
		$VisibleOnScreenNotifier2D.rotation += self_rotate
		$ExplosionAnimation.rotation += self_rotate


func take_projectile_damage(dmg):	
	if !invincible:
		$HitEffect.play("flash_white")
		
		hp -= dmg
		
		if hp > 0:
			$Control/ProgressBar.value = hp
		elif hp <= 0:
			#$CollisionShape2D.disabled = true
			$CollisionShape2D.set_deferred("disabled", true)
			$CollisionShape2D.hide()
			$Control/ProgressBar.value = 0
			if alive:
				alive = false
				emit_signal("dead_by_shot")
				explode()
		


func take_spaceship_damage(body):
	if !invincible:
		$HitEffect.play("flash_white")
		print("Asteroid DMG: ", damage)
		
		hp -= body
		
		if hp > 0:
			$ProgressBar.value = hp
		elif hp <= 0:
			$CollisionShape2D.disabled = true
			$CollisionShape2D.hide()
			emit_signal("dead_by_playercollision")
			print("Dead by player")
			$Control/ProgressBar.value = 0
			explode()


func show_damage(dmg_amount, is_crit, _pos):
	var dmg_text = damage_text.instantiate()
	dmg_text.text = str(dmg_amount)
	add_child(dmg_text)
	dmg_text.display(is_crit)


func show_particles(pos, angle):
	var pos_asteroid = self.get_global_transform_with_canvas()
	var pos_diff_x = pos_asteroid[2].x - pos.x
	var pos_diff_y = pos_asteroid[2].y - pos.y
	
	var hit_particles_i = hit_particles.instantiate()
	hit_particles_i.emitting = true
	hit_particles_i.one_shot = true
	hit_particles_i.position.x -= pos_diff_x
	hit_particles_i.position.y -= pos_diff_y
	hit_particles_i.process_material.direction.x = angle.x
	hit_particles_i.process_material.direction.y = angle.y
	
	add_child(hit_particles_i)
	

#func show_exp(exp_amount):
#	var ep_text = exp_text.instantiate()
#	ep_text.text = exp_amount
#	add_child(ep_text)


func explode():
	#$CollisionPolygon2D.queue_free()
	$Control/Level.hide()
	$Control/ProgressBar.hide()
	$Sprite2D.hide()
	$ExplosionAnimation.show()
	$ExplosionAnimation.play()


func _on_VisibilityNotifier2D_screen_exited():
	self.queue_free()


func _on_ExplosionAnimation_animation_finished():
	self.queue_free()
