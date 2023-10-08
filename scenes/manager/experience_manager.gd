extends Node

var current_exp = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	GameEvents.exp_vial_collected.connect(on_exp_vial_collected)


func increment_xp(num: float):
	current_exp += num
	print(current_exp)


func on_exp_vial_collected(number: float):
	increment_xp(number)
