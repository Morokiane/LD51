extends Area2D

func _on_Lantern_body_entered(body):
	if body is Player:
		$PickedUp.play()
		yield(get_tree().create_timer(0.15), "timeout")
		GameController.hasLantern = true
		GameController.lanternEnergy = 1.5
		GameController.lanternSize = 2
		queue_free()
