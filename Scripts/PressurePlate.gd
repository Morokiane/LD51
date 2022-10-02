extends Area2D

export(PackedScene) var object: PackedScene = null

onready var sprite = $Sprite

func _ready():
	assert(object != null)

func _on_PressurePlate_body_entered(body):
	if body is Player:
		sprite.frame = 1
		$PressedFX.play()
		Loot()

func Loot():
	var loot: Node2D = object.instance()
	owner.get_node("PressurePlate/Objects").call_deferred("add_child", loot)
	#this object has to be put in on the main map
