extends KinematicBody2D
class_name Player

onready var animTree = $AnimationTree
onready var animState = animTree.get("parameters/playback")
onready var swordHitbox = $Sword
onready var light = $Match
onready var timer = $Timer
onready var hitFX = $SFX/Hit

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
	swordHitbox.knockbackVector = swordVector

func _physics_process(_delta):
#	call the function state
	match state:
		move:
			Move()
		swing:
			Swing()
	
func _process(_delta):
	if GameController.matches > 0 && !lightOn && Input.is_action_just_pressed("B"):
		lightOn = true
		light.energy = 1
		light.texture_scale = 1
		GameController.matches -= 1
	
	if GameController.hasLantern:
		lightOn = true
		light.energy = GameController.lanternEnergy
		light.texture_scale = GameController.lanternSize
	
func Move():
	var input = Vector2.ZERO
	input.x = Input.get_axis("left", "right")
	input.y = Input.get_axis("up", "down")
	
	if input != Vector2.ZERO:
		swordHitbox.knockbackVector = input
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

func TimerTimeout():
	if lightOn:
		light.energy = 0
		lightOn = false
	elif !lightOn && !GameController.inLight:
		GameController.playerHealth -= 0.25
		print(GameController.playerHealth)
	
	if GameController.hasLantern && GameController.pips > 0:
		GameController.pips -= 1
		GameController.inLight = true
		GameController.lanternEnergy -= 0.25
		GameController.lanternSize -= 0.333

func _on_Hitbox_area_entered(area):
	if area.is_in_group("enemy"):
		GameController.playerHealth -= 0.25
		hitFX.play()
		if GameController.playerHealth <= 0:
# warning-ignore:return_value_discarded
			get_tree().reload_current_scene()
			GameController.playerHealth = 4
