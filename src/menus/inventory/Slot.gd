extends TextureRect

class_name Slot

var slot_name = "inventory"

func _ready():
	pass


#func _get_drag_data(position):
#	var slot = get_parent().get_name()
#	print("Grabbed in Slot: ", slot)
#	var data = {}
#
#	data["origin_node"] = self
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
#
#
#func _can_drop_data(position, data):
#	var target_slot = get_name()
#	data["target_texture"] = texture
#	return true
#
#
#func _drop_data(position, data):
#	data["origin_node"].texture = data["target_texture"]
#	texture = data["origin_texture"]
