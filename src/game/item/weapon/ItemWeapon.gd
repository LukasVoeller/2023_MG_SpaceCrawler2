extends "res://src/game/item/ItemRigid.gd"
#extends RigidBody2D
class_name ItemWeapon

var damage

func _ready():
	pass # Replace with function body.

func init(_name, _rar, _lvl, _upgr, _val, _tex_no, _equ, _type, _stats):
	item_name = _name
	rarity = _rar
	level = _lvl
	upgrade = _upgr
	value = _val
	#texture_no = _tex_no
	equipped = _equ
	type = _type
	stats = _stats
	
	if rarity == 1:
		$Background_1.show()
		
		rng.randomize()
		texture_no = rng.randi_range(1, 82)
		$Texture2D.texture = $TextureLoader.get_texture("weapon", rarity, texture_no)

	if rarity == 2:
		$Background_2.show()
		
		rng.randomize()
		texture_no = rng.randi_range(1, 35)
		$Texture2D.texture = $TextureLoader.get_texture("weapon", rarity, texture_no)

	if rarity == 3:
		$Background_3.show()
		
		rng.randomize()
		texture_no = rng.randi_range(1, 44)
		$Texture2D.texture = $TextureLoader.get_texture("weapon", rarity, texture_no)

	if rarity == 4:
		$Background_4.show()
		
		rng.randomize()
		texture_no = rng.randi_range(1, 31)
		$Texture2D.texture = $TextureLoader.get_texture("weapon", rarity, texture_no)

	if rarity == 5:
		$Background_5.show()
		
		rng.randomize()
		texture_no = rng.randi_range(1, 50)
		$Texture2D.texture = $TextureLoader.get_texture("weapon", rarity, texture_no)
