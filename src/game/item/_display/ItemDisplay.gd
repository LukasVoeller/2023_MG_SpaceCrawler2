#extends Control
extends "res://src/game/item/Item.gd"

#class_name ItemDisplay

var rng = RandomNumberGenerator.new()

func _ready():
	if upgrade > 0:
		$Upgrade.text = "+" + str(upgrade)
	$Level.text = str(level)
	#print("Instanced ItemDisplay")


func get_copy():
	var copy = load("res://src/game/item/_display/ItemDisplay.tscn").instantiate()
	#func init(_name, rar, lvl, upgr, val, tex_no, equ, _type):
	copy.init(item_name, rarity, level, upgrade, value, texture_no, equipped, type)
	return copy

	
func get_json():
	return ({
		"item_name": item_name,
		"rarity": rarity,
		"level": level,
		"upgrade": upgrade,
		"value": value,
		"texture_no": texture_no,
		"equipped": equipped,
		"type": type,
	})

#func init(_name, rar, lvl, upgr, val, tex_no, equ, type):
func init(_name, rar, lvl, upgr, val, tex_no, equ, _type):
	item_name = _name
	rarity = rar
	level = lvl
	upgrade = upgr
	value = val
	texture_no = tex_no
	equipped = equ
	type = _type
	
	if rar == 1:
		$Background_1.show()
		
		if type == "weapon":
			$Texture2D.texture = $TextureLoader.get_texture("weapon", tex_no)
		elif type == "chest": 
			$Texture2D.texture = $TextureLoader.get_texture("chest", tex_no)
		elif type == "head": 
			$Texture2D.texture = $TextureLoader.get_texture("head", tex_no)
			
	if rar == 2:
		$Background_2.show()
		
		if type == "weapon":
			$Texture2D.texture = $TextureLoader.get_texture("weapon", tex_no)
		elif type == "chest": 
			$Texture2D.texture = $TextureLoader.get_texture("chest", tex_no)
		elif type == "head": 
			$Texture2D.texture = $TextureLoader.get_texture("head", tex_no)
			
	if rar == 3:
		$Background_3.show()
		
		if type == "weapon":
			$Texture2D.texture = $TextureLoader.get_texture("weapon", tex_no)
		elif type == "chest": 
			$Texture2D.texture = $TextureLoader.get_texture("chest", tex_no)
		elif type == "head": 
			$Texture2D.texture = $TextureLoader.get_texture("head", tex_no)
			
	if rar == 4:
		$Background_4.show()
		
		if type == "weapon":
			$Texture2D.texture = $TextureLoader.get_texture("weapon", tex_no)
		elif type == "chest": 
			$Texture2D.texture = $TextureLoader.get_texture("chest", tex_no)
		elif type == "head": 
			$Texture2D.texture = $TextureLoader.get_texture("head", tex_no)
			
	if rar == 5:
		$Background_5.show()
		
		if type == "weapon":
			$Texture2D.texture = $TextureLoader.get_texture("weapon", tex_no)
		elif type == "chest": 
			$Texture2D.texture = $TextureLoader.get_texture("chest", tex_no)
		elif type == "head": 
			$Texture2D.texture = $TextureLoader.get_texture("head", tex_no)
			
	if type == "weapon":
		$Texture2D.rotation = 45
		$Texture2D.position.x += 40
		$Texture2D.position.y -= 20
