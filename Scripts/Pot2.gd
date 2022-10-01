extends Area2D

onready var pot = preload("res://Assets/PotFX.tscn")
onready var heart = preload("res://Assets/Pickups/Heart.tscn")

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
	
	if lootNum <= 3:
		CreateHeart()
	else:
		return

func CreateHeart():
	var heartLoot = heart.instance()
	get_parent().call_deferred("add_child", heartLoot)
	heartLoot.global_position = global_position
