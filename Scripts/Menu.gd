extends Control

func _ready():
	var tween = create_tween()
	tween.tween_interval(1)
	tween.tween_property($BSS, "modulate", Color(1, 1, 1, 0), 2.0).set_trans(Tween.TRANS_CUBIC)

	tween.tween_property($VBoxContainer, "modulate", Color(1, 1, 1, 1), 1.0).set_trans(Tween.TRANS_CUBIC)
	$VBoxContainer/Start.grab_focus()

func _on_Start_pressed():
	get_tree().change_scene("res://TestLevel.tscn")

func _on_Quit_pressed():
	get_tree().quit()
