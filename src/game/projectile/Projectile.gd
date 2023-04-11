extends Area2D

class_name Projectile

var rng = RandomNumberGenerator.new()

var speed = 1000
var size = 1.5
var x_offset
var damage
var rarity
var p_crit_chance
var p_crit_damage

var crit = false

var has_knockback = true
var knockback = 0

var game_paused = false


func _ready():	
	$Sprite2D.scale = Vector2(size, size)


func set_damage(dmg):
	damage = dmg


func set_x_offset(off):
	x_offset = off


func _physics_process(delta):
	if !game_paused:
		global_position.y += -speed * delta
		global_position.x += x_offset


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


# Projectile and asteroid collision
func _on_Projectile_body_entered(asteroid):
	rng.randomize()
	var pos_p = self.get_global_transform_with_canvas()
	var pos_a = asteroid.get_global_transform_with_canvas()
	var col_radius = asteroid.get_node("CollisionShape2D").shape.radius
	var angle = Vector2(0, -1)
	
	var dmg
	var crit_chance_calc = rng.randi_range(1, 100)
	var crit_damage_calc = 1 + (p_crit_damage / 100)
	
	if crit_chance_calc <= p_crit_chance:
		dmg = int(damage * crit_damage_calc)
		crit = true
	else:
		dmg = damage
	
	Global.damage_dealt_per_second += dmg
	if Global.damage_dealt_per_second > Global.damage_dealt_per_second_max:
		Global.damage_dealt_per_second_max = Global.damage_dealt_per_second
		
	asteroid.take_projectile_damage(dmg)
	asteroid.show_damage(dmg, crit, asteroid.global_position)
	#asteroid.show_particles(pos_p[2], pos_a)

	#print(col_radius)


	var pos_diff_x = pos_a[2].x - pos_p[2].x
	var pos_diff_y = pos_a[2].y - pos_p[2].y


	if (pos_diff_x >= col_radius):
		angle = Vector2(-1, 0)
	elif (pos_diff_x < -col_radius):
		angle = Vector2(1, 0)

	if (pos_diff_y <= 0):
		if (pos_diff_x < col_radius && pos_diff_x >= col_radius/2):
			angle = Vector2(-1, 1)
		elif (pos_diff_x < col_radius/2 && pos_diff_x >= -col_radius/2):
			angle = Vector2(0, 1)
		elif (pos_diff_x < -col_radius/2 && pos_diff_x > -col_radius):
			angle = Vector2(1, 1)

	if (pos_diff_y > 0):
		if (pos_diff_x < col_radius && pos_diff_x >= col_radius/2):
			angle = Vector2(-1, -1)
		elif (pos_diff_x < col_radius/2 && pos_diff_x >= -col_radius/2):
			angle = Vector2(0, -1)
		elif (pos_diff_x < -col_radius/2 && pos_diff_x > -col_radius):
			angle = Vector2(1, -1)
	
			
	asteroid.show_particles(pos_p[2], angle)

#	print("Asteroid: ", pos_a[2])
#	print("Projectile: ", pos_p[2])
#	print("Diff: X: ", pos_diff_x, " Y: ", pos_diff_y)

	
	if has_knockback:
		var direction = PI / 2
		var offset = Vector2(0.0, 0.0)
		var impusle = Vector2(0.0, -(knockback))
		#asteroid.linear_velocity = velocity.rotated(direction * (-1))
		asteroid.apply_impulse(impusle, offset)
	
	queue_free()
