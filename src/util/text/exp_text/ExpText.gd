extends Label

var rng = RandomNumberGenerator.new()
var rand_vertical_offset
var rand_horizontal_offset

func _ready():
	pass


func display():
	z_index = 10
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(self, "position", Vector2(600, 1600), 1)
	tween.tween_callback(self.queue_free)
