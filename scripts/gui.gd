extends CanvasLayer

func _process(_delta):
	$top/bg/health.value = GameManager.player_health
	$top/bg/woodpic/woodqty.text = str(GameManager.material_left)
	$top/bg/meatpic/meatqty.text = str(GameManager.meat_left)
		
	if Input.is_action_just_pressed("help"):
		$help.visible = true		
	
	if Input.is_action_just_pressed("stuck"):
		GameManager.player_health = 100
		GameManager.material_left = 0
		GameManager.meat_left = 0
		GameManager.active_scene = 1
		$gohome.visible = true
		await(get_tree().create_timer(2).timeout)
		get_tree().change_scene_to_file("res://scenes/menu.tscn")


func _on_close_pressed():
	$help.visible = false
