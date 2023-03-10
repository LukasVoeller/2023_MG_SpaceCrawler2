extends Marker2D

@onready var label = get_node("Label")
@onready var tween = get_node("Tween")
var text = 0
var velocity = Vector2(0, 0)
var parent_rotation 
var pos_to

func _ready():
	label.set_text("+" + str(text) + " EXP")
	set_rotation(0)
	
	randomize()
	velocity = Vector2(500, 500)
	
	tween.interpolate_property(self, "position", Vector2(0, 0), Vector2(0, 100), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func _on_Tween_tween_all_completed():
	self.queue_free()

func _process(delta):
	position -= velocity * delta
	#set_rotation(0)
	#parent_rotation = get_parent().rotation
	#set_rotation(-parent_rotation)
