extends KinematicBody2D

onready var deathFX = preload("res://Assets/Enemy/DeathFX.tscn")
onready var detector = $Detector
onready var sprite = $Sprite

var knockback = Vector2.ZERO
var hp = 3
var velocity = Vector2.ZERO
var speed = 50
var maxSpeed = 150
var friction = 30
var state = attack
var player = null

enum {
	idle,
	attack
}

func _ready():
	pass

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 140 * delta)
	knockback = move_and_slide(knockback)
	
	match state:
		idle:
			velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
			PlayerFound()
		attack:
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction * speed, maxSpeed * delta)
			else:
				state = idle
				player = null
			
	sprite.flip_h = velocity.x > 0
	velocity = move_and_slide(velocity)

func PlayerDetect():
	return player != null
	
func PlayerFound():
	if PlayerDetect():
		state = attack

func _on_Detector_body_entered(body):
	if body.name == "Player":
		player = body

func _on_Detector_body_exited(body):
	if body.name == "Player":
		player = null

func _on_Hitbox_area_entered(area):
	print("hit")
	knockback = area.knockbackVector * 120
	hp -= 1
	if hp <= 0:
		var death = deathFX.instance()
		get_parent().add_child(death)
		death.global_position = $Hitbox.global_position
		queue_free()
