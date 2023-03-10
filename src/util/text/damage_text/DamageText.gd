extends Label

var rng = RandomNumberGenerator.new()
var rand_vertical_offset
var rand_horizontal_offset

func _ready():
	pass


func display(is_crit):
	rng.randomize()
	rand_vertical_offset = rng.randi_range(-100, -300)
	rand_horizontal_offset = rng.randi_range(-100, 100)
	
	if is_crit:
		add_theme_color_override("font_color", Color(1,0.5,0.1,1))
		add_theme_font_size_override("font_size", 80)
		z_index = 11
		
		var tween = get_tree().create_tween()
		tween.parallel().tween_property(self, "position", Vector2(rand_horizontal_offset, -300), 1).as_relative()
		tween.tween_callback(self.queue_free)
	else:
		z_index = 10
		var tween = get_tree().create_tween()
		tween.parallel().tween_property(self, "position", Vector2(rand_horizontal_offset, rand_vertical_offset), 1).as_relative()
		tween.tween_callback(self.queue_free)
		
