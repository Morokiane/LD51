extends Area2D

onready var sprite = $Sprite

var canOpenDoor = false

func _process(_delta):
	if Input.is_action_just_pressed("X") && GameController.hasKey && canOpenDoor:
		sprite.frame = 1
		$StaticBody2D.visible = false
		GameController.hasKey = false

func _on_Door_body_entered(body):
	if body is Player:
		canOpenDoor = true

func _on_Door_body_exited(body):
	if body is Player:
		canOpenDoor = false 
