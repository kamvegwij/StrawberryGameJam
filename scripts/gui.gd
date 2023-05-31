extends CanvasLayer


func _process(_delta):
	$top/bg/health.value = GameManager.player_health
	
	if !GameManager.boost_available:
		$top/bg/poweruptext.text = "power up unavailable"
	else:
		$top/bg/poweruptext.text = "power up available"
