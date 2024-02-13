extends CanvasLayer

@export var experience_manager: Node
@onready var progress_bar = $MarginContainer/ProgressBar


func _ready():
	progress_bar.value = 0
	experience_manager.experience_updated.connect(on_experience_updated)
	
	
func on_experience_updated(current_exp: float, target_xp: float):
	var percent = current_exp / target_xp
	progress_bar.value = percent