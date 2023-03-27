extends Label

func _ready():
	text = str(get_parent().get_parent().get_parent().level)
