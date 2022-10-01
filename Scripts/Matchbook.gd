extends Area2D

func _on_Matchbook_body_entered(body):
	if body is Player:
		GameController.matches += 5
		queue_free()
