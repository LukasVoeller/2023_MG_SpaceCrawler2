extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func get_texture(type, rarity, tex_no):
	if type == "weapon":
		var tex_path = "res://assets/items/swords/sword_" + str(rarity) + "_" + str(tex_no) + ".png"
		var tex = load(tex_path)
		return tex
	if type == "shield":
		var tex_path = "res://assets/items/shields/shield_" + str(rarity) + "_" + str(tex_no) + ".png"
		var tex = load(tex_path)
		return tex
	if type == "hands":
		var tex_path = "res://assets/items/armor/hands_" + str(rarity) + "_" + str(tex_no) + ".png"
		var tex = load(tex_path)
		return tex
	if type == "head":
		var tex_path = "res://assets/items/armor/head_" + str(rarity) + "_" + str(tex_no) + ".png"
		var tex = load(tex_path)
		return tex
	if type == "chest":
		var tex_path = "res://assets/items/armor/chest_" + str(rarity) + "_" + str(tex_no) + ".png"
		var tex = load(tex_path)
		return tex
	if type == "feet":
		var tex_path = "res://assets/items/armor/feet_" + str(rarity) + "_" + str(tex_no) + ".png"
		var tex = load(tex_path)
		return tex
