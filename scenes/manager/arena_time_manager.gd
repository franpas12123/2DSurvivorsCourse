extends Node

@onready var timer = $Timer


func get_time_lapsed():
	return timer.wait_time - timer.time_left
