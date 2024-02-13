extends Node
class_name HealthComponent

signal died

@export var max_health: float = 10
var cur_health


# Called when the node enters the scene tree for the first time.
func _ready():
	cur_health = max_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func damage(damage_amount: float):
#	print('damaged!', cur_health)
	cur_health = max(cur_health - damage_amount, 0)
	if cur_health == 0:
		died.emit()
		owner.queue_free()
