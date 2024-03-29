extends TouchScreenButton
class_name TouchScreenSwipe

signal double_tap

var tap_count := 1
var timer = Timer.new()

func _ready():
	self.connect("pressed",Callable(self,"_on_self_pressed").bind(),0)
	timer.connect("timeout",Callable(self,'_timer_timeout'))
	
	timer.one_shot = true
	self.add_child(timer, true)
	timer = get_node('Timer')


func _on_self_pressed():
	_tap_counter()


func _tap_counter():
	if timer.time_left == 0:
		timer.start(0.6)
	else:
		tap_count += 1
	
	if tap_count >= 2:
		timer.stop()
		tap_count = 1
		
		emit_signal("double_tap")
		if get_parent().has_method(str("_on_",self.get_name(),"_doubletap")) == true:
			get_parent().call(str("_on_", self.get_name(), "_doubletap"))


func _timer_timeout():
	tap_count = 1
