extends Area2D

export(String, FILE, "*.tscn") var levelPath = ""
export var destinationCoord = Vector2()

onready var sprite = $Sprite

var inDoor = false

func _ready():
	sprite.hide()

func _process(_delta):
	if Input.is_action_just_pressed("X") && inDoor == true:
		WriteCoords()
		LoadLevel()

func LoadLevel():
# warning-ignore:return_value_discarded
	get_tree().change_scene(levelPath)
	
func WriteCoords():
	GameController.destination = destinationCoord

func _on_LevelTransit_body_entered(body):
	if body is Player:
		inDoor = true
		sprite.show()

func _on_LevelTransit_body_exited(body):
	if body is Player:
		inDoor = false
		sprite.hide()
