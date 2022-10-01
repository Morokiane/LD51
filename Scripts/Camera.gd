extends Camera2D

#"anchor_mode" = fixed topleft

onready var player = get_node("../Player")
#onready var player = $Player

func _process(_delta):
	position = player.global_position
	#creates a frame that detects if the player is approaching the outside of it
	var x = floor(position.x / 320) * 320
	var y = floor(position.y / 180) * 180
	global_position = Vector2(x, y)
