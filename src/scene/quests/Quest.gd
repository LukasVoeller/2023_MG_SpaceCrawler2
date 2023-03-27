extends Control

signal selected

var title
var info_text = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum."
var completed = false

var objective_val
var objective_goal

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(_title, _objective_val, objective_goal, _progress):
	title = _title
	objective_val = _objective_val
	objective_goal = _objective_val
	$TextureProgressBar.value = _progress
	$Label.text = _title


func _on_texture_button_pressed():
	emit_signal("selected")
