extends Node


func _on_area_2d_area_entered(_area: Area2D):
	GameEvents.emit_exp_vial_collected(1)
	queue_free()
