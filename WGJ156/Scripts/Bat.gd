extends KinematicBody2D

var knockback : Vector2 = Vector2.ZERO
var air_resistance : float = 200

onready var stats : Stats = $Stats

func _physics_process(delta):
	if knockback != Vector2.ZERO:
		knockback = move_and_slide( knockback.move_toward(Vector2.ZERO, air_resistance * delta))

func _on_Hitbox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockback_vector * 120


func _on_Stats_no_health():
	queue_free()
