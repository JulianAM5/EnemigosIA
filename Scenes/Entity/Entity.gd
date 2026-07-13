extends CharacterBody2D

class_name Entity

@export var speed: float = 100
@export var damage: float = 0

const MAX_HEALTH: float = 100
var current_health:float=MAX_HEALTH

func received_damage(damage:float):
	current_health -= damage
	if current_health<=0:
		dead()

func dead():
	queue_free()
