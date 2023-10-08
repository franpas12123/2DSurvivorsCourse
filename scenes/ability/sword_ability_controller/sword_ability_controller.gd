extends Node

const MAX_RANGE = 150

@export var sword_ability : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	
	if !player:
		return

	var enemies = get_tree().get_nodes_in_group("enemy")
	
	enemies = enemies.filter(
		func(enemy: Node2D):
			return enemy.global_position.distance_squared_to(player.global_position) < pow(MAX_RANGE, 2)
	)

	if !enemies.size():
		return

	print('size', !enemies.size())
	enemies.sort_custom(func(a:Node2D, b:Node2D):
		return a.global_position.distance_squared_to(player.global_position) < b.global_position.distance_squared_to(player.global_position)
	)

	var sword_instance = sword_ability.instantiate() as Node2D
	var enemy = enemies[0] as Node2D
	var player_pos = player.global_position
	var enemy_pos = enemy.global_position
	player.get_parent().add_child(sword_instance)
#	var player_to_enemy_distance = player_pos.distance_squared_to(enemies[0].global_position)
	var sword_offset = Vector2.ZERO
#	sword_offset.x = -20 if player_pos.x - enemy_pos.x < 15 else 20 if player_pos.x - enemy_pos.x > 15 else 0
#	sword_offset.y = -20 if player_pos.y - enemy_pos.y < 15 else 20 if player_pos.y - enemy_pos.y > 15 else 0
	print('enemy: ', enemy_pos, 'offset: ', sword_offset)
	sword_instance.global_position = enemy_pos + sword_offset
	sword_instance.rotation = enemy.get_angle_to(player_pos)
