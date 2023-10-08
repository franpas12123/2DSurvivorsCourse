extends Camera2D

var PLAYER

# Called when the node enters the scene tree for the first time.
func _ready():
	make_current()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	PLAYER = get_tree().get_first_node_in_group("player")
	if (PLAYER):
		global_position = global_position.lerp(PLAYER.global_position, 1.0 - exp(-delta * 20))
