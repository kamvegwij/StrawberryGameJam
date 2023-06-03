extends CanvasLayer

func _process(_delta):
	$top/bg/health.value = GameManager.player_health
	$top/bg/woodpic/woodqty.text = str(GameManager.material_left)
	$top/bg/meatpic/meatqty.text = str(GameManager.meat_left)
		
		
