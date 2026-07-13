extends Entity

class_name enemy

var player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	

func _physics_process(delta: float) -> void:
	var direction = (player.global_position - global_position).normalized()
	velocity = direction*speed
	move_and_slide()
