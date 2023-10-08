extends CanvasLayer

@export var arena_time_manager: Node
@onready var label = %Label


func _process(_delta):
	if arena_time_manager == null:
		return
	var time_lapsed = arena_time_manager.get_time_lapsed()
	label.text = format_sec_to_str(time_lapsed)


func format_sec_to_str(seconds: float):
	var minutes = floor(seconds/60)
	var remaining_seconds = seconds - (minutes * 60)
	return str(minutes) + ":" + ("%02d" % floor(remaining_seconds))
