extends Node2D

const ItemWeapon = preload("res://src/game/item/weapon/ItemWeapon.tscn")
const ItemShield = preload("res://src/game/item/shield/ItemShield.tscn")
const ItemHands = preload("res://src/game/item/hands/ItemHands.tscn")
const ItemHead = preload("res://src/game/item/head/ItemHead.tscn")
const ItemChest = preload("res://src/game/item/chest/ItemChest.tscn")
const ItemFeet = preload("res://src/game/item/feet/ItemFeet.tscn")
const ItemTrinket = preload("res://src/game/item/trinket/ItemTrinket.tscn")

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func spawn_item(player, spaceship_level, asteroid):
	var rand_type = rng.randi_range(1, 7)
	var rand_rarity = rng.randi_range(Global.item_rarity_min, Global.item_rarity_max)
	var item_spawn_location = asteroid.get_global_transform_with_canvas()
	var rand_level
	
	if (spaceship_level - 3) >= 1 && (spaceship_level + 3) <= 60:
		rand_level = rng.randi_range(spaceship_level - 3, spaceship_level + 3)
	else:
		rand_level = spaceship_level
	
	var stats = {
		"primary_stat_first": 0,
		"primary_stat_second": 0,
		
		"secondary_stat_first": 0,
		"secondary_stat_second": 0,
		"secondary_stat_third": 0,
		
		"socket_1": 0,
		"socket_2": 0,
	}
	
	#print("Span item with stats: " , stats)
	
	#func init(_name, _rar, _lvl, _upgr, _val, _tex_no, _equ, _type, _stats):
	if rand_type == 1:
		var item_weapon = ItemWeapon.instantiate()
		var stats_rand = rng.randi_range(1, 3)
		
		stats.primary_stat_first = rand_level * 25
		stats.primary_stat_second = 2
		
		if stats_rand == 1:
			stats.secondary_stat_first = rng.randi_range(8, 12)
		elif stats_rand == 2:
			stats.secondary_stat_first = rng.randi_range(7, 13)
			stats.secondary_stat_second = rng.randi_range(18, 22)
		elif stats_rand == 3:
			stats.secondary_stat_first = rng.randi_range(6, 14)
			stats.secondary_stat_second = rng.randi_range(15, 25)
			stats.secondary_stat_third = rng.randi_range(1, 2)
		
		item_weapon.init("No name", rand_rarity, rand_level, 0, 100, "", "inventory", "weapon", stats)
		item_weapon.position.x = item_spawn_location[2].x
		item_weapon.position.y = item_spawn_location[2].y
		item_weapon.connect("collected",Callable(player,"_on_Item_collected").bind(item_weapon))
		add_child(item_weapon)
	if rand_type == 2:
		var item_shield = ItemShield.instantiate()
		
		stats.primary_stat_first = rng.randi_range(rand_level * 100 - 50, rand_level * 100 + 50)
		stats.primary_stat_second = rng.randi_range(8, 12)
		
		item_shield.init("No name", rand_rarity, rand_level, 0, 100, "", "inventory", "shield", stats)
		item_shield.position.x = item_spawn_location[2].x
		item_shield.position.y = item_spawn_location[2].y
		item_shield.connect("collected",Callable(player,"_on_Item_collected").bind(item_shield))
		add_child(item_shield)
	if rand_type == 3:
		var item_hands = ItemHands.instantiate()
		
		stats.primary_stat_first = rng.randi_range(rand_level * 100 - 50, rand_level * 100 + 50)
		stats.primary_stat_second = rng.randi_range(rand_level * 100 - 50, rand_level * 100 + 50)
		
		item_hands.init("No name", rand_rarity, rand_level, 0, 100, "", "inventory", "hands", stats)
		item_hands.position.x = item_spawn_location[2].x
		item_hands.position.y = item_spawn_location[2].y
		item_hands.connect("collected",Callable(player,"_on_Item_collected").bind(item_hands))
		add_child(item_hands)
	if rand_type == 4:
		var item_head = ItemHead.instantiate()
		
		stats.primary_stat_first = rng.randi_range(rand_level * 100 - 50, rand_level * 100 + 50)
		stats.primary_stat_second = rng.randi_range(rand_level * 100 - 50, rand_level * 100 + 50)
		
		item_head.init("No name", rand_rarity, rand_level, 0, 100, "", "inventory", "head", stats)
		item_head.position.x = item_spawn_location[2].x
		item_head.position.y = item_spawn_location[2].y
		item_head.connect("collected",Callable(player,"_on_Item_collected").bind(item_head))
		add_child(item_head)
	if rand_type == 5:
		var item_chest = ItemChest.instantiate()
		
		stats.primary_stat_first = rng.randi_range(rand_level * 100 - 50, rand_level * 100 + 50)
		stats.primary_stat_second = rng.randi_range(rand_level * 100 - 50, rand_level * 100 + 50)
		
		item_chest.init("No name", rand_rarity, rand_level, 0, 100, "", "inventory", "chest", stats)
		item_chest.position.x = item_spawn_location[2].x
		item_chest.position.y = item_spawn_location[2].y
		item_chest.connect("collected",Callable(player,"_on_Item_collected").bind(item_chest))
		add_child(item_chest)
	if rand_type == 6:
		var item_feet = ItemFeet.instantiate()
		
		stats.primary_stat_first = rng.randi_range(rand_level * 100 - 50, rand_level * 100 + 50)
		stats.primary_stat_second = rng.randi_range(rand_level * 100 - 50, rand_level * 100 + 50)
		
		item_feet.init("No name", rand_rarity, rand_level, 0, 100, "", "inventory", "feet", stats)
		item_feet.position.x = item_spawn_location[2].x
		item_feet.position.y = item_spawn_location[2].y
		item_feet.connect("collected",Callable(player,"_on_Item_collected").bind(item_feet))
		add_child(item_feet)
	if rand_type == 7:
		var item_trinket = ItemTrinket.instantiate()
	
		stats.primary_stat_first = rng.randi_range(rand_level * 100 - 50, rand_level * 100 + 50)
		stats.primary_stat_second = rng.randi_range(rand_level * 100 - 50, rand_level * 100 + 50)
		
		item_trinket.init("No name", rand_rarity, rand_level, 0, 100, "", "inventory", "trinket", stats)
		item_trinket.position.x = item_spawn_location[2].x
		item_trinket.position.y = item_spawn_location[2].y
		item_trinket.connect("collected",Callable(player,"_on_Item_collected").bind(item_trinket))
		add_child(item_trinket)
