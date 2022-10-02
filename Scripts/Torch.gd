extends StaticBody2D

onready var anim = $AnimatedSprite
onready var light = $Light2D
onready var occlude = $LightOccluder2D
onready var timer = $Timer
onready var fireFX = $SFX/FireFX
onready var x = $X

var canLight = false


func _process(_delta):
	#torch lighting
	if Input.is_action_just_pressed("X") && canLight && GameController.matches > 0:
		fireFX.play()
		anim.visible = true
		light.visible = true
		occlude.visible = false
		GameController.inLight = true
		GameController.matches -= 1
		timer.start()

func _on_Area2D_body_entered(body):
	if body is Player:
		canLight = true
		x.visible =true

func _on_Area2D_body_exited(body):
	if body is Player:
		canLight = false
		x.visible = false

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
