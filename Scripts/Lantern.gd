extends Area2D

func _on_Lantern_body_entered(body):
	if body is Player:
		GameController.hasLantern = true
		GameController.lanternEnergy = 1.5
		GameController.lanternSize = 2
		queue_free()
		print(GameController.hasLantern)
