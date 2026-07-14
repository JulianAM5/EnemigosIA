extends Entity

class_name RangedEnemy

var player: Node


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func go_to_target() -> void:
	pass
