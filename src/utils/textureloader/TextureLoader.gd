extends Node2D

var swords = {
	"weapon_1_1": "res://assets/items/swords/rarity_1/1.png",
	"weapon_1_2": "res://assets/items/swords/rarity_1/2.png",
	
	"weapon_2_1": "res://assets/items/swords/rarity_2/1.png",
	"weapon_2_2": "res://assets/items/swords/rarity_2/2.png",
	"weapon_2_3": "res://assets/items/swords/rarity_2/3.png",
	"weapon_2_4": "res://assets/items/swords/rarity_2/4.png",
	
	"weapon_3_1": "res://assets/items/swords/rarity_3/1.png",
	"weapon_3_2": "res://assets/items/swords/rarity_3/2.png",
	"weapon_3_3": "res://assets/items/swords/rarity_3/3.png",
	"weapon_3_4": "res://assets/items/swords/rarity_3/4.png",
	"weapon_3_5": "res://assets/items/swords/rarity_3/5.png",
	"weapon_3_6": "res://assets/items/swords/rarity_3/6.png",
	
	"weapon_4_1": "res://assets/items/swords/rarity_4/1.png",
	"weapon_4_2": "res://assets/items/swords/rarity_4/2.png",
	"weapon_4_3": "res://assets/items/swords/rarity_4/3.png",
	"weapon_4_4": "res://assets/items/swords/rarity_4/4.png",
	"weapon_4_5": "res://assets/items/swords/rarity_4/5.png",
	"weapon_4_6": "res://assets/items/swords/rarity_4/6.png",
	"weapon_4_7": "res://assets/items/swords/rarity_4/7.png",
	"weapon_4_8": "res://assets/items/swords/rarity_4/8.png",
	
	"weapon_5_1": "res://assets/items/swords/rarity_5/1.png",
	"weapon_5_2": "res://assets/items/swords/rarity_5/2.png",
	"weapon_5_3": "res://assets/items/swords/rarity_5/3.png",
	"weapon_5_4": "res://assets/items/swords/rarity_5/4.png",
	"weapon_5_5": "res://assets/items/swords/rarity_5/5.png",
	"weapon_5_6": "res://assets/items/swords/rarity_5/6.png",
	"weapon_5_7": "res://assets/items/swords/rarity_5/7.png",
	"weapon_5_8": "res://assets/items/swords/rarity_5/8.png",
	"weapon_5_9": "res://assets/items/swords/rarity_5/9.png",
	"weapon_5_10": "res://assets/items/swords/rarity_5/10.png",
}

var chest = {
	"chest_1_T1": "res://assets/items/armor/rarity_1/tier_1/chest_1_T1.png",
	"chest_1_T10": "res://assets/items/armor/rarity_1/tier_10/chest_1_T10.png",
	"chest_1_T20": "res://assets/items/armor/rarity_1/tier_20/chest_1_T20.png",
	"chest_1_T30": "res://assets/items/armor/rarity_1/tier_30/chest_1_T30.png",
	"chest_1_T40": "res://assets/items/armor/rarity_1/tier_40/chest_1_T40.png",
	
	"chest_2_T1": "res://assets/items/armor/rarity_2/tier_1/chest_2_T1.png",
	"chest_2_T2": "res://assets/items/armor/rarity_2/tier_2/chest_2_T2.png",
	"chest_2_T3": "res://assets/items/armor/rarity_2/tier_3/chest_2_T3.png",
	"chest_2_T10": "res://assets/items/armor/rarity_2/tier_10/chest_2_T10.png",
	"chest_2_T20": "res://assets/items/armor/rarity_2/tier_20/chest_2_T20.png",
	"chest_2_T30": "res://assets/items/armor/rarity_2/tier_30/chest_2_T30.png",
	"chest_2_T40": "res://assets/items/armor/rarity_2/tier_40/chest_2_T40.png",
	
	"chest_3_T1": "res://assets/items/armor/rarity_3/tier_1/chest_3_T1.png",
	"chest_3_T10": "res://assets/items/armor/rarity_3/tier_10/chest_3_T10.png",
	"chest_3_T20": "res://assets/items/armor/rarity_3/tier_20/chest_3_T20.png",
	"chest_3_T30": "res://assets/items/armor/rarity_3/tier_30/chest_3_T30.png",
	"chest_3_T40": "res://assets/items/armor/rarity_3/tier_40/chest_3_T40.png",
	"chest_3_T50": "res://assets/items/armor/rarity_3/tier_50/chest_3_T50.png",
	
	"chest_4_T1": "res://assets/items/armor/rarity_4/tier_1/chest_4_T1.png",
	"chest_4_T2": "res://assets/items/armor/rarity_4/tier_2/chest_4_T2.png",
	"chest_4_T3": "res://assets/items/armor/rarity_4/tier_3/chest_4_T3.png",
	"chest_4_T4": "res://assets/items/armor/rarity_4/tier_4/chest_4_T4.png",
	"chest_4_T5": "res://assets/items/armor/rarity_4/tier_5/chest_4_T5.png",
	"chest_4_T10": "res://assets/items/armor/rarity_4/tier_10/chest_4_T10.png",
	"chest_4_T20": "res://assets/items/armor/rarity_4/tier_20/chest_4_T20.png",
	"chest_4_T30": "res://assets/items/armor/rarity_4/tier_30/chest_4_T30.png",
	"chest_4_T40": "res://assets/items/armor/rarity_4/tier_40/chest_4_T40.png",
	"chest_4_T50": "res://assets/items/armor/rarity_4/tier_50/chest_4_T50.png",
	
	"chest_5_T1": "res://assets/items/armor/rarity_5/tier_1/chest_5_T1.png",
	"chest_5_T2": "res://assets/items/armor/rarity_5/tier_2/chest_5_T2.png",
	"chest_5_T3": "res://assets/items/armor/rarity_5/tier_3/chest_5_T3.png",
	"chest_5_T4": "res://assets/items/armor/rarity_5/tier_4/chest_5_T4.png",
	"chest_5_T10": "res://assets/items/armor/rarity_5/tier_10/chest_5_T10.png",
	"chest_5_T20": "res://assets/items/armor/rarity_5/tier_20/chest_5_T20.png",
	"chest_5_T30": "res://assets/items/armor/rarity_5/tier_30/chest_5_T30.png",
	"chest_5_T40": "res://assets/items/armor/rarity_5/tier_40/chest_5_T40.png",
	"chest_5_T50": "res://assets/items/armor/rarity_5/tier_50/chest_5_T50.png",
	"chest_5_T60": "res://assets/items/armor/rarity_5/tier_60/chest_5_T60.png",
	"chest_5_T70": "res://assets/items/armor/rarity_5/tier_70/chest_5_T70.png",
	"chest_5_T80": "res://assets/items/armor/rarity_5/tier_80/chest_5_T80.png",
	
	"chest_6_S1": "res://assets/items/armor/rarity_6/set_1/chest_6_S1.png",
	"chest_6_S2": "res://assets/items/armor/rarity_6/set_2/chest_6_S2.png",
	"chest_6_S3": "res://assets/items/armor/rarity_6/set_3/chest_6_S3.png",
	"chest_6_S4": "res://assets/items/armor/rarity_6/set_4/chest_6_S4.png",
	"chest_6_S5": "res://assets/items/armor/rarity_6/set_5/chest_6_S5.png",
	"chest_6_S6": "res://assets/items/armor/rarity_6/set_6/chest_6_S6.png",
	"chest_6_S7": "res://assets/items/armor/rarity_6/set_7/chest_6_S7.png",
	"chest_6_S8": "res://assets/items/armor/rarity_6/set_8/chest_6_S8.png",
}

var head = {
	"head_1_T1": "res://assets/items/armor/rarity_1/tier_1/head_1_T1.png",
	"head_1_T10": "res://assets/items/armor/rarity_1/tier_10/head_1_T10.png",
	"head_1_T20": "res://assets/items/armor/rarity_1/tier_20/head_1_T20.png",
	"head_1_T30": "res://assets/items/armor/rarity_1/tier_30/head_1_T30.png",
	"head_1_T40": "res://assets/items/armor/rarity_1/tier_40/head_1_T40.png",
	
	"head_2_T1": "res://assets/items/armor/rarity_2/tier_1/head_2_T1.png",
	"head_2_T2": "res://assets/items/armor/rarity_2/tier_2/head_2_T2.png",
	"head_2_T3": "res://assets/items/armor/rarity_2/tier_3/head_2_T3.png",
	"head_2_T10": "res://assets/items/armor/rarity_2/tier_10/head_2_T10.png",
	"head_2_T20": "res://assets/items/armor/rarity_2/tier_20/head_2_T20.png",
	"head_2_T30": "res://assets/items/armor/rarity_2/tier_30/head_2_T30.png",
	"head_2_T40": "res://assets/items/armor/rarity_2/tier_40/head_2_T40.png",
	
	"head_3_T1": "res://assets/items/armor/rarity_3/tier_1/head_3_T1.png",
	"head_3_T10": "res://assets/items/armor/rarity_3/tier_10/head_3_T10.png",
	"head_3_T20": "res://assets/items/armor/rarity_3/tier_20/head_3_T20.png",
	"head_3_T30": "res://assets/items/armor/rarity_3/tier_30/head_3_T30.png",
	"head_3_T40": "res://assets/items/armor/rarity_3/tier_40/head_3_T40.png",
	"head_3_T50": "res://assets/items/armor/rarity_3/tier_50/head_3_T50.png",
	
	"head_4_T1": "res://assets/items/armor/rarity_4/tier_1/head_4_T1.png",
	"head_4_T2": "res://assets/items/armor/rarity_4/tier_2/head_4_T2.png",
	"head_4_T3": "res://assets/items/armor/rarity_4/tier_3/head_4_T3.png",
	"head_4_T4": "res://assets/items/armor/rarity_4/tier_4/head_4_T4.png",
	"head_4_T5": "res://assets/items/armor/rarity_4/tier_5/head_4_T5.png",
	"head_4_T10": "res://assets/items/armor/rarity_4/tier_10/head_4_T10.png",
	"head_4_T20": "res://assets/items/armor/rarity_4/tier_20/head_4_T20.png",
	"head_4_T30": "res://assets/items/armor/rarity_4/tier_30/head_4_T30.png",
	"head_4_T40": "res://assets/items/armor/rarity_4/tier_40/head_4_T40.png",
	"head_4_T50": "res://assets/items/armor/rarity_4/tier_50/head_4_T50.png",
	
	"head_5_T1": "res://assets/items/armor/rarity_5/tier_1/head_5_T1.png",
	"head_5_T2": "res://assets/items/armor/rarity_5/tier_2/head_5_T2.png",
	"head_5_T3": "res://assets/items/armor/rarity_5/tier_3/head_5_T3.png",
	"head_5_T4": "res://assets/items/armor/rarity_5/tier_4/head_5_T4.png",
	"head_5_T10": "res://assets/items/armor/rarity_5/tier_10/head_5_T10.png",
	"head_5_T20": "res://assets/items/armor/rarity_5/tier_20/head_5_T20.png",
	"head_5_T30": "res://assets/items/armor/rarity_5/tier_30/head_5_T30.png",
	"head_5_T40": "res://assets/items/armor/rarity_5/tier_40/head_5_T40.png",
	"head_5_T50": "res://assets/items/armor/rarity_5/tier_50/head_5_T50.png",
	"head_5_T60": "res://assets/items/armor/rarity_5/tier_60/head_5_T60.png",
	"head_5_T70": "res://assets/items/armor/rarity_5/tier_70/head_5_T70.png",
	"head_5_T80": "res://assets/items/armor/rarity_5/tier_80/head_5_T80.png",
	
	"head_6_S1": "res://assets/items/armor/rarity_6/set_1/head_6_S1.png",
	"head_6_S2": "res://assets/items/armor/rarity_6/set_2/head_6_S2.png",
	"head_6_S3": "res://assets/items/armor/rarity_6/set_3/head_6_S3.png",
	"head_6_S4": "res://assets/items/armor/rarity_6/set_4/head_6_S4.png",
	"head_6_S5": "res://assets/items/armor/rarity_6/set_5/head_6_S5.png",
	"head_6_S6": "res://assets/items/armor/rarity_6/set_6/head_6_S6.png",
	"head_6_S7": "res://assets/items/armor/rarity_6/set_7/head_6_S7.png",
	"head_6_S8": "res://assets/items/armor/rarity_6/set_8/head_6_S8.png",
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#get_texture("sword", "5_2")

# Type, rarity, set
func get_texture(type, tex_no):
	if type == "weapon":
		var tex_var = str(type) + "_" + str(tex_no)
		var tex_path = swords[tex_var]
		var tex = load(tex_path)
		return tex

	if type == "chest":
		var tex_var = str(type) + "_" + str(tex_no)
		var tex_path = chest[tex_var]
		var tex = load(tex_path)
		return tex
		
	if type == "head":
		var tex_var = str(type) + "_" + str(tex_no)
		var tex_path = head[tex_var]
		var tex = load(tex_path)
		return tex
