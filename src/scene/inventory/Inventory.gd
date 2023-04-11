extends Node2D

const ItemDisplay = preload("res://src/game/item/ItemDisplay.tscn")
const Slot = preload("res://src/scene/inventory/Slot.tscn")
const SlotPlaceholder = preload("res://src/scene/inventory/SlotPlaceholder.tscn")

const weapon_tex = preload("res://assets/ui/darkpixelrpg/icons/inventory/icon_weapon.png")
const shield_tex = preload("res://assets/ui/darkpixelrpg/icons/inventory/icon_shield.png")
const gloves_tex = preload("res://assets/ui/darkpixelrpg/icons/inventory/icon_hands.png")
const helmet_tex = preload("res://assets/ui/darkpixelrpg/icons/inventory/icon_head.png")
const chest_tex = preload("res://assets/ui/darkpixelrpg/icons/inventory/icon_chest.png")
const boots_tex = preload("res://assets/ui/darkpixelrpg/icons/inventory/icon_feet.png")
const tinket_tex = preload("res://assets/ui/darkpixelrpg/icons/inventory/icon_trinket.png")

var slots_equ = ["weapon", "shield", "hands", "head", "chest", "feet", "trinket_1", "trinket_2"]

var inventory = []
var equipped = []

var spaceship

var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	$Control.size = screen_size
	
	load_spaceship()
	
	Global.spaceship_level = spaceship.level
	$Control/Player/Title/Level.text = "Level " + str(Global.spaceship_level)
	$Control/Inventory/Items.text = "Items: " + str(inventory.size())
	get_node("Control/Inventory/ScrollContainer").get_v_scroll_bar().custom_minimum_size.x = 100
	
	load_inventroy()
	init_inventory()
	fill_inventory()

	#print(Equipment.in_use)

func init_inventory():
	# Equipped
	for n in 8:
		if n < 3:
			var slot_i = Slot.instantiate()
			
			if n == 0:
				slot_i.slot_name = "weapon"
				slot_i.texture = weapon_tex
			elif n == 1:
				slot_i.slot_name = "shield"
				slot_i.texture = shield_tex
			elif n == 2:
				slot_i.slot_name = "hands"
				slot_i.texture = gloves_tex
			
			$Control/Player/Background/GridContainerRight.add_child(slot_i)
		elif n >= 3 && n < 6:
			var slot_i = Slot.instantiate()
			
			if n == 3:
				slot_i.slot_name = "head"
				slot_i.texture = helmet_tex
			elif n == 4:
				slot_i.slot_name = "chest"
				slot_i.texture = chest_tex
			elif n == 5:
				slot_i.slot_name = "feet"
				slot_i.texture = boots_tex
			
			$Control/Player/Background/GridContainerLeft.add_child(slot_i)
		elif n >= 6:
			var slot_i = Slot.instantiate()
			
			if n == 6:
				slot_i.slot_name = "trinket_1"
				slot_i.texture = tinket_tex
			elif n == 7:
				slot_i.slot_name = "trinket_2"
				slot_i.texture = tinket_tex
			
			$Control/Player/Background/GridContainerBottom.add_child(slot_i)
		
	# Inventory
	if inventory.size() < 32:
		for n in 32:
			var slot_i = Slot.instantiate()
			#slot_i.slot_name = str(n)
			$Control/Inventory/ScrollContainer/GridContainer.add_child(slot_i)
	else:
		var fill = 0
		if inventory.size() % 4 == 0:
			fill = 4
		if inventory.size() % 4 == 1:
			fill = 3
		if inventory.size() % 4 == 2:
			fill = 2
		if inventory.size() % 4 == 3:
			fill = 1
		
		for n in inventory.size() + fill:
			var slot_i = Slot.instantiate()
			#slot_i.slot_name = str(n)
			$Control/Inventory/ScrollContainer/GridContainer.add_child(slot_i)


func load_inventroy():
	var save_game = FileAccess.open("user://saveinventory.save", FileAccess.READ)
	if not save_game:
		return # Error! We don't have a save to load.

	while save_game.get_position() < save_game.get_length():
		var test_json_conv = JSON.new()
		test_json_conv.parse(save_game.get_line())
		var node_data = test_json_conv.get_data()

		if slots_equ.has(node_data.equipped):
			equipped.append(node_data)
		else:
			inventory.append(node_data)

	#print("Loaded Equipped:")
	#print(equipped)
	#print("Loaded Inventory:")
	#print(inventory)
	
	save_game.close()


func fill_inventory():
	var item_display = null
	var slot_placeholder = null
	
	for n in equipped.size():
		item_display = ItemDisplay.instantiate()
		item_display.init(
			equipped[n].item_name,
			equipped[n].rarity,
			equipped[n].level,
			equipped[n].upgrade,
			equipped[n].value,
			equipped[n].texture_no,
			equipped[n].equipped,
			equipped[n].type,
			equipped[n].stats
		)
		item_display.position = Vector2(8, 8)

		if equipped[n].equipped == "weapon":
			Equipment.in_use.weapon = item_display.get_json()
			$Control/Player/Background/GridContainerRight.get_child(0).add_child(item_display)
		if equipped[n].equipped == "shield":
			Equipment.in_use.shield = item_display.get_json()
			$Control/Player/Background/GridContainerRight.get_child(1).add_child(item_display)
		if equipped[n].equipped == "hands":
			Equipment.in_use.hands = item_display.get_json()
			$Control/Player/Background/GridContainerRight.get_child(2).add_child(item_display)
		if equipped[n].equipped == "head":
			Equipment.in_use.head = item_display.get_json()
			$Control/Player/Background/GridContainerLeft.get_child(0).add_child(item_display)
		if equipped[n].equipped == "chest":
			Equipment.in_use.chest = item_display.get_json()
			$Control/Player/Background/GridContainerLeft.get_child(1).add_child(item_display)
		if equipped[n].equipped == "feet":
			Equipment.in_use.feet = item_display.get_json()
			$Control/Player/Background/GridContainerLeft.get_child(2).add_child(item_display)
		if equipped[n].equipped == "trinket_1":
			Equipment.in_use.trinket_1 = item_display.get_json()
			$Control/Player/Background/GridContainerBottom.get_child(0).add_child(item_display)
		if equipped[n].equipped == "trinket_2":
			Equipment.in_use.trinket_2 = item_display.get_json()
			$Control/Player/Background/GridContainerBottom.get_child(1).add_child(item_display)

	
	# Fill empty Equipmentslots right
	for i in $Control/Player/Background/GridContainerRight.get_child_count():
		var node = $Control/Player/Background/GridContainerRight.get_child(i).get_child(0)
		if !node:
			slot_placeholder = SlotPlaceholder.instantiate()
			slot_placeholder.position = Vector2(8, 8)
			$Control/Player/Background/GridContainerRight.get_child(i).add_child(slot_placeholder)
	
	# Fill empty Equipmentslots left
	for i in $Control/Player/Background/GridContainerLeft.get_child_count():
		var node = $Control/Player/Background/GridContainerLeft.get_child(i).get_child(0)
		if !node:
			slot_placeholder = SlotPlaceholder.instantiate()
			slot_placeholder.position = Vector2(8, 8)
			$Control/Player/Background/GridContainerLeft.get_child(i).add_child(slot_placeholder)
			
	# Fill empty Equipmentslots bottom
	for i in $Control/Player/Background/GridContainerBottom.get_child_count():
		var node = $Control/Player/Background/GridContainerBottom.get_child(i).get_child(0)
		if !node:
			slot_placeholder = SlotPlaceholder.instantiate()
			slot_placeholder.position = Vector2(8, 8)
			$Control/Player/Background/GridContainerBottom.get_child(i).add_child(slot_placeholder)
	
	# Inventory
	for n in $Control/Inventory/ScrollContainer/GridContainer.get_child_count():
		if n < inventory.size():
			item_display = ItemDisplay.instantiate()
			item_display.init(
				inventory[n].item_name,
				inventory[n].rarity,
				inventory[n].level,
				inventory[n].upgrade,
				inventory[n].value,
				inventory[n].texture_no,
				inventory[n].equipped,
				inventory[n].type,
				inventory[n].stats
			)
			item_display.position = Vector2(8, 8)
			#item_display.equipped = str(n)
			item_display.equipped = "inventory"
			$Control/Inventory/ScrollContainer/GridContainer.get_child(n).add_child(item_display)
			
			#item_display.connect("inventory_changed", Callable(self,"_on_change"))
			#item_display.connect("inventory_changed", Callable(self,"_on_change").bind(item_display))
			
#			for k in equipped.size():
#				print(inventory[n].type)
#				if equipped[k].type == inventory[n].type:
#					item_display.compare_with_equipped(equipped[k].type, equipped[k].stats)
		
		
	for i in $Control/Inventory/ScrollContainer/GridContainer.get_child_count():
		var node = $Control/Inventory/ScrollContainer/GridContainer.get_child(i).get_child(0)
		if !node:
			slot_placeholder = SlotPlaceholder.instantiate()
			slot_placeholder.position = Vector2(8, 8)
			$Control/Inventory/ScrollContainer/GridContainer.get_child(i).add_child(slot_placeholder)


#func _on_change(origin_item_copy):
#	print("on change")
#	var equipped_item_stats
#
#	for n in equipped.size():
#		if equipped[n].type == origin_item_copy.type:
#			equipped_item_stats = equipped[n].stats
#
#	origin_item_copy.compare_with_equipped(origin_item_copy.type, equipped_item_stats)
#	#print("JAWOLLO")
#	#print(origin_item_copy)


func save_inventroy():
	inventory = []
	
	# Equipped
	for i in $Control/Player/Background/GridContainerRight.get_child_count():
		var node = $Control/Player/Background/GridContainerRight.get_child(i).get_child(0)
		if node.get_class() == "Node2D":
			inventory.append(JSON.new().stringify(node.get_json()))
			
	for i in $Control/Player/Background/GridContainerLeft.get_child_count():
		var node = $Control/Player/Background/GridContainerLeft.get_child(i).get_child(0)
		if node.get_class() == "Node2D":
			inventory.append(JSON.new().stringify(node.get_json()))
			
	for i in $Control/Player/Background/GridContainerBottom.get_child_count():
		var node = $Control/Player/Background/GridContainerBottom.get_child(i).get_child(0)
		if node.get_class() == "Node2D":
			inventory.append(JSON.new().stringify(node.get_json()))
	
	# Inventory
	for i in $Control/Inventory/ScrollContainer/GridContainer.get_child_count():
		var node = $Control/Inventory/ScrollContainer/GridContainer.get_child(i).get_child(0)
		if node.get_class() == "Node2D":
			inventory.append(JSON.new().stringify(node.get_json()))
			
	#print("Saving Inventory:")
	#print(inventory)
	
	var save_game = FileAccess.open("user://saveinventory.save", FileAccess.WRITE)
	for i in inventory.size():
		var data = inventory[i]
		save_game.store_line(data)
	save_game.close()


func print_inventory():
	print("--- PRINT INVENTORY ---")
	print("Equipped:")
	for i in $Control/Player/BackgroundRight/GridContainerRight.get_child_count():
		var node = $Control/Player/BackgroundRight/GridContainerRight.get_child(i).get_child(0)
		if node.get_class() == "Control":
			print(JSON.new().stringify(node.get_json()))

	print("Inventory:")
	for i in $Control/Inventory/ScrollContainer/GridContainer.get_child_count():
		var node = $Control/Inventory/ScrollContainer/GridContainer.get_child(i).get_child(0)
		if node.get_class() == "Control":
			print(JSON.new().stringify(node.get_json()))


func load_spaceship():
	var save_spaceship = FileAccess.open("user://spaceship.save", FileAccess.READ)
	
	var test_json_conv = JSON.new()
	test_json_conv.parse(save_spaceship.get_line())
	var node_data = test_json_conv.get_data()

	spaceship = load(node_data["filename"]).instantiate()

	for i in node_data.keys():
		if i == "filename":
			continue
		spaceship.set(i, node_data[i])

	save_spaceship.close()


func _on_back_button_pressed():
	save_inventroy()
	get_tree().change_scene_to_file("res://src/scene/hangar/Hangar.tscn")


func _on_show_stats_button_pressed():
	$Control/StatsSheet.show()
	$Control/ShowStatsButton.hide()
	$Control/HideStatsButton.show()


func _on_hide_stats_button_pressed():
	$Control/StatsSheet.hide()
	$Control/ShowStatsButton.show()
	$Control/HideStatsButton.hide()


func _on_sort_pressed():
	pass
