extends Area2D

onready var sprite = $Sprite
onready var col = $StaticBody2D/CollisionShape2D

export var unlocked = false

var canOpenDoor = false

func _ready():
	if unlocked:
		sprite.frame = 1
		col.disabled = true

func _process(_delta):
	if Input.is_action_just_pressed("X") && GameController.hasKey && canOpenDoor:
		sprite.frame = 1
		col.disabled = true
		GameController.hasKey = false

func _on_Door_body_entered(body):
	if body is Player:
		canOpenDoor = true

func _on_Door_body_exited(body):
	if body is Player:
		canOpenDoor = false 
