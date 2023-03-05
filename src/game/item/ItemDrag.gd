extends TextureRect

const Tooltip = preload("res://src/game/item/Tooltip.tscn")

var damage

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
	var target_slot = get_parent().get_parent().get_name()
	var target_slot_name = get_parent().get_parent().slot_name
	#print("Item Drag:", target_slot_name)
	data["target_texture"] = texture
	return true


func _drop_data(position, data):
	if data["origin_item"] is Item:
		if self.get_parent() != data["origin_item"]:
			data["origin_node"].texture = data["target_texture"]
			texture = data["origin_texture"]
			
			var origin_item = data["origin_node"].get_parent()
			var origin_item_parent = origin_item.get_parent()
			var self_item = get_parent()
			var self_item_parent = get_parent().get_parent()

			origin_item.queue_free()
			var self_item_copy = self_item.get_copy()
			self_item_copy.position = Vector2(8, 8)
			#self_item_copy.get_node("CollisionShape2D").disabled = true
			origin_item_parent.add_child(self_item_copy)
			
			self_item.queue_free()
			var origin_item_copy = origin_item.get_copy()
			origin_item_copy.position = Vector2(8, 8)
			#origin_item_copy.get_node("CollisionShape2D").disabled = true
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
				

#func _on_TestTexture_gui_input(event):
#	if event is InputEventMouseButton and event.is_pressed() && event.doubleclick:
#		if get_tree().get_current_scene().get_name() == "Inventory":
#			var tooltip_i = Tooltip.instantiate()
#			add_child(tooltip_i)
#
#			tooltip_i.get_node("NinePatchRect/MarginContainer/VBoxContainer/ItemName").text = str(get_parent().id)
#			tooltip_i.get_node("NinePatchRect/MarginContainer/VBoxContainer/Stat1/Stat").text = "Level:"
#			tooltip_i.get_node("NinePatchRect/MarginContainer/VBoxContainer/Stat1/Value").text = str(get_parent().level)
#			tooltip_i.get_node("NinePatchRect/MarginContainer/VBoxContainer/Stat2/Stat").text = "Rarity:"
#			tooltip_i.get_node("NinePatchRect/MarginContainer/VBoxContainer/Stat2/Value").text = str(get_parent().rarity)
#			tooltip_i.get_node("NinePatchRect/MarginContainer/VBoxContainer/Stat3/Stat").text = "Value:"
#			tooltip_i.get_node("NinePatchRect/MarginContainer/VBoxContainer/Stat3/Value").text = str(get_parent().value)
#			tooltip_i.position = get_global_transform_with_canvas()[2]
#			tooltip_i.position.y -= 208
#
#			tooltip_i.popup()


func _on_TouchScreenButton_double_tap():
	if get_tree().get_current_scene().get_name() == "Inventory" or get_tree().get_current_scene().get_name() == "Play":
		var tooltip_i = Tooltip.instantiate()
		add_child(tooltip_i)
		
		tooltip_i.get_node("Background/VBoxContainer/ItemName").text = str(get_parent().item_name)
		tooltip_i.get_node("Background/VBoxContainer/Stat1/Stat").text = "Level:"
		tooltip_i.get_node("Background/VBoxContainer/Stat1/Value").text = str(get_parent().level)
		tooltip_i.get_node("Background/VBoxContainer/Stat2/Stat").text = "Rarity:"
		tooltip_i.get_node("Background/VBoxContainer/Stat2/Value").text = str(get_parent().rarity)
		tooltip_i.get_node("Background/VBoxContainer/Stat3/Stat").text = "Value:"
		tooltip_i.get_node("Background/VBoxContainer/Stat3/Value").text = str(get_parent().value)
		tooltip_i.get_node("Background/VBoxContainer/Stat4/Stat").text = "Type:"
		tooltip_i.get_node("Background/VBoxContainer/Stat4/Value").text = str(get_parent().type)
		tooltip_i.position = get_global_transform_with_canvas()[2]
		tooltip_i.position.y -= 420
		tooltip_i.position.x -= 50
		
		tooltip_i.popup()
