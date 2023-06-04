extends Area2D



func _on_area_entered(area):
	if area.get_parent() == GameManager.player:
		if GameManager.active_scene <= 3:
			GameManager.active_scene += 1
			get_tree().change_scene_to_file("res://scenes/level" + str(GameManager.active_scene) + ".tscn")
