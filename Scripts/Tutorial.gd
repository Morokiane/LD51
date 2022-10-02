extends YSort

onready var cm = $CanvasModulate
onready var timer = $Timer

func _ready():
	VisualServer.set_default_clear_color(Color("050403"))
	timer.set_wait_time(10)
	timer.start()

func _on_Timer_timeout():
	cm.visible = true
	GameController.tutorial = false
