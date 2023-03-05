extends "res://src/game/item/_rigid/ItemRigid.gd"
#extends RigidBody2D
class_name ItemChest

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
	
	var tex_rng
	
	if rar == 1:
		$Background_1.show()
		
		rng.randomize()
		tex_rng = rng.randi_range(1, 5)
		
		if tex_rng == 1:
			texture_no = "1_T1"
			$Texture2D.texture = $TextureLoader.get_texture("chest", texture_no)
		elif tex_rng == 2:
			texture_no = "1_T10"
			$Texture2D.texture = $TextureLoader.get_texture("chest", texture_no)
		elif tex_rng == 3:
			texture_no = "1_T20"
			$Texture2D.texture = $TextureLoader.get_texture("chest", texture_no)
		elif tex_rng == 4:
			texture_no = "1_T30"
			$Texture2D.texture = $TextureLoader.get_texture("chest", texture_no)
		elif tex_rng == 5:
			texture_no = "1_T40"
			$Texture2D.texture = $TextureLoader.get_texture("chest", texture_no)

	if rar == 2:
		$Background_2.show()
		
		rng.randomize()
		tex_rng = rng.randi_range(1, 7)
		
		if tex_rng == 1:
			texture_no = "2_T1"
			$Texture2D.texture = $TextureLoader.get_texture("chest", texture_no)
		elif tex_rng == 2:
			texture_no = "2_T2"
			$Texture2D.texture = $TextureLoader.get_texture("chest", texture_no)
		elif tex_rng == 3:
			texture_no = "2_T3"
			$Texture2D.texture = $TextureLoader.get_texture("chest", texture_no)
		elif tex_rng == 4:
			texture_no = "2_T10"
			$Texture2D.texture = $TextureLoader.get_texture("chest", texture_no)
		elif tex_rng == 5:
			texture_no = "2_T20"
			$Texture2D.texture = $TextureLoader.get_texture("chest", texture_no)
		elif tex_rng == 6:
			texture_no = "2_T30"
			$Texture2D.texture = $TextureLoader.get_texture("chest", texture_no)
		elif tex_rng == 7:
			texture_no = "2_T40"
			$Texture2D.texture = $TextureLoader.get_texture("chest", texture_no)

	if rar == 3:
		$Background_3.show()
		
		rng.randomize()
		tex_rng = rng.randi_range(1, 6)
		
		if tex_rng == 1:
			texture_no = "3_T1"
			$Texture2D.texture = $TextureLoader.get_texture("chest", texture_no)
		elif tex_rng == 2:
			texture_no = "3_T10"
			$Texture2D.texture = $TextureLoader.get_texture("chest", texture_no)
		elif tex_rng == 3:
			texture_no = "3_T20"
			$Texture2D.texture = $TextureLoader.get_texture("chest", texture_no)
		elif tex_rng == 4:
			texture_no = "3_T30"
			$Texture2D.texture = $TextureLoader.get_texture("chest", texture_no)
		elif tex_rng == 5:
			texture_no = "3_T40"
			$Texture2D.texture = $TextureLoader.get_texture("chest", texture_no)
		elif tex_rng == 6:
			texture_no = "3_T50"
			$Texture2D.texture = $TextureLoader.get_texture("chest", texture_no)

	if rar == 4:
		$Background_4.show()
		
		rng.randomize()
		tex_rng = rng.randi_range(1, 10)
		
		if tex_rng == 1:
			texture_no = "4_T1"
			$Texture2D.texture = $TextureLoader.get_texture("chest", texture_no)
		elif tex_rng == 2:
			texture_no = "4_T2"
			$Texture2D.texture = $TextureLoader.get_texture("chest", texture_no)
		elif tex_rng == 3:
			texture_no = "4_T3"
			$Texture2D.texture = $TextureLoader.get_texture("chest", texture_no)
		elif tex_rng == 4:
			texture_no = "4_T4"
			$Texture2D.texture = $TextureLoader.get_texture("chest", texture_no)
		elif tex_rng == 5:
			texture_no = "4_T5"
			$Texture2D.texture = $TextureLoader.get_texture("chest", texture_no)
		elif tex_rng == 6:
			texture_no = "4_T10"
			$Texture2D.texture = $TextureLoader.get_texture("chest", texture_no)
		elif tex_rng == 7:
			texture_no = "4_T20"
			$Texture2D.texture = $TextureLoader.get_texture("chest", texture_no)
		elif tex_rng == 8:
			texture_no = "4_T30"
			$Texture2D.texture = $TextureLoader.get_texture("chest", texture_no)
		elif tex_rng == 9:
			texture_no = "4_T40"
			$Texture2D.texture = $TextureLoader.get_texture("chest", texture_no)
		elif tex_rng == 10:
			texture_no = "4_T50"
			$Texture2D.texture = $TextureLoader.get_texture("chest", texture_no)

	if rar == 5:
		$Background_5.show()
		
		rng.randomize()
		tex_rng = rng.randi_range(1, 12)
		
		if tex_rng == 1:
			texture_no = "5_T1"
			$Texture2D.texture = $TextureLoader.get_texture("chest", texture_no)
		elif tex_rng == 2:
			texture_no = "5_T2"
			$Texture2D.texture = $TextureLoader.get_texture("chest", texture_no)
		elif tex_rng == 3:
			texture_no = "5_T3"
			$Texture2D.texture = $TextureLoader.get_texture("chest", texture_no)
		elif tex_rng == 4:
			texture_no = "5_T4"
			$Texture2D.texture = $TextureLoader.get_texture("chest", texture_no)
		elif tex_rng == 5:
			texture_no = "5_T10"
			$Texture2D.texture = $TextureLoader.get_texture("chest", texture_no)
		elif tex_rng == 6:
			texture_no = "5_T20"
			$Texture2D.texture = $TextureLoader.get_texture("chest", texture_no)
		elif tex_rng == 7:
			texture_no = "5_T30"
			$Texture2D.texture = $TextureLoader.get_texture("chest", texture_no)
		elif tex_rng == 8:
			texture_no = "5_T40"
			$Texture2D.texture = $TextureLoader.get_texture("chest", texture_no)
		elif tex_rng == 9:
			texture_no = "5_T50"
			$Texture2D.texture = $TextureLoader.get_texture("chest", texture_no)
		elif tex_rng == 10:
			texture_no = "5_T60"
			$Texture2D.texture = $TextureLoader.get_texture("chest", texture_no)
		elif tex_rng == 11:
			texture_no = "5_T70"
			$Texture2D.texture = $TextureLoader.get_texture("chest", texture_no)
		elif tex_rng == 12:
			texture_no = "5_T80"
			$Texture2D.texture = $TextureLoader.get_texture("chest", texture_no)
