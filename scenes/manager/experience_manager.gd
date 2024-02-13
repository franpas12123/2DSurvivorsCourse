extends Node

signal experience_updated(current_experience: float, target_experience: float)
signal level_up(new_level: int)

const TARGET_EXPERIENCE_GROWTH = 5

var current_exp = 0
var current_level = 1
var target_experience = 1 # 5

# Called when the node enters the scene tree for the first time.
func _ready():
	GameEvents.exp_vial_collected.connect(on_exp_vial_collected)


func increment_xp(num: float):
#	current_exp += min(current_exp + num, target_experience)
	current_exp += num
	experience_updated.emit(current_exp, target_experience)
	while current_exp >= target_experience:
		current_level += 1
		target_experience += TARGET_EXPERIENCE_GROWTH
		current_exp = 0
		experience_updated.emit(current_exp, target_experience)
		level_up.emit(current_level)
	print('player level: ', current_level)
	print(current_exp, ':', target_experience, '\n\n')


func on_exp_vial_collected(number: float):
	increment_xp(number)
