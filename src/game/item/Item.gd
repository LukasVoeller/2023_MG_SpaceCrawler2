extends Node2D

class_name Item

var item_name
var rarity
var level
var upgrade = 0
var value

var texture_no
var equipped = ""
var type = ""

const Tooltip = preload("res://src/util/tooltip/Tooltip.tscn")

func _ready():
	pass


func get_copy():
	pass


func init(_name, rar, lvl, upgr, val, tex_no, equ, _type):
	pass


func collect():
	pass


func _on_TouchScreenButton_double_tap():
	pass
