extends Node2D

func _on_Hurtbox_area_entered(area):
	var grassEffect : Node2D = load("res://Prefabs/Effects/GrassEffect.tscn").instance()
	get_tree().current_scene.add_child(grassEffect)
	grassEffect.global_position = global_position
	queue_free()
