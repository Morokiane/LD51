extends Area2D

func _on_Matchbook_body_entered(body):
	if body is Player:
		$PickedUp.play()
		yield(get_tree().create_timer(0.15), "timeout")
		GameController.matches += 5
		queue_free()
