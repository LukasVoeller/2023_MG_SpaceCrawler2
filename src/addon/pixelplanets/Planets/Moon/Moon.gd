extends "res://Planets/Planet.gd"

func set_pixels(amount):
	$Moon.material.set_shader_parameter("pixels", amount)

func set_light(pos):
	$Moon.material.set_shader_parameter("light_origin", pos)

func set_seed(sd):
	var converted_seed = sd%1000/100.0
	$Moon.material.set_shader_parameter("seed", converted_seed)

func set_rotates(r):
	$Moon.material.set_shader_parameter("rotation", r)

func update_time(t):
	$Moon.material.set_shader_parameter("time", t * get_multiplier($Moon.material) * 0.02)

func set_custom_time(t):
	$Moon.material.set_shader_parameter("time", t * get_multiplier($Moon.material))

func set_dither(d):
	$Moon.material.set_shader_parameter("should_dither", d)

func get_dither():
	return $Moon.material.get_shader_parameter("should_dither")

func get_colors():
	return _get_colors_from_gradient($Moon.material, "colorscheme")
	

func set_colors(colors):
	_set_colors_from_gradient($Moon.material, "colorscheme", colors)

func randomize_colors():
	var seed_colors = _generate_new_colorscheme(8 + randi() % 4, randf_range(0.3,0.55), 1.4)
	var cols = []
	for i in 6:
		var new_col = seed_colors[i].darkened(i/7.0)
		new_col = new_col.lightened((1.0 - (i/6.0)) * 0.3)
		cols.append(new_col)

	set_colors(cols)
