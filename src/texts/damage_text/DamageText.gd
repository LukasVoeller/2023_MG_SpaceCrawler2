extends Marker2D

@onready var label = get_node("Label")
#@onready var tween = get_node("Tween")

var tween = Tween.new()

var text = 0
var velocity = Vector2(0, 0)
var max_size = Vector2(1.5, 1.5)
var parent_rotation 
var offset_diagonal_rand
var speed = 350

var rng = RandomNumberGenerator.new()

func _ready():
	pass
	

func display(crit):
	rng.randomize()
	label.set_text(str(text))
	set_rotation(0)
	
	offset_diagonal_rand = rng.randi_range(1, 5)
	
	if Global.weapon_projectiles == 1:
		velocity = Vector2(0, speed)
	if Global.weapon_projectiles == 2:
		offset_diagonal_rand = rng.randi_range(1, 2)
		
		if offset_diagonal_rand == 1:
			velocity = Vector2(-50, speed+50)
		if offset_diagonal_rand == 2:
			velocity = Vector2(50, speed)
	if Global.weapon_projectiles == 3:
		offset_diagonal_rand = rng.randi_range(1, 3)
		
		if offset_diagonal_rand == 1:
			velocity = Vector2(-100, speed)
		if offset_diagonal_rand == 2:
			velocity = Vector2(0, speed-50)
		if offset_diagonal_rand == 3:
			velocity = Vector2(100, speed)
	if Global.weapon_projectiles == 4:
		offset_diagonal_rand = rng.randi_range(1, 4)
		
		if offset_diagonal_rand == 1:
			velocity = Vector2(-150, speed+50)
		if offset_diagonal_rand == 2:
			velocity = Vector2(-50, speed)
		if offset_diagonal_rand == 3:
			velocity = Vector2(50, speed+50)
		if offset_diagonal_rand == 4:
			velocity = Vector2(150, speed)
	if Global.weapon_projectiles == 5:
		offset_diagonal_rand = rng.randi_range(1, 5)
		
		if offset_diagonal_rand == 1:
			velocity = Vector2(-150, speed-50)
		if offset_diagonal_rand == 2:
			velocity = Vector2(-50, speed)
		if offset_diagonal_rand == 3:
			velocity = Vector2(0, speed+50)
		if offset_diagonal_rand == 4:
			velocity = Vector2(50, speed)
		if offset_diagonal_rand == 5:
			velocity = Vector2(150, speed-50)
	
	if crit:
		$Label.add_theme_color_override("font_color", Color(1,0,0,1))
		#tween.interpolate_property(self, 'scale', Vector2(1, 1), Vector2(3, 3), 0.7, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		tween.tween_property($Label, "modulate", Color.RED, 1)
	else:
		$Label.add_theme_color_override("font_color", Color(1,1,1,1))
		tween.tween_property($Label, "modulate", Color.RED, 1)
		
		#tween.interpolate_property(self, 'scale', Vector2(0.1, 0.1), Vector2(1.5, 1.5), 0.7, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	
	#tween.interpolate_property(self, 'scale', scale, max_size, 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	#tween.interpolate_property(self, 'scale', Vector2(0.1, 0.1), Vector2(1.5, 1.5), 0.7, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	
	#tween.interpolate_property(self, 'scale', scale, max_size, 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	#tween.interpolate_property(self, 'scale', Vector2(1.5, 1.5), Vector2(0.1, 0.1), 0.3, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0.3)
	
	#tween.start()


func _on_Tween_tween_all_completed():
	self.queue_free()

func _process(delta):
	position -= velocity * delta
	#set_rotation(0)
	#parent_rotation = get_parent().rotation
	#set_rotation(-parent_rotation)
