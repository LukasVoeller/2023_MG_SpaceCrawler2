#extends Node2D
extends "res://src/game/item/Item.gd"

#class_name ItemDisplay
#const Tooltip = preload("res://src/utils/tooltips/Tooltip.tscn")

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
			$Texture2D.texture = $TextureLoader.get_texture("weapon", rarity, tex_no)
		elif type == "shield": 
			$Texture2D.texture = $TextureLoader.get_texture("shield", rarity, tex_no)
		elif type == "hands": 
			$Texture2D.texture = $TextureLoader.get_texture("hands", rarity, tex_no)
		elif type == "head": 
			$Texture2D.texture = $TextureLoader.get_texture("head", rarity, tex_no)
		elif type == "chest": 
			$Texture2D.texture = $TextureLoader.get_texture("chest", rarity, tex_no)
		elif type == "feet": 
			$Texture2D.texture = $TextureLoader.get_texture("feet", rarity, tex_no)
			
	if rar == 2:
		$Background_2.show()
		
		if type == "weapon":
			$Texture2D.texture = $TextureLoader.get_texture("weapon", rarity, tex_no)
		elif type == "shield": 
			$Texture2D.texture = $TextureLoader.get_texture("shield", rarity, tex_no)
		elif type == "hands": 
			$Texture2D.texture = $TextureLoader.get_texture("hands", rarity, tex_no)
		elif type == "head": 
			$Texture2D.texture = $TextureLoader.get_texture("head", rarity, tex_no)
		elif type == "chest": 
			$Texture2D.texture = $TextureLoader.get_texture("chest", rarity, tex_no)
		elif type == "feet": 
			$Texture2D.texture = $TextureLoader.get_texture("feet", rarity, tex_no)
			
	if rar == 3:
		$Background_3.show()
		
		if type == "weapon":
			$Texture2D.texture = $TextureLoader.get_texture("weapon", rarity, tex_no)
		elif type == "shield": 
			$Texture2D.texture = $TextureLoader.get_texture("shield", rarity, tex_no)
		elif type == "hands": 
			$Texture2D.texture = $TextureLoader.get_texture("hands", rarity, tex_no)
		elif type == "head": 
			$Texture2D.texture = $TextureLoader.get_texture("head", rarity, tex_no)
		elif type == "chest": 
			$Texture2D.texture = $TextureLoader.get_texture("chest", rarity, tex_no)
		elif type == "feet": 
			$Texture2D.texture = $TextureLoader.get_texture("feet", rarity, tex_no)
			
	if rar == 4:
		$Background_4.show()
		
		if type == "weapon":
			$Texture2D.texture = $TextureLoader.get_texture("weapon", rarity, tex_no)
		elif type == "shield": 
			$Texture2D.texture = $TextureLoader.get_texture("shield", rarity, tex_no)
		elif type == "hands": 
			$Texture2D.texture = $TextureLoader.get_texture("hands", rarity, tex_no)
		elif type == "head": 
			$Texture2D.texture = $TextureLoader.get_texture("head", rarity, tex_no)
		elif type == "chest": 
			$Texture2D.texture = $TextureLoader.get_texture("chest", rarity, tex_no)
		elif type == "feet": 
			$Texture2D.texture = $TextureLoader.get_texture("feet", rarity, tex_no)
			
	if rar == 5:
		$Background_5.show()
		
		if type == "weapon":
			$Texture2D.texture = $TextureLoader.get_texture("weapon", rarity, tex_no)
		elif type == "shield": 
			$Texture2D.texture = $TextureLoader.get_texture("shield", rarity, tex_no)
		elif type == "hands": 
			$Texture2D.texture = $TextureLoader.get_texture("hands", rarity, tex_no)
		elif type == "head": 
			$Texture2D.texture = $TextureLoader.get_texture("head", rarity, tex_no)
		elif type == "chest": 
			$Texture2D.texture = $TextureLoader.get_texture("chest", rarity, tex_no)
		elif type == "feet": 
			$Texture2D.texture = $TextureLoader.get_texture("feet", rarity, tex_no)
			
	if type == "weapon":
		$Texture2D.rotation = 45
		$Texture2D.position.x += 40
		$Texture2D.position.y -= 20


func _on_touch_screen_button_double_tap():
	print("TAPPED")
	var tooltip_i = Tooltip.instantiate()
	add_child(tooltip_i)
	tooltip_i.popup()
	
#	if get_tree().get_current_scene().get_name() == "Inventory" or get_tree().get_current_scene().get_name() == "Play":
#		print("TAPPED")
#		var tooltip_i = Tooltip.instantiate()
#		add_child(tooltip_i)
#		print(get_children())
		
#		tooltip_i.get_node("Background/VBoxContainer/ItemName").text = str(get_parent().item_name)
#		tooltip_i.get_node("Background/VBoxContainer/Stat1/Stat").text = "Level:"
#		tooltip_i.get_node("Background/VBoxContainer/Stat1/Value").text = str(get_parent().level)
#		tooltip_i.get_node("Background/VBoxContainer/Stat2/Stat").text = "Rarity:"
#		tooltip_i.get_node("Background/VBoxContainer/Stat2/Value").text = str(get_parent().rarity)
#		tooltip_i.get_node("Background/VBoxContainer/Stat3/Stat").text = "Value:"
#		tooltip_i.get_node("Background/VBoxContainer/Stat3/Value").text = str(get_parent().value)
#		tooltip_i.get_node("Background/VBoxContainer/Stat4/Stat").text = "Type:"
#		tooltip_i.get_node("Background/VBoxContainer/Stat4/Value").text = str(get_parent().type)
#		tooltip_i.position = get_global_transform_with_canvas()[2]
#		tooltip_i.position.y -= 420
#		tooltip_i.position.x -= 50
		
#		tooltip_i.popup()
