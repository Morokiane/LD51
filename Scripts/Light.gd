extends Light2D

onready var timer = $Timer

var lightOn = true

func _ready():
	timer.set_wait_time(10)
	timer.start()
	
#func _process(_delta):
#	print(timer.time_left)
	
func _on_Timer_timeout():
	if lightOn:
		self.energy = 0
		lightOn = false
	elif !lightOn:
		self.energy = 2
		lightOn = true
