extends Node

@export_range(0,1) var drop_rate: float = 1
@export var vial_scene: PackedScene
@export var health_component: Node


func _ready():
	(health_component as HealthComponent).died.connect(on_died)


func on_died():
	if randf() > drop_rate:
		return

	if vial_scene == null:
		return
		
	if !owner is Node2D:
		return
		
	var spawn_position = (owner as Node2D).global_position
	var vial_instance = vial_scene.instantiate() as Node2D
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	entities_layer.add_child(vial_instance)
	vial_instance.global_position = spawn_position
