extends Control

var screen_size

#const Item = preload("res://src/game/item/Item.tscn")
const ItemDisplay = preload("res://src/game/item/_display/ItemDisplay.tscn")
#const ItemRigid = preload("res://src/game/item/rigid/ItemRigid.tscn")
const Slot = preload("res://src/menus/inventory/Slot.tscn")
const SlotPlaceholder = preload("res://src/menus/inventory/SlotPlaceholder.tscn")

const weapon_tex = preload("res://assets/ui/icons/icons_printed/Icon_Eq_Weapon.png")
const shield_tex = preload("res://assets/ui/icons/icons_printed/Icon_Eq_Shield.png")
const gloves_tex = preload("res://assets/ui/icons/icons_printed/Icon_Eq_Glowes.png")
const helmet_tex = preload("res://assets/ui/icons/icons_printed/Icon_Eq_Head.png")
const chest_tex = preload("res://assets/ui/icons/icons_printed/Icon_Eq_Chest.png")
const boots_tex = preload("res://assets/ui/icons/icons_printed/Icon_Eq_boots.png")

var slots_equ = ["weapon", "shield", "hands", "head", "chest", "feet"]

var inventory = []
var equipped = []

# Called when the node enters the scene tree for the first time.
func _ready():
	load_inventroy()
	init_inventory()
	fill_inventory()
	
	$Inventory/Items.text = "Items: " + str(inventory.size())
	
	get_node("Inventory/ScrollContainer").get_v_scroll_bar().custom_minimum_size.x = 100
	
	#print(inventroy)


func init_inventory():	
	# Equipped
	for n in 6:
		
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
			
			$Player/BackgroundRight/GridContainerRight.add_child(slot_i)
		else:
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
			
			$Player/BackgroundRight/GridContainerLeft.add_child(slot_i)
		
	# Inventory
	if inventory.size() < 32:
		for n in 32:
			var slot_i = Slot.instantiate()
			slot_i.slot_name = str(n)
			$Inventory/ScrollContainer/GridContainer.add_child(slot_i)
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
			slot_i.slot_name = str(n)
			$Inventory/ScrollContainer/GridContainer.add_child(slot_i)


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
#		for i in node_data.keys():
#			inventroy = node_data[i]

	#print("Loaded Inventory:")
	#print(equipped)
	#print(inventory)
	
	save_game.close()


func fill_inventory():
	var item_display = null
	var slot_placeholder = null
	
# Equipped Right
	for n in $Player/BackgroundRight/GridContainerRight.get_child_count():
		if n < equipped.size():
			if equipped[n].equipped == "weapon":
				item_display = ItemDisplay.instantiate()
				#func init(_name, rar, lvl, upgr, val, tex_no, equ, _type):
				item_display.init(
					equipped[n].item_name,
					equipped[n].rarity,
					equipped[n].level,
					equipped[n].upgrade,
					equipped[n].value,
					equipped[n].texture_no,
					equipped[n].equipped,
					equipped[n].type
				)
				item_display.position = Vector2(8, 8)
				$Player/BackgroundRight/GridContainerRight.get_child(0).add_child(item_display)
			elif equipped[n].equipped == "shield":
				item_display = ItemDisplay.instantiate()
				item_display.init(
					equipped[n].item_name,
					equipped[n].rarity,
					equipped[n].level,
					equipped[n].upgrade,
					equipped[n].value,
					equipped[n].texture_no,
					equipped[n].equipped,
					equipped[n].type
				)
				item_display.position = Vector2(8, 8)
				$Player/BackgroundRight/GridContainerRight.get_child(1).add_child(item_display)
			elif equipped[n].equipped == "hands":
				#print("true")
				item_display = ItemDisplay.instantiate()
				item_display.init(
					equipped[n].item_name,
					equipped[n].rarity,
					equipped[n].level,
					equipped[n].upgrade,
					equipped[n].value,
					equipped[n].texture_no,
					equipped[n].equipped,
					equipped[n].type
				)
				item_display.position = Vector2(8, 8)
				$Player/BackgroundRight/GridContainerRight.get_child(2).add_child(item_display)
			elif equipped[n].equipped == "head":
				#print("true")
				item_display = ItemDisplay.instantiate()
				item_display.init(
					equipped[n].item_name,
					equipped[n].rarity,
					equipped[n].level,
					equipped[n].upgrade,
					equipped[n].value,
					equipped[n].texture_no,
					equipped[n].equipped,
					equipped[n].type
				)
				item_display.position = Vector2(8, 8)
				$Player/BackgroundRight/GridContainerRight.get_child(2).add_child(item_display)
			elif equipped[n].equipped == "chest":
				#print("true")
				item_display = ItemDisplay.instantiate()
				item_display.init(
					equipped[n].item_name,
					equipped[n].rarity,
					equipped[n].level,
					equipped[n].upgrade,
					equipped[n].value,
					equipped[n].texture_no,
					equipped[n].equipped,
					equipped[n].type
				)
				item_display.position = Vector2(8, 8)
				$Player/BackgroundRight/GridContainerRight.get_child(2).add_child(item_display)
			elif equipped[n].equipped == "feet":
				#print("true")
				item_display = ItemDisplay.instantiate()
				item_display.init(
					equipped[n].item_name,
					equipped[n].rarity,
					equipped[n].level,
					equipped[n].upgrade,
					equipped[n].value,
					equipped[n].texture_no,
					equipped[n].equipped,
					equipped[n].type
				)
				item_display.position = Vector2(8, 8)
				$Player/BackgroundRight/GridContainerRight.get_child(2).add_child(item_display)
	
	for i in $Player/BackgroundRight/GridContainerRight.get_child_count():
		var node = $Player/BackgroundRight/GridContainerRight.get_child(i).get_child(0)
		if !node:
			slot_placeholder = SlotPlaceholder.instantiate()
			slot_placeholder.position = Vector2(8, 8)
			$Player/BackgroundRight/GridContainerRight.get_child(i).add_child(slot_placeholder)
			
	# Temp Equipped Left
	for i in $Player/BackgroundRight/GridContainerLeft.get_child_count():
		var node = $Player/BackgroundRight/GridContainerLeft.get_child(i).get_child(0)
		if !node:
			slot_placeholder = SlotPlaceholder.instantiate()
			slot_placeholder.position = Vector2(8, 8)
			$Player/BackgroundRight/GridContainerLeft.get_child(i).add_child(slot_placeholder)
	
# Inventory
	for n in $Inventory/ScrollContainer/GridContainer.get_child_count():
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
				inventory[n].type
			)
			item_display.position = Vector2(8, 8)
			item_display.equipped = str(n)
			$Inventory/ScrollContainer/GridContainer.get_child(n).add_child(item_display)
		
	for i in $Inventory/ScrollContainer/GridContainer.get_child_count():
		var node = $Inventory/ScrollContainer/GridContainer.get_child(i).get_child(0)
		if !node:
			slot_placeholder = SlotPlaceholder.instantiate()
			slot_placeholder.position = Vector2(8, 8)
			$Inventory/ScrollContainer/GridContainer.get_child(i).add_child(slot_placeholder)


func save_inventroy():
	inventory = []
	
	# Equipped
	for i in $Player/BackgroundRight/GridContainerRight.get_child_count():
		var node = $Player/BackgroundRight/GridContainerRight.get_child(i).get_child(0)
		if node.get_class() == "Control":
			inventory.append(JSON.new().stringify(node.get_json()))
	
	# Inventory
	for i in $Inventory/ScrollContainer/GridContainer.get_child_count():
		var node = $Inventory/ScrollContainer/GridContainer.get_child(i).get_child(0)
		if node.get_class() == "Control":
			inventory.append(JSON.new().stringify(node.get_json()))
			
	#print("Saving Inventory:")
	#print(inventory)
	
	var save_game = FileAccess.open("user://saveinventory.save", FileAccess.WRITE)
	# Call the node's save function.
	for i in inventory.size():
		var data = inventory[i]
		save_game.store_line(data)
	save_game.close()


func _on_BackButton_pressed():
	#print_inventory()
	save_inventroy()
	
	#save_equipped()
	get_tree().change_scene_to_file("res://src/menus/hangar/Hangar.tscn")


func fetch_state():
	# Equipped
	for i in $Player/BackgroundRight/GridContainer.get_child_count():
		var node = $Player/BackgroundRight/GridContainer.get_child(i).get_child(0)
		if node.name == "ItemDisplay":
			equipped.append(JSON.new().stringify(node.get_data()))

	# Inventory
	for i in $Inventory/ScrollContainer/GridContainer.get_child_count():
		var node = $Inventory/ScrollContainer/GridContainer.get_child(i).get_child(0)
		if node.name == "ItemDisplay":
			inventory.append(JSON.new().stringify(node.get_data()))


func print_inventory():
	print("--- PRINT INVENTORY ---")
	print("Equipped:")
	for i in $Player/BackgroundRight/GridContainerRight.get_child_count():
		var node = $Player/BackgroundRight/GridContainerRight.get_child(i).get_child(0)
		if node.get_class() == "Control":
			print(JSON.new().stringify(node.get_json()))

	print("Inventory:")
	for i in $Inventory/ScrollContainer/GridContainer.get_child_count():
		var node = $Inventory/ScrollContainer/GridContainer.get_child(i).get_child(0)
		if node.get_class() == "Control":
			print(JSON.new().stringify(node.get_json()))


func _on_ShowStatsButton_pressed():
	$StatsSheet.show()
	$Player/ShowStatsButton.hide()
	$Player/HideStatsButton.show()


func _on_HideStatsButton_pressed():
	$StatsSheet.hide()
	$Player/ShowStatsButton.show()
	$Player/HideStatsButton.hide()
