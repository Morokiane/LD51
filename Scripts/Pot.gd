extends Area2D

onready var pot = preload("res://Assets/PotFX.tscn")
onready var heart = preload("res://Assets/Pickups/Heart.tscn")
onready var matchbook = preload("res://Assets/Pickups/Matchbook.tscn")

func _on_Pot_area_entered(area):
	if area.is_in_group("swing"):
		var potFX = pot.instance()
		get_parent().add_child(potFX)
		potFX.global_position = global_position
		LootGeneration()
		queue_free()

func LootGeneration():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var lootNum = rng.randi_range(0, 10)
	
	print(lootNum)
	if lootNum <= 1:
		CreateHeart()
	
	if lootNum >= 8:
		CreateMatch()

func CreateHeart():
	var heartLoot = heart.instance()
	get_parent().call_deferred("add_child", heartLoot)
	heartLoot.global_position = global_position
	
func CreateMatch():
	var matchLoot = matchbook.instance()
	get_parent().call_deferred("add_child", matchLoot)
	matchLoot.global_position = global_position
