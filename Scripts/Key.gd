extends Area2D

func _on_Key_body_entered(body):
	if body is Player:
		$PickedUp.play()
		yield(get_tree().create_timer(0.15), "timeout")
		GameController.hasKey = true
		queue_free()
