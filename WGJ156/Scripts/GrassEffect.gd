extends Node2D

onready var animatedSprite : AnimatedSprite = $AnimatedSprite
func _ready():
	animatedSprite.play("default")


func _on_AnimatedSprite_animation_finished():
	queue_free()
