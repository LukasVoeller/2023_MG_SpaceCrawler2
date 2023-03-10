#extends RigidBody2D
#extends Area2D
extends ColorRect
# TODO: Is RigidBody2D necessary?

var rng = RandomNumberGenerator.new()

var speed
var scale_factor


func _ready():
	rng.randomize()
	# TODO: optimze float rng
	scale_factor = randf_range(0.5, 1.5)
	speed = rng.randi_range(500, 1500)
	
	scale *= scale_factor
	$VisibleOnScreenNotifier2D.scale *= scale_factor


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _process(delta):
	position.y += speed * delta
