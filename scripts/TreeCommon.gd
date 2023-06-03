extends StaticBody2D

var health

func _physics_process(_delta):
	health = GameManager.common_tree_health
	$health.value = GameManager.common_tree_health
	if health <= 0:
		GameManager.material_left += 50
		queue_free()
