extends Control

func _ready():
	MusicControl.gameplay_theme_stop()
	MusicControl.play_theme()
	MusicControl.stop_ambience()
	
func _on_start_pressed():
	MusicControl.click_play()
	MusicControl.gameplay_theme_play()
	MusicControl.play_ambience()
	MusicControl.stop_theme()
	get_tree().change_scene_to_file("res://scenes/level1.tscn")


func _on_quit_pressed():
	MusicControl.click_play()
	$closescreen.visible = true
	await(get_tree().create_timer(2.5).timeout)
	get_tree().quit()


func _on_start_mouse_entered():
	MusicControl.play_hover()

func _on_quit_mouse_entered():
	MusicControl.play_hover()
