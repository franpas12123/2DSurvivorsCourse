extends Node

const MAX_RANGE = 150

@export var sword_ability : PackedScene
var base_wait_time
var damage = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	base_wait_time = $Timer.wait_time
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)


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

	enemies.sort_custom(func(a:Node2D, b:Node2D):
		return a.global_position.distance_squared_to(player.global_position) < b.global_position.distance_squared_to(player.global_position)
	)

	var sword_instance = sword_ability.instantiate() as SwordAbility
	var enemy = enemies[0] as Node2D
	var player_pos = player.global_position
	var enemy_pos = enemy.global_position
	
	var foreground_layer = get_tree().get_first_node_in_group("foreground_layer")
	foreground_layer.add_child(sword_instance)
	sword_instance.hitbox_component.damage = damage
#	var player_to_enemy_distance = player_pos.distance_squared_to(enemies[0].global_position)
	var sword_offset = Vector2.ZERO
#	sword_offset.x = -20 if player_pos.x - enemy_pos.x < 15 else 20 if player_pos.x - enemy_pos.x > 15 else 0
#	sword_offset.y = -20 if player_pos.y - enemy_pos.y < 15 else 20 if player_pos.y - enemy_pos.y > 15 else 0
	sword_instance.global_position = enemy_pos + sword_offset
	sword_instance.rotation = enemy.get_angle_to(player_pos)

func on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	if upgrade.id != 'sword_rate':
		return
	
	print('upgrade', upgrade, current_upgrades, current_upgrades.sword_rate)
	var percent_reduction = current_upgrades["sword_rate"]["quantity"] * .1
	$Timer.wait_time = base_wait_time * (1 - percent_reduction)
	print('timer', base_wait_time * (1 - percent_reduction))
	$Timer.start()
