extends Control

func _ready():
	$VBoxContainer/BacktoTitle.grab_focus()

func _on_BacktoTitle_pressed():
	get_tree().change_scene("res://Menu.tscn")

func _on_Quit_pressed():
	get_tree().quit()
