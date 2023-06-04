extends StaticBody2D

var health = 350.0

var colliding: bool = false

func _physics_process(_delta):
	$health.value = health
	
	if colliding:
		if Input.is_action_just_pressed("chop"):
			health -= 40
			
	if health <= 0 and is_instance_valid(self):
		GameManager.material_left += 75
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
