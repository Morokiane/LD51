extends Area2D

onready var pot = preload("res://Assets/PotFX.tscn")
#onready var coin = preload("res://Prefabs/Collectibles/Coin.tscn")
	
func _on_Pot_area_entered(area):
	print("wTFF!!")
	if area.is_in_group("swing"):
		var potFX = pot.instance()
		get_parent().add_child(potFX)
		potFX.global_position = global_position
		LootGeneration()
		queue_free()
		
func LootGeneration():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var lootNum = rng.randi_range(0, 5)
	
#	if lootNum >= 3:
#		CreateCoin()
#	else:
#		return
		
#func CreateCoin():
#	var coinLoot = coin.instance()
#	get_parent().call_deferred("add_child", coinLoot)
#	coinLoot.global_position = global_position
