extends "res://src/game/item/ItemRigid.gd"
#extends RigidBody2D
class_name ItemTrinket

func _ready():
	pass # Replace with function body.

func init(_name, _rar, _lvl, _upgr, _val, _tex_no, _equ, _type, _stats):
	item_name = _name
	rarity = _rar
	level = _lvl
	upgrade = _upgr
	value = _val
	texture_no = _tex_no
	equipped = _equ
	type = _type
	stats = _stats
	
	var tier_rng
	var version_rng
	
	if rarity == 1:
		$Background_1.show()
		
		rng.randomize()
		tier_rng = rng.randi_range(1, 4)
		version_rng = rng.randi_range(1, 6)
		
		texture_no = "T" + str(tier_rng) + "-" + str(version_rng)
		$Texture2D.texture = $TextureLoader.get_texture("trinket", rarity, texture_no)

	if rarity == 2:
		$Background_2.show()
		
		rng.randomize()
		tier_rng = rng.randi_range(1, 4)
		version_rng = rng.randi_range(1, 6)
		
		texture_no = "T" + str(tier_rng) + "-" + str(version_rng)
		$Texture2D.texture = $TextureLoader.get_texture("trinket", rarity, texture_no)

	if rarity == 3:
		$Background_3.show()
		
		rng.randomize()
		tier_rng = rng.randi_range(1, 5)
		if tier_rng == 3:
			version_rng = rng.randi_range(1, 6)
		elif tier_rng == 5:
			version_rng = rng.randi_range(1, 3)
		else:
			version_rng = rng.randi_range(1, 5)
		
		
		texture_no = "T" + str(tier_rng) + "-" + str(version_rng)
		$Texture2D.texture = $TextureLoader.get_texture("trinket", rarity, texture_no)

	if rarity == 4:
		$Background_4.show()
		
		rng.randomize()
		tier_rng = rng.randi_range(1, 5)
		if tier_rng == 5:
			version_rng = rng.randi_range(1, 2)
		else:
			version_rng = rng.randi_range(1, 4)
		
		texture_no = "T" + str(tier_rng) + "-" + str(version_rng)
		$Texture2D.texture = $TextureLoader.get_texture("trinket", rarity, texture_no)

	if rarity == 5:
		$Background_5.show()
		
		rng.randomize()
		tier_rng = rng.randi_range(1, 8)
		if tier_rng == 1:
			version_rng = rng.randi_range(1, 4)
		elif tier_rng == 2:
			version_rng = rng.randi_range(1, 6)
		elif tier_rng == 3 or tier_rng == 4:
			version_rng = rng.randi_range(1, 5)
		elif tier_rng == 5 or tier_rng == 6:
			version_rng = rng.randi_range(1, 3)
		elif tier_rng == 7 or tier_rng == 8:
			version_rng = rng.randi_range(1, 2)
		
		texture_no = "T" + str(tier_rng) + "-" + str(version_rng)
		$Texture2D.texture = $TextureLoader.get_texture("trinket", rarity, texture_no)
