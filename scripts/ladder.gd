extends Area2D



func _on_area_entered(area):
	if area.get_parent() == GameManager.player:
		pass
