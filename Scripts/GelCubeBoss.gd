extends KinematicBody2D

export var pathToPlayer = NodePath()

onready var player = get_node(pathToPlayer)
onready var agent = $NavigationAgent2D
onready var deathFX = preload("res://Assets/Enemy/DeathFX.tscn")
onready var sprite = $Sprite
onready var deathSFX = $SFX/DeathSFX
onready var spottedFX = $SFX/SpottedFX
onready var swingFX = $SFX/SwingFX
onready var timer = $Timer

var knockback = Vector2.ZERO
export var hp = 3
var velocity = Vector2.ZERO
export var speed = 50
export var maxSpeed = 150
export var friction = 30
var state = attack

enum {
	idle,
	attack
}

func _ready():
	timer.set_wait_time(.1)
	timer.start()

func _physics_process(delta):
	if agent.is_navigation_finished():
		return
		
	var direction = global_position.direction_to(agent.get_next_location())
	
	var desiredVelocity = direction * maxSpeed
	var steering = (desiredVelocity - velocity) * delta * 4.0
	velocity += steering
	
	velocity = move_and_slide(velocity)
	
	knockback = knockback.move_toward(Vector2.ZERO, 140 * delta)
	knockback = move_and_slide(knockback)

func _on_Hitbox_area_entered(area):
	knockback = area.knockbackVector * 120
	hp -= 1
	swingFX.play()
	if hp <= 0:
		deathSFX.play()
		var death = deathFX.instance()
		get_parent().add_child(death)
		death.global_position = $Hitbox.global_position
		sprite.visible = false
		Ending()

func _on_Timer_timeout():
	agent.set_target_location(player.global_position)
	
func Ending():
	yield(get_tree().create_timer(1), "timeout")
	get_tree().change_scene("res://End.tscn")
