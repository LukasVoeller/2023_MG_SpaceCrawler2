extends Popup

var origin = ""
var slot = ""
var valid = false

func _ready():
	var icon_tex = TextureRect.new()
	icon_tex.texture = get_parent().get_parent().get_node("Texture2D").texture
	icon_tex.position.x += 25
	icon_tex.position.y += 10
	$Background/Icon.add_child(icon_tex)
