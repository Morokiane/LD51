extends Node

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

var tutorial = true
var playerHealth = 3
var hasSword = false
var hasLantern = false
var lanternEnergy = 0
var lanternSize = 0
var inLight = false
var matches = 10
var pips = 6
var hasKey = false
var hasChestKey = false
var lastPosition = Vector2()
var destination = Vector2()
