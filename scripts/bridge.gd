extends StaticBody2D

var colliding: bool = false
func _physics_process(_delta):
	if Input.is_action_just_pressed("chop") and colliding:
			GameManager.material_left += 25
			MusicControl.play_tree_down()
			queue_free()
			
func _on_area_2d_area_entered(area):
	if area.get_parent() == GameManager.player:
		$prompt.visible = true
		colliding = true		


func _on_area_2d_area_exited(area):
	if area.get_parent() == GameManager.player:
		$prompt.visible = false
		colliding = false	
