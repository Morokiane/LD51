extends KinematicBody2D
class_name Player

onready var animTree = $AnimationTree
onready var animState = animTree.get("parameters/playback")
onready var light = $Match
onready var timer = $Timer

enum {
	move,
	swing
}

var speed = 100
var velocity = Vector2.ZERO
var state = move
var lightOn = true
var swordVector = Vector2.ZERO

func _ready():
	timer.set_wait_time(10)
	timer.start()
#	swordHitbox.knockbackVector = swordVector

func _physics_process(_delta):
#	call the function state
	match state:
		move:
			Move()
		swing:
			Swing()
	
func _process(_delta):
	if GameController.matches > 0 && !lightOn && Input.is_action_just_pressed("X"):
		lightOn = true
		light.energy = 1
		GameController.matches -= 1
	
func Move():
	var input = Vector2.ZERO
	input.x = Input.get_axis("left", "right")
	input.y = Input.get_axis("up", "down")
	
	if input != Vector2.ZERO:
#		swordHitbox.knockbackVector = inputMovement
		animTree.set("parameters/idle/blend_position", input)
		animTree.set("parameters/walk/blend_position", input)
		animTree.set("parameters/swing/blend_position", input)
		animState.travel("walk")
		velocity += input * speed
		velocity = velocity.limit_length(speed)
	else:
		animState.travel("idle")
		velocity = Vector2.ZERO
		
	if Input.is_action_just_pressed("A") && GameController.hasSword:
		state = swing
		
# warning-ignore:return_value_discarded
	move_and_slide(velocity)

func Swing():
	velocity = Vector2.ZERO
	animState.travel("swing")
	
func SwingFinish():
	state = move

func _on_Hitbox_area_entered(area):
	if area.is_in_group("enemy"):
		GameController.playerLives -= 0.25
		if GameController.playerLives <= 0:
# warning-ignore:return_value_discarded
			get_tree().reload_current_scene()
			GameController.playerLives = 4

func TimerTimeout():
	if lightOn:
		light.energy = 0
		lightOn = false
#	else:
#		light.energy = 1
#		lightOn = true
