extends Area2D

#export(String, FILE, "*.tscn") var loot = ""
export(PackedScene) var object: PackedScene = null

onready var sprite = $Sprite
onready var tween = $Tween

var canOpen = false
var opened = false

func _ready():
	assert(object != null)
	
func _process(_delta):
	if canOpen && Input.is_action_just_pressed("X") && !opened && GameController.hasChestKey:
		sprite.frame = 1
		opened = true
		GameController.hasChestKey = false
		Loot()

func _on_Chest_body_entered(body):
	if body is Player:
		canOpen = true
		
func _on_Chest_body_exited(body):
	if body is Player:
		canOpen = false
		
func Loot():
	$Pop.play()
	var loot: Node2D = object.instance()
	owner.get_node("Chest/Objects").add_child(loot)

#	tween.interpolate_property(loot, "position", position, position + Vector2(0, -5), 5, Tween.TRANS_QUAD, Tween.EASE_OUT)
#	tween.start()
#	yield(tween, "tween_completed")
#	tween.interpolate_property(loot, "position", position, position + Vector2(0, -5), 0.3, Tween.TRANS_SINE, Tween.EASE_IN)
#	tween.start()
