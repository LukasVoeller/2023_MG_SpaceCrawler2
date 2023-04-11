extends Node2D

const Quest = preload("res://src/scene/quests/Quest.tscn")

var rng = RandomNumberGenerator.new()
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	$Control.size = screen_size
	
	rng.randomize()
	generate_quests()
	
	get_node("Control/Background/ScrollContainer").get_v_scroll_bar().custom_minimum_size.x = 75


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


#func init(_title, objective_val, objective_goal):
func generate_quests():
	for n in 10:
		var quest = Quest.instantiate()
		var nplusone = n+1
		var title = "Quest " + str(nplusone)
		var goal = (n+1) * 100
		var progress = rng.randi_range(1, 100)
		quest.init(title, 0, goal, progress)
		quest.connect("selected", Callable(self, "_on_Quest_selected").bind(quest))
		$Control/Background/ScrollContainer/VBoxContainer.add_child(quest)


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://src/scene/hangar/Hangar.tscn")
	

func _on_Quest_selected(quest):
	$Control/Details/QuestTitle.text = quest.title
	$Control/Details/QuestInfo.text = quest.info_text
