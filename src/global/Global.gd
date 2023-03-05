extends Node

var rng = RandomNumberGenerator.new()

########## ASTEROID SETTINGS ##########
var asteroid_level = 1
var asteroid_timer = 0.5
var asteroid_velocity_x_min = -50
var asteroid_velocity_x_max = 50
var asteroid_velocity_y_min = 200
var asteroid_velocity_y_max = 400


########## POWERUP SETTINGS ##########
var powerup_timer_range_min = 1
var powerup_timer_range_max = 2


########## ITEM SETTINGS ##########
var item_chance_min = 1
var item_chance_max = 1
var item_rarity_min = 1
var item_rarity_max = 5


########## WEAPON SETTINGS ##########
var weapon_atk_speed = 0.3
var weapon_projectiles = 3
var weapon_level = 25
var weapon_crit_chance = 0.1
var weapon_crit_damage = 1.5


########## STATISTICS ##########
var time_played = 0
var damage_dealt_per_second_average = 0
var damage_dealt_per_second_max = 0
var damage_dealt_per_second = 0
var damage_dealt_total = 0


########## DEBUG ##########
var spaceship_collision_disabled = false
var spaceship_hp_max = 100


func _ready():
	print("Global instanced")
	rng.randomize()
