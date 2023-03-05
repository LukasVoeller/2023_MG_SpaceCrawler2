extends "res://src/game/item/_rigid/ItemRigid.gd"
#extends RigidBody2D
class_name ItemWeapon

var damage = 1000

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
	
	var tex_rng
	
	if rar == 1:
		$Background_1.show()
		
		rng.randomize()
		tex_rng = rng.randi_range(1, 2)
		if tex_rng == 1:
			texture_no = "1_1"
			$Texture2D.texture = $TextureLoader.get_texture("weapon", texture_no)
		elif tex_rng == 2:
			texture_no = "1_2"
			$Texture2D.texture = $TextureLoader.get_texture("weapon", texture_no)

	if rar == 2:
		$Background_2.show()
		
		rng.randomize()
		tex_rng = rng.randi_range(1, 4)
		if tex_rng == 1:
			texture_no = "2_1"
			$Texture2D.texture = $TextureLoader.get_texture("weapon", texture_no)
		elif tex_rng == 2:
			texture_no = "2_2"
			$Texture2D.texture = $TextureLoader.get_texture("weapon", texture_no)
		elif tex_rng == 3:
			texture_no = "2_3"
			$Texture2D.texture = $TextureLoader.get_texture("weapon", texture_no)
		elif tex_rng == 4:
			texture_no = "2_4"
			$Texture2D.texture = $TextureLoader.get_texture("weapon", texture_no)

	if rar == 3:
		$Background_3.show()
		
		rng.randomize()
		tex_rng = rng.randi_range(1, 6)
		if tex_rng == 1:
			texture_no = "3_1"
			$Texture2D.texture = $TextureLoader.get_texture("weapon", texture_no)
		elif tex_rng == 2:
			texture_no = "3_2"
			$Texture2D.texture = $TextureLoader.get_texture("weapon", texture_no)
		elif tex_rng == 3:
			texture_no = "3_3"
			$Texture2D.texture = $TextureLoader.get_texture("weapon", texture_no)
		elif tex_rng == 4:
			texture_no = "3_4"
			$Texture2D.texture = $TextureLoader.get_texture("weapon", texture_no)
		elif tex_rng == 5:
			texture_no = "3_5"
			$Texture2D.texture = $TextureLoader.get_texture("weapon", texture_no)
		elif tex_rng == 6:
			texture_no = "3_6"
			$Texture2D.texture = $TextureLoader.get_texture("weapon", texture_no)

	if rar == 4:
		$Background_4.show()
		
		rng.randomize()
		tex_rng = rng.randi_range(1, 8)
		if tex_rng == 1:
			texture_no = "4_1"
			$Texture2D.texture = $TextureLoader.get_texture("weapon", texture_no)
		elif tex_rng == 2:
			texture_no = "4_2"
			$Texture2D.texture = $TextureLoader.get_texture("weapon", texture_no)
		elif tex_rng == 3:
			texture_no = "4_3"
			$Texture2D.texture = $TextureLoader.get_texture("weapon", texture_no)
		elif tex_rng == 4:
			texture_no = "4_4"
			$Texture2D.texture = $TextureLoader.get_texture("weapon", texture_no)
		elif tex_rng == 5:
			texture_no = "4_5"
			$Texture2D.texture = $TextureLoader.get_texture("weapon", texture_no)
		elif tex_rng == 6:
			texture_no = "4_6"
			$Texture2D.texture = $TextureLoader.get_texture("weapon", texture_no)
		elif tex_rng == 7:
			texture_no = "4_7"
			$Texture2D.texture = $TextureLoader.get_texture("weapon", texture_no)
		elif tex_rng == 8:
			texture_no = "4_8"
			$Texture2D.texture = $TextureLoader.get_texture("weapon", texture_no)

	if rar == 5:
		$Background_5.show()
		
		rng.randomize()
		tex_rng = rng.randi_range(1, 10)
		if tex_rng == 1:
			texture_no = "5_1"
			$Texture2D.texture = $TextureLoader.get_texture("weapon", texture_no)
		elif tex_rng == 2:
			texture_no = "5_2"
			$Texture2D.texture = $TextureLoader.get_texture("weapon", texture_no)
		elif tex_rng == 3:
			texture_no = "5_3"
			$Texture2D.texture = $TextureLoader.get_texture("weapon", texture_no)
		elif tex_rng == 4:
			texture_no = "5_4"
			$Texture2D.texture = $TextureLoader.get_texture("weapon", texture_no)
		elif tex_rng == 5:
			texture_no = "5_5"
			$Texture2D.texture = $TextureLoader.get_texture("weapon", texture_no)
		elif tex_rng == 6:
			texture_no = "5_6"
			$Texture2D.texture = $TextureLoader.get_texture("weapon", texture_no)
		elif tex_rng == 7:
			texture_no = "5_7"
			$Texture2D.texture = $TextureLoader.get_texture("weapon", texture_no)
		elif tex_rng == 8:
			texture_no = "5_8"
			$Texture2D.texture = $TextureLoader.get_texture("weapon", texture_no)
		elif tex_rng == 9:
			texture_no = "5_9"
			$Texture2D.texture = $TextureLoader.get_texture("weapon", texture_no)
		elif tex_rng == 10:
			texture_no = "5_10"
			$Texture2D.texture = $TextureLoader.get_texture("weapon", texture_no)
