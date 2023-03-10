extends TextureRect

func _get_drag_data(position):
	if get_tree().get_current_scene().get_name() == "Inventory":
		var item = get_parent()
		var slot = get_parent().get_parent()
		var data = {}
		
		data["origin_node"] = self
		data["origin_item"] = item
		data["origin_slot"] = slot
		data["origin_texture"] = texture
		
		var drag_texture = TextureRect.new()
		drag_texture.expand = true
		drag_texture.stretch_mode = STRETCH_KEEP_ASPECT_CENTERED
		drag_texture.texture = texture
		drag_texture.size = Vector2(100, 100)
		
		var control = Control.new()
		control.add_child(drag_texture)
		drag_texture.position = -0.5 * drag_texture.size
		set_drag_preview(control)
		
		return data


func _can_drop_data(position, data):
	var origin_item_type = data["origin_node"].get_parent().type
	var origin_slot_type = data["origin_node"].get_parent().equipped
	var target_item_type = get_parent().type
	var target_slot_type = get_parent().get_parent().slot_name
	
	#print("Dragging in ID: ", origin_item_type, " from ", origin_slot_type, " to ", target_item_type, " from ", target_slot_type)
	
	data["target_texture"] = texture
	
	if origin_item_type == target_item_type:
		return true
	elif origin_slot_type == target_slot_type:
		return true
	else:
		false


func _drop_data(position, data):
	if data["origin_item"] is Item:
		if self.get_parent() != data["origin_item"]:
			data["origin_node"].texture = data["target_texture"]
			texture = data["origin_texture"]
			
			var origin_item = data["origin_node"].get_parent()
			var origin_item_parent = origin_item.get_parent()
			var self_item = get_parent()
			var self_item_parent = get_parent().get_parent()
			
			#print("Dropping: ", origin_item.rarity, " into: ", self_item.rarity)
			
			origin_item.queue_free()
			var self_item_copy = self_item.get_copy()
			self_item_copy.position = Vector2(8, 8)
			origin_item_parent.add_child(self_item_copy)
			
			self_item.queue_free()
			var origin_item_copy = origin_item.get_copy()
			origin_item_copy.position = Vector2(8, 8)
			self_item_parent.add_child(origin_item_copy)
			
			if get_parent().get_parent().slot_name == "weapon":
				self_item_copy.equipped = origin_item_copy.equipped
				origin_item_copy.equipped = get_parent().get_parent().slot_name
			elif get_parent().get_parent().slot_name == "shield":
				self_item_copy.equipped = origin_item_copy.equipped
				origin_item_copy.equipped = get_parent().get_parent().slot_name
			elif get_parent().get_parent().slot_name == "hands":
				self_item_copy.equipped = origin_item_copy.equipped
				origin_item_copy.equipped = get_parent().get_parent().slot_name
			elif get_parent().get_parent().slot_name == "head":
				self_item_copy.equipped = origin_item_copy.equipped
				origin_item_copy.equipped = get_parent().get_parent().slot_name
			elif get_parent().get_parent().slot_name == "chest":
				self_item_copy.equipped = origin_item_copy.equipped
				origin_item_copy.equipped = get_parent().get_parent().slot_name
			elif get_parent().get_parent().slot_name == "feet":
				self_item_copy.equipped = origin_item_copy.equipped
				origin_item_copy.equipped = get_parent().get_parent().slot_name
			else:
				self_item_copy.equipped = origin_item_copy.equipped
				origin_item_copy.equipped = get_parent().get_parent().slot_name
