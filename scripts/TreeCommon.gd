extends StaticBody2D

var health = 250.0

var colliding: bool = false

func _physics_process(_delta):
	$health.value = health
	
	if colliding:
		if Input.is_action_just_pressed("chop"):
			MusicControl.play_chopping()
			health -= 20
			
	if health <= 0 and is_instance_valid(self):
		GameManager.material_left += 50
		MusicControl.play_tree_down()
		queue_free()


func _on_area_2d_area_entered(area):
	if area.get_parent() == GameManager.player:
		colliding = true
		$health.visible = true
		$prompt.visible = true


func _on_area_2d_area_exited(area):
	if area.get_parent() == GameManager.player:
		colliding = false
		$health.visible = false
		$prompt.visible = false
