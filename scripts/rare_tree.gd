extends StaticBody2D

var health

func _physics_process(_delta):
	health = GameManager.rare_tree_health
	$health.value = GameManager.rare_tree_health
	if health <= 0:
		queue_free()
