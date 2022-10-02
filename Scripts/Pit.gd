extends Area2D

func _on_Pit_body_entered(body):
	if body is Player:
		GameController.playerHealth -= .25
		body.position = GameController.lastPosition
		
