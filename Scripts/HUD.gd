extends CanvasLayer

const heartRowSize = 8
const heartOffset = 17
const pipRowSize = 8
const pipOffset = 16

onready var coinNum = $CoinNum
onready var playerHP = $PlayerHP
onready var battery = $Battery
onready var meter = $Meter
onready var key = $Key
onready var chestKey = $ChestKey

func _ready():
	for i in GameController.playerHealth:
		var newHeart = Sprite.new()
		newHeart.texture = playerHP.texture
		newHeart.hframes = playerHP.hframes
		playerHP.add_child(newHeart)
		
	for i in GameController.pips:
		var newPip = Sprite.new()
		newPip.texture = meter.texture
		newPip.hframes = meter.hframes
		meter.add_child(newPip)

func _process(_delta):
	coinNum.text = String("%02d" % GameController.matches)
	
	if GameController.hasKey:
		key.visible = true
	else:
		key.visible = false
	
	if GameController.hasChestKey:
		chestKey.visible = true
	else:
		chestKey.visible = false
		
	if GameController.hasLantern:
		meter.visible = true
		battery.visible = true
	
	if GameController.pips <= 0:
		meter.visible = false
		battery.visible = false
		GameController.hasLantern = false

	for heart in playerHP.get_children():
		var index = heart.get_index()
		var x = (index % heartRowSize) * heartOffset
		var y = (index / heartRowSize) * heartOffset
		heart.position = Vector2(x,y)
		
		var lastHeart = floor(GameController.playerHealth)
		if index > lastHeart:
			heart.frame = 0
		if index == lastHeart:
			heart.frame = (GameController.playerHealth - lastHeart) * 4
		if index < lastHeart:
			heart.frame = 4

	for pip in meter.get_children():
		var index = pip.get_index()
		var x = (index % heartRowSize) * heartOffset / 2.9
		var y = (index / heartRowSize) * heartOffset 
		pip.position = Vector2(x,y)
		
		var lastPip = floor(GameController.pips)
		if index > lastPip:
			pip.frame = 0
		if index == lastPip:
			pip.frame = (GameController.pips - lastPip) * 4
		if index < lastPip:
			pip.frame = 7
