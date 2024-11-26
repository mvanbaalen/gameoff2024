extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		# TODO Signal this to the player instead?
		(body as Player).trigger_scene_change()
