extends "res://src/game/item/ItemRigid.gd"
#extends RigidBody2D
class_name ItemHead

var armor = 100

func _ready():
	pass # Replace with function body.

func init(_name, rar, lvl, upgr, val, tex_no, equ, _type):
	item_name = _name
	rarity = rar
	level = rar
	upgrade = upgr
	value = val

	texture_no = tex_no
	equipped = equ
	type = _type
	
	var tier_rng
	
	if rar == 1:
		$Background_1.show()
		
		rng.randomize()
		tier_rng = rng.randi_range(1, 4)
		
		texture_no = "T" + str(tier_rng)
		$Texture2D.texture = $TextureLoader.get_texture("head", rarity, texture_no)

	if rar == 2:
		$Background_2.show()
		
		rng.randomize()
		tier_rng = rng.randi_range(1, 4)
		
		texture_no = "T" + str(tier_rng)
		$Texture2D.texture = $TextureLoader.get_texture("head", rarity, texture_no)

	if rar == 3:
		$Background_3.show()
		
		rng.randomize()
		tier_rng = rng.randi_range(1, 5)
		
		texture_no = "T" + str(tier_rng)
		$Texture2D.texture = $TextureLoader.get_texture("head", rarity, texture_no)

	if rar == 4:
		$Background_4.show()
		
		rng.randomize()
		tier_rng = rng.randi_range(1, 5)
		
		texture_no = "T" + str(tier_rng)
		$Texture2D.texture = $TextureLoader.get_texture("head", rarity, texture_no)

	if rar == 5:
		$Background_5.show()
		
		rng.randomize()
		tier_rng = rng.randi_range(1, 8)
		
		texture_no = "T" + str(tier_rng)
		$Texture2D.texture = $TextureLoader.get_texture("head", rarity, texture_no)
