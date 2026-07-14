extends State
class_name StateChase

@export var movement_speed: float = 100.0
@export var time_between_attacks:float = 2.0
@export var enemy: CharacterBody2D
@export var next_attack: Timer
var can_attack: bool = true
var player

var noise_timer: float = 0.0
var random_offset: Vector2 = Vector2.ZERO

func enter():
	player = get_tree().get_first_node_in_group("player")

	if !can_attack:
		next_attack.start(time_between_attacks)

func update(_delta: float):
	var direction: Vector2 = player.global_position - enemy.global_position
	var angle := direction.angle()
	enemy.rotation = lerp_angle(enemy.rotation, angle, 10 * _delta)

	var distance_from_player: float = enemy.global_position.distance_to(player.global_position)
	if distance_from_player <= 200.0 && can_attack:
		can_attack = false
		Transitioned.emit(self, "StateAttack")
		return

	if distance_from_player <= 200.0:
# Within range but on cooldown - circle with noise
		noise_timer += _delta
		
		# Update noise periodically
		if noise_timer >= (1.0 / 3.0):
			noise_timer = 0.0
			# Generate random offset in a circle
			var random_angle = randf() * 2 * PI
			var random_magnitude = randf() * 100.0
			random_offset = Vector2(cos(random_angle), sin(random_angle)) * random_magnitude
		var tangent = direction.normalized().orthogonal()
		enemy.velocity = (tangent * movement_speed) + random_offset
	else:
		enemy.velocity = enemy.transform.x * movement_speed

	enemy.move_and_slide()

func exit():
	enemy.velocity = Vector2.ZERO

func _on_next_attack_timer_timeout() -> void:
	print("can_taac")
	can_attack = true
