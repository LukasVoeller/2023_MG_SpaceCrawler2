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

var stats = {
	"primary_stat_first": 0,
	"primary_stat_second": 0,
	
	"secondary_stat_first": 0,
	"secondary_stat_second": 0,
	"secondary_stat_third": 0,
	
	"socket_1": 0,
	"socket_2": 0,
}

#const Tooltip = preload("res://src/util/tooltip/Tooltip.tscn")

func _ready():
	pass


func get_copy():
	pass


func init(_name, _rar, _lvl, _upgr, _val, _tex_no, _equ, _type, _stats):
	pass


func collect():
	pass


func _on_TouchScreenButton_double_tap():
	pass
