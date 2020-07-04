extends Node
class_name Stats

export var max_health : int = 2

onready var health : int = max_health setget set_health

signal no_health

func set_health(value):
	health = value
	if health <= 0:
		emit_signal("no_health")
