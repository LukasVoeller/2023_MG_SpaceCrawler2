extends TextureRect

var item = null

var slots_equ = ["weapon", "shield", "hands", "head", "chest", "feet", "trinket_1", "trinket_2"]

func _get_drag_data(position):
	pass


func _can_drop_data(position, data):
	var origin_item_level = data["origin_node"].get_parent().level
	var origin_item_type = data["origin_node"].get_parent().type
	var target_slot_type = get_parent().slot_name
	
	#print("Dragging in SP: Level ", origin_item_level, " ", origin_item_type, " to ", target_slot_type)
	
	if origin_item_type == target_slot_type  and origin_item_level <= Global.spaceship_level:
		return true
	elif origin_item_type == "trinket" and target_slot_type == "trinket_1" and origin_item_level <= Global.spaceship_level:
		return true
	elif origin_item_type == "trinket" and target_slot_type == "trinket_2" and origin_item_level <= Global.spaceship_level:
		return true
	# Prevents unallowed inner equpipped switches
	elif !slots_equ.has(target_slot_type):
		return true
	else:
		false


func _drop_data(position, data):
	if _can_drop_data(position, data):
		if data["origin_item"] != null:
			var origin_item = data["origin_node"].get_parent()
			var origin_item_parent = origin_item.get_parent()
			var self_item = self
			var self_item_parent = get_parent()
			
			var self_item_copy = self.duplicate()
			self_item_copy.position = Vector2(8, 8)
			origin_item_parent.add_child(self_item_copy)
			origin_item.queue_free()
			
			var origin_item_copy = origin_item.get_copy()
			origin_item_copy.position = Vector2(8, 8)
			self_item_parent.add_child(origin_item_copy)
			self_item.queue_free()
			
			origin_item_copy.equipped = get_parent().slot_name
