extends RigidBody2D

class_name Powerup

var rng = RandomNumberGenerator.new()

var type
var type_relative

func _ready():
	rng.randomize()
	type_relative = rng.randi_range(1, 100)
	#type_relative = 11
	
	if type_relative <= 10:
		type = 1
		$AnimatedSprite2D.animation = "powerup_special"
		$AnimatedSprite2D.play()
	elif type_relative > 10 && type_relative <= 30:
		type = 2
		$AnimatedSprite2D.animation = "powerup_speed"
		$AnimatedSprite2D.play()
	elif type_relative > 30 && type_relative <= 50:
		type = 3
		$AnimatedSprite2D.animation = "powerup_power"
		$AnimatedSprite2D.play()
	elif type_relative > 50 && type_relative <= 100:
		type = 4
		$AnimatedSprite2D.animation = "powerup_health"
		$AnimatedSprite2D.play()
	
	#print("Instanced Pickup from Type: ", type)


func use():
	self.queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	self.queue_free()
