extends State
class_name StateAttack

@export var fire_rate: float = 3
@export var burst_size: float = 3
@export var attack_timer: Timer
@export var bullet_scene: PackedScene
@export var enemy: CharacterBody2D

var can_attack: bool = true
var timesShot: int = 0

func attack():
	var bullet: Node2D = bullet_scene.instantiate()
	bullet.position = enemy.global_position
	bullet.velocity = enemy.transform.x * 400.0
	get_tree().get_root().add_child(bullet)
	

func enter():
	can_attack = true
	timesShot = 0
	attack()

func update(_delta: float):
	if timesShot >= burst_size:
		Transitioned.emit(self, "StateChase")
	elif can_attack:
		attack()
		attack_timer.start(1 / fire_rate)
		can_attack = false
		timesShot += 1


func _on_attack_timer_timeout() -> void:
	can_attack = true
