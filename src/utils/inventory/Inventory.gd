extends Control

const ItemDisplay = preload("res://src/game/item/display/ItemDisplay.tscn")
const SlotPlaceholder = preload("res://src/menus/inventory/SlotPlaceholder.tscn")
const Slot = preload("res://src/menus/inventory/Slot.tscn")

var inventory = []

func _ready():
	init_inventory()
	load_inventroy()
	fill_inventory()
	
	get_node("ScrollContainer").get_v_scroll_bar().custom_minimum_size.x = 30


func init_inventory():			
	# Inventory
	for n in 32:
		var slot_i = Slot.instantiate()
		slot_i.slot_name = str(n)
		$ScrollContainer/GridContainer.add_child(slot_i)


func load_inventroy():
	var save_game = File.new()
	if not save_game.file_exists("user://saveinventroy.save"):
		return # Error! We don't have a save to load.

	save_game.open("user://saveinventroy.save", File.READ)
	while save_game.get_position() < save_game.get_length():
		var test_json_conv = JSON.new()
		test_json_conv.parse(save_game.get_line())
		var node_data = test_json_conv.get_data()

		if node_data.equipped == "first" or node_data.equipped == "second" or node_data.equipped == "third":
			pass
		else:
			inventory.append(node_data)
#		for i in node_data.keys():
#			inventroy = node_data[i]

	#print("Loaded Inventory:")
	#print(inventory)
	
	save_game.close()


func fill_inventory():
	var item_display = null
	var slot_placeholder = null
	
# Inventory
	for n in $ScrollContainer/GridContainer.get_child_count():
		if n < inventory.size():
			item_display = ItemDisplay.instantiate()
			item_display.init(inventory[n].level, inventory[n].rarity, inventory[n].value, inventory[n].tex_no, inventory[n].equipped)
			item_display.position = Vector2(8, 8)
			item_display.equipped = str(n)
			$ScrollContainer/GridContainer.get_child(n).add_child(item_display)
		
	for i in $ScrollContainer/GridContainer.get_child_count():
		var node = $ScrollContainer/GridContainer.get_child(i).get_child(0)
		if !node:
			slot_placeholder = SlotPlaceholder.instantiate()
			slot_placeholder.position = Vector2(8, 8)
			$ScrollContainer/GridContainer.get_child(i).add_child(slot_placeholder)


func save_inventroy():
	inventory = []
	
	# Inventory
	print("Child count: ", $ScrollContainer/GridContainer.get_child_count())
	for i in $ScrollContainer/GridContainer.get_child_count():
		var node = $ScrollContainer/GridContainer.get_child(i).get_child(0)
		
		if node.get_class() == "Control":
			inventory.append(JSON.new().stringify(node.get_json()))
			
	#print("Saving Inventory:")
	#print(inventory)
	
	var save_game = File.new()
	save_game.open("user://saveinventroy.save", File.WRITE)
	# Call the node's save function.
	for i in inventory.size():
		var data = inventory[i]
		save_game.store_line(data)
	save_game.close()
