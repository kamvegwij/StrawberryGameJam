extends Control

func _ready():
	$AnimationPlayer.play("intro")
	await(get_tree().create_timer(4.8).timeout)
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
