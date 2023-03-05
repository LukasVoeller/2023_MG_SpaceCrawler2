extends TextureRect

const Tooltip = preload("res://src/game/item/Tooltip.tscn")
var item = null

var slots_equ = ["weapon", "shield", "hands", "head", "chest", "feet"]

func _get_drag_data(position):
	pass
#	var slot = get_parent()
#	var data = {}
#
#	data["origin_node"] = self
#	data["origin_item"] = item
#	data["origin_slot"] = slot
#	data["origin_texture"] = texture
#
#	var drag_texture = TextureRect.new()
#	drag_texture.expand = true
#	drag_texture.texture = texture
#	drag_texture.size = Vector2(100, 100)
#
#	var control = Control.new()
#	control.add_child(drag_texture)
#	drag_texture.position = -0.5 * drag_texture.size
#	set_drag_preview(control)
#
#	return data


func _can_drop_data(position, data):
	var target_slot = get_parent().get_name()
	var target_slot_name = get_parent().slot_name
	var origin_item = data["origin_node"].get_parent()
	
	#print(slots_equ.has("first"))
	#print("Dragging: ", origin_item.type, " to ", target_slot_name)
	
	if origin_item.type == "weapon" && target_slot_name == "weapon":
		return true
	elif origin_item.type == "weapon" && !slots_equ.has(target_slot_name):
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
			#origin_item_copy.get_node("CollisionShape2D").disabled = true
			self_item_parent.add_child(origin_item_copy)
			self_item.queue_free()
			
			if get_parent().slot_name == "weapon":
				print("dropped rarity: ", origin_item_copy.rarity)
				print("into empty slot: ", get_parent().slot_name)
				origin_item_copy.equipped = get_parent().slot_name
			elif get_parent().slot_name == "shield":
				print("dropped rarity: ", origin_item_copy.rarity)
				print("into empty slot: ", get_parent().slot_name)
				origin_item_copy.equipped = get_parent().slot_name
			elif get_parent().slot_name == "hands":
				print("dropped rarity: ", origin_item_copy.rarity)
				print("into empty slot: ", get_parent().slot_name)
				origin_item_copy.equipped = get_parent().slot_name
			else:
				print("dropped rarity: ", origin_item_copy.rarity)
				print("into empty slot: ", get_parent().slot_name)
				origin_item_copy.equipped = get_parent().slot_name


func _on_SlotPlaceholder_gui_input(event):
	if item != null:
		if event is InputEventMouseButton and event.is_pressed() && event.button_index == MOUSE_BUTTON_RIGHT:
			if get_tree().get_current_scene().get_name() == "Inventory":				
				var tooltip_i = Tooltip.instantiate()
				add_child(tooltip_i)
				
				tooltip_i.get_node("NinePatchRect/MarginContainer/VBoxContainer/ItemName").text = str(item.id)
				tooltip_i.get_node("NinePatchRect/MarginContainer/VBoxContainer/Stat1/Stat").text = "Level:"
				tooltip_i.get_node("NinePatchRect/MarginContainer/VBoxContainer/Stat1/Value").text = str(item.level)
				tooltip_i.get_node("NinePatchRect/MarginContainer/VBoxContainer/Stat2/Stat").text = "Rarity:"
				tooltip_i.get_node("NinePatchRect/MarginContainer/VBoxContainer/Stat2/Value").text = str(item.rarity)
				tooltip_i.get_node("NinePatchRect/MarginContainer/VBoxContainer/Stat3/Stat").text = "Value:"
				tooltip_i.get_node("NinePatchRect/MarginContainer/VBoxContainer/Stat3/Value").text = str(item.value)
				tooltip_i.position = get_global_transform_with_canvas()[2]
				tooltip_i.position.y -= 208
				
				tooltip_i.popup()
