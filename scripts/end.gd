extends Control

func _ready():
	await(get_tree().create_timer(3).timeout)
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
