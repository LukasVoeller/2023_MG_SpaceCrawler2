extends RigidBody2D
class_name ItemRigid

signal collected

var rng = RandomNumberGenerator.new()

var item_name
var rarity
var level
var upgrade
var value

var texture_no = ""
var equipped = ""
var type = ""

func _ready():
	pass


func init(_name, rar, lvl, upgr, val, tex_no, equ, _type):
	pass


func collect():
	emit_signal("collected")
