extends Control


func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/level1.tscn")


func _on_quit_pressed():
	$closescreen.visible = true
	await(get_tree().create_timer(2.5).timeout)
	get_tree().quit()
