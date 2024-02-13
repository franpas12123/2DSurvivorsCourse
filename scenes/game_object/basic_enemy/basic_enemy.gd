extends CharacterBody2D

const Max_SPEED = 50.0
@onready var health_component: HealthComponent = $HealthComponent

func _physics_process(_delta):
	velocity = get_direction_to_player() * Max_SPEED
	move_and_slide()


func get_direction_to_player():
	var player_node = get_tree().get_first_node_in_group("player") as Node2D
	if player_node:
		return (player_node.global_position - global_position).normalized()
	return Vector2.ZERO
