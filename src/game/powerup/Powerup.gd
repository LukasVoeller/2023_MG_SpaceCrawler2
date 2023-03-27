extends RigidBody2D

class_name Powerup

var hp_lesser = preload("res://assets/potions/potion_hp_lesser.png")
var hp_greater = preload("res://assets/potions/potion_hp_lesser.png")
var armor_lesser = preload("res://assets/potions/potion_armor_lesser.png")
var armor_greater = preload("res://assets/potions/potion_armor_geater.png")
var luck_lesser = preload("res://assets/potions/potion_luck_lesser.png")
var luck_greater = preload("res://assets/potions/potion_luck_greater.png")
var cd_lesser = preload("res://assets/potions/potion_cd_lesser.png")
var cd_greater = preload("res://assets/potions/potion_cd_greater.png")
var atkspeed_lesser = preload("res://assets/potions/potion_atkspeed_lesser.png")
var atkspeed_greater = preload("res://assets/potions/potion_atkspeed_greater.png")
var atkdmg_lesser = preload("res://assets/potions/potion_atkdmg_lesser.png")
var atkdmg_greater = preload("res://assets/potions/potion_atkdmg_greater.png")
var critchance_lesser = preload("res://assets/potions/potion_critchance_lesser.png")
var critchance_greater = preload("res://assets/potions/potion_critchance_greater.png")
var critdmg_lesser = preload("res://assets/potions/potion_critdmg_lesser.png")
var critdmg_greater = preload("res://assets/potions/potion_critdmg_greater.png")
var exp_lesser = preload("res://assets/potions/potion_exp_lesser.png")
var exp_greater = preload("res://assets/potions/potion_exp_greater.png")
var projectile_lesser = preload("res://assets/potions/potion_projectile_lesser.png")
var projectile_greater = preload("res://assets/potions/potion_projectile_greater.png")

var rng = RandomNumberGenerator.new()

var type
var potion_rng

func _ready():
	rng.randomize()
	potion_rng = rng.randi_range(9, 10)
	#type_relative = 11
	
	if potion_rng == 1:
		type = "hp_lesser"
		$Texture.texture = hp_lesser
#	if potion_rng == 2:
#		type = "hp_greater"
#		$Texture.texture = hp_greater
#	if potion_rng == 3:
#		type = "armor_lesser"
#		$Texture.texture = armor_lesser
#	if potion_rng == 4:
#		type = "armor_greater"
#		$Texture.texture = armor_greater
#	if potion_rng == 5:
#		type = "luck_lesser"
#		$Texture.texture = luck_lesser
#	if potion_rng == 6:
#		type = "luck_greater"
#		$Texture.texture = luck_greater
#	if potion_rng == 7:
#		type = "cd_lesser"
#		$Texture.texture = cd_lesser
#	if potion_rng == 8:
#		type = "cd_greater"
#		$Texture.texture = cd_greater
	if potion_rng == 9:
		type = "atkspeed_lesser"
		$Texture.texture = atkspeed_lesser
	if potion_rng == 10:
		type = "atkspeed_greater"
		$Texture.texture = atkspeed_greater
	if potion_rng == 11:
		type = "atkdmg_lesser"
		$Texture.texture = atkdmg_lesser
#	if potion_rng == 12:
#		type = "atkdmg_greater"
#		$Texture.texture = atkdmg_greater
#	if potion_rng == 13:
#		type = "critchance_lesser"
#		$Texture.texture = critchance_lesser
#	if potion_rng == 14:
#		type = "critchance_greater"
#		$Texture.texture = critchance_greater
	if potion_rng == 15:
		type = "critdmg_lesser"
		$Texture.texture = critdmg_lesser
#	if potion_rng == 16:
#		type = "critdmg_greater"
#		$Texture.texture = critdmg_greater
#	if potion_rng == 17:
#		type = "exp_lesser"
#		$Texture.texture = exp_lesser
#	if potion_rng == 18:
#		type = "exp_greater"
#		$Texture.texture = exp_greater
	if potion_rng == 19:
		type = "projectile_lesser"
		$Texture.texture = projectile_lesser
#	if potion_rng == 20:
#		type = "projectile_greater"
#		$Texture.texture = projectile_greater

func use():
	self.queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	self.queue_free()
