extends StaticBody2D

onready var anim = $AnimatedSprite
onready var light = $Light2D
onready var occlude = $LightOccluder2D
onready var timer = $Timer

var canLight = false

func _process(_delta):
	if Input.is_action_just_pressed("X") && canLight && GameController.matches > 0:
		anim.visible = true
		light.visible = true
		occlude.visible = false
		GameController.inLight = true
		timer.start()

func _on_Area2D_body_entered(body):
	if body is Player:
		canLight = true

func _on_Area2D_body_exited(body):
	if body is Player:
		canLight = false

func _on_Timer_timeout():
	anim.visible = false
	light.visible = false
	occlude.visible = true
	GameController.inLight = false

func _on_Detector_body_entered(body):
	if body is Player && light.visible:
		GameController.inLight = true
		print("in the light")

func _on_Detector_body_exited(body):
	if body is Player:
		GameController.inLight = false
		print("forsaken to darkness")
